-- MySQL dump 10.13  Distrib 8.3.0, for macos14.2 (arm64)
--
-- Host: 127.0.0.1    Database: testdb
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Dept`
--

DROP TABLE IF EXISTS `Dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Dept` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `pid` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '상위부서id',
  `dname` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `captain` int unsigned DEFAULT NULL COMMENT '부서장',
  PRIMARY KEY (`id`),
  KEY `fk_Dept_captain_Emp` (`captain`),
  CONSTRAINT `fk_Dept_captain_Emp` FOREIGN KEY (`captain`) REFERENCES `Emp` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dept`
--

LOCK TABLES `Dept` WRITE;
/*!40000 ALTER TABLE `Dept` DISABLE KEYS */;
INSERT INTO `Dept` VALUES (1,0,'영업부',NULL),(2,0,'개발부',30),(3,1,'영업1팀',78),(4,1,'영업2팀',51),(5,1,'영업3팀',169),(6,2,'서버팀',109),(7,2,'클라이언트팀',150),(8,6,'인프라셀',NULL),(9,6,'DB셀',NULL),(10,7,'모바일셀',NULL);
/*!40000 ALTER TABLE `Dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EmailLog`
--

DROP TABLE IF EXISTS `EmailLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EmailLog` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sender` int unsigned NOT NULL COMMENT '발신자',
  `receiver` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '수신자',
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '제목',
  `body` text COLLATE utf8mb4_unicode_ci COMMENT '내용',
  PRIMARY KEY (`id`),
  KEY `fk_EmailLog_sender_Emp` (`sender`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EmailLog`
--

LOCK TABLES `EmailLog` WRITE;
/*!40000 ALTER TABLE `EmailLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `EmailLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Emp`
--

DROP TABLE IF EXISTS `Emp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Emp` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ename` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept` tinyint unsigned NOT NULL,
  `auth` tinyint unsigned NOT NULL DEFAULT '9' COMMENT '0:sysadmin, 1:superuser, 3: manager, 5:employee, 7:temporary, 9:guest',
  `salary` int NOT NULL DEFAULT '0',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `outdt` date DEFAULT NULL COMMENT '퇴사일',
  `outdt2` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '퇴사일2',
  `remark` json DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dept` (`dept`),
  KEY `index_Emp_remark_famxx` ((cast(json_unquote(json_extract(`remark`,_utf8mb4'$.fam[*].name')) as char(255) array))),
  KEY `functional_index` ((substring_index(`email`,_utf8mb4'@',-(1)))),
  KEY `functional_index_2` ((substr(`mobile`,8,4))),
  CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`dept`) REFERENCES `Dept` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Emp`
--

LOCK TABLES `Emp` WRITE;
/*!40000 ALTER TABLE `Emp` DISABLE KEYS */;
INSERT INTO `Emp` VALUES (2,'유세혜',4,9,300,'01012340002',NULL,NULL,'{\"id\": 1, \"age\": 55, \"fam\": [{\"id\": 1, \"name\": \"유세홍\"}, {\"id\": 2, \"name\": \"새로이\"}], \"name\": \"Hong\"}','mail2@gmail.com'),(3,'원사아',4,9,100,'01012340003','2025-04-26','2025-04-25','{\"id\": 3, \"age\": 33, \"fam\": [{\"id\": 1, \"name\": \"유세차\"}, {\"id\": 2, \"name\": \"새로이\"}]}','mail3@gmail.com'),(4,'김태혜',5,9,700,'01012340004',NULL,NULL,'[1, 2, 3]','mail4@gmail.com'),(5,'지세국',7,9,400,'01012340005','2025-04-26','2025-04-25','{\"id\": 5, \"age\": 44, \"fam\": [{\"id\": 1, \"name\": \"지세차\"}, {\"id\": 2, \"name\": \"지세창\"}]}','mail5@gmail.com'),(6,'최가국',4,9,800,'01012340006',NULL,NULL,NULL,'mail6@gmail.com'),(7,'배파나',1,9,800,'01012340007',NULL,NULL,NULL,'mail7@gmail.com'),(8,'원성결',2,9,200,'01012340008',NULL,NULL,NULL,'mail8@gmail.com'),(9,'전바찬',6,9,900,'01012340009',NULL,NULL,NULL,'mail9@gmail.com'),(10,'지윤희',5,9,500,'01012340010',NULL,NULL,NULL,'mail10@gmail.com'),(11,'전차가',1,9,900,'01012340011',NULL,NULL,NULL,'mail11@gmail.com'),(12,'지호하',3,9,800,'01012340012',NULL,NULL,NULL,'mail12@gmail.com'),(13,'최종라',5,9,300,'01012340013',NULL,NULL,NULL,'mail13@gmail.com'),(14,'마마순',1,9,700,'01012340014','2025-05-01','2025-05-01',NULL,'mail14@gmail.com'),(15,'원자파',7,9,200,'01012340015',NULL,NULL,NULL,'mail15@gmail.com'),(16,'이결세',7,9,700,'01012340016',NULL,NULL,NULL,'mail16@gmail.com'),(17,'원호신',2,9,600,'01012340017',NULL,NULL,NULL,'mail17@gmail.com'),(18,'전국찬',3,9,904,'01012340018',NULL,NULL,NULL,'mail18@gmail.com'),(19,'방성찬',3,9,800,'01012340019',NULL,NULL,NULL,'mail19@gmail.com'),(20,'최희결',5,9,700,'01012340020',NULL,NULL,NULL,'mail20@gmail.com'),(21,'지찬파',2,9,600,'01012340021',NULL,NULL,NULL,'mail21@gmail.com'),(22,'최파지',4,9,100,'01012340022',NULL,NULL,NULL,'mail22@gmail.com'),(23,'마다윤',4,9,300,'01012340023',NULL,NULL,NULL,'mail23@gmail.com'),(24,'이윤파',6,9,600,'01012340024',NULL,NULL,NULL,'mail24@gmail.com'),(25,'전다윤',3,9,800,'01012340025',NULL,NULL,NULL,'mail25@gmail.com'),(26,'김나나',1,9,800,'01012340026','2025-05-01','2025-05-01',NULL,'mail26@gmail.com'),(27,'원호순',7,9,600,'01012340027',NULL,NULL,NULL,'mail27@gmail.com'),(28,'조국국',7,9,400,'01012340028',NULL,NULL,NULL,'mail28@gmail.com'),(29,'이윤바',1,9,300,'01012340029',NULL,NULL,NULL,'mail29@gmail.com'),(30,'김바순',2,9,800,'01012340030',NULL,NULL,NULL,'mail30@gmail.com'),(31,'방윤윤',6,9,600,'01012340031',NULL,NULL,NULL,'mail31@gmail.com'),(32,'방호지',4,9,900,'01012340032',NULL,NULL,NULL,'mail32@gmail.com'),(33,'최마호',1,9,500,'01012340033',NULL,NULL,NULL,'mail33@gmail.com'),(34,'전아가',3,9,600,'01012340034',NULL,NULL,NULL,'mail34@gmail.com'),(35,'원성태',6,9,600,'01012340035',NULL,NULL,NULL,'mail35@gmail.com'),(36,'마다라',3,9,904,'01012340036',NULL,NULL,NULL,'mail36@gmail.com'),(37,'지라파',3,9,200,'01012340037',NULL,NULL,NULL,'mail37@gmail.com'),(38,'김자나',3,9,300,'01012340038',NULL,NULL,NULL,'mail38@gmail.com'),(39,'전가순',2,9,400,'01012340039',NULL,NULL,NULL,'mail39@gmail.com'),(40,'유호가',6,9,400,'01012340040',NULL,NULL,NULL,'mail40@gmail.com'),(41,'방사자',6,9,400,'01012340041',NULL,NULL,NULL,'mail41@gmail.com'),(42,'마윤결',2,9,700,'01012340042',NULL,NULL,NULL,'mail42@gmail.com'),(43,'마마차',1,9,800,'01012340043',NULL,NULL,NULL,'mail43@gmail.com'),(44,'이찬가',4,9,100,'01012340044',NULL,NULL,NULL,'mail44@gmail.com'),(45,'유태파',5,9,500,'01012340045',NULL,NULL,NULL,'mail45@gmail.com'),(46,'유호다',4,9,200,'01012340046',NULL,NULL,NULL,'mail46@gmail.com'),(47,'이신희',6,9,907,'01012340047',NULL,NULL,NULL,'mail47@gmail.com'),(48,'천마라',7,9,200,'01012340048',NULL,NULL,NULL,'mail48@gmail.com'),(49,'이순아',4,9,600,'01012340049',NULL,NULL,NULL,'mail49@gmail.com'),(50,'최찬자',7,9,200,'01012340050',NULL,NULL,NULL,'mail50@gmail.com'),(51,'김바가',4,9,500,'01012340051',NULL,NULL,NULL,'mail51@gmail.com'),(52,'원가국',6,9,600,'01012340052',NULL,NULL,NULL,'mail52@gmail.com'),(53,'방가다',7,9,100,'01012340053',NULL,NULL,NULL,'mail53@gmail.com'),(54,'전순차',6,9,700,'01012340054',NULL,NULL,NULL,'mail54@gmail.com'),(55,'조종차',5,9,600,'01012340055',NULL,NULL,NULL,'mail55@gmail.com'),(56,'전호라',3,9,200,'01012340056',NULL,NULL,NULL,'mail56@gmail.com'),(57,'천호윤',4,9,500,'01012340057',NULL,NULL,NULL,'mail57@gmail.com'),(58,'마신혜',1,9,300,'01012340058',NULL,NULL,NULL,'mail58@gmail.com'),(59,'전세국',2,9,600,'01012340059',NULL,NULL,NULL,'mail59@gmail.com'),(60,'지호태',2,9,300,'01012340060',NULL,NULL,NULL,'mail60@gmail.com'),(61,'유혜태',4,9,700,'01012340061',NULL,NULL,NULL,'mail61@gmail.com'),(62,'천세찬',4,9,800,'01012340062',NULL,NULL,NULL,'mail62@gmail.com'),(63,'지바혜',3,9,200,'01012340063',NULL,NULL,NULL,'mail63@gmail.com'),(64,'천가차',1,9,800,'01012340064',NULL,NULL,NULL,'mail64@gmail.com'),(65,'배세사',2,9,800,'01012340065',NULL,NULL,NULL,'mail65@gmail.com'),(66,'방나하',6,9,200,'01012340066',NULL,NULL,NULL,'mail66@gmail.com'),(67,'최호태',1,9,800,'01012340067',NULL,NULL,NULL,'mail67@gmail.com'),(68,'마가혜',3,9,100,'01012340068',NULL,NULL,NULL,'mail68@gmail.com'),(69,'김성바',6,9,200,'01012340069',NULL,NULL,NULL,'mail69@gmail.com'),(70,'방혜국',5,9,600,'01012340070',NULL,NULL,NULL,'mail70@gmail.com'),(71,'이파파',4,9,300,'01012340071',NULL,NULL,NULL,'mail71@gmail.com'),(72,'지윤혜',7,9,100,'01012340072',NULL,NULL,NULL,'mail72@gmail.com'),(73,'박찬종',6,9,600,'01012340073',NULL,NULL,NULL,'mail73@gmail.com'),(74,'방혜윤',3,9,300,'01012340074',NULL,NULL,NULL,'mail74@gmail.com'),(75,'전호바',1,9,600,'01012340075',NULL,NULL,NULL,'mail75@gmail.com'),(76,'유희마',1,9,700,'01012340076',NULL,NULL,NULL,'mail76@gmail.com'),(77,'천성혜',7,9,500,'01012340077',NULL,NULL,NULL,'mail77@gmail.com'),(78,'김나라',3,9,800,'01012340078',NULL,NULL,NULL,'mail78@gmail.com'),(79,'최혜성',1,9,700,'01012340079',NULL,NULL,NULL,'mail79@gmail.com'),(80,'지종라',4,9,905,'01012340080',NULL,NULL,NULL,'mail80@gmail.com'),(81,'이바희',7,9,800,'01012340081',NULL,NULL,NULL,'mail81@gmail.com'),(82,'최은가',4,9,800,'01012340082',NULL,NULL,NULL,'mail82@gmail.com'),(83,'배자호',5,9,500,'01012340083',NULL,NULL,NULL,'mail83@gmail.com'),(84,'배사파',7,9,500,'01012340084',NULL,NULL,NULL,'mail84@gmail.com'),(85,'마성다',2,9,400,'01012340085',NULL,NULL,NULL,'mail85@gmail.com'),(86,'최국세',3,9,600,'01012340086',NULL,NULL,NULL,'mail86@gmail.com'),(87,'유다지',4,9,600,'01012340087',NULL,NULL,NULL,'mail87@gmail.com'),(88,'천결신',4,9,400,'01012340088',NULL,NULL,NULL,'mail88@gmail.com'),(89,'박태사',7,9,300,'01012340089',NULL,NULL,NULL,'mail89@gmail.com'),(90,'원파가',7,9,900,'01012340090',NULL,NULL,NULL,'mail90@gmail.com'),(91,'마순차',7,9,300,'01012340091',NULL,NULL,NULL,'mail91@gmail.com'),(92,'지호희',6,9,700,'01012340092',NULL,NULL,NULL,'mail92@gmail.com'),(93,'최가국',6,9,800,'01012340093',NULL,NULL,NULL,'mail93@gmail.com'),(94,'마성나',1,9,200,'01012340094',NULL,NULL,NULL,'mail94@gmail.com'),(95,'조하마',4,9,700,'01012340095',NULL,NULL,NULL,'mail95@gmail.com'),(96,'원바가',3,9,300,'01012340096',NULL,NULL,NULL,'mail96@gmail.com'),(97,'최신세',2,9,903,'01012340097',NULL,NULL,NULL,'mail97@gmail.com'),(98,'김은다',5,9,900,'01012340098',NULL,NULL,NULL,'mail98@gmail.com'),(99,'천라국',5,9,500,'01012340099',NULL,NULL,NULL,'mail99@gmail.com'),(100,'원신국',1,9,200,'01012340100',NULL,NULL,NULL,'mail100@gmail.com'),(101,'방국윤',5,9,300,'01012340101',NULL,NULL,NULL,'mail101@gmail.com'),(102,'박세찬',4,9,600,'01012340102',NULL,NULL,NULL,'mail102@gmail.com'),(103,'최종다',4,9,500,'01012340103',NULL,NULL,NULL,'mail103@gmail.com'),(104,'이신찬',4,9,900,'01012340104',NULL,NULL,NULL,'mail104@gmail.com'),(105,'원종마',6,9,900,'01012340105',NULL,NULL,NULL,'mail105@gmail.com'),(106,'최신호',6,9,200,'01012340106',NULL,NULL,NULL,'mail106@gmail.com'),(107,'지차찬',3,9,100,'01012340107',NULL,NULL,NULL,'mail107@gmail.com'),(108,'이나종',1,9,100,'01012340108',NULL,NULL,NULL,'mail108@gmail.com'),(109,'김결나',6,9,500,'01012340109',NULL,NULL,NULL,'mail109@gmail.com'),(110,'조파호',3,9,600,'01012340110',NULL,NULL,NULL,'mail110@gmail.com'),(111,'유신찬',5,9,200,'01012340111',NULL,NULL,NULL,'mail111@gmail.com'),(112,'원세태',1,9,200,'01012340112',NULL,NULL,NULL,'mail112@gmail.com'),(113,'방호혜',5,9,800,'01012340113',NULL,NULL,NULL,'mail113@gmail.com'),(114,'유마자',7,9,200,'01012340114',NULL,NULL,NULL,'mail114@gmail.com'),(115,'최순신',2,9,900,'01012340115',NULL,NULL,NULL,'mail115@gmail.com'),(116,'조윤혜',7,9,100,'01012340116',NULL,NULL,NULL,'mail116@gmail.com'),(117,'조호호',3,9,400,'01012340117',NULL,NULL,NULL,'mail117@gmail.com'),(118,'마세사',3,9,900,'01012340118',NULL,NULL,NULL,'mail118@gmail.com'),(119,'방결희',1,9,600,'01012340119',NULL,NULL,NULL,'mail119@gmail.com'),(120,'지국혜',1,9,300,'01012340120',NULL,NULL,NULL,'mail120@gmail.com'),(121,'박세결',3,9,100,'01012340121',NULL,NULL,NULL,'mail121@gmail.com'),(122,'조지혜',4,9,800,'01012340122',NULL,NULL,NULL,'mail122@gmail.com'),(123,'방은희',7,9,800,'01012340123',NULL,NULL,NULL,'mail123@gmail.com'),(124,'이성가',7,9,900,'01012340124',NULL,NULL,NULL,'mail124@gmail.com'),(125,'원지신',5,9,300,'01012340125',NULL,NULL,NULL,'mail125@gmail.com'),(126,'천윤아',3,9,600,'01012340126',NULL,NULL,NULL,'mail126@gmail.com'),(127,'원순지',1,9,400,'01012340127',NULL,NULL,NULL,'mail127@gmail.com'),(128,'이윤바',7,9,908,'01012340128',NULL,NULL,NULL,'mail128@gmail.com'),(129,'김신호',6,9,300,'01012340129',NULL,NULL,NULL,'mail129@gmail.com'),(130,'원혜호',2,9,600,'01012340130',NULL,NULL,NULL,'mail130@gmail.com'),(131,'천윤사',2,9,800,'01012340131',NULL,NULL,NULL,'mail131@gmail.com'),(132,'천희가',3,9,600,'01012340132',NULL,NULL,NULL,'mail132@gmail.com'),(133,'원결바',5,9,906,'01012340133',NULL,NULL,NULL,'mail133@gmail.com'),(134,'마성호',4,9,100,'01012340134',NULL,NULL,NULL,'mail134@gmail.com'),(135,'이성다',3,9,800,'01012340135',NULL,NULL,NULL,'mail135@gmail.com'),(136,'조사자',5,9,800,'01012340136',NULL,NULL,NULL,'mail136@gmail.com'),(137,'천찬혜',3,9,400,'01012340137',NULL,NULL,NULL,'mail137@gmail.com'),(138,'전지사',6,9,900,'01012340138',NULL,NULL,NULL,'mail138@gmail.com'),(139,'방자세',2,9,800,'01012340139',NULL,NULL,NULL,'mail139@gmail.com'),(140,'지아마',7,9,700,'01012340140',NULL,NULL,NULL,'mail140@gmail.com'),(141,'김찬마',2,9,500,'01012340141',NULL,NULL,NULL,'mail141@gmail.com'),(142,'방가사',7,9,500,'01012340142',NULL,NULL,NULL,'mail142@gmail.com'),(143,'배아순',7,9,400,'01012340143',NULL,NULL,NULL,'mail143@gmail.com'),(144,'최호희',6,9,200,'01012340144',NULL,NULL,NULL,'mail144@gmail.com'),(145,'최혜혜',4,9,400,'01012340145',NULL,NULL,NULL,'mail145@gmail.com'),(146,'유태차',3,9,200,'01012340146',NULL,NULL,NULL,'mail146@gmail.com'),(147,'원국은',1,9,700,'01012340147',NULL,NULL,NULL,'mail147@gmail.com'),(148,'조혜은',7,9,400,'01012340148',NULL,NULL,NULL,'mail148@gmail.com'),(149,'조가마',2,9,200,'01012340149',NULL,NULL,NULL,'mail149@gmail.com'),(150,'김찬라',7,9,300,'01012340150',NULL,NULL,NULL,'mail150@gmail.com'),(151,'최신세',2,9,900,'01012340151',NULL,NULL,NULL,'mail151@gmail.com'),(152,'박성종',1,9,902,'01012340152',NULL,NULL,NULL,'mail152@gmail.com'),(153,'지나국',6,9,600,'01012340153',NULL,NULL,NULL,'mail153@gmail.com'),(154,'마파결',1,9,500,'01012340154',NULL,NULL,NULL,'mail154@gmail.com'),(155,'조태국',5,9,200,'01012340155',NULL,NULL,NULL,'mail155@gmail.com'),(156,'방나차',3,9,600,'01012340156',NULL,NULL,NULL,'mail156@gmail.com'),(157,'김지희',3,9,500,'01012340157',NULL,NULL,NULL,'mail157@gmail.com'),(158,'유나순',5,9,100,'01012340158',NULL,NULL,NULL,'mail158@gmail.com'),(159,'조윤호',6,9,100,'01012340159',NULL,NULL,NULL,'mail159@gmail.com'),(160,'배다결',7,9,200,'01012340160',NULL,NULL,NULL,'mail160@gmail.com'),(161,'배희호',1,9,500,'01012340161',NULL,NULL,NULL,'mail161@gmail.com'),(162,'방호성',4,9,400,'01012340162',NULL,NULL,NULL,'mail162@gmail.com'),(163,'김세은',3,9,900,'01012340163',NULL,NULL,NULL,'mail163@gmail.com'),(164,'최성라',4,9,800,'01012340164',NULL,NULL,NULL,'mail164@gmail.com'),(165,'마신신',1,9,200,'01012340165',NULL,NULL,NULL,'mail165@gmail.com'),(166,'유윤사',2,9,800,'01012340166',NULL,NULL,NULL,'mail166@gmail.com'),(167,'전파자',3,9,200,'01012340167',NULL,NULL,NULL,'mail167@gmail.com'),(168,'박국다',3,9,300,'01012340168',NULL,NULL,NULL,'mail168@gmail.com'),(169,'김다바',5,9,200,'01012340169',NULL,NULL,NULL,'mail169@gmail.com'),(170,'원호신',6,9,700,'01012340170',NULL,NULL,NULL,'mail170@gmail.com'),(171,'김호파',5,9,500,'01012340171',NULL,NULL,NULL,'mail171@gmail.com'),(172,'방나자',2,9,905,'01012340172',NULL,NULL,NULL,'mail172@gmail.com'),(173,'박세자',4,9,300,'01012340173',NULL,NULL,NULL,'mail173@gmail.com'),(174,'원결바',4,9,500,'01012340174',NULL,NULL,NULL,'mail174@gmail.com'),(175,'김태신',5,9,300,'01012340175',NULL,NULL,NULL,'mail175@gmail.com'),(176,'최신신',2,9,700,'01012340176',NULL,NULL,NULL,'mail176@gmail.com'),(177,'배가하',5,9,300,'01012340177',NULL,NULL,NULL,'mail177@gmail.com'),(178,'지나다',2,9,200,'01012340178',NULL,NULL,NULL,'mail178@gmail.com'),(179,'박사파',7,9,500,'01012340179',NULL,NULL,NULL,'mail179@gmail.com'),(180,'천신아',4,9,300,'01012340180',NULL,NULL,NULL,'mail180@gmail.com'),(181,'이가세',1,9,900,'01012340181',NULL,NULL,NULL,'mail181@gmail.com'),(182,'방신다',4,9,100,'01012340182',NULL,NULL,NULL,'mail182@gmail.com'),(183,'방태가',6,9,700,'01012340183',NULL,NULL,NULL,'mail183@gmail.com'),(184,'박하아',7,9,501,'01012340184',NULL,NULL,NULL,'mail184@gmail.com'),(185,'천성가',7,9,700,'01012340185',NULL,NULL,NULL,'mail185@gmail.com'),(186,'이호라',3,9,400,'01012340186',NULL,NULL,NULL,'mail186@gmail.com'),(187,'천다종',1,9,600,'01012340187',NULL,NULL,NULL,'mail187@gmail.com'),(188,'이하결',7,9,700,'01012340188',NULL,NULL,NULL,'mail188@gmail.com'),(189,'이은호',7,9,400,'01012340189',NULL,NULL,NULL,'mail189@gmail.com'),(190,'이성다',3,9,800,'01012340190',NULL,NULL,NULL,'mail190@gmail.com'),(191,'이신신',1,9,200,'01012340191',NULL,NULL,NULL,'mail191@gmail.com'),(192,'마세가',2,9,100,'01012340192',NULL,NULL,NULL,'mail192@gmail.com'),(193,'원세순',7,9,700,'01012340193',NULL,NULL,NULL,'mail193@gmail.com'),(194,'원윤가',1,9,600,'01012340194',NULL,NULL,NULL,'mail194@gmail.com'),(195,'김세윤',6,9,900,'01012340195',NULL,NULL,NULL,'mail195@gmail.com'),(196,'최찬라',1,9,600,'01012340196',NULL,NULL,NULL,'mail196@gmail.com'),(197,'유호윤',7,9,400,'01012340197',NULL,NULL,NULL,'mail197@gmail.com'),(198,'박차호',5,9,700,'01012340198',NULL,NULL,NULL,'mail198@gmail.com'),(199,'마바순',2,9,800,'01012340199',NULL,NULL,NULL,'mail199@gmail.com'),(200,'방국가',1,9,200,'01012340200',NULL,NULL,NULL,'mail200@gmail.com'),(201,'최세마',1,9,300,'01012340201',NULL,NULL,NULL,'mail201@gmail.com'),(202,'조라종',6,9,500,'01012340202',NULL,NULL,NULL,'mail202@gmail.com'),(203,'이지마',4,9,700,'01012340203',NULL,NULL,NULL,'mail203@gmail.com'),(204,'김신호',6,9,300,'01012340204',NULL,NULL,NULL,'mail204@gmail.com'),(205,'김은다',6,9,200,'01012340205',NULL,NULL,NULL,'mail205@gmail.com'),(206,'마세혜',7,9,700,'01012340206',NULL,NULL,NULL,'mail206@gmail.com'),(207,'김바순',1,9,200,'01012340207',NULL,NULL,NULL,'mail207@gmail.com'),(208,'원순세',5,9,400,'01012340208',NULL,NULL,NULL,'mail208@gmail.com'),(209,'원마종',6,9,600,'01012340209',NULL,NULL,NULL,'mail209@gmail.com'),(210,'마사혜',2,9,200,'01012340210',NULL,NULL,NULL,'mail210@gmail.com'),(211,'박나신',5,9,300,'01012340211',NULL,NULL,NULL,'mail211@gmail.com'),(212,'전호사',6,9,100,'01012340212',NULL,NULL,NULL,'mail212@gmail.com'),(213,'지지호',2,9,400,'01012340213',NULL,NULL,NULL,'mail213@gmail.com'),(214,'천혜파',2,9,900,'01012340214',NULL,NULL,NULL,'mail214@gmail.com'),(215,'지사세',6,9,700,'01012340215',NULL,NULL,NULL,'mail215@gmail.com'),(216,'방나태',6,9,100,'01012340216',NULL,NULL,NULL,'mail216@gmail.com'),(217,'김지하',6,9,400,'01012340217',NULL,NULL,NULL,'mail217@gmail.com'),(218,'지찬태',3,9,300,'01012340218',NULL,NULL,NULL,'mail218@gmail.com'),(219,'조사나',4,9,800,'01012340219',NULL,NULL,NULL,'mail219@gmail.com'),(220,'지차순',6,9,800,'01012340220',NULL,NULL,NULL,'mail220@gmail.com'),(221,'지희태',3,9,300,'01012340221',NULL,NULL,NULL,'mail221@gmail.com'),(222,'이희나',5,9,800,'01012340222',NULL,NULL,NULL,'mail222@gmail.com'),(223,'배신마',7,9,900,'01012340223',NULL,NULL,NULL,'mail223@gmail.com'),(224,'배나희',3,9,900,'01012340224',NULL,NULL,NULL,'mail224@gmail.com'),(225,'마아세',4,9,800,'01012340225',NULL,NULL,NULL,'mail225@gmail.com'),(226,'전바신',2,9,900,'01012340226',NULL,NULL,NULL,'mail226@gmail.com'),(227,'박희윤',1,9,200,'01012340227',NULL,NULL,NULL,'mail227@gmail.com'),(228,'천결호',1,9,100,'01012340228',NULL,NULL,NULL,'mail228@gmail.com'),(229,'마사혜',2,9,200,'01012340229',NULL,NULL,NULL,'mail229@gmail.com'),(230,'최종바',6,9,300,'01012340230',NULL,NULL,NULL,'mail230@gmail.com'),(231,'원파가',1,9,200,'01012340231',NULL,NULL,NULL,'mail231@gmail.com'),(232,'지희결',5,9,200,'01012340232',NULL,NULL,NULL,'mail232@gmail.com'),(233,'김자마',6,9,200,'01012340233',NULL,NULL,NULL,'mail233@gmail.com'),(234,'방성세',1,9,900,'01012340234',NULL,NULL,NULL,'mail234@gmail.com'),(235,'마바성',6,9,600,'01012340235',NULL,NULL,NULL,'mail235@gmail.com'),(236,'천마마',2,9,200,'01012340236',NULL,NULL,NULL,'mail236@gmail.com'),(237,'최가세',6,9,100,'01012340237',NULL,NULL,NULL,'mail237@gmail.com'),(238,'김파희',3,9,200,'01012340238',NULL,NULL,NULL,'mail238@gmail.com'),(239,'마찬아',5,9,900,'01012340239',NULL,NULL,NULL,'mail239@gmail.com'),(240,'김세가',1,9,200,'01012340240',NULL,NULL,NULL,'mail240@gmail.com'),(241,'전차나',2,9,700,'01012340241',NULL,NULL,NULL,'mail241@gmail.com'),(242,'유희국',2,9,100,'01012340242',NULL,NULL,NULL,'mail242@gmail.com'),(243,'전희마',1,9,800,'01012340243',NULL,NULL,NULL,'mail243@gmail.com'),(244,'마호차',3,9,200,'01012340244',NULL,NULL,NULL,'mail244@gmail.com'),(245,'배태바',5,9,600,'01012340245',NULL,NULL,NULL,'mail245@gmail.com'),(246,'배나희',4,9,300,'01012340246',NULL,NULL,NULL,'mail246@gmail.com'),(247,'유은종',6,9,300,'01012340247',NULL,NULL,NULL,'mail247@gmail.com'),(248,'원세마',6,9,300,'01012340248',NULL,NULL,NULL,'mail248@gmail.com'),(249,'배마가',4,9,100,'01012340249',NULL,NULL,NULL,'mail249@gmail.com'),(250,'유결호',1,9,700,'01012340250',NULL,NULL,NULL,'mail250@gmail.com'),(251,'지태윤',4,9,100,'01012340251',NULL,NULL,NULL,'mail251@gmail.com'),(252,'배호가',7,9,600,'01012340252',NULL,NULL,NULL,'mail252@gmail.com');
/*!40000 ALTER TABLE `Emp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EmpTest`
--

DROP TABLE IF EXISTS `EmpTest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EmpTest` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ename` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept` tinyint unsigned NOT NULL,
  `auth` tinyint unsigned NOT NULL DEFAULT '9' COMMENT '0:sysadmin, 1:superuser, 3: manager, 5:employee, 7:temporary, 9:guest',
  `salary` int NOT NULL DEFAULT '0',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `outdt` date DEFAULT NULL COMMENT '퇴사일',
  `outdt2` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '퇴사일2',
  `remark` json DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
/*!50100 PARTITION BY RANGE (`id`)
(PARTITION p1 VALUES LESS THAN (100) ENGINE = InnoDB,
 PARTITION p2 VALUES LESS THAN (200) ENGINE = InnoDB,
 PARTITION p3 VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EmpTest`
--

LOCK TABLES `EmpTest` WRITE;
/*!40000 ALTER TABLE `EmpTest` DISABLE KEYS */;
INSERT INTO `EmpTest` VALUES (2,'유세혜',4,9,300,'01012340002',NULL,NULL,'{\"id\": 1, \"age\": 55, \"fam\": [{\"id\": 1, \"name\": \"유세홍\"}, {\"id\": 2, \"name\": \"새로이\"}], \"name\": \"Hong\"}','mail2@gmail.com'),(3,'원사아',4,9,100,'01012340003','2025-04-26','2025-04-25','{\"id\": 3, \"age\": 33, \"fam\": [{\"id\": 1, \"name\": \"유세차\"}, {\"id\": 2, \"name\": \"새로이\"}]}','mail3@gmail.com'),(4,'김태혜',5,9,700,'01012340004',NULL,NULL,'[1, 2, 3]','mail4@gmail.com'),(5,'지세국',7,9,400,'01012340005','2025-04-26','2025-04-25','{\"id\": 5, \"age\": 44, \"fam\": [{\"id\": 1, \"name\": \"지세차\"}, {\"id\": 2, \"name\": \"지세창\"}]}','mail5@gmail.com'),(6,'최가국',4,9,800,'01012340006',NULL,NULL,NULL,'mail6@gmail.com'),(7,'배파나',1,9,800,'01012340007',NULL,NULL,NULL,'mail7@gmail.com'),(8,'원성결',2,9,200,'01012340008',NULL,NULL,NULL,'mail8@gmail.com'),(9,'전바찬',6,9,900,'01012340009',NULL,NULL,NULL,'mail9@gmail.com'),(10,'지윤희',5,9,500,'01012340010',NULL,NULL,NULL,'mail10@gmail.com'),(11,'전차가',1,9,900,'01012340011',NULL,NULL,NULL,'mail11@gmail.com'),(12,'지호하',3,9,800,'01012340012',NULL,NULL,NULL,'mail12@gmail.com'),(13,'최종라',5,9,300,'01012340013',NULL,NULL,NULL,'mail13@gmail.com'),(14,'마마순',1,9,700,'01012340014','2025-05-01','2025-05-01',NULL,'mail14@gmail.com'),(15,'원자파',7,9,200,'01012340015',NULL,NULL,NULL,'mail15@gmail.com'),(16,'이결세',7,9,700,'01012340016',NULL,NULL,NULL,'mail16@gmail.com'),(17,'원호신',2,9,600,'01012340017',NULL,NULL,NULL,'mail17@gmail.com'),(18,'전국찬',3,9,904,'01012340018',NULL,NULL,NULL,'mail18@gmail.com'),(19,'방성찬',3,9,800,'01012340019',NULL,NULL,NULL,'mail19@gmail.com'),(20,'최희결',5,9,700,'01012340020',NULL,NULL,NULL,'mail20@gmail.com'),(21,'지찬파',2,9,600,'01012340021',NULL,NULL,NULL,'mail21@gmail.com'),(22,'최파지',4,9,100,'01012340022',NULL,NULL,NULL,'mail22@gmail.com'),(23,'마다윤',4,9,300,'01012340023',NULL,NULL,NULL,'mail23@gmail.com'),(24,'이윤파',6,9,600,'01012340024',NULL,NULL,NULL,'mail24@gmail.com'),(25,'전다윤',3,9,800,'01012340025',NULL,NULL,NULL,'mail25@gmail.com'),(26,'김나나',1,9,800,'01012340026','2025-05-01','2025-05-01',NULL,'mail26@gmail.com'),(27,'원호순',7,9,600,'01012340027',NULL,NULL,NULL,'mail27@gmail.com'),(28,'조국국',7,9,400,'01012340028',NULL,NULL,NULL,'mail28@gmail.com'),(29,'이윤바',1,9,300,'01012340029',NULL,NULL,NULL,'mail29@gmail.com'),(30,'김바순',2,9,800,'01012340030',NULL,NULL,NULL,'mail30@gmail.com'),(31,'방윤윤',6,9,600,'01012340031',NULL,NULL,NULL,'mail31@gmail.com'),(32,'방호지',4,9,900,'01012340032',NULL,NULL,NULL,'mail32@gmail.com'),(33,'최마호',1,9,500,'01012340033',NULL,NULL,NULL,'mail33@gmail.com'),(34,'전아가',3,9,600,'01012340034',NULL,NULL,NULL,'mail34@gmail.com'),(35,'원성태',6,9,600,'01012340035',NULL,NULL,NULL,'mail35@gmail.com'),(36,'마다라',3,9,904,'01012340036',NULL,NULL,NULL,'mail36@gmail.com'),(37,'지라파',3,9,200,'01012340037',NULL,NULL,NULL,'mail37@gmail.com'),(38,'김자나',3,9,300,'01012340038',NULL,NULL,NULL,'mail38@gmail.com'),(39,'전가순',2,9,400,'01012340039',NULL,NULL,NULL,'mail39@gmail.com'),(40,'유호가',6,9,400,'01012340040',NULL,NULL,NULL,'mail40@gmail.com'),(41,'방사자',6,9,400,'01012340041',NULL,NULL,NULL,'mail41@gmail.com'),(42,'마윤결',2,9,700,'01012340042',NULL,NULL,NULL,'mail42@gmail.com'),(43,'마마차',1,9,800,'01012340043',NULL,NULL,NULL,'mail43@gmail.com'),(44,'이찬가',4,9,100,'01012340044',NULL,NULL,NULL,'mail44@gmail.com'),(45,'유태파',5,9,500,'01012340045',NULL,NULL,NULL,'mail45@gmail.com'),(46,'유호다',4,9,200,'01012340046',NULL,NULL,NULL,'mail46@gmail.com'),(47,'이신희',6,9,907,'01012340047',NULL,NULL,NULL,'mail47@gmail.com'),(48,'천마라',7,9,200,'01012340048',NULL,NULL,NULL,'mail48@gmail.com'),(49,'이순아',4,9,600,'01012340049',NULL,NULL,NULL,'mail49@gmail.com'),(50,'최찬자',7,9,200,'01012340050',NULL,NULL,NULL,'mail50@gmail.com'),(51,'김바가',4,9,500,'01012340051',NULL,NULL,NULL,'mail51@gmail.com'),(52,'원가국',6,9,600,'01012340052',NULL,NULL,NULL,'mail52@gmail.com'),(53,'방가다',7,9,100,'01012340053',NULL,NULL,NULL,'mail53@gmail.com'),(54,'전순차',6,9,700,'01012340054',NULL,NULL,NULL,'mail54@gmail.com'),(55,'조종차',5,9,600,'01012340055',NULL,NULL,NULL,'mail55@gmail.com'),(56,'전호라',3,9,200,'01012340056',NULL,NULL,NULL,'mail56@gmail.com'),(57,'천호윤',4,9,500,'01012340057',NULL,NULL,NULL,'mail57@gmail.com'),(58,'마신혜',1,9,300,'01012340058',NULL,NULL,NULL,'mail58@gmail.com'),(59,'전세국',2,9,600,'01012340059',NULL,NULL,NULL,'mail59@gmail.com'),(60,'지호태',2,9,300,'01012340060',NULL,NULL,NULL,'mail60@gmail.com'),(61,'유혜태',4,9,700,'01012340061',NULL,NULL,NULL,'mail61@gmail.com'),(62,'천세찬',4,9,800,'01012340062',NULL,NULL,NULL,'mail62@gmail.com'),(63,'지바혜',3,9,200,'01012340063',NULL,NULL,NULL,'mail63@gmail.com'),(64,'천가차',1,9,800,'01012340064',NULL,NULL,NULL,'mail64@gmail.com'),(65,'배세사',2,9,800,'01012340065',NULL,NULL,NULL,'mail65@gmail.com'),(66,'방나하',6,9,200,'01012340066',NULL,NULL,NULL,'mail66@gmail.com'),(67,'최호태',1,9,800,'01012340067',NULL,NULL,NULL,'mail67@gmail.com'),(68,'마가혜',3,9,100,'01012340068',NULL,NULL,NULL,'mail68@gmail.com'),(69,'김성바',6,9,200,'01012340069',NULL,NULL,NULL,'mail69@gmail.com'),(70,'방혜국',5,9,600,'01012340070',NULL,NULL,NULL,'mail70@gmail.com'),(71,'이파파',4,9,300,'01012340071',NULL,NULL,NULL,'mail71@gmail.com'),(72,'지윤혜',7,9,100,'01012340072',NULL,NULL,NULL,'mail72@gmail.com'),(73,'박찬종',6,9,600,'01012340073',NULL,NULL,NULL,'mail73@gmail.com'),(74,'방혜윤',3,9,300,'01012340074',NULL,NULL,NULL,'mail74@gmail.com'),(75,'전호바',1,9,600,'01012340075',NULL,NULL,NULL,'mail75@gmail.com'),(76,'유희마',1,9,700,'01012340076',NULL,NULL,NULL,'mail76@gmail.com'),(77,'천성혜',7,9,500,'01012340077',NULL,NULL,NULL,'mail77@gmail.com'),(78,'김나라',3,9,800,'01012340078',NULL,NULL,NULL,'mail78@gmail.com'),(79,'최혜성',1,9,700,'01012340079',NULL,NULL,NULL,'mail79@gmail.com'),(80,'지종라',4,9,905,'01012340080',NULL,NULL,NULL,'mail80@gmail.com'),(81,'이바희',7,9,800,'01012340081',NULL,NULL,NULL,'mail81@gmail.com'),(82,'최은가',4,9,800,'01012340082',NULL,NULL,NULL,'mail82@gmail.com'),(83,'배자호',5,9,500,'01012340083',NULL,NULL,NULL,'mail83@gmail.com'),(84,'배사파',7,9,500,'01012340084',NULL,NULL,NULL,'mail84@gmail.com'),(85,'마성다',2,9,400,'01012340085',NULL,NULL,NULL,'mail85@gmail.com'),(86,'최국세',3,9,600,'01012340086',NULL,NULL,NULL,'mail86@gmail.com'),(87,'유다지',4,9,600,'01012340087',NULL,NULL,NULL,'mail87@gmail.com'),(88,'천결신',4,9,400,'01012340088',NULL,NULL,NULL,'mail88@gmail.com'),(89,'박태사',7,9,300,'01012340089',NULL,NULL,NULL,'mail89@gmail.com'),(90,'원파가',7,9,900,'01012340090',NULL,NULL,NULL,'mail90@gmail.com'),(91,'마순차',7,9,300,'01012340091',NULL,NULL,NULL,'mail91@gmail.com'),(92,'지호희',6,9,700,'01012340092',NULL,NULL,NULL,'mail92@gmail.com'),(93,'최가국',6,9,800,'01012340093',NULL,NULL,NULL,'mail93@gmail.com'),(94,'마성나',1,9,200,'01012340094',NULL,NULL,NULL,'mail94@gmail.com'),(95,'조하마',4,9,700,'01012340095',NULL,NULL,NULL,'mail95@gmail.com'),(96,'원바가',3,9,300,'01012340096',NULL,NULL,NULL,'mail96@gmail.com'),(97,'최신세',2,9,903,'01012340097',NULL,NULL,NULL,'mail97@gmail.com'),(98,'김은다',5,9,900,'01012340098',NULL,NULL,NULL,'mail98@gmail.com'),(99,'천라국',5,9,500,'01012340099',NULL,NULL,NULL,'mail99@gmail.com'),(150,'김150수',4,9,300,'0101234150',NULL,NULL,NULL,NULL),(200,'방국가',1,9,200,'01012340200',NULL,NULL,NULL,'mail200@gmail.com'),(201,'최세마',1,9,300,'01012340201',NULL,NULL,NULL,'mail201@gmail.com'),(202,'조라종',6,9,500,'01012340202',NULL,NULL,NULL,'mail202@gmail.com'),(203,'이지마',4,9,700,'01012340203',NULL,NULL,NULL,'mail203@gmail.com'),(204,'김신호',6,9,300,'01012340204',NULL,NULL,NULL,'mail204@gmail.com'),(205,'김은다',6,9,200,'01012340205',NULL,NULL,NULL,'mail205@gmail.com'),(206,'마세혜',7,9,700,'01012340206',NULL,NULL,NULL,'mail206@gmail.com'),(207,'김바순',1,9,200,'01012340207',NULL,NULL,NULL,'mail207@gmail.com'),(208,'원순세',5,9,400,'01012340208',NULL,NULL,NULL,'mail208@gmail.com'),(209,'원마종',6,9,600,'01012340209',NULL,NULL,NULL,'mail209@gmail.com'),(210,'마사혜',2,9,200,'01012340210',NULL,NULL,NULL,'mail210@gmail.com'),(211,'박나신',5,9,300,'01012340211',NULL,NULL,NULL,'mail211@gmail.com'),(212,'전호사',6,9,100,'01012340212',NULL,NULL,NULL,'mail212@gmail.com'),(213,'지지호',2,9,400,'01012340213',NULL,NULL,NULL,'mail213@gmail.com'),(214,'천혜파',2,9,900,'01012340214',NULL,NULL,NULL,'mail214@gmail.com'),(215,'지사세',6,9,700,'01012340215',NULL,NULL,NULL,'mail215@gmail.com'),(216,'방나태',6,9,100,'01012340216',NULL,NULL,NULL,'mail216@gmail.com'),(217,'김지하',6,9,400,'01012340217',NULL,NULL,NULL,'mail217@gmail.com'),(218,'지찬태',3,9,300,'01012340218',NULL,NULL,NULL,'mail218@gmail.com'),(219,'조사나',4,9,800,'01012340219',NULL,NULL,NULL,'mail219@gmail.com'),(220,'지차순',6,9,800,'01012340220',NULL,NULL,NULL,'mail220@gmail.com'),(221,'지희태',3,9,300,'01012340221',NULL,NULL,NULL,'mail221@gmail.com'),(222,'이희나',5,9,800,'01012340222',NULL,NULL,NULL,'mail222@gmail.com'),(223,'배신마',7,9,900,'01012340223',NULL,NULL,NULL,'mail223@gmail.com'),(224,'배나희',3,9,900,'01012340224',NULL,NULL,NULL,'mail224@gmail.com'),(225,'마아세',4,9,800,'01012340225',NULL,NULL,NULL,'mail225@gmail.com'),(226,'전바신',2,9,900,'01012340226',NULL,NULL,NULL,'mail226@gmail.com'),(227,'박희윤',1,9,200,'01012340227',NULL,NULL,NULL,'mail227@gmail.com'),(228,'천결호',1,9,100,'01012340228',NULL,NULL,NULL,'mail228@gmail.com'),(229,'마사혜',2,9,200,'01012340229',NULL,NULL,NULL,'mail229@gmail.com'),(230,'최종바',6,9,300,'01012340230',NULL,NULL,NULL,'mail230@gmail.com'),(231,'원파가',1,9,200,'01012340231',NULL,NULL,NULL,'mail231@gmail.com'),(232,'지희결',5,9,200,'01012340232',NULL,NULL,NULL,'mail232@gmail.com'),(233,'김자마',6,9,200,'01012340233',NULL,NULL,NULL,'mail233@gmail.com'),(234,'방성세',1,9,900,'01012340234',NULL,NULL,NULL,'mail234@gmail.com'),(235,'마바성',6,9,600,'01012340235',NULL,NULL,NULL,'mail235@gmail.com'),(236,'천마마',2,9,200,'01012340236',NULL,NULL,NULL,'mail236@gmail.com'),(237,'최가세',6,9,100,'01012340237',NULL,NULL,NULL,'mail237@gmail.com'),(238,'김파희',3,9,200,'01012340238',NULL,NULL,NULL,'mail238@gmail.com'),(239,'마찬아',5,9,900,'01012340239',NULL,NULL,NULL,'mail239@gmail.com'),(240,'김세가',1,9,200,'01012340240',NULL,NULL,NULL,'mail240@gmail.com'),(241,'전차나',2,9,700,'01012340241',NULL,NULL,NULL,'mail241@gmail.com'),(242,'유희국',2,9,100,'01012340242',NULL,NULL,NULL,'mail242@gmail.com'),(243,'전희마',1,9,800,'01012340243',NULL,NULL,NULL,'mail243@gmail.com'),(244,'마호차',3,9,200,'01012340244',NULL,NULL,NULL,'mail244@gmail.com'),(245,'배태바',5,9,600,'01012340245',NULL,NULL,NULL,'mail245@gmail.com'),(246,'배나희',4,9,300,'01012340246',NULL,NULL,NULL,'mail246@gmail.com'),(247,'유은종',6,9,300,'01012340247',NULL,NULL,NULL,'mail247@gmail.com'),(248,'원세마',6,9,300,'01012340248',NULL,NULL,NULL,'mail248@gmail.com'),(249,'배마가',4,9,100,'01012340249',NULL,NULL,NULL,'mail249@gmail.com'),(250,'유결호',1,9,700,'01012340250',NULL,NULL,NULL,'mail250@gmail.com'),(251,'지태윤',4,9,100,'01012340251',NULL,NULL,NULL,'mail251@gmail.com'),(252,'배호가',7,9,600,'01012340252',NULL,NULL,NULL,'mail252@gmail.com');
/*!40000 ALTER TABLE `EmpTest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notice`
--

DROP TABLE IF EXISTS `Notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Notice` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일',
  `workdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '제목',
  `writer` int unsigned DEFAULT NULL COMMENT '작성자',
  `contents` text COLLATE utf8mb4_unicode_ci COMMENT '내용',
  PRIMARY KEY (`id`),
  KEY `fk_Notice_writer_Emp` (`writer`),
  FULLTEXT KEY `ft_idx_Notice_title_contents` (`title`,`contents`),
  CONSTRAINT `fk_Notice_writer_Emp` FOREIGN KEY (`writer`) REFERENCES `Emp` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notice`
--

LOCK TABLES `Notice` WRITE;
/*!40000 ALTER TABLE `Notice` DISABLE KEYS */;
INSERT INTO `Notice` VALUES (1,'2025-05-08 02:17:53','2025-05-08 02:17:53','세종대왕',NULL,'조선의 제4대 국왕이다.'),(2,'2025-05-08 02:17:53','2025-05-08 02:17:53','단군',NULL,'단군왕검(檀君王儉)은 한민족의 시조이자 고조선(古朝鮮)의 국조(國祖), 대종교의 시작.'),(3,'2025-05-08 02:17:53','2025-05-08 02:17:53','정약용',NULL,'조선 후기의 문신이자 실학자·저술가·시인·철학자·과학자·공학자이다.'),(4,'2025-05-08 02:17:53','2025-05-08 02:17:53','계백',NULL,'백제 말기의 군인이다.'),(5,'2025-05-08 02:17:53','2025-05-08 02:17:53','이순신',NULL,'조선 중기의 무신이었다. 본관은 덕수(德水), 자는 여해(汝諧), 시호는 충무(忠武).'),(6,'2025-05-08 02:17:53','2025-05-08 02:17:53','김유신',NULL,'신라의 화랑의 우두머리였으며 태대각간(太大角干)이었고 신라에 귀순한 가야 왕족의 후손.');
/*!40000 ALTER TABLE `Notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PartiRangeTest`
--

DROP TABLE IF EXISTS `PartiRangeTest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PartiRangeTest` (
  `studentno` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `enteryear` smallint NOT NULL,
  `studentname` varchar(31) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
/*!50100 PARTITION BY RANGE (`enteryear`)
(PARTITION p1 VALUES LESS THAN (2000) ENGINE = InnoDB,
 PARTITION p3 VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PartiRangeTest`
--

LOCK TABLES `PartiRangeTest` WRITE;
/*!40000 ALTER TABLE `PartiRangeTest` DISABLE KEYS */;
INSERT INTO `PartiRangeTest` VALUES ('8809080',1988,'팔팔학번'),('1809080',2018,'일팔학번');
/*!40000 ALTER TABLE `PartiRangeTest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StopWord`
--

DROP TABLE IF EXISTS `StopWord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `StopWord` (
  `value` varchar(31) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StopWord`
--

LOCK TABLES `StopWord` WRITE;
/*!40000 ALTER TABLE `StopWord` DISABLE KEYS */;
INSERT INTO `StopWord` VALUES ('가까스로'),('가령'),('각각'),('각자'),('각종'),('갖고말하자면'),('같다'),('같이'),('개의치않고'),('거니와'),('거바'),('거의'),('것과'),('것들'),('게다가'),('게우다'),('겨우'),('견지에서'),('이르다'),('있다'),('겸사겸사'),('고려하면'),('고로'),('공동으로'),('과연'),('관계없이'),('관련이'),('관하여'),('관한'),('관해서는'),('구체적으로'),('구토하다'),('그들'),('그때'),('그래'),('그래도'),('그래서'),('그러나'),('그러니'),('그러니까'),('그러면'),('그러므로'),('그러한즉'),('그런'),('까닭에'),('그런데'),('그런즉'),('그럼'),('그럼에도불구하고'),('그렇게'),('함으로써'),('그렇지'),('않다면'),('않으면'),('그렇지만'),('그렇지않으면'),('그리고'),('그리하여'),('그만이다'),('그에'),('따르는'),('그위에'),('그저'),('그중에서'),('그치지'),('않다'),('근거로'),('근거하여'),('기대여'),('기점으로'),('기준으로'),('기타'),('까닭으로'),('까악'),('까지'),('미치다'),('까지도'),('꽈당'),('끙끙'),('끼익'),('나머지는'),('남들'),('남짓'),('너희'),('너희들'),('논하지'),('놀라다'),('누가'),('알겠는가'),('누구'),('다른'),('방면으로'),('다만'),('다섯'),('다소'),('다수'),('다시'),('말하자면'),('다시말하면'),('다음'),('다음에'),('다음으로'),('단지'),('답다'),('당신'),('당장'),('대로'),('하다'),('대하면'),('대하여'),('대해'),('대해서'),('댕그'),('더구나'),('더군다나'),('더라도'),('더불어'),('더욱더'),('더욱이는'),('도달하다'),('도착하다'),('동시에'),('동안'),('된바에야'),('된이상'),('두번째로'),('둥둥'),('뒤따라'),('뒤이어'),('든간에'),('등등'),('딩동'),('따라'),('따라서'),('따위'),('따지지'),('때가'),('되어'),('때문에'),('또한'),('뚝뚝'),('해도'),('인하여'),('로부터'),('로써'),('마음대로'),('마저'),('마저도'),('마치'),('막론하고'),('못하다'),('만약'),('만약에'),('만은'),('아니다'),('만이'),('만일'),('만큼'),('말할것도'),('없고'),('매번'),('메쓰겁다'),('모두'),('무렵'),('무릎쓰고'),('무슨'),('무엇'),('무엇때문에'),('물론'),('바꾸어말하면'),('바꾸어말하자면'),('바꾸어서'),('말하면'),('한다면'),('바꿔'),('바로'),('바와같이'),('밖에'),('안된다'),('반대로'),('반드시'),('버금'),('보는데서'),('보다더'),('보드득'),('본대로'),('봐라'),('부류의'),('사람들'),('부터'),('불구하고'),('불문하고'),('붕붕'),('비걱거리다'),('비교적'),('비길수'),('없다'),('비로소'),('비록'),('비슷하다'),('비추어'),('보아'),('비하면'),('뿐만'),('아니라'),('뿐만아니라'),('뿐이다'),('삐걱'),('삐걱거리다'),('상대적으로'),('생각한대로'),('설령'),('설마'),('설사'),('소생'),('소인'),('습니까'),('습니다'),('시각'),('시간'),('시작하여'),('시초에'),('시키다'),('실로'),('심지어'),('아니'),('아니나다를가'),('아니라면'),('아니면'),('아니었다면'),('아래윗'),('아무거나'),('아무도'),('아야'),('아울러'),('아이'),('아이고'),('아이구'),('아이야'),('아이쿠'),('아하'),('아홉'),('않기'),('위하여'),('위해서'),('알았어'),('앞에서'),('앞의것'),('약간'),('양자'),('어기여차'),('어느'),('년도'),('어느것'),('어느곳'),('어느때'),('어느쪽'),('어느해'),('어디'),('어때'),('어떠한'),('어떤'),('어떤것'),('어떤것들'),('어떻게'),('어떻해'),('어이'),('어째서'),('어쨋든'),('어쩔수'),('어찌'),('어찌됏든'),('어찌됏어'),('어찌하든지'),('어찌하여'),('언제'),('언젠가'),('얼마'),('되는'),('얼마간'),('얼마나'),('얼마든지'),('얼마만큼'),('얼마큼'),('엉엉'),('가서'),('달려'),('한하다'),('에게'),('에서'),('여기'),('여덟'),('여러분'),('여보시오'),('여부'),('여섯'),('여전히'),('여차'),('연관되다'),('연이서'),('영차'),('옆사람'),('예를'),('들면'),('들자면'),('예컨대'),('예하면'),('오로지'),('오르다'),('오자마자'),('오직'),('오호'),('오히려'),('같은'),('와르르'),('와아'),('왜냐하면'),('외에도'),('요만큼'),('요만한'),('요만한걸'),('요컨대'),('우르르'),('우리'),('우리들'),('우선'),('우에'),('종합한것과같이'),('운운'),('위에서'),('서술한바와같이'),('윙윙'),('으로'),('으로서'),('으로써'),('응당'),('의거하여'),('의지하여'),('의해'),('의해되다'),('의해서'),('되다'),('외에'),('정도의'),('이것'),('이곳'),('이때'),('이라면'),('이래'),('이러이러하다'),('이러한'),('이런'),('이럴정도로'),('이렇게'),('많은'),('이렇게되면'),('이렇게말하자면'),('이렇구나'),('이로'),('이르기까지'),('이리하여'),('이만큼'),('이번'),('이봐'),('이상'),('이어서'),('이었다'),('이와'),('이와같다면'),('이외에도'),('이용하여'),('이유만으로'),('이젠'),('이지만'),('이쪽'),('이천구'),('이천육'),('이천칠'),('이천팔'),('듯하다'),('인젠'),('일것이다'),('일곱'),('일단'),('일때'),('일반적으로'),('일지라도'),('임에'),('틀림없다'),('입각하여'),('입장에서'),('잇따라'),('자기'),('자기집'),('자마자'),('자신'),('잠깐'),('잠시'),('저것'),('저것만큼'),('저기'),('저쪽'),('저희'),('전부'),('전자'),('전후'),('점에서'),('정도에'),('제각기'),('제외하고'),('조금'),('조차'),('조차도'),('졸졸'),('좋아'),('좍좍'),('주룩주룩'),('주저하지'),('않고'),('줄은'),('몰랏다'),('줄은모른다'),('중에서'),('중의하나'),('즈음하여'),('즉시'),('지든지'),('지만'),('지말고'),('진짜로'),('쪽으로'),('차라리'),('참나'),('첫번째로'),('총적으로'),('보면'),('콸콸'),('쾅쾅'),('타다'),('타인'),('탕탕'),('토하다'),('통하여'),('틈타'),('펄렁'),('하게될것이다'),('하게하다'),('하겠는가'),('하고'),('하고있었다'),('하곤하였다'),('하구나'),('하기'),('하기는한데'),('하기만'),('하면'),('하기보다는'),('하기에'),('하나'),('하느니'),('하는'),('김에'),('편이'),('낫다'),('하는것도'),('하는것만'),('하는것이'),('하는바'),('하더라도'),('하도다'),('하도록시키다'),('하도록하다'),('하든지'),('하려고하다'),('하마터면'),('할수록'),('하면된다'),('하면서'),('하물며'),('하여금'),('하여야'),('하자마자'),('하지'),('않는다면'),('않도록'),('하지마'),('하지마라'),('하지만'),('하하'),('이유는'),('몰라도'),('한데'),('한마디'),('한적이있다'),('한켠으로는'),('한항목'),('따름이다'),('생각이다'),('안다'),('지경이다'),('힘이'),('할때'),('할만하다'),('할망정'),('할뿐'),('할수있다'),('할수있어'),('할줄알다'),('할지라도'),('할지언정'),('함께'),('해도된다'),('해도좋다'),('해봐요'),('해서는'),('해야한다'),('해요'),('했어요'),('향하다'),('향하여'),('향해서'),('허걱'),('허허'),('헉헉'),('헐떡헐떡'),('형식으로'),('쓰여'),('혹시'),('혹은'),('혼자'),('훨씬'),('휘익'),('흐흐'),('힘입어');
/*!40000 ALTER TABLE `StopWord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Test`
--

DROP TABLE IF EXISTS `Test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Test` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ttt` varchar(31) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept` tinyint unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Test`
--

LOCK TABLES `Test` WRITE;
/*!40000 ALTER TABLE `Test` DISABLE KEYS */;
INSERT INTO `Test` VALUES (1,'aaa1',3),(2,'aaa2',4);
/*!40000 ALTER TABLE `Test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_emp_groupby_dept`
--

DROP TABLE IF EXISTS `v_emp_groupby_dept`;
/*!50001 DROP VIEW IF EXISTS `v_emp_groupby_dept`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_emp_groupby_dept` AS SELECT 
 1 AS `dept`,
 1 AS `minName`,
 1 AS `maxName`,
 1 AS `totsal`,
 1 AS `avgsal`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'testdb'
--
/*!50003 DROP FUNCTION IF EXISTS `f_empinfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tester`@`%` FUNCTION `f_empinfo`(_id int unsigned) RETURNS varchar(64) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
BEGIN
    declare v_ret varchar(64) default '미등록 직원';
    
    select concat(e.ename, '(', ifnull(d.dname, '발령대기'), ')') into v_ret
      from Emp e left outer join Dept d on e.dept = d.id
     where e.id = _id;
     
RETURN v_ret;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cnt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tester`@`%` PROCEDURE `sp_cnt`(_table varchar(31))
begin
SET @sql = CONCAT('select count(*) from ', _table);
PREPARE myQuery from @sql;
EXECUTE myQuery;
DEALLOCATE PREPARE myQuery;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_deptinfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tester`@`%` PROCEDURE `sp_deptinfo`(_dept_name varchar(31))
BEGIN
    select d.id, d.dname, ifnull(e.ename, '공석') captainName,
        (select format(avg(salary) * 10000, 0)
           from Emp where dept = d.id) avgsal
      from Dept d left outer join Emp e
        on d.id = e.dept and d.captain = e.id
     where d.dname like concat(_dept_name, '%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_dept_salary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tester`@`%` PROCEDURE `sp_dept_salary`()
BEGIN
    Declare _done boolean default False;
    
    Declare _id smallint unsigned;
    Declare _dname varchar(31);
    Declare _captain int unsigned;
    
    Declare v_maxsal int;
    Declare v_ename varchar(31);
    Declare v_salary int;
    
    Declare _cur CURSOR FOR
        select id, dname, captain from Dept;
        
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SHOW ERRORS;
        SELECT '에러발생' as 'Result';
        -- ROLLBACK;
    END;

        
    Declare Continue Handler
        For Not Found SET _done := True;
        
    drop table if exists $Tmp;
    create temporary table $Tmp(
        id smallint unsigned,
        dname varchar(31),
        maxsal int,
        maxcnt smallint,
        captain varchar(31),
        captainsal int
    );
    
    OPEN _cur;
        cur_loop: LOOP
            Fetch _cur into _id, _dname, _captain;
            
            IF _done THEN
                LEAVE cur_loop;
            END IF;
            
            select round(max(salary)) into v_maxsal from Emp where dept = _id;
            
            IF _captain is null THEN
                set v_ename = '';
                set v_salary = 0;
            ELSE
                select ename, salary into v_ename, v_salary
                  from Emp where id = _captain;
            END IF;
            
            insert into $Tmp
            select _id, _dname, v_maxsal, 
                (select count(*) from Emp where dept = _id and salary = v_maxsal),
                v_ename, v_salary;
            
        END LOOP cur_loop;
    CLOSE _cur;
    
    select * from $Tmp order by dname;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_emplist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tester`@`%` PROCEDURE `sp_emplist`(_id int unsigned)
BEGIN
    select * from Emp where id < ifnull(_id, 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ttt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tester`@`%` PROCEDURE `sp_ttt`(IN _initValue int, OUT _retValue int)
BEGIN
    declare v_i int default _initValue;
    
    while (v_i < 10) do
        set v_i = v_i + 1;
    end while;
    
    set _retValue = v_i;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_emp_groupby_dept`
--

/*!50001 DROP VIEW IF EXISTS `v_emp_groupby_dept`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tester`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_emp_groupby_dept` AS select `emp`.`dept` AS `dept`,min(`emp`.`ename`) AS `minName`,max(`emp`.`ename`) AS `maxName`,sum(`emp`.`salary`) AS `totsal`,avg(`emp`.`salary`) AS `avgsal` from `emp` group by `emp`.`dept` */;
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

-- Dump completed on 2025-05-08 17:05:03
