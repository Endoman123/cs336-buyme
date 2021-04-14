-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: buyme
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `login` varchar(30) NOT NULL,
  PRIMARY KEY (`login`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`login`) REFERENCES `user` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('Admin');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction_transactions`
--

DROP TABLE IF EXISTS `auction_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction_transactions` (
  `auction_ID` int NOT NULL,
  `item_ID` int DEFAULT NULL,
  `login` varchar(30) DEFAULT NULL,
  `close_date` date DEFAULT NULL,
  `close_time` time DEFAULT NULL,
  `winner` varchar(30) DEFAULT NULL,
  `init_price` float DEFAULT NULL,
  `bid_increment` float DEFAULT NULL,
  `minimum` float DEFAULT NULL,
  `final_price` float DEFAULT NULL,
  PRIMARY KEY (`auction_ID`),
  KEY `item_ID` (`item_ID`),
  KEY `login` (`login`),
  CONSTRAINT `auction_transactions_ibfk_1` FOREIGN KEY (`item_ID`) REFERENCES `item` (`item_ID`),
  CONSTRAINT `auction_transactions_ibfk_2` FOREIGN KEY (`login`) REFERENCES `user` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction_transactions`
--

LOCK TABLES `auction_transactions` WRITE;
/*!40000 ALTER TABLE `auction_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auction_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `belongs_to`
--

DROP TABLE IF EXISTS `belongs_to`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `belongs_to` (
  `category_number` int NOT NULL,
  `item_ID` int NOT NULL,
  PRIMARY KEY (`category_number`,`item_ID`),
  KEY `item_ID` (`item_ID`),
  CONSTRAINT `belongs_to_ibfk_1` FOREIGN KEY (`category_number`) REFERENCES `category` (`category_number`),
  CONSTRAINT `belongs_to_ibfk_2` FOREIGN KEY (`item_ID`) REFERENCES `item` (`item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `belongs_to`
--

LOCK TABLES `belongs_to` WRITE;
/*!40000 ALTER TABLE `belongs_to` DISABLE KEYS */;
/*!40000 ALTER TABLE `belongs_to` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bid_posts_for`
--

DROP TABLE IF EXISTS `bid_posts_for`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bid_posts_for` (
  `bid_number` int NOT NULL,
  `login` varchar(30) DEFAULT NULL,
  `auction_ID` int DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `bid_date` date DEFAULT NULL,
  `bid_time` time DEFAULT NULL,
  `auto_bid` tinyint(1) DEFAULT NULL,
  `bid_increment` float DEFAULT NULL,
  `upper_limit` float DEFAULT NULL,
  PRIMARY KEY (`bid_number`),
  KEY `auction_ID` (`auction_ID`),
  KEY `login` (`login`),
  CONSTRAINT `bid_posts_for_ibfk_1` FOREIGN KEY (`auction_ID`) REFERENCES `auction_transactions` (`auction_ID`),
  CONSTRAINT `bid_posts_for_ibfk_2` FOREIGN KEY (`login`) REFERENCES `user` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bid_posts_for`
--

LOCK TABLES `bid_posts_for` WRITE;
/*!40000 ALTER TABLE `bid_posts_for` DISABLE KEYS */;
/*!40000 ALTER TABLE `bid_posts_for` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_number` int NOT NULL,
  PRIMARY KEY (`category_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_rep`
--

DROP TABLE IF EXISTS `customer_rep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_rep` (
  `login` varchar(30) NOT NULL,
  PRIMARY KEY (`login`),
  CONSTRAINT `customer_rep_ibfk_1` FOREIGN KEY (`login`) REFERENCES `user` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_rep`
--

LOCK TABLES `customer_rep` WRITE;
/*!40000 ALTER TABLE `customer_rep` DISABLE KEYS */;
INSERT INTO `customer_rep` VALUES ('Dorian_Hobot'),('Jared_Tulayan'),('Mikita_Belausau'),('Muskan_Burman');
/*!40000 ALTER TABLE `customer_rep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `end_user`
--

DROP TABLE IF EXISTS `end_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `end_user` (
  `login` varchar(30) NOT NULL,
  `bid_alert` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`login`),
  CONSTRAINT `end_user_ibfk_1` FOREIGN KEY (`login`) REFERENCES `user` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `end_user`
--

LOCK TABLES `end_user` WRITE;
/*!40000 ALTER TABLE `end_user` DISABLE KEYS */;
INSERT INTO `end_user` VALUES ('Customer',NULL),('hello',NULL),('person',NULL),('person2',NULL),('person3',NULL);
/*!40000 ALTER TABLE `end_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `item_ID` int NOT NULL,
  PRIMARY KEY (`item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_alerts`
--

DROP TABLE IF EXISTS `item_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_alerts` (
  `login` varchar(30) NOT NULL,
  `item_ID` int NOT NULL,
  PRIMARY KEY (`login`,`item_ID`),
  KEY `item_ID` (`item_ID`),
  CONSTRAINT `item_alerts_ibfk_1` FOREIGN KEY (`login`) REFERENCES `user` (`login`),
  CONSTRAINT `item_alerts_ibfk_2` FOREIGN KEY (`item_ID`) REFERENCES `item` (`item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_alerts`
--

LOCK TABLES `item_alerts` WRITE;
/*!40000 ALTER TABLE `item_alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `question_number` int NOT NULL,
  `user_login_End_User` varchar(30) DEFAULT NULL,
  `user_login_Customer_Rep` varchar(30) DEFAULT NULL,
  `question_text` varchar(144) DEFAULT NULL,
  `answer_text` varchar(144) DEFAULT NULL,
  PRIMARY KEY (`question_number`),
  KEY `user_login_End_User` (`user_login_End_User`),
  KEY `user_login_Customer_Rep` (`user_login_Customer_Rep`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`user_login_End_User`) REFERENCES `end_user` (`login`),
  CONSTRAINT `questions_ibfk_2` FOREIGN KEY (`user_login_Customer_Rep`) REFERENCES `customer_rep` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_category_1`
--

DROP TABLE IF EXISTS `sub_category_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_category_1` (
  `category_number` int NOT NULL,
  `spec_1` varchar(20) DEFAULT NULL,
  `spec_2` varchar(20) DEFAULT NULL,
  `spec_3` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`category_number`),
  CONSTRAINT `sub_category_1_ibfk_1` FOREIGN KEY (`category_number`) REFERENCES `category` (`category_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_category_1`
--

LOCK TABLES `sub_category_1` WRITE;
/*!40000 ALTER TABLE `sub_category_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_category_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_category_2`
--

DROP TABLE IF EXISTS `sub_category_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_category_2` (
  `category_number` int NOT NULL,
  `spec_1` varchar(20) DEFAULT NULL,
  `spec_2` varchar(20) DEFAULT NULL,
  `spec_3` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`category_number`),
  CONSTRAINT `sub_category_2_ibfk_1` FOREIGN KEY (`category_number`) REFERENCES `category` (`category_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_category_2`
--

LOCK TABLES `sub_category_2` WRITE;
/*!40000 ALTER TABLE `sub_category_2` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_category_2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_category_3`
--

DROP TABLE IF EXISTS `sub_category_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_category_3` (
  `category_number` int NOT NULL,
  `spec_1` varchar(20) DEFAULT NULL,
  `spec_2` varchar(20) DEFAULT NULL,
  `spec_3` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`category_number`),
  CONSTRAINT `sub_category_3_ibfk_1` FOREIGN KEY (`category_number`) REFERENCES `category` (`category_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_category_3`
--

LOCK TABLES `sub_category_3` WRITE;
/*!40000 ALTER TABLE `sub_category_3` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_category_3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `login` varchar(30) NOT NULL,
  `password` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('Admin','testpassword5','Admin@buyme.com'),('Customer','testpassword6','customer@buyme.com'),('Dorian_Hobot','testpassword1','djh242@scarletmail.rutgers.edu'),('hello','password',''),('Jared_Tulayan','testpassword4','jared.tulayan@rutgers.edu'),('Mikita_Belausau','testpassword3','mikita.belausau@rutgers.edu'),('Muskan_Burman','testpassword2','mb1966@rutgers.edu'),('person','password','person@buyme.com'),('person2','password','person2@buyme.com'),('person3','password','');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-11  2:59:03
