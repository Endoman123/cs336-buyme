-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Apr 26, 2021 at 01:57 AM
-- Server version: 8.0.24
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `buyme`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `login` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`login`) VALUES
('admin');

-- --------------------------------------------------------

--
-- Table structure for table `auction_transactions`
--

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
  `subcategory` varchar(30) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `brand` varchar(30) DEFAULT NULL,
  `color` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auction_transactions`
--

INSERT INTO `auction_transactions` (`auction_ID`, `item_ID`, `login`, `close_date`, `close_time`, `winner`, `init_price`, `bid_increment`, `minimum`, `final_price`, `subcategory`, `name`, `brand`, `color`) VALUES
(1, 1, 'dorianht', '2021-04-25', '23:00:00', NULL, 20, 2, 3, NULL, 'shoes', 'Gucci Shoes', 'gucci', 'black'),
(2, 1, 'endoman123', '2021-04-18', '23:00:00', 'muskanb12', 20, 1, 2, 40, 'shoes', 'Gucci Shoes', 'gucci', 'black'),
(3, 1, 'muskanb12', '2021-03-08', '23:00:00', 'windhollow', 10, 1, 2, 30, 'shoes', 'Gucci Shoes', 'gucci', 'black'),
(4, 1, 'windhollow', '2021-04-09', '23:00:00', 'dorianht', 30, 2, 5, 50, 'shoes', 'Gucci Shoes', 'gucci', 'black'),
(5, 2, 'dorianht', '2021-04-25', '23:00:00', NULL, 20, 2, 3, NULL, 'pants', 'Uniqlo Pants', 'uniqlo', 'grey'),
(6, 2, 'endoman123', '2021-04-18', '23:00:00', 'muskanb12', 20, 1, 2, 40, 'pants', 'Uniqlo Pants', 'uniqlo', 'grey'),
(7, 2, 'muskanb12', '2021-03-08', '23:00:00', 'windhollow', 10, 1, 2, 30, 'pants', 'Uniqlo Pants', 'uniqlo', 'grey'),
(8, 2, 'windhollow', '2021-04-09', '23:00:00', 'dorianht', 30, 2, 5, 50, 'pants', 'Uniqlo Pants', 'uniqlo', 'grey'),
(9, 3, 'dorianht', '2021-04-25', '23:00:00', NULL, 20, 2, 3, NULL, 'shirts', 'Polo Shirt', 'polo', 'green'),
(10, 3, 'endoman123', '2021-04-18', '23:00:00', 'muskanb12', 20, 1, 2, 40, 'shirts', 'Polo Shirt', 'polo', 'green'),
(11, 3, 'muskanb12', '2021-03-08', '23:00:00', 'windhollow', 10, 1, 2, 30, 'shirts', 'Polo Shirt', 'polo', 'green'),
(12, 3, 'windhollow', '2021-04-09', '23:00:00', 'dorianht', 30, 2, 5, 50, 'shirts', 'Polo Shirt', 'polo', 'green');

-- --------------------------------------------------------

--
-- Table structure for table `autobid`
--

CREATE TABLE `autobid` (
  `login` varchar(30) NOT NULL,
  `auction_ID` int NOT NULL,
  `bid_increment` float DEFAULT NULL,
  `upper_limit` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bid_posts_for`
--

