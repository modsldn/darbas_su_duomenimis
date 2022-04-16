create database programavimo_kursai;
use programavimo_kursai; 



CREATE TABLE `employees` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `last_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `hourly_rate` float(5,2) DEFAULT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `courses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` float(7,1) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `course_employees` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `course_id` int unsigned DEFAULT NULL,
  `employee_id` int unsigned DEFAULT NULL,
  `hours` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_id` (`course_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `course_employees_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`),
  CONSTRAINT `course_employees_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`)
);