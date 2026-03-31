



-- Creando la db 
CREATE DATABASE IF NOT EXISTS inventario_db;
USE inventario_db;

-- Creando las tablas delas db
CREATE TABLE roles (
  rol_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE usuarios (
  usuario_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre_completo VARCHAR(120) NOT NULL,
  correo VARCHAR(150) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  rol_id INT NOT NULL,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (rol_id) REFERENCES roles(rol_id)
) ENGINE=InnoDB;


CREATE TABLE almacenes (
  almacen_id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  ubicacion VARCHAR(200) NOT NULL,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE productos (
  producto_id INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(40) NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  precio DECIMAL(12,2) NOT NULL,
  estado ENUM('ACTIVO','INACTIVO') DEFAULT 'ACTIVO',
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_producto_codigo (codigo),
  INDEX idx_producto_precio (precio)
) ENGINE=InnoDB;

CREATE TABLE productos_extra (
  producto_id INT PRIMARY KEY,
  descripcion TEXT,
  FOREIGN KEY (producto_id) REFERENCES productos(producto_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE inventario (
  inventario_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  producto_id INT NOT NULL,
  almacen_id INT NOT NULL,
  cantidad INT NOT NULL DEFAULT 0,
  ubicacion_interna VARCHAR(120) NOT NULL,
  fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  UNIQUE KEY uq_inventario_producto_almacen (producto_id, almacen_id),

  INDEX idx_inventario_almacen (almacen_id),
  INDEX idx_inventario_cantidad (cantidad),

  FOREIGN KEY (producto_id) REFERENCES productos(producto_id),
  FOREIGN KEY (almacen_id) REFERENCES almacenes(almacen_id)
) ENGINE=InnoDB;


CREATE TABLE transacciones (
  transaccion_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  tipo ENUM('ENTRADA','SALIDA','AJUSTE','VENTA_SIMULADA','TRANSFERENCIA') NOT NULL,
  producto_id INT NOT NULL,
  almacen_id INT NOT NULL,
  cantidad INT NOT NULL,
  fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  creado_por INT NOT NULL,
  notas VARCHAR(255),

  FOREIGN KEY (producto_id) REFERENCES productos(producto_id),
  FOREIGN KEY (almacen_id) REFERENCES almacenes(almacen_id),
  FOREIGN KEY (creado_por) REFERENCES usuarios(usuario_id),

  INDEX idx_transaccion_fecha (fecha),
  INDEX idx_transaccion_tipo (tipo)
) ENGINE=InnoDB;

CREATE TABLE auditoria_productos (
  auditoria_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  producto_id INT NOT NULL,
  modificado_por INT NOT NULL,
  tipo_cambio ENUM('CREAR','ACTUALIZAR','ELIMINAR') NOT NULL,
  antes_json JSON,
  despues_json JSON,
  fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (producto_id) REFERENCES productos(producto_id),

  INDEX idx_auditoria_producto (producto_id)
) ENGINE=InnoDB;


-- 3 IMPLEMENTACION Basica de funciones

-- procedimiento para registrar un producto nuevo
-- valida codigo duplicado y registra auditoria

DELIMITER $$ 
CREATE PROCEDURE sp_crear_producto(
    IN p_codigo VARCHAR(40),
    IN p_nombre VARCHAR(150),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(12,2),
    IN p_estado ENUM('ACTIVO','INACTIVO'),
    IN p_creado_por INT
)

BEGIN

    DECLARE v_producto_id INT;
 
    START TRANSACTION;
 
    IF EXISTS (SELECT 1 FROM productos WHERE codigo = p_codigo) THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'codigo de producto duplicado';
    END IF;
 
    INSERT INTO productos(codigo,nombre,precio,estado)
    VALUES(p_codigo,p_nombre,p_precio,IFNULL(p_estado,'ACTIVO'));
 
    SET v_producto_id = LAST_INSERT_ID();
 
    INSERT INTO productos_extra(producto_id,descripcion)
    VALUES(v_producto_id,p_descripcion);
 
    INSERT INTO auditoria_productos(producto_id,modificado_por,tipo_cambio,antes_json,despues_json)
    VALUES(
        v_producto_id,
        p_creado_por,
        'CREAR',
        NULL,
        JSON_OBJECT(
            'codigo',p_codigo,
            'nombre',p_nombre,
            'precio',p_precio,
            'estado',IFNULL(p_estado,'ACTIVO')
        )
    );

    -- confirmar operacion
    COMMIT;

END$$

-- procedimiento para registrar almacenes en el sistema

DELIMITER $$

CREATE PROCEDURE sp_crear_almacen(
    IN p_nombre VARCHAR(120),
    IN p_ubicacion VARCHAR(200)
)

BEGIN

    INSERT INTO almacenes(nombre, ubicacion)
    VALUES(p_nombre, p_ubicacion);

END$$ 


DELIMITER ;

-- procedimiento para actualizar producto 

DELIMITER $$

CREATE PROCEDURE sp_actualizar_producto(
    IN p_producto_id INT,
    IN p_nombre VARCHAR(150),
    IN p_precio DECIMAL(12,2),
    IN p_estado ENUM('ACTIVO','INACTIVO'),
    IN p_modificado_por INT
)

BEGIN

    DECLARE v_antes JSON;

    -- iniciar transaccion
    START TRANSACTION;

    -- guardar estado actual del producto
    SELECT JSON_OBJECT(
        'nombre', nombre,
        'precio', precio,
        'estado', estado
    )
    INTO v_antes
    FROM productos
    WHERE producto_id = p_producto_id;
 
    UPDATE productos
    SET
        nombre = p_nombre,
        precio = p_precio,
        estado = p_estado
    WHERE producto_id = p_producto_id;

   
    INSERT INTO auditoria_productos(
        producto_id,
        modificado_por,
        tipo_cambio,
        antes_json,
        despues_json
    )
    VALUES(
        p_producto_id,
        p_modificado_por,
        'ACTUALIZAR',
        v_antes,
        JSON_OBJECT(
            'nombre',p_nombre,
            'precio',p_precio,
            'estado',p_estado
        )
    );

    -- confirmar cambios
    COMMIT;

END$$

DELIMITER ;

-- procedimiento para eliminar producto del sistema
-- registra el estado anterior en auditoria antes de eliminar

DELIMITER $$

CREATE PROCEDURE sp_eliminar_producto(
    IN p_producto_id INT,
    IN p_modificado_por INT
)

BEGIN

    DECLARE v_antes JSON;

    START TRANSACTION;

    SELECT JSON_OBJECT(
        'codigo', codigo,
        'nombre', nombre,
        'precio', precio,
        'estado', estado
    )
    INTO v_antes
    FROM productos
    WHERE producto_id = p_producto_id;

    INSERT INTO auditoria_productos(
        producto_id,
        modificado_por,
        tipo_cambio,
        antes_json,
        despues_json
    )
    VALUES(
        p_producto_id,
        p_modificado_por,
        'ELIMINAR',
        v_antes,
        NULL
    );

    DELETE FROM productos
    WHERE producto_id = p_producto_id;

    COMMIT;

END$$

DELIMITER ;

-- 3.2	GESTION DE INVENTARIO

-- procedimiento para registrar entrada de inventario en un almacen

DELIMITER $$

CREATE PROCEDURE sp_registrar_entrada_inventario(
    IN p_producto_id INT,
    IN p_almacen_id INT,
    IN p_cantidad INT,
    IN p_usuario_id INT,
    IN p_notas VARCHAR(255)
)

BEGIN

    START TRANSACTION;

    INSERT INTO inventario(producto_id, almacen_id, cantidad, ubicacion_interna)
    VALUES(p_producto_id, p_almacen_id, p_cantidad, 'DEFAULT')
    ON DUPLICATE KEY UPDATE
    cantidad = cantidad + p_cantidad;

    INSERT INTO transacciones(tipo, producto_id, almacen_id, cantidad, creado_por, notas)
    VALUES('ENTRADA', p_producto_id, p_almacen_id, p_cantidad, p_usuario_id, p_notas);

    COMMIT;

END$$

DELIMITER ;

-- procedimiento para simular venta de producto y descontar inventario

DELIMITER $$

CREATE PROCEDURE sp_simular_venta(
    IN p_producto_id INT,
    IN p_almacen_id INT,
    IN p_cantidad INT,
    IN p_usuario_id INT
)

BEGIN

    DECLARE v_stock_actual INT;

    START TRANSACTION;

    SELECT cantidad
    INTO v_stock_actual
    FROM inventario
    WHERE producto_id = p_producto_id
    AND almacen_id = p_almacen_id
    FOR UPDATE;

    IF v_stock_actual < p_cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'stock insuficiente';
    END IF;

    UPDATE inventario
    SET cantidad = cantidad - p_cantidad
    WHERE producto_id = p_producto_id
    AND almacen_id = p_almacen_id;

    INSERT INTO transacciones(tipo, producto_id, almacen_id, cantidad, creado_por)
    VALUES('VENTA_SIMULADA', p_producto_id, p_almacen_id, p_cantidad, p_usuario_id);

    COMMIT;

END$$

DELIMITER ;


-- procedimiento para transferir productos entre almacenes y registrar movimiento

DELIMITER $$

CREATE PROCEDURE sp_transferir_inventario(
    IN p_producto_id INT,
    IN p_almacen_origen INT,
    IN p_almacen_destino INT,
    IN p_cantidad INT,
    IN p_usuario_id INT
)

BEGIN

    DECLARE v_stock_origen INT;

    START TRANSACTION;

    SELECT cantidad
    INTO v_stock_origen
    FROM inventario
    WHERE producto_id = p_producto_id
    AND almacen_id = p_almacen_origen
    FOR UPDATE;

    IF v_stock_origen < p_cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'stock insuficiente en almacen origen';
    END IF;

    UPDATE inventario
    SET cantidad = cantidad - p_cantidad
    WHERE producto_id = p_producto_id
    AND almacen_id = p_almacen_origen;

    INSERT INTO inventario(producto_id, almacen_id, cantidad, ubicacion_interna)
    VALUES(p_producto_id, p_almacen_destino, p_cantidad, 'DEFAULT')
    ON DUPLICATE KEY UPDATE
    cantidad = cantidad + p_cantidad;

    INSERT INTO transacciones(tipo, producto_id, almacen_id, cantidad, creado_por, notas)
    VALUES('TRANSFERENCIA', p_producto_id, p_almacen_origen, p_cantidad, p_usuario_id, 'transferencia a otro almacen');

    COMMIT;

END$$

DELIMITER ;


-- procedimiento para ajustar inventario cuando existe diferencia en conteo fisico

DELIMITER $$

CREATE PROCEDURE sp_ajustar_inventario(
    IN p_producto_id INT,
    IN p_almacen_id INT,
    IN p_cantidad INT,
    IN p_usuario_id INT,
    IN p_notas VARCHAR(255)
)

BEGIN

    START TRANSACTION;

    UPDATE inventario
    SET cantidad = p_cantidad
    WHERE producto_id = p_producto_id
    AND almacen_id = p_almacen_id;

    INSERT INTO transacciones(tipo, producto_id, almacen_id, cantidad, creado_por, notas)
    VALUES('AJUSTE', p_producto_id, p_almacen_id, p_cantidad, p_usuario_id, p_notas);

    COMMIT;

END$$

DELIMITER ;

-- TRIGGER para registrar cambios en el inventario

DROP TRIGGER IF EXISTS trg_actualizacion_inventario;

DELIMITER $$

CREATE TRIGGER trg_actualizacion_inventario
AFTER UPDATE ON inventario
FOR EACH ROW
BEGIN
    -- se activa cuando la cantidad es 5 o menos  
    IF NEW.cantidad <= 5 AND OLD.cantidad > 5 THEN
        INSERT INTO transacciones(
            tipo, producto_id, almacen_id, cantidad, creado_por, notas
        )
        VALUES(
            'AJUSTE', NEW.producto_id, NEW.almacen_id, NEW.cantidad, 1, 'alerta automatica: stock en nivel critico'
        );
    END IF;
END$$

DELIMITER ;
-- ver triggers 
 
show triggers; 
-- PRUEBA TRIGGER 
 UPDATE inventario SET cantidad = 30 WHERE inventario_id = 3;
 
 SELECT * FROM transacciones;


-- 3.3 USUARIOS Y ROLES 
-- procedimiento para registrar usuario y asignar rol dentro del sistema

DELIMITER $$

CREATE PROCEDURE sp_crear_usuario(
    IN p_nombre_completo VARCHAR(120),
    IN p_correo VARCHAR(150),
    IN p_password_hash VARCHAR(255),
    IN p_rol_id INT
)

BEGIN

    START TRANSACTION;

    INSERT INTO usuarios(nombre_completo, correo, password_hash, rol_id)
    VALUES(p_nombre_completo, p_correo, p_password_hash, p_rol_id);

    COMMIT;

END$$

DELIMITER ;

-- procedimiento para actualizar el rol de un usuario dentro del sistema

DELIMITER $$

CREATE PROCEDURE sp_actualizar_rol_usuario(
    IN p_usuario_id INT,
    IN p_rol_id INT
)

BEGIN

    START TRANSACTION;

    UPDATE usuarios
    SET rol_id = p_rol_id
    WHERE usuario_id = p_usuario_id;

    COMMIT;

END$$

DELIMITER ;

-- 3.4 consultas para reportes

-- vista para mostrar inventario general con valor total de productos

CREATE OR REPLACE VIEW vw_inventario_general AS
SELECT
    p.codigo,
    p.nombre,
    SUM(i.cantidad) AS stock_total,
    p.precio,
    (SUM(i.cantidad) * p.precio) AS valor_total
FROM productos p
JOIN inventario i ON i.producto_id = p.producto_id
WHERE p.estado = 'ACTIVO'
GROUP BY p.producto_id;


-- vista para mostrar productos organizados por almacen y ubicacion

CREATE OR REPLACE VIEW vw_productos_por_ubicacion AS
SELECT
    a.nombre AS almacen,
    i.ubicacion_interna,
    p.codigo,
    p.nombre,
    i.cantidad,
    p.precio
FROM inventario i
JOIN almacenes a ON a.almacen_id = i.almacen_id
JOIN productos p ON p.producto_id = i.producto_id;


-- vista para mostrar reporte de ventas simuladas

CREATE OR REPLACE VIEW vw_ventas_simuladas AS
SELECT
    t.transaccion_id,
    t.fecha,
    a.nombre AS almacen,
    p.codigo,
    p.nombre,
    t.cantidad,
    p.precio,
    (t.cantidad * p.precio) AS valor_total
FROM transacciones t
JOIN productos p ON p.producto_id = t.producto_id
JOIN almacenes a ON a.almacen_id = t.almacen_id
WHERE t.tipo = 'VENTA_SIMULADA';



-- pruebas y funcionalidad 
-- CREAR ROLES 
INSERT INTO roles(nombre)
VALUES
('ADMINISTRADOR'),
('ENCARGADO_INVENTARIO'); 

SELECT * FROM roles;

-- registrar usuarios. 

CALL sp_crear_usuario( 'Carlos Ramirez','carlos.ramirez@ejemplo.gt','sha256_admin_demo',1); 
CALL sp_crear_usuario('Ana Lopez','ana.lopez@ejemplo.gt','sha256_operador_demo',2 ); 

SELECT usuario_id, nombre_completo, correo, rol_id FROM usuarios;


-- registrar productos de tecnologia en el sistema
-- registrar productos de tecnologia en el sistema


 

CALL sp_crear_producto(
'DELL-INS-15',
'Laptop Dell Inspiron 15',
'Laptop Dell Inspiron 15 pulgadas con procesador Intel Core i5',
7500.00,
'ACTIVO',
1
);

CALL sp_crear_producto(
'LOG-G435',
'Audifonos Logitech G435',
'Audifonos inalambricos Logitech para gaming',
850.00,
'ACTIVO',
1
);

CALL sp_crear_producto(
'LOG-G502',
'Mouse Logitech G502',
'Mouse gamer Logitech G502 con sensor de alta precision',
450.00,
'ACTIVO', 1 );

SELECT * FROM productos; 

-- registrar almacenes usando procedimiento almacenado

CALL sp_crear_almacen(
'Almacen Central',
'Ciudad de Guatemala zona 4'
);

CALL sp_crear_almacen(
'Almacen Norte',
'Ciudad de Guatemala zona 18'
);

SELECT * FROM almacenes;

-- registrar inventario inicial de los productos
CALL sp_registrar_entrada_inventario(1,1,10,2,'ESTANTE-A1');
CALL sp_registrar_entrada_inventario(2,1,25,2,'ESTANTE-B2');
CALL sp_registrar_entrada_inventario(3,1,30,2,'ESTANTE-C3');

SELECT * FROM inventario;

-- ----SIMULAR VENTA DE PRODUCTO 

CALL sp_simular_venta(1,1,1,2);
CALL sp_simular_venta(2,1,2,2);
CALL sp_simular_venta(3,1,1,2);

SELECT * FROM transacciones;
SELECT * FROM inventario;


-- COMPROBAR QUE EL INVENTARIO SE ACTUALIZO
SELECT * FROM inventario;

-- transferencia de inventario entre almacenes

CALL sp_transferir_inventario(3,1,2,2,2);

SELECT * FROM inventario;
SELECT * FROM transacciones;

-- ajuste de inventario despues de conteo fisico

CALL sp_ajustar_inventario(2,1,22,2,'ajuste por conteo fisico');

SELECT * FROM inventario;
SELECT * FROM transacciones;

-- REPORTE INVENTARIO GENERAL 
SELECT * FROM vw_inventario_general;


 -- REPORTE  de productos por ubicación 
 SELECT * FROM vw_productos_por_ubicacion;
 
 -- REPORTE DE VENTA SIMIULADA 
  SELECT * FROM vw_ventas_simuladas;
  
  
  -- MAS REGISTROS para la fase 2 
    

-- Añadiendo otros alamacenes 
-- ------------------------------------------------------------

CALL sp_crear_almacen(
    'Almacen Sur',
    '12 Calle 5-56 Zona 12, Ciudad de Guatemala'
);

CALL sp_crear_almacen(
    'Almacen Oeste',
    'Calzada Roosevelt 22-43 Zona 7, Ciudad de Guatemala'
);

SELECT * FROM almacenes;

-- oTROS Productos 
-- Producto 4
CALL sp_crear_producto(
    'SAM-A54',
    'Celular Samsung Galaxy A54',
    'Smartphone Samsung Galaxy A54 128GB pantalla 6.4 pulgadas',
    3200.00,
    'ACTIVO',
    1
);

-- Producto 5
CALL sp_crear_producto(
    'HP-DESK-290',
    'Desktop HP 290 G4',
    'Computadora de escritorio HP procesador Intel Core i3 8GB RAM',
    4800.00,
    'ACTIVO',
    1
);

-- Producto 6
CALL sp_crear_producto(
    'EPSON-L3250',
    'Impresora Epson EcoTank L3250',
    'Impresora multifuncional Epson sistema de tinta continua WiFi',
    1850.00,
    'ACTIVO',
    1
);

-- Producto 7
CALL sp_crear_producto(
    'TP-LINK-AC1200',
    'Router TP-Link AC1200',
    'Router inalambrico TP-Link doble banda 1200Mbps',
    425.00,
    'ACTIVO',
    1
);

-- Producto 8
CALL sp_crear_producto(
    'GHIA-TAB7',
    'Tablet Ghia 7 pulgadas',
    'Tablet Ghia 7 pulgadas 16GB Android quad core economica',
    650.00,
    'ACTIVO',
    1
);

-- Producto 9
CALL sp_crear_producto(
    'CABLE-HDMI-3M',
    'Cable HDMI 3 metros',
    'Cable HDMI macho a macho 3 metros full HD compatible con TV y monitor',
    85.00,
    'ACTIVO',
    1
);

-- Producto 10 con precio alto 
CALL sp_crear_producto(
    'LG-OLED55',
    'Televisor LG OLED 55 pulgadas',
    'Televisor LG OLED 55 pulgadas 4K Smart TV con ThinQ AI',
    12500.00,
    'ACTIVO',
    1
);

-- Producto inactivo 
CALL sp_crear_producto(
    'NOKIA-105',
    'Telefono Nokia 105',
    'Telefono basico Nokia 105 doble SIM bateria de larga duracion',
    180.00,
    'INACTIVO',
    1
);

SELECT * FROM productos;
 
 
 -- ALMACENES 
-- Almacen 1  - Central zona 4
-- Almacen 2  -norte zona 18
-- Almacen 3- Sur zona 12
-- Almacen 4 - Oeste zona 7
 

-- Almacen Central (almacen_id = 1) productos nuevos
CALL sp_registrar_entrada_inventario(4, 1, 20, 2, 'ESTANTE-D1');
CALL sp_registrar_entrada_inventario(5, 1, 8,  2, 'ESTANTE-D2');
CALL sp_registrar_entrada_inventario(6, 1, 15, 2, 'ESTANTE-E1');
CALL sp_registrar_entrada_inventario(7, 1, 30, 2, 'ESTANTE-E2');
CALL sp_registrar_entrada_inventario(8, 1, 12, 2, 'ESTANTE-F1');
CALL sp_registrar_entrada_inventario(9, 1, 50, 2, 'ESTANTE-F2');
CALL sp_registrar_entrada_inventario(10,1, 5,  2, 'ESTANTE-G1');

-- Almacen Norte (almacen_id = 2) todos los productos
CALL sp_registrar_entrada_inventario(1, 2, 8,  2, 'ESTANTE-A1');
CALL sp_registrar_entrada_inventario(2, 2, 15, 2, 'ESTANTE-A2');
CALL sp_registrar_entrada_inventario(3, 2, 20, 2, 'ESTANTE-B1');
CALL sp_registrar_entrada_inventario(4, 2, 10, 2, 'ESTANTE-B2');
CALL sp_registrar_entrada_inventario(5, 2, 4,  2, 'ESTANTE-C1');
CALL sp_registrar_entrada_inventario(6, 2, 7,  2, 'ESTANTE-C2');
CALL sp_registrar_entrada_inventario(7, 2, 25, 2, 'ESTANTE-D1');
CALL sp_registrar_entrada_inventario(9, 2, 40, 2, 'ESTANTE-D2');
CALL sp_registrar_entrada_inventario(10,2, 3,  2, 'ESTANTE-E1');

-- Almacen Sur (almacen_id = 3)
CALL sp_registrar_entrada_inventario(1, 3, 5,  2, 'ESTANTE-A1');
CALL sp_registrar_entrada_inventario(3, 3, 10, 2, 'ESTANTE-A2');
CALL sp_registrar_entrada_inventario(4, 3, 8,  2, 'ESTANTE-B1');
CALL sp_registrar_entrada_inventario(6, 3, 6,  2, 'ESTANTE-B2');
CALL sp_registrar_entrada_inventario(7, 3, 20, 2, 'ESTANTE-C1');
CALL sp_registrar_entrada_inventario(8, 3, 5,  2, 'ESTANTE-C2');
CALL sp_registrar_entrada_inventario(9, 3, 35, 2, 'ESTANTE-D1');

-- Almacen Oeste (almacen_id = 4)
CALL sp_registrar_entrada_inventario(2, 4, 10, 2, 'ESTANTE-A1');
CALL sp_registrar_entrada_inventario(4, 4, 6,  2, 'ESTANTE-A2');
CALL sp_registrar_entrada_inventario(5, 4, 3,  2, 'ESTANTE-B1');
CALL sp_registrar_entrada_inventario(7, 4, 15, 2, 'ESTANTE-B2');
CALL sp_registrar_entrada_inventario(9, 4, 45, 2, 'ESTANTE-C1');
CALL sp_registrar_entrada_inventario(10,4, 2,  2, 'ESTANTE-C2');

SELECT * FROM inventario;

--  ventas de prubeba o simuladas pra historial
-- Ventas enalmacen Central
CALL sp_simular_venta(1, 1, 2, 2);
CALL sp_simular_venta(2, 1, 3, 2);
CALL sp_simular_venta(4, 1, 5, 2);
CALL sp_simular_venta(6, 1, 2, 2);
CALL sp_simular_venta(9, 1, 10, 2);

-- Ventas en Almacen Norte
CALL sp_simular_venta(1, 2, 1, 2);
CALL sp_simular_venta(3, 2, 4, 2);
CALL sp_simular_venta(7, 2, 5, 2);
CALL sp_simular_venta(9, 2, 8, 2);

-- Ventas en Almacen Sur
CALL sp_simular_venta(4, 3, 2, 2);
CALL sp_simular_venta(6, 3, 1, 2);
CALL sp_simular_venta(9, 3, 7, 2);

-- Ventas en Almacen Oeste
CALL sp_simular_venta(2, 4, 3, 2);
CALL sp_simular_venta(7, 4, 4, 2);
CALL sp_simular_venta(9, 4, 10, 2);

SELECT * FROM transacciones;

 -- ----     ********* transferencia entre almacenes -- 
 
-- Transferir laptops del central al sur
CALL sp_transferir_inventario(1, 1, 3, 2, 2);

-- Transferir routers del norte al oeste
CALL sp_transferir_inventario(7, 2, 4, 3, 2);

-- Transferir cables del central al norte
CALL sp_transferir_inventario(9, 1, 4, 2, 2);

SELECT * FROM inventario;

-- ajuste en inventario para los filtros de la fas 2
 
-- Dejar algunos productos con stock critico < a 5 

-- TV LG en almacen central queda en stock critico
CALL sp_ajustar_inventario(10, 1, 2, 2, 'ajuste por conteo fisico, unidades danadas');

-- Desktop HP en almacen oeste queda en stock critico
CALL sp_ajustar_inventario(5, 4, 1, 2, 'ajuste por conteo fisico');

-- Tablet Ghia en almacen sur queda en stock critico
CALL sp_ajustar_inventario(8, 3, 3, 2, 'ajuste por conteo fisico, devolucion de cliente');

SELECT * FROM inventario;

-- REPORTES 

SELECT * FROM vw_inventario_general;
SELECT * FROM vw_productos_por_ubicacion;
SELECT * FROM vw_ventas_simuladas;
  