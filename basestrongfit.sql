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
  `calorias` float DEFAULT NULL,
  `idTipoAlimento` varchar(250) DEFAULT NULL,
  `proteinas` float DEFAULT NULL,
  `lipidos` float DEFAULT NULL,
  `carbohidratos` float DEFAULT NULL,
  PRIMARY KEY (`idAlimento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alimento`
--

LOCK TABLES `alimento` WRITE;
/*!40000 ALTER TABLE `alimento` DISABLE KEYS */;
INSERT INTO `alimento` VALUES (1,'taco al pastor',400,'1',NULL,NULL,NULL);
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
-- Table structure for table `cat_tipodieta`
--

DROP TABLE IF EXISTS `cat_tipodieta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_tipodieta` (
  `idTipoDieta` int(11) NOT NULL,
  `tipoDieta` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idTipoDieta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_tipodieta`
--

LOCK TABLES `cat_tipodieta` WRITE;
/*!40000 ALTER TABLE `cat_tipodieta` DISABLE KEYS */;
INSERT INTO `cat_tipodieta` VALUES (1,'muestra'),(2,'nutriologo'),(3,'pagada');
/*!40000 ALTER TABLE `cat_tipodieta` ENABLE KEYS */;
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
  `idTipoDieta` int(11) DEFAULT NULL,
  `kcalorias` int(22) DEFAULT NULL,
  PRIMARY KEY (`idDieta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dieta`
--

LOCK TABLES `dieta` WRITE;
/*!40000 ALTER TABLE `dieta` DISABLE KEYS */;
INSERT INTO `dieta` VALUES (1,'Dieta de 1600Kc',1,NULL),(2,'Dieta vegetariana 1600Kc',1,NULL),(3,'Dieta de carne 1600Kc',1,NULL),(4,'Dieta baja en grasa de 1600Kc',1,NULL),(5,'Dieta de pechuga de 1600Kc',1,NULL);
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
-- Table structure for table `imagenAlimento`
--

DROP TABLE IF EXISTS `imagenAlimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagenAlimento` (
  `idImagenAlimento` int(11) NOT NULL,
  `imagen` blob,
  PRIMARY KEY (`idImagenAlimento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagenAlimento`
--

LOCK TABLES `imagenAlimento` WRITE;
/*!40000 ALTER TABLE `imagenAlimento` DISABLE KEYS */;
/*!40000 ALTER TABLE `imagenAlimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagenalimento`
--

DROP TABLE IF EXISTS `imagenalimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagenalimento` (
  `idImagenAlimento` int(11) NOT NULL,
  `imagen` blob,
  PRIMARY KEY (`idImagenAlimento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagenalimento`
--

LOCK TABLES `imagenalimento` WRITE;
/*!40000 ALTER TABLE `imagenalimento` DISABLE KEYS */;
/*!40000 ALTER TABLE `imagenalimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medico`
--

DROP TABLE IF EXISTS `medico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico` (
  `idMedico` varchar(200) NOT NULL,
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
  `idPaciente` varchar(200) NOT NULL,
  `peso` int(11) DEFAULT NULL,
  `estatura` int(11) DEFAULT NULL,
  `medidaCintura` int(11) DEFAULT NULL,
  `calorias` int(11) DEFAULT NULL,
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
-- Table structure for table `rel_medicoPaciente`
--

DROP TABLE IF EXISTS `rel_medicoPaciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rel_medicoPaciente` (
  `idMedicoPaciente` int(11) NOT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idMedico` int(11) DEFAULT NULL,
  PRIMARY KEY (`idMedicoPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rel_medicoPaciente`
--

LOCK TABLES `rel_medicoPaciente` WRITE;
/*!40000 ALTER TABLE `rel_medicoPaciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `rel_medicoPaciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rel_medicopaciente`
--

DROP TABLE IF EXISTS `rel_medicopaciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rel_medicopaciente` (
  `idMedicoPaciente` int(11) NOT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idMedico` int(11) DEFAULT NULL,
  PRIMARY KEY (`idMedicoPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rel_medicopaciente`
--

LOCK TABLES `rel_medicopaciente` WRITE;
/*!40000 ALTER TABLE `rel_medicopaciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `rel_medicopaciente` ENABLE KEYS */;
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
  `posicion` int(11) DEFAULT NULL,
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
-- Table structure for table `sexo`
--

DROP TABLE IF EXISTS `sexo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sexo` (
  `idSexo` int(11) NOT NULL,
  `sexo` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idSexo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sexo`
--

LOCK TABLES `sexo` WRITE;
/*!40000 ALTER TABLE `sexo` DISABLE KEYS */;
/*!40000 ALTER TABLE `sexo` ENABLE KEYS */;
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
  `idImagenAlimento` int(11) DEFAULT NULL,
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
-- Table structure for table `tipoalimento`
--

DROP TABLE IF EXISTS `tipoalimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoalimento` (
  `idTipoAlimento` int(11) NOT NULL,
  `tipoAlimento` varchar(250) DEFAULT NULL,
  `idImagenAlimento` int(11) DEFAULT NULL,
  PRIMARY KEY (`idTipoAlimento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoalimento`
--

LOCK TABLES `tipoalimento` WRITE;
/*!40000 ALTER TABLE `tipoalimento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipoalimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `idUsuario` varchar(200) NOT NULL,
  `passUsuario` varchar(50) DEFAULT NULL,
  `nombre` varchar(200) DEFAULT NULL,
  `apellidos` varchar(250) DEFAULT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idMedico` int(11) DEFAULT NULL,
  `idSalud` int(11) DEFAULT NULL,
  `idConteo` int(11) DEFAULT NULL,
  `idSexo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('ianmj2013@gmail.com','123','ian',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'basestrongfit'
--
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarDieta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarDieta`(in idUsr int, in idDiet int, in quita nvarchar(10))
begin
	declare relacion int;
	declare idRelacion int;
	
	if quita = "no" then
		set relacion = (select count(*) from rel_usr_dieta where idUsuario = idUsr and idDieta = idDiet);
		if relacion = 0 then
			set idRelacion = (select ifnull(max(idRelUsrDieta), 0) + 1 from rel_usr_dieta);
			insert into rel_usr_dieta(idRelUsrDieta, idUsuario, idDieta) values(idRelacion, idUsr, idDiet);
		else
			select 0 valido, "Ya existe la relacion";
		end if;
	else
		set idRelacion = (select idRelUsrDieta from rel_usr_dieta where idUsuario = idUsr and idDieta = idDiet);
		delete from rel_usr_dieta where idRelUsrDieta = idRelacion;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGetDietasRegistradas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetDietasRegistradas`(in idUsr int)
begin
	select * from rel_usr_dieta join dieta using(idDieta) where idUsuario = idUsr;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGetDietasSugeridas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetDietasSugeridas`()
begin
	select * from dieta where idTipoDieta = 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AltaUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AltaUsuario`(in idUsr varchar(45), in contasena varchar(45),in nombre varchar(45))
begin
declare contador int;
set contador = (select count(*) from usuario where usuario.idUsuario = idUsr);
if contador > 0 then
select 'invalido' as 'nombre';
else
insert into usuario(idUsuario, passUsuario, nombre) values (idUsr, contasena, nombre);
select 'valido' as 'nombre';
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Login`(in idUsr varchar(200), in pass varchar(50))
begin
declare contador int;
declare contador2 int;
declare valor varchar(50);
set contador = (select count(*) from usuario  where usuario.idusuario = idUsr);
set contador2 = (select count(*) from usuario  where usuario.idusuario = idUsr and usuario.passUsuario = pass);
if contador > 0 then
if contador2 > 0 then
select 'si' as 'valido';
else 
select 'nop' as 'valido';
end if;
else 
select 'no' as 'valido';
end if;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-12-13 19:56:38
