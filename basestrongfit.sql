CREATE DATABASE  IF NOT EXISTS `basestrongfit` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `basestrongfit`;
-- MySQL dump 10.13  Distrib 5.5.40, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: basestrongfit
-- ------------------------------------------------------
-- Server version	5.5.40-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alimento`
--

DROP TABLE IF EXISTS `alimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alimento` (
  `idAlimento` int(11) NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `calorias` int(11) DEFAULT NULL,
  `idTipoAlimento` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idAlimento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alimento`
--

LOCK TABLES `alimento` WRITE;
/*!40000 ALTER TABLE `alimento` DISABLE KEYS */;
INSERT INTO `alimento` VALUES (1,'taco al pastor',400,'1');
/*!40000 ALTER TABLE `alimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_dia`
--

DROP TABLE IF EXISTS `cat_dia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_dia` (
  `idCatDia` int(11) NOT NULL,
  `catDia` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idCatDia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_dia`
--

LOCK TABLES `cat_dia` WRITE;
/*!40000 ALTER TABLE `cat_dia` DISABLE KEYS */;
/*!40000 ALTER TABLE `cat_dia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_tiempocomida`
--

DROP TABLE IF EXISTS `cat_tiempocomida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_tiempocomida` (
  `idTiempoComida` int(11) NOT NULL,
  `tiempo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idTiempoComida`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_tiempocomida`
--

LOCK TABLES `cat_tiempocomida` WRITE;
/*!40000 ALTER TABLE `cat_tiempocomida` DISABLE KEYS */;
/*!40000 ALTER TABLE `cat_tiempocomida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comidas`
--

DROP TABLE IF EXISTS `comidas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comidas` (
  `idComidas` int(11) NOT NULL,
  `idTiempoComida` int(11) DEFAULT NULL,
  `idAlimento` int(11) DEFAULT NULL,
  `idDia` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`idComidas`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comidas`
--

LOCK TABLES `comidas` WRITE;
/*!40000 ALTER TABLE `comidas` DISABLE KEYS */;
/*!40000 ALTER TABLE `comidas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conteocalorico`
--

DROP TABLE IF EXISTS `conteocalorico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conteocalorico` (
  `idConteo` int(11) NOT NULL,
  `caloriasSem` int(11) DEFAULT NULL,
  `caloriasMen` int(11) DEFAULT NULL,
  `caloriasDia` int(11) DEFAULT NULL,
  PRIMARY KEY (`idConteo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conteocalorico`
--

LOCK TABLES `conteocalorico` WRITE;
/*!40000 ALTER TABLE `conteocalorico` DISABLE KEYS */;
/*!40000 ALTER TABLE `conteocalorico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dia`
--

DROP TABLE IF EXISTS `dia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dia` (
  `idDia` int(11) NOT NULL,
  `idCatDia` int(11) DEFAULT NULL,
  `idDieta` int(11) DEFAULT NULL,
  PRIMARY KEY (`idDia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dia`
--

LOCK TABLES `dia` WRITE;
/*!40000 ALTER TABLE `dia` DISABLE KEYS */;
/*!40000 ALTER TABLE `dia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dieta`
--

DROP TABLE IF EXISTS `dieta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dieta` (
  `idDieta` int(11) NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idDieta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dieta`
--

LOCK TABLES `dieta` WRITE;
/*!40000 ALTER TABLE `dieta` DISABLE KEYS */;
/*!40000 ALTER TABLE `dieta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direccion`
--

DROP TABLE IF EXISTS `direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `direccion` (
  `idDireccion` int(11) NOT NULL,
  `estado` varchar(250) DEFAULT NULL,
  `municipio` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idDireccion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direccion`
--

LOCK TABLES `direccion` WRITE;
/*!40000 ALTER TABLE `direccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `direccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadosalud`
--

DROP TABLE IF EXISTS `estadosalud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estadosalud` (
  `idSalud` int(11) NOT NULL,
  `tipoEstado` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idSalud`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadosalud`
--

LOCK TABLES `estadosalud` WRITE;
/*!40000 ALTER TABLE `estadosalud` DISABLE KEYS */;
/*!40000 ALTER TABLE `estadosalud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medico`
--

DROP TABLE IF EXISTS `medico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico` (
  `idMedico` int(11) NOT NULL,
  `cedulaProf` int(11) DEFAULT NULL,
  `escuela` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idMedico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medico`
--

LOCK TABLES `medico` WRITE;
/*!40000 ALTER TABLE `medico` DISABLE KEYS */;
/*!40000 ALTER TABLE `medico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensajes`
--

DROP TABLE IF EXISTS `mensajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mensajes` (
  `idMensajes` int(11) NOT NULL,
  `remitente` int(11) DEFAULT NULL,
  `destinatario` int(11) DEFAULT NULL,
  `mensaje` text,
  PRIMARY KEY (`idMensajes`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensajes`
--

LOCK TABLES `mensajes` WRITE;
/*!40000 ALTER TABLE `mensajes` DISABLE KEYS */;
/*!40000 ALTER TABLE `mensajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paciente` (
  `idPaciente` int(11) NOT NULL,
  `peso` int(11) DEFAULT NULL,
  `estatura` int(11) DEFAULT NULL,
  `medidaCintura` int(11) DEFAULT NULL,
  PRIMARY KEY (`idPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente`
--

LOCK TABLES `paciente` WRITE;
/*!40000 ALTER TABLE `paciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rel_usr_dieta`
--

DROP TABLE IF EXISTS `rel_usr_dieta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rel_usr_dieta` (
  `idRelUsrDieta` int(11) NOT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `idDieta` int(11) DEFAULT NULL,
  PRIMARY KEY (`idRelUsrDieta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rel_usr_dieta`
--

LOCK TABLES `rel_usr_dieta` WRITE;
/*!40000 ALTER TABLE `rel_usr_dieta` DISABLE KEYS */;
/*!40000 ALTER TABLE `rel_usr_dieta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoAlimento`
--

DROP TABLE IF EXISTS `tipoAlimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoAlimento` (
  `idTipoAlimento` int(11) NOT NULL,
  `tipoAlimento` varchar(250) DEFAULT NULL,
  `imagen` blob,
  PRIMARY KEY (`idTipoAlimento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoAlimento`
--

LOCK TABLES `tipoAlimento` WRITE;
/*!40000 ALTER TABLE `tipoAlimento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipoAlimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `passUsuario` varchar(50) DEFAULT NULL,
  `nombre` varchar(200) DEFAULT NULL,
  `apellidos` varchar(250) DEFAULT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idMedico` int(11) DEFAULT NULL,
  `idSalud` int(11) DEFAULT NULL,
  `idConteo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'basestrongfit'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-21 15:26:50