CREATE TABLE `bid_posts_for` (
  `bid_number` int NOT NULL,
  `login` varchar(30) DEFAULT NULL,
  `auction_ID` int DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `bid_date` date DEFAULT NULL,
  `bid_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bid_posts_for`
--

INSERT INTO `bid_posts_for` (`bid_number`, `login`, `auction_ID`, `amount`, `bid_date`, `bid_time`) VALUES
(1, 'endoman123', 2, 20, '2021-04-20', '11:48:28'),
(2, 'muskanb12', 2, 20, '2021-04-20', '11:47:00'),
(3, 'endoman123', 2, 20, '2021-04-21', '11:48:28');

-- --------------------------------------------------------

--
-- Table structure for table `customer_rep`
--

CREATE TABLE `customer_rep` (
  `login` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `customer_rep`
--

INSERT INTO `customer_rep` (`login`) VALUES
('rep');

-- --------------------------------------------------------

--
-- Table structure for table `end_user`
--

CREATE TABLE `end_user` (
  `login` varchar(30) NOT NULL,
  `bid_alert` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `end_user`
--

INSERT INTO `end_user` (`login`, `bid_alert`) VALUES
('dorianht', 1),
('endoman123', 1),
('muskanb12', 1),
('windhollow', 1);

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `item_ID` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `subcategory` varchar(30) NOT NULL,
  `color` varchar(30) NOT NULL,
  `brand` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`item_ID`, `name`, `subcategory`, `color`, `brand`) VALUES
(1, 'Gucci Shoes', 'shoes', 'black', 'gucci'),
(2, 'Uniqlo Pants', 'pants', 'blue', 'uniqlo'),
(3, 'Polo Shirt', 'shirt', 'green', 'polo');

-- --------------------------------------------------------

--
-- Table structure for table `item_alerts`
--

CREATE TABLE `item_alerts` (
  `item_ID` int NOT NULL,
  `login` varchar(30) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `item_alerts`
--

INSERT INTO `item_alerts` (`item_ID`, `login`, `name`) VALUES
(0, 'dorianht', 'gucci shoes'),
(0, 'endoman123', 'gucci');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int NOT NULL,
  `eu_login` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cr_login` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `question_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `answer_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `eu_login`, `cr_login`, `question_text`, `answer_text`) VALUES
(1, 'endoman123', NULL, 'How do I create an auction?', NULL),
(2, 'dorianht', NULL, 'When do I know an auction has ended?', NULL),
(3, 'muskanb12', NULL, 'How do I reset my password?', NULL),
(4, 'windhollow', NULL, 'Can I remove an auction?', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `login` varchar(30) NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `hash` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `salt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`login`, `email`, `hash`, `salt`) VALUES
('admin', 'admin@buyme.com', '7Dv6iB4qDQARRIstzfi7OA==', '178efc4a880'),
('dorianht', 'dorian.hobot@rutgers.edu', 'Wf4ZSsopreO4BZmi52AZbQ==', '178efc572bb'),
('endoman123', 'jared.tulayan@rutgers.edu', 'SUYvXobrEuW+73Sqg9REhg==', '178efc5b932'),
('muskanb12', 'muskan.burman@rutgers.edu', 'b1qfynQU1QI1JeXMLEQQ0Q==', '178efc61152'),
('rep', 'rep@buyme.com', 'eTRbwE7XQtJ+k1TlWb0QMA==', '178efc76f60'),
('windhollow', 'mikita.belausau@rutgers.edu', 'fjM7wRaniOkLzSGSXIWmPQ==', '178efc68434');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`login`);

--
-- Indexes for table `auction_transactions`
--
ALTER TABLE `auction_transactions`
  ADD PRIMARY KEY (`auction_ID`),
  ADD KEY `item_ID` (`item_ID`),
  ADD KEY `login` (`login`);

--
-- Indexes for table `autobid`
--
ALTER TABLE `autobid`
  ADD PRIMARY KEY (`login`,`auction_ID`),
  ADD KEY `auction_ID` (`auction_ID`);

--
-- Indexes for table `bid_posts_for`
--
ALTER TABLE `bid_posts_for`
  ADD PRIMARY KEY (`bid_number`),
  ADD KEY `auction_ID` (`auction_ID`),
  ADD KEY `login` (`login`);

--
-- Indexes for table `customer_rep`
--
ALTER TABLE `customer_rep`
  ADD PRIMARY KEY (`login`);

--
-- Indexes for table `end_user`
--
ALTER TABLE `end_user`
  ADD PRIMARY KEY (`login`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`item_ID`);

--
-- Indexes for table `item_alerts`
--
ALTER TABLE `item_alerts`
  ADD PRIMARY KEY (`login`,`item_ID`),
  ADD KEY `item_ID` (`item_ID`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `eu_login` (`eu_login`) USING BTREE,
  ADD KEY `cr_login` (`cr_login`) USING BTREE;

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`login`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auction_transactions`
--
ALTER TABLE `auction_transactions`
  MODIFY `auction_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `bid_posts_for`
--
ALTER TABLE `bid_posts_for`
  MODIFY `bid_number` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `item_ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`login`) REFERENCES `user` (`login`);

--
-- Constraints for table `auction_transactions`
--
ALTER TABLE `auction_transactions`
  ADD CONSTRAINT `auction_transactions_ibfk_1` FOREIGN KEY (`item_ID`) REFERENCES `item` (`item_ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `auction_transactions_ibfk_2` FOREIGN KEY (`login`) REFERENCES `end_user` (`login`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `autobid`
--
ALTER TABLE `autobid`
  ADD CONSTRAINT `autobid_ibfk_1` FOREIGN KEY (`auction_ID`) REFERENCES `auction_transactions` (`auction_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `autobid_ibfk_2` FOREIGN KEY (`login`) REFERENCES `user` (`login`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bid_posts_for`
--
ALTER TABLE `bid_posts_for`
  ADD CONSTRAINT `bid_posts_for_ibfk_1` FOREIGN KEY (`auction_ID`) REFERENCES `auction_transactions` (`auction_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bid_posts_for_ibfk_2` FOREIGN KEY (`login`) REFERENCES `user` (`login`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `customer_rep`
--
ALTER TABLE `customer_rep`
  ADD CONSTRAINT `customer_rep_ibfk_1` FOREIGN KEY (`login`) REFERENCES `user` (`login`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `end_user`
--
ALTER TABLE `end_user`
  ADD CONSTRAINT `end_user_ibfk_1` FOREIGN KEY (`login`) REFERENCES `user` (`login`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `item_alerts`
--
ALTER TABLE `item_alerts`
  ADD CONSTRAINT `item_alerts_ibfk_1` FOREIGN KEY (`login`) REFERENCES `user` (`login`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`eu_login`) REFERENCES `end_user` (`login`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `questions_ibfk_2` FOREIGN KEY (`cr_login`) REFERENCES `customer_rep` (`login`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
