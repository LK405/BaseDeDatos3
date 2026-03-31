CREATE DATABASE  IF NOT EXISTS `inventario_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventario_db`;
-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: inventario_db
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `almacenes`
--

DROP TABLE IF EXISTS `almacenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `almacenes` (
  `almacen_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) NOT NULL,
  `ubicacion` varchar(200) NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`almacen_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `almacenes`
--

LOCK TABLES `almacenes` WRITE;
/*!40000 ALTER TABLE `almacenes` DISABLE KEYS */;
INSERT INTO `almacenes` VALUES (1,'Almacen Central','Ciudad de Guatemala zona 4','2026-03-08 17:56:00'),(2,'Almacen Norte','Ciudad de Guatemala zona 18','2026-03-08 17:56:03'),(3,'Almacen Sur','12 Calle 5-56 Zona 12, Ciudad de Guatemala','2026-03-26 02:36:49'),(4,'Almacen Oeste','Calzada Roosevelt 22-43 Zona 7, Ciudad de Guatemala','2026-03-26 02:36:53');
/*!40000 ALTER TABLE `almacenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditoria_productos`
--

DROP TABLE IF EXISTS `auditoria_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria_productos` (
  `auditoria_id` bigint NOT NULL AUTO_INCREMENT,
  `producto_id` int NOT NULL,
  `modificado_por` int NOT NULL,
  `tipo_cambio` enum('CREAR','ACTUALIZAR','ELIMINAR') NOT NULL,
  `antes_json` json DEFAULT NULL,
  `despues_json` json DEFAULT NULL,
  `fecha_cambio` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`auditoria_id`),
  KEY `idx_auditoria_producto` (`producto_id`),
  CONSTRAINT `auditoria_productos_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`producto_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria_productos`
--

