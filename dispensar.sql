-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.27 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for dispensar
DROP DATABASE IF EXISTS `dispensar`;
CREATE DATABASE IF NOT EXISTS `dispensar` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dispensar`;

-- Dumping structure for table dispensar.medici
DROP TABLE IF EXISTS `medici`;
CREATE TABLE IF NOT EXISTS `medici` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nume` varchar(512) CHARACTER SET utf8 DEFAULT NULL,
  `adresa` varchar(512) CHARACTER SET utf8 DEFAULT NULL,
  `specialitatea` varchar(512) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=ascii;

-- Dumping data for table dispensar.medici: ~5 rows (approximately)
INSERT INTO `medici` (`ID`, `nume`, `adresa`, `specialitatea`) VALUES
	(1, 'ADRIANA AVRAMESCU', 'Cabinet Individual - Tg. Mureş, MS', 'Medicină de Familie'),
	(2, 'BOGDAN BĂRBULESCU\r\n', 'Policlinica "Drumul Taberei" - Bucureşti S6', 'Medicină Naturistă\r\n'),
	(3, 'COSTACHE COŞEREANU\r\n', 'Policlinica "Stadion" - Bucureşti S3', 'Medicină Profilactică'),
	(4, 'ŞERBAN ŞTEFĂNESCU', 'Clinica de Medicină - Sinaia, PH', 'Medicină Balneară şi Recuperare'),
	(5, 'TATIANA ŢUCULESCU', 'Centrul Balnear - Mangalia, CT', 'Medicină Internă\r\n');

-- Dumping structure for table dispensar.pacienti
DROP TABLE IF EXISTS `pacienti`;
CREATE TABLE IF NOT EXISTS `pacienti` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nume` varchar(512) CHARACTER SET utf8 NOT NULL,
  `Gen` varchar(1) DEFAULT NULL,
  `data_nastere` date DEFAULT NULL,
  `domiciliu` varchar(512) CHARACTER SET utf8 DEFAULT NULL,
  `id_medic_principal` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_pacienti_medici` (`id_medic_principal`),
  CONSTRAINT `FK_pacienti_medici` FOREIGN KEY (`id_medic_principal`) REFERENCES `medici` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=ascii;

-- Dumping data for table dispensar.pacienti: ~6 rows (approximately)
INSERT INTO `pacienti` (`ID`, `nume`, `Gen`, `data_nastere`, `domiciliu`, `id_medic_principal`) VALUES
	(1, 'Mirel Pălădean', 'm', '1970-04-21', 'Tg. Mureş, MS', 1),
	(2, 'Cătălin Tolodescu', 'm', '1960-08-08', 'Bucureşti S1', 2),
	(3, 'Dan Andreescu', 'm', '1965-11-15', 'Chiaşna, IF', 3),
	(4, 'Marius Deleanu', 'm', '1958-01-28', 'Bucureşti S5', 2),
	(5, 'Adina Mungea', 'f', '1954-12-19', 'Mangalia, CT', 5),
	(6, 'Arina Şăfţoiu', 'f', '1968-10-09', 'Codlea, BV', 4);

