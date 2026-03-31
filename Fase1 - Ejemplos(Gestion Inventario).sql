-- FASE 1- 3 Implementación básica de funciones :

-- Registro, actualización y eliminación de productos.
-- Gestión del inventario.
-- Usuarios y roles.
-- Consultas básicas para reportes generales.

	
-- TIENDA DE ELECTRONICOS Zona502  
select * from almacenes;
 

-- Productos del almacen central 
select producto_id, codigo, nombre, precio
from productos
where estado = 'ACTIVO'
order by producto_id;

call sp_crear_producto(
    'MSI-RTX3060',
    'Tarjeta Grafica MSI RTX 3060',
    'Tarjeta grafica MSI GeForce RTX 3060 12GB GDDR6 ideal para gaming y diseño',
    3800.00,
    'ACTIVO',
    1
);

select * from productos;
  

call sp_actualizar_producto(24, 'Tarjeta Grafica MSI RTX 3060', 4200.00, 'ACTIVO', 1);

select * from productos;
 
 -- --- **** 



 -- -- ****
 

 
  
-- 		INVENTARIO
-- Estado del almacen centarl antes de registra la tarjeta 
select p.nombre, i.cantidad, i.ubicacion_interna, a.nombre as almacen
from inventario i
join productos p on p.producto_id = i.producto_id
join almacenes a on a.almacen_id = i.almacen_id
where i.almacen_id = 1
order by p.nombre;
 

-- añadiendo 15 tarjetas al estante k1 
call sp_registrar_entrada_inventario(24, 1, 15, 2, 'DEFAULT');
-- comprobar 
select p.nombre, i.cantidad, i.ubicacion_interna, a.nombre as almacen
from inventario i
join productos p on p.producto_id = i.producto_id
join almacenes a on a.almacen_id = i.almacen_id
where i.almacen_id = 1
order by p.nombre;

 -- venta de 2 tarjetas
 -- atnes de la venta 
select p.nombre, i.cantidad, a.nombre as almacen
from inventario i
join productos p on p.producto_id = i.producto_id
join almacenes a on a.almacen_id = i.almacen_id
where p.codigo = 'MSI-RTX3060' and i.almacen_id = 1;
-- venta
call sp_simular_venta(24, 1, 2, 2);
-- despues de veder
select p.nombre, i.cantidad, a.nombre as almacen
from inventario i
join productos p on p.producto_id = i.producto_id
join almacenes a on a.almacen_id = i.almacen_id
where p.codigo = 'MSI-RTX3060' and i.almacen_id = 1;


-- TRANSFERIRA del central al norte 
-- antes
select p.nombre, i.cantidad, a.nombre as almacen
from inventario i
join productos p on p.producto_id = i.producto_id
join almacenes a on a.almacen_id = i.almacen_id
where p.codigo = 'MSI-RTX3060';

-- se transfieren 5 unidades
call sp_transferir_inventario(24, 1, 2, 5, 2);
--  despues 
select p.nombre, i.cantidad, a.nombre as almacen
from inventario i
join productos p on p.producto_id = i.producto_id
join almacenes a on a.almacen_id = i.almacen_id
where p.codigo = 'MSI-RTX3060';

-- VEr antes de ajustar 
select p.nombre, i.cantidad, a.nombre as almacen
from inventario i
join productos p on p.producto_id = i.producto_id
join almacenes a on a.almacen_id = i.almacen_id
where p.codigo = 'MSI-RTX3060' and i.almacen_id = 1;

-- ajuste 
call sp_ajustar_inventario(24, 1, 7, 2, 'ajuste por conteo fisico, 1 unidad danada en transporte');
-- despues 
select p.nombre, i.cantidad, a.nombre as almacen
from inventario i
join productos p on p.producto_id = i.producto_id
join almacenes a on a.almacen_id = i.almacen_id
where p.codigo = 'MSI-RTX3060' and i.almacen_id = 1;

 
-- USUARIOS Y ROLES
select * from roles;

select u.nombre_completo, u.correo, r.nombre as rol
from usuarios u
join roles r on r.rol_id = u.rol_id;
 



-- REPORTES 
select * from vw_inventario_general;
select * from vw_productos_por_ubicacion;
select * from vw_ventas_simuladas;








