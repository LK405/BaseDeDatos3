use inventario_db;

-- PARTICION HORIZONTAL
-- Verificar las 4 particiones
select partition_name, table_rows
from information_schema.partitions
where table_name = 'inventario'
and table_schema = 'inventario_db';

-- Consultar solo el Almacen Central
select * from inventario partition (p_almacen_1);

-- Consultar solo el Almacen Norte
select * from inventario partition (p_almacen_2);

-- PARTICION VERTICAL
-- Vista de consulta frecuente
select * from vw_productos_frecuente;

-- Vista de consulta ocasional con descripcion
select * from vw_productos_detalle;

-- REPLICACION - ejecutar en servidor principal
call sp_crear_producto(
    'JBL-GO3',
    'Parlante JBL Go 3',
    'Parlante portatil JBL Go 3 resistente al agua bluetooth 5.1',
    380.00,
    'ACTIVO',
    1
);

select producto_id, codigo, nombre, precio
from productos
where codigo = 'JBL-GO3';


-- SCritp para la instancia  secundaria
use inventario_db;
select producto_id, codigo, nombre, precio
from productos
where codigo = 'JBL-GO3';