# Sistema de Gestion de Inventario — Zona502
### Base de Datos III — Proyecto Final

---

## Descripcion General

Sistema de gestion de inventario para una tienda de electronicos en Guatemala llamada Zona502. Permite administrar productos, controlar stock en 4 almacenes ubicados en distintas zonas de la ciudad, registrar ventas, transferencias entre bodegas y generar reportes en tiempo real.

Tecnologias utilizadas: MySQL 8.0, MongoDB y Ubuntu.

---

## Archivos del Repositorio

| Archivo | Descripcion |
|---------|-------------|
| `BD con Registros.sql` | Dump completo listo para importar |
| `Fase 1 - Script (Creacion Tablas, Gestion de Inventario).sql` | Estructura y funciones base del sistema |
| `Fase 2 - Ejemplos (Particiones y Replicacion).sql` | Optimizacion y replicacion de datos |
| `Fase 2 - Ejemplo Consultas avanzadas.sql` | Reportes y filtros avanzados |
| `Fase 1 - Ejemplos (Gestion Inventario).sql` | Ejemplos de uso del sistema |
| `FASE 2 - APIBASEDEDATOS3.postman_collection.json` | Coleccion de endpoints para pruebas en Postman |

---

 

---

## Fase 1

Diseño e implementacion de la base de datos. Incluye la creacion de tablas, relaciones, procedimientos almacenados para gestionar productos e inventario, triggers de alerta y vistas para reportes generales.

---

## Fase 2

Funcionalidades avanzadas sobre la base existente. Incluye particion horizontal y vertical de tablas, replicacion en tiempo real entre dos servidores MySQL, consultas avanzadas con filtros por precio y stock, gestion de usuarios con permisos reales en MySQL y almacenamiento de historial en MongoDB con API probada en Postman.