-- Dumping structure for table dispensar.recomandari
DROP TABLE IF EXISTS `recomandari`;
CREATE TABLE IF NOT EXISTS `recomandari` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `continut` varchar(4096) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `id_pacient` int(10) unsigned NOT NULL,
  `id_medic` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `unicitate` (`id_pacient`,`id_medic`,`continut`(255)) USING BTREE,
  KEY `FK_recomandari_pacienti` (`id_pacient`),
  KEY `FK_recomandari_medici` (`id_medic`),
  CONSTRAINT `FK_recomandari_medici` FOREIGN KEY (`id_medic`) REFERENCES `medici` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_recomandari_pacienti` FOREIGN KEY (`id_pacient`) REFERENCES `pacienti` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=ascii;

-- Dumping data for table dispensar.recomandari: ~8 rows (approximately)
INSERT INTO `recomandari` (`ID`, `continut`, `id_pacient`, `id_medic`) VALUES
	(1, 'Mişcare în aer liber: alergare moderată, genoflexiuni, mers pe jos rapid.', 1, 2),
	(3, 'Gimnastică cu greutăţi moderate, utilizate progresiv.', 2, 3),
	(4, 'Alimentaţie preponderent vegetariană; de consumat miere sau zahăr de cocos, de eliminat zahărul alb procesat.', 3, 5),
	(6, 'Hidratare cu regularitate; vitaminizare.\r\n', 4, 1),
	(7, 'Aport proteinic din brînzeturi şi carne, foarte rar permis consumul de caşcaval în cantitate mică', 5, 4),
	(8, 'Somn nocturn de calitate, cu perdelele coborâte; pernă mai mult rigidă decât moale.', 6, 2),
	(9, 'Alimentaţie preponderent vegetariană; de consumat miere sau zahăr de cocos, de eliminat zahărul alb procesat.', 2, 5),
	(10, 'Efort intelectual susţinut pentru persoanele vârstnice prin rezolvarea de probleme de matematică / teste de IQ, şi prin povestirea acţiunii unui film.', 5, 2);

-- Dumping structure for procedure dispensar.AfisezRecomandari
DROP PROCEDURE IF EXISTS `AfisezRecomandari`;
DELIMITER //
CREATE PROCEDURE `AfisezRecomandari`()
BEGIN
	-- afiseaza toate recomandarile pacientului cu ID = 2
	SELECT * FROM recomandari WHERE recomandari.id_pacient = 2;

	-- afiseaza toate recomandarile facute de catre medicul cu ID = 5
	SELECT * FROM recomandari WHERE recomandari.id_medic = 5;
END//
DELIMITER ;

-- Dumping structure for procedure dispensar.AlimenteRele
DROP PROCEDURE IF EXISTS `AlimenteRele`;
DELIMITER //
CREATE PROCEDURE `AlimenteRele`(
	IN `primul` LONGTEXT,
	IN `doi` LONGTEXT
)
BEGIN
	SELECT
		-- tabelele referite in SELECT sunt alias-urile
		pac.nume AS Pacientul,
		rec.continut AS Recom,
		med.nume AS Medicul,
		med.adresa AS Clinica
	FROM pacienti pac -- pac = alias pentru prima tabela
	INNER JOIN recomandari rec ON pac.ID = rec.id_pacient -- rec = alias
	INNER JOIN medici med ON med.ID = rec.id_medic -- med = alias
	
	-- indeplinirea conditiei de regasire a textelor cautate
	WHERE rec.continut LIKE CONCAT ( '%', primul, '%' )
	OR rec.continut LIKE CONCAT ( '%', doi, '%' )
	;
END//
DELIMITER ;

-- Dumping structure for procedure dispensar.PacientiiMedicului
DROP PROCEDURE IF EXISTS `PacientiiMedicului`;
DELIMITER //
CREATE PROCEDURE `PacientiiMedicului`(
	IN `nume` LONGTEXT
)
BEGIN
	SELECT
		-- tabelele referite in SELECT sunt alias-urile
		pac.nume AS Pacientul,
		pac.domiciliu AS DomiciliuPacient,
		
		-- calcularea varstei curente (in ani) functie de data nasterii
		TIMESTAMPDIFF(YEAR, pac.data_nastere, CURDATE()) AS Varsta,
		med.nume AS Medicul
	FROM pacienti pac -- pac = alias pentru prima tabela
	INNER JOIN medici med ON med.ID = pac.id_medic_principal -- med = alias
	
	-- asigurarea unei unice aparitii a fiecarui medic
	-- confera interogarii un spor de viteza
	GROUP BY pac.ID
	
	-- conditia de regasire a numelui medicului
	HAVING med.nume LIKE CONCAT ('%', nume, '%' )
	;
END//
DELIMITER ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
