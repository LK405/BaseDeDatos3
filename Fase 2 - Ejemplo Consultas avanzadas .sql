USE inventario_db;

-- Opitimizacion

ALTER TABLE productos DROP INDEX idx_prod_precio;
CREATE INDEX idx_prod_precio ON productos(precio);

ALTER TABLE inventario DROP INDEX idx_inv_cant;
CREATE INDEX idx_inv_cant ON inventario(cantidad);


-- Vistas Agrupadas

CREATE OR REPLACE VIEW vw_inventario_general AS
SELECT 
    p.producto_id AS 'Código',
    p.nombre AS 'Producto',
    i.cantidad AS 'Stock',
    CONCAT('Q', FORMAT(p.precio, 2)) AS 'Unitario',
    CONCAT('Q', FORMAT(i.cantidad * p.precio, 2)) AS 'Valor_Total'
FROM productos p
INNER JOIN inventario i ON p.producto_id = i.producto_id;

CREATE OR REPLACE VIEW vw_productos_ubicacion AS
SELECT 
    a.nombre AS 'Almacen',
    p.nombre AS 'Producto',
    i.cantidad AS 'Stock_Fisico'
FROM almacenes a
INNER JOIN inventario i ON a.almacen_id = i.almacen_id
INNER JOIN productos p ON i.producto_id = p.producto_id
ORDER BY a.nombre;

CREATE OR REPLACE VIEW vw_reporte_ventas AS
SELECT 
    t.fecha AS 'Fecha',
    p.nombre AS 'Producto',
    t.cantidad AS 'Vendidos',
    CONCAT('Q', FORMAT(t.cantidad * p.precio, 2)) AS 'Total_Venta'
FROM transacciones t
INNER JOIN productos p ON t.producto_id = p.producto_id
WHERE t.tipo = 'VENTA_SIMULADA';


-- DEMOSTRACIÓN DE RESULTADOS 
SELECT * FROM vw_inventario_general;
SELECT * FROM vw_productos_ubicacion;
SELECT * FROM vw_reporte_ventas;