LOCK TABLES `auditoria_productos` WRITE;
/*!40000 ALTER TABLE `auditoria_productos` DISABLE KEYS */;
INSERT INTO `auditoria_productos` VALUES (1,1,1,'CREAR',NULL,'{\"codigo\": \"DELL-INS-15\", \"estado\": \"ACTIVO\", \"nombre\": \"Laptop Dell Inspiron 15\", \"precio\": 7500.00}','2026-03-08 17:38:14'),(2,2,1,'CREAR',NULL,'{\"codigo\": \"LOG-G435\", \"estado\": \"ACTIVO\", \"nombre\": \"Audifonos Logitech G435\", \"precio\": 850.00}','2026-03-08 17:38:19'),(3,3,1,'CREAR',NULL,'{\"codigo\": \"LOG-G502\", \"estado\": \"ACTIVO\", \"nombre\": \"Mouse Logitech G502\", \"precio\": 450.00}','2026-03-08 17:38:23'),(4,1,1,'ELIMINAR','{\"codigo\": \"DELL-INS-15\", \"estado\": \"ACTIVO\", \"nombre\": \"Laptop Dell Inspiron 15\", \"precio\": 7500.00}',NULL,'2026-03-26 02:22:35'),(5,1,1,'ELIMINAR','{\"codigo\": \"DELL-INS-15\", \"estado\": \"ACTIVO\", \"nombre\": \"Laptop Dell Inspiron 15\", \"precio\": 7500.00}',NULL,'2026-03-26 02:22:50'),(6,2,1,'ELIMINAR','{\"codigo\": \"LOG-G435\", \"estado\": \"ACTIVO\", \"nombre\": \"Audifonos Logitech G435\", \"precio\": 850.00}',NULL,'2026-03-26 02:22:54'),(7,3,1,'ELIMINAR','{\"codigo\": \"LOG-G502\", \"estado\": \"ACTIVO\", \"nombre\": \"Mouse Logitech G502\", \"precio\": 450.00}',NULL,'2026-03-26 02:22:59'),(8,4,1,'CREAR',NULL,'{\"codigo\": \"SAM-A54\", \"estado\": \"ACTIVO\", \"nombre\": \"Celular Samsung Galaxy A54\", \"precio\": 3200.00}','2026-03-26 02:37:28'),(9,5,1,'CREAR',NULL,'{\"codigo\": \"HP-DESK-290\", \"estado\": \"ACTIVO\", \"nombre\": \"Desktop HP 290 G4\", \"precio\": 4800.00}','2026-03-26 02:37:35'),(10,6,1,'CREAR',NULL,'{\"codigo\": \"EPSON-L3250\", \"estado\": \"ACTIVO\", \"nombre\": \"Impresora Epson EcoTank L3250\", \"precio\": 1850.00}','2026-03-26 02:37:40'),(11,7,1,'CREAR',NULL,'{\"codigo\": \"TP-LINK-AC1200\", \"estado\": \"ACTIVO\", \"nombre\": \"Router TP-Link AC1200\", \"precio\": 425.00}','2026-03-26 02:37:47'),(12,8,1,'CREAR',NULL,'{\"codigo\": \"GHIA-TAB7\", \"estado\": \"ACTIVO\", \"nombre\": \"Tablet Ghia 7 pulgadas\", \"precio\": 650.00}','2026-03-26 02:37:55'),(13,9,1,'CREAR',NULL,'{\"codigo\": \"CABLE-HDMI-3M\", \"estado\": \"ACTIVO\", \"nombre\": \"Cable HDMI 3 metros\", \"precio\": 85.00}','2026-03-26 02:38:00'),(14,10,1,'CREAR',NULL,'{\"codigo\": \"LG-OLED55\", \"estado\": \"ACTIVO\", \"nombre\": \"Televisor LG OLED 55 pulgadas\", \"precio\": 12500.00}','2026-03-26 02:38:26'),(15,11,1,'CREAR',NULL,'{\"codigo\": \"NOKIA-105\", \"estado\": \"INACTIVO\", \"nombre\": \"Telefono Nokia 105\", \"precio\": 180.00}','2026-03-26 02:38:38'),(16,12,1,'CREAR',NULL,'{\"codigo\": \"DEMO-REP\", \"estado\": \"ACTIVO\", \"nombre\": \"Producto Demo Replicacion\", \"precio\": 999.00}','2026-03-28 02:10:32'),(17,13,1,'CREAR',NULL,'{\"codigo\": \"DEMO-REP2\", \"estado\": \"ACTIVO\", \"nombre\": \"Producto Demo Replicacion 2\", \"precio\": 500.00}','2026-03-28 02:25:06'),(18,14,1,'CREAR',NULL,'{\"codigo\": \"DEMO-REP3\", \"estado\": \"ACTIVO\", \"nombre\": \"Producto Demo Replicacion 3\", \"precio\": 750.00}','2026-03-28 02:30:04'),(19,15,1,'CREAR',NULL,'{\"codigo\": \"PRUEBA-VIDEO\", \"estado\": \"ACTIVO\", \"nombre\": \"Bocina JBL Flip 6\", \"precio\": 950.00}','2026-03-28 04:04:47'),(20,16,1,'CREAR',NULL,'{\"codigo\": \"WD-SSD-1TB\", \"estado\": \"ACTIVO\", \"nombre\": \"Disco Duro Solido WD 1TB\", \"precio\": 850.00}','2026-03-29 17:01:44'),(21,17,1,'CREAR',NULL,'{\"codigo\": \"KING-RAM-8GB\", \"estado\": \"ACTIVO\", \"nombre\": \"Memoria RAM Kingston 8GB\", \"precio\": 320.00}','2026-03-29 17:01:44'),(22,18,1,'CREAR',NULL,'{\"codigo\": \"KING-RAM-16GB\", \"estado\": \"ACTIVO\", \"nombre\": \"Memoria RAM Kingston 16GB\", \"precio\": 580.00}','2026-03-29 17:01:44'),(23,12,1,'ACTUALIZAR','{\"estado\": \"ACTIVO\", \"nombre\": \"Producto Demo Replicacion\", \"precio\": 999.00}','{\"estado\": \"ACTIVO\", \"nombre\": \"Disco Duro Solido WD 1TB\", \"precio\": 950.00}','2026-03-29 17:10:03'),(24,11,1,'ELIMINAR','{\"codigo\": \"NOKIA-105\", \"estado\": \"INACTIVO\", \"nombre\": \"Telefono Nokia 105\", \"precio\": 180.00}',NULL,'2026-03-29 17:12:31'),(25,19,1,'CREAR',NULL,'{\"codigo\": \"LOGI-C920\", \"estado\": \"ACTIVO\", \"nombre\": \"Webcam Logitech C920\", \"precio\": 650.00}','2026-03-29 17:29:25'),(26,15,1,'ACTUALIZAR','{\"estado\": \"ACTIVO\", \"nombre\": \"Bocina JBL Flip 6\", \"precio\": 950.00}','{\"estado\": \"ACTIVO\", \"nombre\": \"Webcam Logitech C920\", \"precio\": 100.00}','2026-03-29 17:30:24'),(27,15,1,'ACTUALIZAR','{\"estado\": \"ACTIVO\", \"nombre\": \"Webcam Logitech C920\", \"precio\": 100.00}','{\"estado\": \"ACTIVO\", \"nombre\": \"Webcam Logitech C920\", \"precio\": 100.00}','2026-03-29 17:30:42'),(28,15,1,'ACTUALIZAR','{\"estado\": \"ACTIVO\", \"nombre\": \"Webcam Logitech C920\", \"precio\": 100.00}','{\"estado\": \"ACTIVO\", \"nombre\": \"Webcam Logitech C920\", \"precio\": 7700.00}','2026-03-29 17:31:00'),(29,20,1,'CREAR',NULL,'{\"codigo\": \"LOGI-K380\", \"estado\": \"ACTIVO\", \"nombre\": \"Teclado Logitech K380\", \"precio\": 350.00}','2026-03-29 17:41:22'),(30,21,1,'CREAR',NULL,'{\"codigo\": \"AOC-24G2\", \"estado\": \"ACTIVO\", \"nombre\": \"Monitor AOC 24 pulgadas\", \"precio\": 1450.00}','2026-03-29 17:44:25'),(31,17,1,'ACTUALIZAR','{\"estado\": \"ACTIVO\", \"nombre\": \"Memoria RAM Kingston 8GB\", \"precio\": 320.00}','{\"estado\": \"ACTIVO\", \"nombre\": \"Monitor AOC 24 pulgadas\", \"precio\": 1350.00}','2026-03-29 17:45:11'),(32,17,1,'ACTUALIZAR','{\"estado\": \"ACTIVO\", \"nombre\": \"Monitor AOC 24 pulgadas\", \"precio\": 1350.00}','{\"estado\": \"ACTIVO\", \"nombre\": \"Monitor AOC 24 pulgadas\", \"precio\": 1350.00}','2026-03-29 17:45:38'),(33,17,1,'ACTUALIZAR','{\"estado\": \"ACTIVO\", \"nombre\": \"Monitor AOC 24 pulgadas\", \"precio\": 1350.00}','{\"estado\": \"ACTIVO\", \"nombre\": \"Monitor AOC 24 pulgadas\", \"precio\": 1350.00}','2026-03-29 17:47:18'),(34,21,1,'ACTUALIZAR','{\"estado\": \"ACTIVO\", \"nombre\": \"Monitor AOC 24 pulgadas\", \"precio\": 1450.00}','{\"estado\": \"ACTIVO\", \"nombre\": \"Monitor AOC 24 pulgadas\", \"precio\": 1350.00}','2026-03-29 17:48:44'),(35,22,1,'CREAR',NULL,'{\"codigo\": \"SEAG-SSD-500\", \"estado\": \"ACTIVO\", \"nombre\": \"Disco Duro Solido Seagate 500GB\", \"precio\": 650.00}','2026-03-29 17:55:28'),(36,22,1,'ACTUALIZAR','{\"estado\": \"ACTIVO\", \"nombre\": \"Disco Duro Solido Seagate 500GB\", \"precio\": 650.00}','{\"estado\": \"ACTIVO\", \"nombre\": \"Disco Duro Solido Seagate 500GB\", \"precio\": 700.00}','2026-03-29 17:56:31'),(37,13,1,'ELIMINAR','{\"codigo\": \"DEMO-REP2\", \"estado\": \"ACTIVO\", \"nombre\": \"Producto Demo Replicacion 2\", \"precio\": 500.00}',NULL,'2026-03-29 18:06:45'),(38,13,1,'ELIMINAR','{\"codigo\": \"DEMO-REP2\", \"estado\": \"ACTIVO\", \"nombre\": \"Producto Demo Replicacion 2\", \"precio\": 500.00}',NULL,'2026-03-29 18:07:12'),(39,23,1,'CREAR',NULL,'{\"codigo\": \"EVGA-500W\", \"estado\": \"ACTIVO\", \"nombre\": \"Fuente de Poder EVGA 500W\", \"precio\": 450.00}','2026-03-29 18:11:29'),(40,23,1,'ACTUALIZAR','{\"estado\": \"ACTIVO\", \"nombre\": \"Fuente de Poder EVGA 500W\", \"precio\": 450.00}','{\"estado\": \"ACTIVO\", \"nombre\": \"Fuente de Poder EVGA 500W\", \"precio\": 480.00}','2026-03-29 18:12:21'),(41,24,1,'CREAR',NULL,'{\"codigo\": \"MSI-RTX3060\", \"estado\": \"ACTIVO\", \"nombre\": \"Tarjeta Grafica MSI RTX 3060\", \"precio\": 3800.00}','2026-03-29 19:19:38'),(42,24,1,'ACTUALIZAR','{\"estado\": \"ACTIVO\", \"nombre\": \"Tarjeta Grafica MSI RTX 3060\", \"precio\": 3800.00}','{\"estado\": \"ACTIVO\", \"nombre\": \"Tarjeta Grafica MSI RTX 3060\", \"precio\": 4200.00}','2026-03-29 19:20:14'),(43,25,1,'CREAR',NULL,'{\"codigo\": \"PRUEBA-REPLICA\", \"estado\": \"ACTIVO\", \"nombre\": \"Audifono Sony WH1000XM5\", \"precio\": 2800.00}','2026-03-29 21:57:17'),(44,26,1,'CREAR',NULL,'{\"codigo\": \"JBL-GO3\", \"estado\": \"ACTIVO\", \"nombre\": \"Parlante JBL Go 3\", \"precio\": 380.00}','2026-03-29 22:40:34');
/*!40000 ALTER TABLE `auditoria_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `inventario_id` bigint NOT NULL AUTO_INCREMENT,
  `producto_id` int NOT NULL,
  `almacen_id` int NOT NULL,
  `cantidad` int NOT NULL DEFAULT '0',
  `ubicacion_interna` varchar(120) NOT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`inventario_id`,`almacen_id`),
  KEY `idx_inventario_almacen` (`almacen_id`),
  KEY `idx_inventario_cantidad` (`cantidad`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*!50100 PARTITION BY LIST (`almacen_id`)
(PARTITION p_almacen_1 VALUES IN (1) ENGINE = InnoDB,
 PARTITION p_almacen_2 VALUES IN (2) ENGINE = InnoDB,
 PARTITION p_almacen_3 VALUES IN (3) ENGINE = InnoDB,
 PARTITION p_almacen_4 VALUES IN (4) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (1,1,1,5,'ESTANTE-A1','2026-03-26 02:46:01'),(2,2,1,19,'ESTANTE-B1','2026-03-26 02:45:08'),(3,3,1,30,'ESTANTE-C1','2026-03-08 19:56:59'),(5,4,1,15,'DEFAULT','2026-03-26 02:45:08'),(6,5,1,8,'DEFAULT','2026-03-26 02:40:03'),(7,6,1,13,'DEFAULT','2026-03-26 02:45:08'),(8,7,1,30,'DEFAULT','2026-03-26 02:40:03'),(9,8,1,12,'DEFAULT','2026-03-26 02:40:03'),(10,9,1,38,'DEFAULT','2026-03-26 02:46:07'),(11,10,1,2,'DEFAULT','2026-03-26 02:48:12'),(37,12,1,23,'DEFAULT','2026-03-29 17:17:06'),(38,13,1,38,'DEFAULT','2026-03-29 17:15:09'),(39,14,1,12,'DEFAULT','2026-03-29 17:16:29'),(41,16,1,30,'DEFAULT','2026-03-29 17:42:02'),(42,22,1,20,'DEFAULT','2026-03-29 17:58:41'),(43,23,1,11,'DEFAULT','2026-03-29 18:19:00'),(51,24,1,7,'DEFAULT','2026-03-29 21:06:41'),(4,3,2,18,'ESTANTE-C2','2026-03-26 02:45:13'),(12,1,2,7,'DEFAULT','2026-03-26 02:45:13'),(13,2,2,15,'DEFAULT','2026-03-26 02:40:24'),(15,4,2,10,'DEFAULT','2026-03-26 02:40:24'),(16,5,2,4,'DEFAULT','2026-03-26 02:40:24'),(17,6,2,7,'DEFAULT','2026-03-26 02:40:24'),(18,7,2,17,'DEFAULT','2026-03-26 02:46:04'),(19,9,2,32,'DEFAULT','2026-03-26 02:45:13'),(20,10,2,3,'DEFAULT','2026-03-26 02:40:24'),(40,14,2,8,'DEFAULT','2026-03-29 17:16:29'),(52,24,2,5,'DEFAULT','2026-03-29 21:05:34'),(21,1,3,7,'DEFAULT','2026-03-26 02:46:01'),(22,3,3,10,'DEFAULT','2026-03-26 02:40:32'),(23,4,3,6,'DEFAULT','2026-03-26 02:45:17'),(24,6,3,5,'DEFAULT','2026-03-26 02:45:17'),(25,7,3,20,'DEFAULT','2026-03-26 02:40:32'),(26,8,3,3,'DEFAULT','2026-03-26 02:48:19'),(27,9,3,28,'DEFAULT','2026-03-26 02:45:17'),(28,2,4,7,'DEFAULT','2026-03-26 02:45:21'),(29,4,4,6,'DEFAULT','2026-03-26 02:40:40'),(30,5,4,1,'DEFAULT','2026-03-26 02:48:15'),(31,7,4,14,'DEFAULT','2026-03-26 02:46:04'),(32,9,4,37,'DEFAULT','2026-03-26 02:46:07'),(33,10,4,2,'DEFAULT','2026-03-26 02:40:40');
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_actualizacion_inventario` AFTER UPDATE ON `inventario` FOR EACH ROW BEGIN
    -- NEW = valores nuevos despues del UPDATE
    -- OLD = valores anteriores antes del UPDATE
    -- Solo se activa si la cantidad nueva es critica (5 o menos)
    -- y la cantidad anterior estaba bien (mayor a 5)
    IF NEW.cantidad <= 5 AND OLD.cantidad > 5 THEN
        INSERT INTO transacciones(
            tipo, producto_id, almacen_id, cantidad, creado_por, notas
        )
        VALUES(
            'AJUSTE', NEW.producto_id, NEW.almacen_id, NEW.cantidad, 1, 'alerta automatica: stock en nivel critico'
        );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `inventario_backup`
--

DROP TABLE IF EXISTS `inventario_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_backup` (
  `inventario_id` bigint NOT NULL DEFAULT '0',
  `producto_id` int NOT NULL,
  `almacen_id` int NOT NULL,
  `cantidad` int NOT NULL DEFAULT '0',
  `ubicacion_interna` varchar(120) NOT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_backup`
--

LOCK TABLES `inventario_backup` WRITE;
/*!40000 ALTER TABLE `inventario_backup` DISABLE KEYS */;
INSERT INTO `inventario_backup` VALUES (1,1,1,5,'ESTANTE-A1','2026-03-26 02:46:01'),(2,2,1,19,'ESTANTE-B1','2026-03-26 02:45:08'),(3,3,1,30,'ESTANTE-C1','2026-03-08 19:56:59'),(4,3,2,18,'ESTANTE-C2','2026-03-26 02:45:13'),(5,4,1,15,'DEFAULT','2026-03-26 02:45:08'),(6,5,1,8,'DEFAULT','2026-03-26 02:40:03'),(7,6,1,13,'DEFAULT','2026-03-26 02:45:08'),(8,7,1,30,'DEFAULT','2026-03-26 02:40:03'),(9,8,1,12,'DEFAULT','2026-03-26 02:40:03'),(10,9,1,38,'DEFAULT','2026-03-26 02:46:07'),(11,10,1,2,'DEFAULT','2026-03-26 02:48:12'),(12,1,2,7,'DEFAULT','2026-03-26 02:45:13'),(13,2,2,15,'DEFAULT','2026-03-26 02:40:24'),(15,4,2,10,'DEFAULT','2026-03-26 02:40:24'),(16,5,2,4,'DEFAULT','2026-03-26 02:40:24'),(17,6,2,7,'DEFAULT','2026-03-26 02:40:24'),(18,7,2,17,'DEFAULT','2026-03-26 02:46:04'),(19,9,2,32,'DEFAULT','2026-03-26 02:45:13'),(20,10,2,3,'DEFAULT','2026-03-26 02:40:24'),(21,1,3,7,'DEFAULT','2026-03-26 02:46:01'),(22,3,3,10,'DEFAULT','2026-03-26 02:40:32'),(23,4,3,6,'DEFAULT','2026-03-26 02:45:17'),(24,6,3,5,'DEFAULT','2026-03-26 02:45:17'),(25,7,3,20,'DEFAULT','2026-03-26 02:40:32'),(26,8,3,3,'DEFAULT','2026-03-26 02:48:19'),(27,9,3,28,'DEFAULT','2026-03-26 02:45:17'),(28,2,4,7,'DEFAULT','2026-03-26 02:45:21'),(29,4,4,6,'DEFAULT','2026-03-26 02:40:40'),(30,5,4,1,'DEFAULT','2026-03-26 02:48:15'),(31,7,4,14,'DEFAULT','2026-03-26 02:46:04'),(32,9,4,37,'DEFAULT','2026-03-26 02:46:07'),(33,10,4,2,'DEFAULT','2026-03-26 02:40:40');
/*!40000 ALTER TABLE `inventario_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `producto_id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(40) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `precio` decimal(12,2) NOT NULL,
  `estado` enum('ACTIVO','INACTIVO') DEFAULT 'ACTIVO',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`producto_id`),
  UNIQUE KEY `uq_producto_codigo` (`codigo`),
  KEY `idx_producto_precio` (`precio`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'DELL-INS-15','Laptop Dell Inspiron 15',7500.00,'ACTIVO','2026-03-08 17:38:14'),(2,'LOG-G435','Audifonos Logitech G435',850.00,'ACTIVO','2026-03-08 17:38:19'),(3,'LOG-G502','Mouse Logitech G502',450.00,'ACTIVO','2026-03-08 17:38:23'),(4,'SAM-A54','Celular Samsung Galaxy A54',3200.00,'ACTIVO','2026-03-26 02:37:28'),(5,'HP-DESK-290','Desktop HP 290 G4',4800.00,'ACTIVO','2026-03-26 02:37:35'),(6,'EPSON-L3250','Impresora Epson EcoTank L3250',1850.00,'ACTIVO','2026-03-26 02:37:40'),(7,'TP-LINK-AC1200','Router TP-Link AC1200',425.00,'ACTIVO','2026-03-26 02:37:47'),(8,'GHIA-TAB7','Tablet Ghia 7 pulgadas',650.00,'ACTIVO','2026-03-26 02:37:55'),(9,'CABLE-HDMI-3M','Cable HDMI 3 metros',85.00,'ACTIVO','2026-03-26 02:38:00'),(10,'LG-OLED55','Televisor LG OLED 55 pulgadas',12500.00,'ACTIVO','2026-03-26 02:38:26'),(11,'NOKIA-105','Telefono Nokia 105',180.00,'INACTIVO','2026-03-26 02:38:38'),(12,'DEMO-REP','Disco Duro Solido WD 1TB',950.00,'ACTIVO','2026-03-28 02:10:32'),(13,'DEMO-REP2','Producto Demo Replicacion 2',500.00,'ACTIVO','2026-03-28 02:25:06'),(14,'DEMO-REP3','Producto Demo Replicacion 3',750.00,'ACTIVO','2026-03-28 02:30:04'),(15,'PRUEBA-VIDEO','Webcam Logitech C920',7700.00,'ACTIVO','2026-03-28 04:04:47'),(16,'WD-SSD-1TB','Disco Duro Solido WD 1TB',850.00,'ACTIVO','2026-03-29 17:01:44'),(17,'KING-RAM-8GB','Monitor AOC 24 pulgadas',1350.00,'ACTIVO','2026-03-29 17:01:44'),(18,'KING-RAM-16GB','Memoria RAM Kingston 16GB',580.00,'ACTIVO','2026-03-29 17:01:44'),(19,'LOGI-C920','Webcam Logitech C920',650.00,'ACTIVO','2026-03-29 17:29:25'),(20,'LOGI-K380','Teclado Logitech K380',350.00,'ACTIVO','2026-03-29 17:41:22'),(21,'AOC-24G2','Monitor AOC 24 pulgadas',1350.00,'ACTIVO','2026-03-29 17:44:25'),(22,'SEAG-SSD-500','Disco Duro Solido Seagate 500GB',700.00,'ACTIVO','2026-03-29 17:55:28'),(23,'EVGA-500W','Fuente de Poder EVGA 500W',480.00,'ACTIVO','2026-03-29 18:11:29'),(24,'MSI-RTX3060','Tarjeta Grafica MSI RTX 3060',4200.00,'ACTIVO','2026-03-29 19:19:38'),(25,'PRUEBA-REPLICA','Audifono Sony WH1000XM5',2800.00,'ACTIVO','2026-03-29 21:57:17'),(26,'JBL-GO3','Parlante JBL Go 3',380.00,'ACTIVO','2026-03-29 22:40:34');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos_extra`
--

DROP TABLE IF EXISTS `productos_extra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos_extra` (
  `producto_id` int NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`producto_id`),
  CONSTRAINT `productos_extra_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`producto_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos_extra`
--

LOCK TABLES `productos_extra` WRITE;
/*!40000 ALTER TABLE `productos_extra` DISABLE KEYS */;
INSERT INTO `productos_extra` VALUES (1,'Laptop Dell Inspiron 15 pulgadas con procesador Intel Core i5'),(2,'Audifonos inalambricos Logitech para gaming'),(3,'Mouse gamer Logitech G502 con sensor de alta precision'),(4,'Smartphone Samsung Galaxy A54 128GB pantalla 6.4 pulgadas'),(5,'Computadora de escritorio HP procesador Intel Core i3 8GB RAM'),(6,'Impresora multifuncional Epson sistema de tinta continua WiFi'),(7,'Router inalambrico TP-Link doble banda 1200Mbps'),(8,'Tablet Ghia 7 pulgadas 16GB Android quad core economica'),(9,'Cable HDMI macho a macho 3 metros full HD compatible con TV y monitor'),(10,'Televisor LG OLED 55 pulgadas 4K Smart TV con ThinQ AI'),(11,'Telefono basico Nokia 105 doble SIM bateria de larga duracion'),(12,'Prueba de replicacion en tiempo real'),(13,'Segunda prueba de replicacion'),(14,'Tercera prueba de replicacion'),(15,'Bocina portatil JBL resistente al agua'),(16,'SSD Western Digital 1TB SATA lectura 560MB/s ideal para laptops y desktops'),(17,'Memoria RAM DDR4 8GB 3200MHz Kingston compatible con la mayoria de motherboards'),(18,'Memoria RAM DDR4 16GB 3200MHz Kingston para workstations y equipos de alto rendimiento'),(19,'Webcam Full HD 1080p con microfono integrado ideal para videoconferencias'),(20,'Teclado inalambrico Bluetooth Logitech compacto compatible con Windows Mac y Android'),(21,'Monitor AOC Full HD 24 pulgadas 144Hz ideal para gaming y trabajo'),(22,'SSD Seagate 500GB SATA lectura 540MB/s ideal para upgrade de laptops'),(23,'Fuente de poder EVGA 500W 80 Plus certificada para ensamble de computadoras'),(24,'Tarjeta grafica MSI GeForce RTX 3060 12GB GDDR6 ideal para gaming y diseño'),(25,'Audifono inalambrico Sony cancelacion de ruido activa'),(26,'Parlante portatil JBL Go 3 resistente al agua bluetooth 5.1');
/*!40000 ALTER TABLE `productos_extra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `rol_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`rol_id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMINISTRADOR'),(2,'ENCARGADO_INVENTARIO');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transacciones`
--

DROP TABLE IF EXISTS `transacciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transacciones` (
  `transaccion_id` bigint NOT NULL AUTO_INCREMENT,
  `tipo` enum('ENTRADA','SALIDA','AJUSTE','VENTA_SIMULADA','TRANSFERENCIA') NOT NULL,
  `producto_id` int NOT NULL,
  `almacen_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_por` int NOT NULL,
  `notas` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`transaccion_id`),
  KEY `producto_id` (`producto_id`),
  KEY `almacen_id` (`almacen_id`),
  KEY `creado_por` (`creado_por`),
  KEY `idx_transaccion_fecha` (`fecha`),
  KEY `idx_transaccion_tipo` (`tipo`),
  CONSTRAINT `transacciones_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`producto_id`),
  CONSTRAINT `transacciones_ibfk_2` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`almacen_id`),
  CONSTRAINT `transacciones_ibfk_3` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`usuario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacciones`
--

LOCK TABLES `transacciones` WRITE;
/*!40000 ALTER TABLE `transacciones` DISABLE KEYS */;
INSERT INTO `transacciones` VALUES (1,'ENTRADA',1,1,10,'2026-03-08 12:18:42',2,'ESTANTE-A1'),(2,'ENTRADA',2,1,25,'2026-03-08 12:18:46',2,'ESTANTE-B2'),(3,'ENTRADA',3,1,30,'2026-03-08 12:18:50',2,'ESTANTE-C3'),(4,'VENTA_SIMULADA',1,1,1,'2026-03-08 12:41:45',2,NULL),(5,'VENTA_SIMULADA',2,1,2,'2026-03-08 12:41:52',2,NULL),(6,'VENTA_SIMULADA',3,1,1,'2026-03-08 12:41:55',2,NULL),(7,'TRANSFERENCIA',3,1,2,'2026-03-08 12:53:43',2,'transferencia a otro almacen'),(8,'AJUSTE',2,1,22,'2026-03-08 13:02:17',2,'ajuste por conteo fisico'),(9,'AJUSTE',3,1,30,'2026-03-08 13:56:59',1,'actualizacion automatica de inventario'),(10,'ENTRADA',4,1,20,'2026-03-25 20:40:03',2,'ESTANTE-D1'),(11,'ENTRADA',5,1,8,'2026-03-25 20:40:03',2,'ESTANTE-D2'),(12,'ENTRADA',6,1,15,'2026-03-25 20:40:03',2,'ESTANTE-E1'),(13,'ENTRADA',7,1,30,'2026-03-25 20:40:03',2,'ESTANTE-E2'),(14,'ENTRADA',8,1,12,'2026-03-25 20:40:03',2,'ESTANTE-F1'),(15,'ENTRADA',9,1,50,'2026-03-25 20:40:03',2,'ESTANTE-F2'),(16,'ENTRADA',10,1,5,'2026-03-25 20:40:03',2,'ESTANTE-G1'),(17,'ENTRADA',1,2,8,'2026-03-25 20:40:24',2,'ESTANTE-A1'),(18,'ENTRADA',2,2,15,'2026-03-25 20:40:24',2,'ESTANTE-A2'),(19,'ENTRADA',3,2,20,'2026-03-25 20:40:24',2,'ESTANTE-B1'),(20,'ENTRADA',4,2,10,'2026-03-25 20:40:24',2,'ESTANTE-B2'),(21,'ENTRADA',5,2,4,'2026-03-25 20:40:24',2,'ESTANTE-C1'),(22,'ENTRADA',6,2,7,'2026-03-25 20:40:24',2,'ESTANTE-C2'),(23,'ENTRADA',7,2,25,'2026-03-25 20:40:24',2,'ESTANTE-D1'),(24,'ENTRADA',9,2,40,'2026-03-25 20:40:24',2,'ESTANTE-D2'),(25,'ENTRADA',10,2,3,'2026-03-25 20:40:24',2,'ESTANTE-E1'),(26,'ENTRADA',1,3,5,'2026-03-25 20:40:32',2,'ESTANTE-A1'),(27,'ENTRADA',3,3,10,'2026-03-25 20:40:32',2,'ESTANTE-A2'),(28,'ENTRADA',4,3,8,'2026-03-25 20:40:32',2,'ESTANTE-B1'),(29,'ENTRADA',6,3,6,'2026-03-25 20:40:32',2,'ESTANTE-B2'),(30,'ENTRADA',7,3,20,'2026-03-25 20:40:32',2,'ESTANTE-C1'),(31,'ENTRADA',8,3,5,'2026-03-25 20:40:32',2,'ESTANTE-C2'),(32,'ENTRADA',9,3,35,'2026-03-25 20:40:32',2,'ESTANTE-D1'),(33,'ENTRADA',2,4,10,'2026-03-25 20:40:40',2,'ESTANTE-A1'),(34,'ENTRADA',4,4,6,'2026-03-25 20:40:40',2,'ESTANTE-A2'),(35,'ENTRADA',5,4,3,'2026-03-25 20:40:40',2,'ESTANTE-B1'),(36,'ENTRADA',7,4,15,'2026-03-25 20:40:40',2,'ESTANTE-B2'),(37,'ENTRADA',9,4,45,'2026-03-25 20:40:40',2,'ESTANTE-C1'),(38,'ENTRADA',10,4,2,'2026-03-25 20:40:40',2,'ESTANTE-C2'),(39,'VENTA_SIMULADA',1,1,2,'2026-03-25 20:45:08',2,NULL),(40,'VENTA_SIMULADA',2,1,3,'2026-03-25 20:45:08',2,NULL),(41,'VENTA_SIMULADA',4,1,5,'2026-03-25 20:45:08',2,NULL),(42,'VENTA_SIMULADA',6,1,2,'2026-03-25 20:45:08',2,NULL),(43,'VENTA_SIMULADA',9,1,10,'2026-03-25 20:45:08',2,NULL),(44,'VENTA_SIMULADA',1,2,1,'2026-03-25 20:45:13',2,NULL),(45,'VENTA_SIMULADA',3,2,4,'2026-03-25 20:45:13',2,NULL),(46,'VENTA_SIMULADA',7,2,5,'2026-03-25 20:45:13',2,NULL),(47,'VENTA_SIMULADA',9,2,8,'2026-03-25 20:45:13',2,NULL),(48,'VENTA_SIMULADA',4,3,2,'2026-03-25 20:45:17',2,NULL),(49,'AJUSTE',6,3,5,'2026-03-25 20:45:17',1,'alerta automatica: stock en nivel critico'),(50,'VENTA_SIMULADA',6,3,1,'2026-03-25 20:45:17',2,NULL),(51,'VENTA_SIMULADA',9,3,7,'2026-03-25 20:45:17',2,NULL),(52,'VENTA_SIMULADA',2,4,3,'2026-03-25 20:45:21',2,NULL),(53,'VENTA_SIMULADA',7,4,4,'2026-03-25 20:45:21',2,NULL),(54,'VENTA_SIMULADA',9,4,10,'2026-03-25 20:45:21',2,NULL),(55,'AJUSTE',1,1,5,'2026-03-25 20:46:01',1,'alerta automatica: stock en nivel critico'),(56,'TRANSFERENCIA',1,1,2,'2026-03-25 20:46:01',2,'transferencia a otro almacen'),(57,'TRANSFERENCIA',7,2,3,'2026-03-25 20:46:04',2,'transferencia a otro almacen'),(58,'TRANSFERENCIA',9,1,2,'2026-03-25 20:46:07',2,'transferencia a otro almacen'),(59,'AJUSTE',10,1,2,'2026-03-25 20:48:12',2,'ajuste por conteo fisico, unidades danadas'),(60,'AJUSTE',5,4,1,'2026-03-25 20:48:15',2,'ajuste por conteo fisico'),(61,'AJUSTE',8,3,3,'2026-03-25 20:48:19',2,'ajuste por conteo fisico, devolucion de cliente'),(62,'AJUSTE',8,3,3,'2026-03-25 20:50:15',2,'ajuste por conteo fisico, devolucion de cliente'),(63,'AJUSTE',5,4,1,'2026-03-25 20:50:18',2,'ajuste por conteo fisico'),(64,'AJUSTE',10,1,2,'2026-03-25 20:50:22',2,'ajuste por conteo fisico, unidades danadas'),(65,'ENTRADA',12,1,25,'2026-03-29 11:13:53',2,'ESTANTE-H1'),(66,'ENTRADA',13,1,40,'2026-03-29 11:13:53',2,'ESTANTE-H2'),(67,'ENTRADA',14,1,20,'2026-03-29 11:13:53',2,'ESTANTE-H3'),(68,'VENTA_SIMULADA',13,1,2,'2026-03-29 11:15:09',2,NULL),(69,'TRANSFERENCIA',14,1,8,'2026-03-29 11:16:29',2,'transferencia a otro almacen'),(70,'AJUSTE',12,1,23,'2026-03-29 11:17:06',2,'ajuste por conteo fisico, 2 unidades danadas en transporte'),(71,'ENTRADA',16,1,30,'2026-03-29 11:42:02',2,'ESTANTE-H4'),(72,'ENTRADA',22,1,20,'2026-03-29 11:58:41',2,'ESTANTE-J1'),(73,'ENTRADA',23,1,20,'2026-03-29 12:13:49',2,'ESTANTE-J1'),(74,'ENTRADA',23,1,20,'2026-03-29 12:14:29',2,'ESTANTE-J1'),(75,'ENTRADA',23,1,20,'2026-03-29 12:16:02',2,'ESTANTE-J1'),(76,'AJUSTE',23,1,11,'2026-03-29 12:19:00',2,'ajuste por conteo fisico, 1 unidad danada en transporte'),(77,'ENTRADA',24,1,15,'2026-03-29 13:23:23',2,'ESTANTE-K1'),(78,'ENTRADA',24,1,15,'2026-03-29 13:24:02',2,'ESTANTE-K1'),(79,'ENTRADA',24,1,15,'2026-03-29 13:30:37',2,'ESTANTE-K1'),(80,'ENTRADA',24,1,15,'2026-03-29 13:31:24',2,'ESTANTE-K1'),(81,'ENTRADA',24,1,15,'2026-03-29 14:45:15',2,'ESTANTE-K1'),(82,'ENTRADA',24,1,15,'2026-03-29 14:58:05',2,'DEFAULT'),(83,'VENTA_SIMULADA',24,1,2,'2026-03-29 15:01:46',2,NULL),(84,'TRANSFERENCIA',24,1,5,'2026-03-29 15:05:34',2,'transferencia a otro almacen'),(85,'AJUSTE',24,1,7,'2026-03-29 15:06:41',2,'ajuste por conteo fisico, 1 unidad danada en transporte');
/*!40000 ALTER TABLE `transacciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `usuario_id` int NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(120) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `rol_id` int NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`usuario_id`),
  UNIQUE KEY `correo` (`correo`),
  KEY `rol_id` (`rol_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Carlos Ramirez','carlos.ramirez@ejemplo.gt','sha256_admin_demo',1,'2026-03-08 17:25:19'),(2,'Ana Lopez','ana.lopez@ejemplo.gt','sha256_operador_demo',2,'2026-03-08 17:25:23');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_inventario_general`
--

DROP TABLE IF EXISTS `vw_inventario_general`;
/*!50001 DROP VIEW IF EXISTS `vw_inventario_general`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_inventario_general` AS SELECT 
 1 AS `codigo`,
 1 AS `nombre`,
 1 AS `stock_total`,
 1 AS `precio`,
 1 AS `valor_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_productos_detalle`
--

DROP TABLE IF EXISTS `vw_productos_detalle`;
/*!50001 DROP VIEW IF EXISTS `vw_productos_detalle`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_productos_detalle` AS SELECT 
 1 AS `producto_id`,
 1 AS `codigo`,
 1 AS `nombre`,
 1 AS `descripcion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_productos_frecuente`
--

DROP TABLE IF EXISTS `vw_productos_frecuente`;
/*!50001 DROP VIEW IF EXISTS `vw_productos_frecuente`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_productos_frecuente` AS SELECT 
 1 AS `producto_id`,
 1 AS `codigo`,
 1 AS `nombre`,
 1 AS `precio`,
 1 AS `estado`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_productos_por_ubicacion`
--

DROP TABLE IF EXISTS `vw_productos_por_ubicacion`;
/*!50001 DROP VIEW IF EXISTS `vw_productos_por_ubicacion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_productos_por_ubicacion` AS SELECT 
 1 AS `almacen`,
 1 AS `ubicacion_interna`,
 1 AS `codigo`,
 1 AS `nombre`,
 1 AS `cantidad`,
 1 AS `precio`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_ventas_simuladas`
--

DROP TABLE IF EXISTS `vw_ventas_simuladas`;
/*!50001 DROP VIEW IF EXISTS `vw_ventas_simuladas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_ventas_simuladas` AS SELECT 
 1 AS `transaccion_id`,
 1 AS `fecha`,
 1 AS `almacen`,
 1 AS `codigo`,
 1 AS `nombre`,
 1 AS `cantidad`,
 1 AS `precio`,
 1 AS `valor_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'inventario_db'
--

--
-- Dumping routines for database 'inventario_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_actualizar_producto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_producto`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_actualizar_rol_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_rol_usuario`(
    IN p_usuario_id INT,
    IN p_rol_id INT
)
BEGIN

    START TRANSACTION;

    UPDATE usuarios
    SET rol_id = p_rol_id
    WHERE usuario_id = p_usuario_id;

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ajustar_inventario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ajustar_inventario`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_crear_almacen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_crear_almacen`(
    IN p_nombre VARCHAR(120),
    IN p_ubicacion VARCHAR(200)
)
BEGIN

    INSERT INTO almacenes(nombre, ubicacion)
    VALUES(p_nombre, p_ubicacion);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_crear_producto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_crear_producto`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_crear_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_crear_usuario`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_eliminar_producto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_producto`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrar_entrada_inventario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_entrada_inventario`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_simular_venta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_simular_venta`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_transferir_inventario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_transferir_inventario`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_inventario_general`
--

/*!50001 DROP VIEW IF EXISTS `vw_inventario_general`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_inventario_general` AS select `p`.`codigo` AS `codigo`,`p`.`nombre` AS `nombre`,sum(`i`.`cantidad`) AS `stock_total`,`p`.`precio` AS `precio`,(sum(`i`.`cantidad`) * `p`.`precio`) AS `valor_total` from (`productos` `p` join `inventario` `i` on((`i`.`producto_id` = `p`.`producto_id`))) where (`p`.`estado` = 'ACTIVO') group by `p`.`producto_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_productos_detalle`
--

/*!50001 DROP VIEW IF EXISTS `vw_productos_detalle`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_productos_detalle` AS select `p`.`producto_id` AS `producto_id`,`p`.`codigo` AS `codigo`,`p`.`nombre` AS `nombre`,`pe`.`descripcion` AS `descripcion` from (`productos` `p` join `productos_extra` `pe` on((`pe`.`producto_id` = `p`.`producto_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_productos_frecuente`
--

/*!50001 DROP VIEW IF EXISTS `vw_productos_frecuente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_productos_frecuente` AS select `productos`.`producto_id` AS `producto_id`,`productos`.`codigo` AS `codigo`,`productos`.`nombre` AS `nombre`,`productos`.`precio` AS `precio`,`productos`.`estado` AS `estado` from `productos` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_productos_por_ubicacion`
--

/*!50001 DROP VIEW IF EXISTS `vw_productos_por_ubicacion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_productos_por_ubicacion` AS select `a`.`nombre` AS `almacen`,`i`.`ubicacion_interna` AS `ubicacion_interna`,`p`.`codigo` AS `codigo`,`p`.`nombre` AS `nombre`,`i`.`cantidad` AS `cantidad`,`p`.`precio` AS `precio` from ((`inventario` `i` join `almacenes` `a` on((`a`.`almacen_id` = `i`.`almacen_id`))) join `productos` `p` on((`p`.`producto_id` = `i`.`producto_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_ventas_simuladas`
--

/*!50001 DROP VIEW IF EXISTS `vw_ventas_simuladas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_ventas_simuladas` AS select `t`.`transaccion_id` AS `transaccion_id`,`t`.`fecha` AS `fecha`,`a`.`nombre` AS `almacen`,`p`.`codigo` AS `codigo`,`p`.`nombre` AS `nombre`,`t`.`cantidad` AS `cantidad`,`p`.`precio` AS `precio`,(`t`.`cantidad` * `p`.`precio`) AS `valor_total` from ((`transacciones` `t` join `productos` `p` on((`p`.`producto_id` = `t`.`producto_id`))) join `almacenes` `a` on((`a`.`almacen_id` = `t`.`almacen_id`))) where (`t`.`tipo` = 'VENTA_SIMULADA') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-29 20:14:54
