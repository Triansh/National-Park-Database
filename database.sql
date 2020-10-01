-- MySQL dump 10.13  Distrib 8.0.21, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: testDB
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE = @@TIME_ZONE */;
/*!40103 SET TIME_ZONE = '+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES = @@SQL_NOTES, SQL_NOTES = 0 */;

--
-- Table structure for table `Booking`
--

DROP TABLE IF EXISTS `Booking`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Booking`
(
    `booking_id`         int NOT NULL,
    `user_id`            int NOT NULL,
    `number_of_adults`   int DEFAULT NULL,
    `number_of_children` int DEFAULT NULL,
    `transaction_id`     int NOT NULL,
    PRIMARY KEY (`booking_id`, `user_id`),
    KEY `user_id` (`user_id`),
    KEY `transaction_id` (`transaction_id`),
    CONSTRAINT `Booking_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `Booking_service` (`booking_id`),
    CONSTRAINT `Booking_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
    CONSTRAINT `Booking_ibfk_3` FOREIGN KEY (`transaction_id`) REFERENCES `Transaction` (`transaction_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Booking`
--

LOCK TABLES `Booking` WRITE;
/*!40000 ALTER TABLE `Booking`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Booking`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Booking_service`
--

DROP TABLE IF EXISTS `Booking_service`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Booking_service`
(
    `booking_id`     int NOT NULL,
    `sub_service_id` varchar(255) DEFAULT NULL,
    `price`          int NOT NULL,
    PRIMARY KEY (`booking_id`),
    KEY `sub_service_id` (`sub_service_id`),
    CONSTRAINT `Booking_service_ibfk_1` FOREIGN KEY (`sub_service_id`) REFERENCES `Service_timings` (`sub_service_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Booking_service`
--

LOCK TABLES `Booking_service` WRITE;
/*!40000 ALTER TABLE `Booking_service`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Booking_service`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Class_classification`
--

DROP TABLE IF EXISTS `Class_classification`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Class_classification`
(
    `class` varchar(255) NOT NULL,
    `order` varchar(255) NOT NULL,
    PRIMARY KEY (`order`, `class`),
    KEY `Class_classification_class_index` (`class`),
    CONSTRAINT `Class_classification_Kingdom_classification_class_fk` FOREIGN KEY (`class`) REFERENCES `Kingdom_classification` (`class`) ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Class_classification`
--

LOCK TABLES `Class_classification` WRITE;
/*!40000 ALTER TABLE `Class_classification`
    DISABLE KEYS */;
INSERT INTO `Class_classification`
VALUES ('insecta', 'hymenoptera');
/*!40000 ALTER TABLE `Class_classification`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Crosses`
--

DROP TABLE IF EXISTS `Crosses`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Crosses`
(
    `feature_id` varchar(255) NOT NULL,
    `trail_id`   varchar(255) NOT NULL,
    PRIMARY KEY (`feature_id`, `trail_id`),
    KEY `trail_id` (`trail_id`),
    CONSTRAINT `Crosses_ibfk_1` FOREIGN KEY (`feature_id`) REFERENCES `Features` (`feature_id`),
    CONSTRAINT `Crosses_ibfk_3` FOREIGN KEY (`trail_id`) REFERENCES `Trail` (`feature_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Crosses`
--

LOCK TABLES `Crosses` WRITE;
/*!40000 ALTER TABLE `Crosses`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Crosses`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Data`
--

DROP TABLE IF EXISTS `Data`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Data`
(
    `data_id`     varchar(255) NOT NULL,
    `description` longtext,
    `data_link`   varchar(255) DEFAULT NULL,
    `data_type`   varchar(255) DEFAULT NULL,
    PRIMARY KEY (`data_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Data`
--

LOCK TABLES `Data` WRITE;
/*!40000 ALTER TABLE `Data`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Data`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Demography`
--

DROP TABLE IF EXISTS `Demography`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Demography`
(
    `presence_id`           varchar(255)   NOT NULL,
    `time_stamp`            timestamp      NOT NULL,
    `percent_of_lifespan`   decimal(10, 0) DEFAULT NULL,
    `percent_of_population` decimal(10, 0) NOT NULL,
    PRIMARY KEY (`presence_id`, `time_stamp`),
    CONSTRAINT `Demography_ibfk_1` FOREIGN KEY (`presence_id`) REFERENCES `Presence` (`presence_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Demography`
--

LOCK TABLES `Demography` WRITE;
/*!40000 ALTER TABLE `Demography`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Demography`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Department`
(
    `contained_in`  int          NOT NULL,
    `dep_number`    int          NOT NULL,
    `dep_name`      varchar(255) NOT NULL,
    `is_chaired_by` int DEFAULT NULL,
    PRIMARY KEY (`contained_in`, `dep_number`),
    KEY `is_chaired_by` (`is_chaired_by`),
    CONSTRAINT `Department_ibfk_1` FOREIGN KEY (`is_chaired_by`) REFERENCES `Employee` (`emp_id`),
    CONSTRAINT `Department_ibfk_2` FOREIGN KEY (`contained_in`) REFERENCES `National_Park` (`unit_code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Department`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee`
(
    `emp_id`          int          NOT NULL,
    `emp_name`        varchar(255) NOT NULL,
    `date_of_birth`   date                           DEFAULT NULL,
    `contact_number`  varchar(15)                    DEFAULT NULL,
    `emp_email`       varchar(255)                   DEFAULT NULL,
    `gender`          enum ('Male','Female','Other') DEFAULT NULL,
    `date_of_joining` date                           DEFAULT (now()),
    `role`            varchar(255)                   DEFAULT NULL,
    `works_for_dno`   int                            DEFAULT NULL,
    `national_park`   int                            DEFAULT NULL,
    PRIMARY KEY (`emp_id`),
    UNIQUE KEY `emp_email` (`emp_email`),
    KEY `national_park` (`national_park`, `works_for_dno`),
    CONSTRAINT `Employee_ibfk_1` FOREIGN KEY (`national_park`) REFERENCES `National_Park` (`unit_code`),
    CONSTRAINT `Employee_ibfk_3` FOREIGN KEY (`national_park`, `works_for_dno`) REFERENCES `Department` (`contained_in`, `dep_number`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Employee`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Family_classification`
--

DROP TABLE IF EXISTS `Family_classification`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Family_classification`
(
    `family` varchar(255) NOT NULL,
    `genus`  varchar(255) NOT NULL,
    PRIMARY KEY (`genus`, `family`),
    KEY `Family_classification_ibfk_1` (`family`),
    CONSTRAINT `Family_classification_ibfk_1` FOREIGN KEY (`family`) REFERENCES `Order_classification` (`family`) ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Family_classification`
--

LOCK TABLES `Family_classification` WRITE;
/*!40000 ALTER TABLE `Family_classification`
    DISABLE KEYS */;
INSERT INTO `Family_classification`
VALUES ('apidae', 'apis');
/*!40000 ALTER TABLE `Family_classification`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Feature_Feedback`
--

DROP TABLE IF EXISTS `Feature_Feedback`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Feature_Feedback`
(
    `user_id`    int NOT NULL,
    `feature_id` varchar(255)   DEFAULT NULL,
    `rating`     decimal(10, 0) DEFAULT NULL COMMENT 'between 1 and 5',
    `remarks`    longtext,
    `date`       datetime       DEFAULT NULL,
    PRIMARY KEY (`user_id`),
    KEY `feature_id` (`feature_id`),
    CONSTRAINT `Feature_Feedback_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
    CONSTRAINT `Feature_Feedback_ibfk_4` FOREIGN KEY (`feature_id`) REFERENCES `Features` (`feature_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feature_Feedback`
--

LOCK TABLES `Feature_Feedback` WRITE;
/*!40000 ALTER TABLE `Feature_Feedback`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Feature_Feedback`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Feature_images`
--

DROP TABLE IF EXISTS `Feature_images`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Feature_images`
(
    `feature_id` varchar(255) NOT NULL,
    `image_id`   int          NOT NULL,
    `image`      longblob,
    PRIMARY KEY (`feature_id`, `image_id`),
    CONSTRAINT `Feature_images_ibfk_1` FOREIGN KEY (`feature_id`) REFERENCES `Features` (`feature_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feature_images`
--

LOCK TABLES `Feature_images` WRITE;
/*!40000 ALTER TABLE `Feature_images`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Feature_images`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Features`
--

DROP TABLE IF EXISTS `Features`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Features`
(
    `feature_id`   varchar(255) NOT NULL,
    `feature_name` varchar(255) NOT NULL,
    `availability` int          DEFAULT NULL,
    `latitude`     varchar(255) DEFAULT NULL,
    `longitude`    varchar(255) DEFAULT NULL,
    PRIMARY KEY (`feature_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Features`
--

LOCK TABLES `Features` WRITE;
/*!40000 ALTER TABLE `Features`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Features`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Feeds_on`
--

DROP TABLE IF EXISTS `Feeds_on`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Feeds_on`
(
    `predator_genus`         varchar(255) DEFAULT NULL,
    `predator_specific_name` varchar(255) DEFAULT NULL,
    `prey_genus`             varchar(255) DEFAULT NULL,
    `prey_specific_name`     varchar(255) DEFAULT NULL,
    KEY `predator_genus` (`predator_genus`, `predator_specific_name`),
    KEY `prey_genus` (`prey_genus`, `prey_specific_name`),
    CONSTRAINT `Feeds_on_ibfk_3` FOREIGN KEY (`predator_genus`, `predator_specific_name`) REFERENCES `Species` (`genus`, `specific_name`),
    CONSTRAINT `Feeds_on_ibfk_4` FOREIGN KEY (`prey_genus`, `prey_specific_name`) REFERENCES `Species` (`genus`, `specific_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feeds_on`
--

LOCK TABLES `Feeds_on` WRITE;
/*!40000 ALTER TABLE `Feeds_on`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Feeds_on`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Kingdom_classification`
--

DROP TABLE IF EXISTS `Kingdom_classification`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Kingdom_classification`
(
    `kingdom` varchar(255) NOT NULL,
    `class`   varchar(255) NOT NULL,
    PRIMARY KEY (`kingdom`, `class`),
    KEY `Kingdom_classification_class_index` (`class`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Kingdom_classification`
--

LOCK TABLES `Kingdom_classification` WRITE;
/*!40000 ALTER TABLE `Kingdom_classification`
    DISABLE KEYS */;
INSERT INTO `Kingdom_classification`
VALUES ('animalia', 'insecta');
/*!40000 ALTER TABLE `Kingdom_classification`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lodging`
--

DROP TABLE IF EXISTS `Lodging`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Lodging`
(
    `feature_id`       varchar(255) NOT NULL,
    `name`             varchar(255) NOT NULL,
    `person_in_charge` varchar(255) NOT NULL,
    `capacity`         int         DEFAULT NULL,
    `occupancy`        int         DEFAULT NULL,
    `contact_number`   varchar(15) DEFAULT NULL,
    PRIMARY KEY (`feature_id`),
    CONSTRAINT `Lodging_ibfk_1` FOREIGN KEY (`feature_id`) REFERENCES `Features` (`feature_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lodging`
--

LOCK TABLES `Lodging` WRITE;
/*!40000 ALTER TABLE `Lodging`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Lodging`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `National_Park`
--

DROP TABLE IF EXISTS `National_Park`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `National_Park`
(
    `unit_code`   int          NOT NULL,
    `name`        varchar(255) NOT NULL,
    `region_code` varchar(255) NOT NULL,
    `boundary`    geometry       DEFAULT NULL,
    `latitude`    decimal(10, 6) DEFAULT NULL,
    `longitude`   decimal(10, 6) DEFAULT NULL,
    PRIMARY KEY (`unit_code`),
    UNIQUE KEY `name` (`name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `National_Park`
--

LOCK TABLES `National_Park` WRITE;
/*!40000 ALTER TABLE `National_Park`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `National_Park`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order_classification`
--

DROP TABLE IF EXISTS `Order_classification`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order_classification`
(
    `order`  varchar(255) NOT NULL,
    `family` varchar(255) NOT NULL,
    PRIMARY KEY (`family`, `order`),
    KEY `Order_classification_ibfk_1` (`order`),
    CONSTRAINT `Order_classification_ibfk_1` FOREIGN KEY (`order`) REFERENCES `Class_classification` (`order`) ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_classification`
--

LOCK TABLES `Order_classification` WRITE;
/*!40000 ALTER TABLE `Order_classification`
    DISABLE KEYS */;
INSERT INTO `Order_classification`
VALUES ('hymenoptera', 'apidae');
/*!40000 ALTER TABLE `Order_classification`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Permit`
--

DROP TABLE IF EXISTS `Permit`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Permit`
(
    `permit_id`              int  NOT NULL,
    `permit_expiration_date` date NOT NULL,
    PRIMARY KEY (`permit_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Permit`
--

LOCK TABLES `Permit` WRITE;
/*!40000 ALTER TABLE `Permit`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Permit`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Presence`
--

DROP TABLE IF EXISTS `Presence`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Presence`
(
    `presence_id`   varchar(255) NOT NULL,
    `genus`         varchar(255)                      DEFAULT NULL,
    `specific_name` varchar(255)                      DEFAULT NULL,
    `national_park` int                               DEFAULT NULL,
    `nativeness`    tinyint(1)                        DEFAULT NULL,
    `is_attraction` tinyint(1)                        DEFAULT NULL,
    `abundance`     enum ('rare','common','uncommon') DEFAULT NULL,
    `record_status` enum ('Verified','Non Verified')  DEFAULT NULL,
    `record_time`   datetime                          DEFAULT NULL,
    `occurence`     enum ('Full Year','Seasonal')     DEFAULT NULL,
    PRIMARY KEY (`presence_id`),
    KEY `genus` (`genus`, `specific_name`),
    KEY `national_park` (`national_park`),
    CONSTRAINT `Presence_ibfk_1` FOREIGN KEY (`genus`) REFERENCES `Species` (`genus`),
    CONSTRAINT `Presence_ibfk_3` FOREIGN KEY (`national_park`) REFERENCES `National_Park` (`unit_code`),
    CONSTRAINT `Presence_ibfk_5` FOREIGN KEY (`genus`, `specific_name`) REFERENCES `Species` (`genus`, `specific_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Presence`
--

LOCK TABLES `Presence` WRITE;
/*!40000 ALTER TABLE `Presence`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Presence`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Public_Facilities`
--

DROP TABLE IF EXISTS `Public_Facilities`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Public_Facilities`
(
    `feature_id`       varchar(255) NOT NULL,
    `name`             varchar(255) NOT NULL,
    `person_in_charge` varchar(255) NOT NULL,
    PRIMARY KEY (`feature_id`),
    CONSTRAINT `Public_Facilities_ibfk_1` FOREIGN KEY (`feature_id`) REFERENCES `Features` (`feature_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Public_Facilities`
--

LOCK TABLES `Public_Facilities` WRITE;
/*!40000 ALTER TABLE `Public_Facilities`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Public_Facilities`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Published`
--

DROP TABLE IF EXISTS `Published`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Published`
(
    `ISBN_number`        int NOT NULL,
    `publishing_journal` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`ISBN_number`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Published`
--

LOCK TABLES `Published` WRITE;
/*!40000 ALTER TABLE `Published`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Published`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Report`
--

DROP TABLE IF EXISTS `Report`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Report`
(
    `report_title`      varchar(255) NOT NULL,
    `parent_data`       varchar(255) NOT NULL,
    `publishing_status` int DEFAULT NULL,
    PRIMARY KEY (`report_title`, `parent_data`),
    KEY `parent_data` (`parent_data`),
    KEY `publishing_status` (`publishing_status`),
    CONSTRAINT `Report_ibfk_1` FOREIGN KEY (`parent_data`) REFERENCES `Data` (`data_id`),
    CONSTRAINT `Report_ibfk_2` FOREIGN KEY (`publishing_status`) REFERENCES `Published` (`ISBN_number`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Report`
--

LOCK TABLES `Report` WRITE;
/*!40000 ALTER TABLE `Report`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Report`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Report_coauthors`
--

DROP TABLE IF EXISTS `Report_coauthors`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Report_coauthors`
(
    `report_title`  varchar(255) NOT NULL,
    `report`        varchar(255) NOT NULL,
    `coauthor_name` varchar(255) NOT NULL,
    PRIMARY KEY (`report_title`, `report`, `coauthor_name`),
    KEY `report` (`report`),
    CONSTRAINT `Report_coauthors_ibfk_1` FOREIGN KEY (`report_title`) REFERENCES `Report` (`report_title`),
    CONSTRAINT `Report_coauthors_ibfk_2` FOREIGN KEY (`report`) REFERENCES `Data` (`data_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Report_coauthors`
--

LOCK TABLES `Report_coauthors` WRITE;
/*!40000 ALTER TABLE `Report_coauthors`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Report_coauthors`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Researcher`
--

DROP TABLE IF EXISTS `Researcher`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Researcher`
(
    `researcher_id`   varchar(255) NOT NULL,
    `name`            varchar(255) NOT NULL,
    `contact_number`  varchar(15)  DEFAULT NULL,
    `email`           varchar(255) NOT NULL,
    `university_name` varchar(255) DEFAULT NULL,
    `permit`          int          DEFAULT NULL,
    PRIMARY KEY (`researcher_id`),
    KEY `permit` (`permit`),
    CONSTRAINT `Researcher_ibfk_1` FOREIGN KEY (`permit`) REFERENCES `Permit` (`permit_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Researcher`
--

LOCK TABLES `Researcher` WRITE;
/*!40000 ALTER TABLE `Researcher`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Researcher`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Service_Feature`
--

DROP TABLE IF EXISTS `Service_Feature`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Service_Feature`
(
    `service_id` varchar(255) NOT NULL,
    `feature_id` varchar(255) NOT NULL,
    PRIMARY KEY (`service_id`, `feature_id`),
    KEY `feature_id` (`feature_id`),
    CONSTRAINT `Service_Feature_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `Services` (`service_id`),
    CONSTRAINT `Service_Feature_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `Features` (`feature_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Service_Feature`
--

LOCK TABLES `Service_Feature` WRITE;
/*!40000 ALTER TABLE `Service_Feature`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Service_Feature`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Service_Feedback`
--

DROP TABLE IF EXISTS `Service_Feedback`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Service_Feedback`
(
    `user_id`    int          NOT NULL,
    `service_id` varchar(255) NOT NULL,
    `rating`     decimal(10, 0) DEFAULT NULL COMMENT 'between 1 and 5',
    `remarks`    longtext,
    `date`       datetime       DEFAULT NULL,
    PRIMARY KEY (`user_id`, `service_id`),
    KEY `service_id` (`service_id`),
    CONSTRAINT `Service_Feedback_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
    CONSTRAINT `Service_Feedback_ibfk_5` FOREIGN KEY (`service_id`) REFERENCES `Services` (`service_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Service_Feedback`
--

LOCK TABLES `Service_Feedback` WRITE;
/*!40000 ALTER TABLE `Service_Feedback`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Service_Feedback`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Service_timings`
--

DROP TABLE IF EXISTS `Service_timings`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Service_timings`
(
    `sub_service_id` varchar(255) NOT NULL,
    `service_id`     varchar(255)                                                                  DEFAULT NULL,
    `timings`        time                                                                          DEFAULT NULL,
    `day_of_service` enum ('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') DEFAULT NULL,
    PRIMARY KEY (`sub_service_id`),
    KEY `service_id` (`service_id`),
    CONSTRAINT `Service_timings_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `Services` (`service_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Service_timings`
--

LOCK TABLES `Service_timings` WRITE;
/*!40000 ALTER TABLE `Service_timings`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Service_timings`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Services`
--

DROP TABLE IF EXISTS `Services`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Services`
(
    `service_id`   varchar(255)   NOT NULL,
    `name`         varchar(255)   NOT NULL,
    `availability` int DEFAULT NULL,
    `capacity`     int DEFAULT NULL,
    `price`        decimal(10, 0) NOT NULL,
    `description`  longtext,
    `provided_by`  int DEFAULT NULL,
    PRIMARY KEY (`service_id`),
    KEY `provided_by` (`provided_by`),
    CONSTRAINT `Services_ibfk_1` FOREIGN KEY (`provided_by`) REFERENCES `National_Park` (`unit_code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Services`
--

LOCK TABLES `Services` WRITE;
/*!40000 ALTER TABLE `Services`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Services`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Species`
--

DROP TABLE IF EXISTS `Species`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Species`
(
    `genus`            varchar(255)                                                                                                                              NOT NULL,
    `specific_name`    varchar(255)                                                                                                                              NOT NULL,
    `taxonomy_code`    varchar(10)                                                                                                                               NOT NULL,
    `name`             varchar(255)                                                                                                                              NOT NULL,
    `vulnerability`    enum ('Extinct','Extinct from wild','Critically Endangered','Endangered','Vulnerable','Near Threatened','Least Concern','Data Deficient') NOT NULL,
    `average_lifespan` decimal(10, 0)                                                                                                                            NOT NULL,
    PRIMARY KEY (`genus`, `specific_name`),
    UNIQUE KEY `taxonomy_code` (`taxonomy_code`),
    UNIQUE KEY `name` (`name`),
    CONSTRAINT `Species_ibfk_1` FOREIGN KEY (`genus`) REFERENCES `Family_classification` (`genus`) ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Species`
--

LOCK TABLES `Species` WRITE;
/*!40000 ALTER TABLE `Species`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Species`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Species_habitats`
--

DROP TABLE IF EXISTS `Species_habitats`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Species_habitats`
(
    `presence_id`     varchar(255)                                                           NOT NULL,
    `type_of_habitat` enum ('Marshland','Desert','Savannah','Mountainous','Forest','Tundra') NOT NULL,
    PRIMARY KEY (`presence_id`, `type_of_habitat`),
    CONSTRAINT `Species_habitats_ibfk_1` FOREIGN KEY (`presence_id`) REFERENCES `Presence` (`presence_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Species_habitats`
--

LOCK TABLES `Species_habitats` WRITE;
/*!40000 ALTER TABLE `Species_habitats`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Species_habitats`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Species_names`
--

DROP TABLE IF EXISTS `Species_names`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Species_names`
(
    `name`        varchar(255) NOT NULL,
    `common_name` varchar(255) NOT NULL,
    PRIMARY KEY (`name`, `common_name`),
    CONSTRAINT `Species_names_ibfk_1` FOREIGN KEY (`name`) REFERENCES `Species` (`name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Species_names`
--

LOCK TABLES `Species_names` WRITE;
/*!40000 ALTER TABLE `Species_names`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Species_names`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Study`
--

DROP TABLE IF EXISTS `Study`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Study`
(
    `study_id`      varchar(255) NOT NULL,
    `national_park` int          DEFAULT NULL,
    `researcher`    varchar(255) DEFAULT NULL,
    `type`          varchar(255) DEFAULT NULL,
    `duration`      datetime     DEFAULT NULL,
    PRIMARY KEY (`study_id`),
    KEY `national_park` (`national_park`),
    KEY `researcher` (`researcher`),
    CONSTRAINT `Study_ibfk_1` FOREIGN KEY (`researcher`) REFERENCES `Researcher` (`researcher_id`),
    CONSTRAINT `Study_ibfk_2` FOREIGN KEY (`national_park`) REFERENCES `National_Park` (`unit_code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Study`
--

LOCK TABLES `Study` WRITE;
/*!40000 ALTER TABLE `Study`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Study`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Study_data`
--

DROP TABLE IF EXISTS `Study_data`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Study_data`
(
    `study_id` varchar(255) NOT NULL,
    `data_id`  varchar(255) NOT NULL,
    PRIMARY KEY (`study_id`, `data_id`),
    KEY `data_id` (`data_id`),
    CONSTRAINT `Study_data_ibfk_1` FOREIGN KEY (`study_id`) REFERENCES `Study` (`study_id`),
    CONSTRAINT `Study_data_ibfk_2` FOREIGN KEY (`data_id`) REFERENCES `Data` (`data_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Study_data`
--

LOCK TABLES `Study_data` WRITE;
/*!40000 ALTER TABLE `Study_data`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Study_data`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Study_species`
--

DROP TABLE IF EXISTS `Study_species`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Study_species`
(
    `study_id`      varchar(255) NOT NULL,
    `genus`         varchar(255) NOT NULL,
    `specific_name` varchar(255) NOT NULL,
    PRIMARY KEY (`study_id`, `genus`, `specific_name`),
    KEY `genus` (`genus`, `specific_name`),
    CONSTRAINT `Study_species_ibfk_1` FOREIGN KEY (`study_id`) REFERENCES `Study` (`study_id`),
    CONSTRAINT `Study_species_ibfk_7` FOREIGN KEY (`genus`, `specific_name`) REFERENCES `Species` (`genus`, `specific_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Study_species`
--

LOCK TABLES `Study_species` WRITE;
/*!40000 ALTER TABLE `Study_species`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Study_species`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Trail`
--

DROP TABLE IF EXISTS `Trail`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Trail`
(
    `feature_id`   varchar(255) NOT NULL,
    `name`         varchar(255) NOT NULL,
    `length`       decimal(10, 0) DEFAULT NULL,
    `spatial_data` geometry       DEFAULT NULL,
    PRIMARY KEY (`feature_id`),
    CONSTRAINT `Trail_ibfk_1` FOREIGN KEY (`feature_id`) REFERENCES `Features` (`feature_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Trail`
--

LOCK TABLES `Trail` WRITE;
/*!40000 ALTER TABLE `Trail`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Trail`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transaction`
--

DROP TABLE IF EXISTS `Transaction`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transaction`
(
    `transaction_id`      int       NOT NULL,
    `price`               int       NOT NULL,
    `date_of_transaction` timestamp NULL                                                                    DEFAULT (now()),
    `pay_method`          enum ('mobile transfer','credit card','net banking','cash','cheque','debit card') DEFAULT NULL,
    PRIMARY KEY (`transaction_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transaction`
--

LOCK TABLES `Transaction` WRITE;
/*!40000 ALTER TABLE `Transaction`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Transaction`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User`
(
    `user_id`        int          NOT NULL,
    `username`       varchar(255) NOT NULL,
    `email`          varchar(255) NOT NULL,
    `password`       varchar(255) NOT NULL,
    `contact_number` varchar(15) DEFAULT NULL,
    PRIMARY KEY (`user_id`),
    UNIQUE KEY `email` (`email`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `User`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ViewPoints`
--

DROP TABLE IF EXISTS `ViewPoints`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ViewPoints`
(
    `feature_id` varchar(255) NOT NULL,
    `name`       varchar(255) NOT NULL,
    PRIMARY KEY (`feature_id`),
    CONSTRAINT `ViewPoints_ibfk_1` FOREIGN KEY (`feature_id`) REFERENCES `Features` (`feature_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ViewPoints`
--

LOCK TABLES `ViewPoints` WRITE;
/*!40000 ALTER TABLE `ViewPoints`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `ViewPoints`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Volunteer`
--

DROP TABLE IF EXISTS `Volunteer`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Volunteer`
(
    `volunteer_permit_id` int NOT NULL,
    `user_id`             int      DEFAULT NULL,
    `emp_incharge`        int      DEFAULT NULL,
    `dep_number`          int      DEFAULT NULL,
    `period`              datetime DEFAULT (now()),
    `job_description`     longtext,
    `national_park`       int NOT NULL,
    PRIMARY KEY (`volunteer_permit_id`),
    KEY `user_id` (`user_id`),
    KEY `emp_incharge` (`emp_incharge`),
    KEY `national_park` (`national_park`, `dep_number`),
    CONSTRAINT `Volunteer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
    CONSTRAINT `Volunteer_ibfk_10` FOREIGN KEY (`national_park`, `dep_number`) REFERENCES `Department` (`contained_in`, `dep_number`),
    CONSTRAINT `Volunteer_ibfk_12` FOREIGN KEY (`emp_incharge`) REFERENCES `Employee` (`emp_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Volunteer`
--

LOCK TABLES `Volunteer` WRITE;
/*!40000 ALTER TABLE `Volunteer`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Volunteer`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Zone`
--

DROP TABLE IF EXISTS `Zone`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Zone`
(
    `belongs_to`  int NOT NULL,
    `zone_number` int NOT NULL,
    `contact`     varchar(15) DEFAULT NULL,
    PRIMARY KEY (`zone_number`, `belongs_to`),
    KEY `belongs_to` (`belongs_to`),
    CONSTRAINT `Zone_ibfk_1` FOREIGN KEY (`belongs_to`) REFERENCES `National_Park` (`unit_code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Zone`
--

LOCK TABLES `Zone` WRITE;
/*!40000 ALTER TABLE `Zone`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Zone`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Zone_contains`
--

DROP TABLE IF EXISTS `Zone_contains`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Zone_contains`
(
    `zone_number` int          NOT NULL,
    `feature_id`  varchar(255) NOT NULL,
    PRIMARY KEY (`zone_number`, `feature_id`),
    KEY `feature_id` (`feature_id`),
    CONSTRAINT `Zone_contains_ibfk_1` FOREIGN KEY (`zone_number`) REFERENCES `Zone` (`zone_number`),
    CONSTRAINT `Zone_contains_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `Features` (`feature_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Zone_contains`
--

LOCK TABLES `Zone_contains` WRITE;
/*!40000 ALTER TABLE `Zone_contains`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Zone_contains`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Zone_terrain`
--

DROP TABLE IF EXISTS `Zone_terrain`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Zone_terrain`
(
    `naitonal_park` int                                                                    NOT NULL,
    `zone_number`   int                                                                    NOT NULL,
    `terrain`       enum ('Marshland','Desert','Savannah','Mountainous','Forest','Tundra') NOT NULL,
    PRIMARY KEY (`zone_number`, `terrain`, `naitonal_park`),
    KEY `naitonal_park` (`naitonal_park`),
    CONSTRAINT `Zone_terrain_ibfk_1` FOREIGN KEY (`zone_number`) REFERENCES `Zone` (`zone_number`),
    CONSTRAINT `Zone_terrain_ibfk_2` FOREIGN KEY (`naitonal_park`) REFERENCES `National_Park` (`unit_code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Zone_terrain`
--

LOCK TABLES `Zone_terrain` WRITE;
/*!40000 ALTER TABLE `Zone_terrain`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `Zone_terrain`
    ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE = @OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES = @OLD_SQL_NOTES */;

-- Dump completed on 2020-10-01 12:06:55
