-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Apr 19, 2021 at 03:55 PM
-- Server version: 8.0.23
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
('Admin');

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
  `final_price` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `belongs_to`
--

CREATE TABLE `belongs_to` (
  `category_number` int NOT NULL,
  `item_ID` int NOT NULL
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
  `bid_time` time DEFAULT NULL,
  `auto_bid` tinyint(1) DEFAULT NULL,
  `bid_increment` float DEFAULT NULL,
  `upper_limit` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_number` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
('Dorian_Hobot'),
('Jared_Tulayan'),
('Mikita_Belausau'),
('Muskan_Burman');

-- --------------------------------------------------------

--
-- Table structure for table `end_user`
--

CREATE TABLE `end_user` (
  `login` varchar(30) NOT NULL,
  `bid_alert` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `item_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item_alerts`
--

CREATE TABLE `item_alerts` (
  `login` varchar(30) NOT NULL,
  `item_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int NOT NULL,
  `eu_login` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cr_login` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `question_text` varchar(144) DEFAULT NULL,
  `answer_text` varchar(144) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_category_1`
--

CREATE TABLE `sub_category_1` (
  `category_number` int NOT NULL,
  `spec_1` varchar(20) DEFAULT NULL,
  `spec_2` varchar(20) DEFAULT NULL,
  `spec_3` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_category_2`
--

CREATE TABLE `sub_category_2` (
  `category_number` int NOT NULL,
  `spec_1` varchar(20) DEFAULT NULL,
  `spec_2` varchar(20) DEFAULT NULL,
  `spec_3` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_category_3`
--

CREATE TABLE `sub_category_3` (
  `category_number` int NOT NULL,
  `spec_1` varchar(20) DEFAULT NULL,
  `spec_2` varchar(20) DEFAULT NULL,
  `spec_3` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `login` varchar(30) NOT NULL,
  `password` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`login`, `password`, `email`) VALUES
('Admin', 'testpassword5', 'Admin@buyme.com'),
('Dorian_Hobot', 'testpassword1', 'djh242@scarletmail.rutgers.edu'),
('Jared_Tulayan', 'testpassword4', 'jared.tulayan@rutgers.edu'),
('Mikita_Belausau', 'testpassword3', 'mikita.belausau@rutgers.edu'),
('Muskan_Burman', 'testpassword2', 'mb1966@rutgers.edu');

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
-- Indexes for table `belongs_to`
--
ALTER TABLE `belongs_to`
  ADD PRIMARY KEY (`category_number`,`item_ID`),
  ADD KEY `item_ID` (`item_ID`);

--
-- Indexes for table `bid_posts_for`
--
ALTER TABLE `bid_posts_for`
  ADD PRIMARY KEY (`bid_number`),
  ADD KEY `auction_ID` (`auction_ID`),
  ADD KEY `login` (`login`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_number`);

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
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_login_Customer_Rep` (`cr_login`),
  ADD KEY `user_login_End_User` (`eu_login`) USING BTREE;

--
-- Indexes for table `sub_category_1`
--
ALTER TABLE `sub_category_1`
  ADD PRIMARY KEY (`category_number`);

--
-- Indexes for table `sub_category_2`
--
ALTER TABLE `sub_category_2`
  ADD PRIMARY KEY (`category_number`);

--
-- Indexes for table `sub_category_3`
--
ALTER TABLE `sub_category_3`
  ADD PRIMARY KEY (`category_number`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`login`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`login`) REFERENCES `user` (`login`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `auction_transactions`
--
ALTER TABLE `auction_transactions`
  ADD CONSTRAINT `auction_transactions_ibfk_1` FOREIGN KEY (`item_ID`) REFERENCES `item` (`item_ID`),
  ADD CONSTRAINT `auction_transactions_ibfk_2` FOREIGN KEY (`login`) REFERENCES `user` (`login`);

--
-- Constraints for table `belongs_to`
--
ALTER TABLE `belongs_to`
  ADD CONSTRAINT `belongs_to_ibfk_1` FOREIGN KEY (`category_number`) REFERENCES `category` (`category_number`),
  ADD CONSTRAINT `belongs_to_ibfk_2` FOREIGN KEY (`item_ID`) REFERENCES `item` (`item_ID`);

--
-- Constraints for table `bid_posts_for`
--
ALTER TABLE `bid_posts_for`
  ADD CONSTRAINT `bid_posts_for_ibfk_1` FOREIGN KEY (`auction_ID`) REFERENCES `auction_transactions` (`auction_ID`),
  ADD CONSTRAINT `bid_posts_for_ibfk_2` FOREIGN KEY (`login`) REFERENCES `user` (`login`);

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
  ADD CONSTRAINT `item_alerts_ibfk_1` FOREIGN KEY (`login`) REFERENCES `user` (`login`),
  ADD CONSTRAINT `item_alerts_ibfk_2` FOREIGN KEY (`item_ID`) REFERENCES `item` (`item_ID`);

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`eu_login`) REFERENCES `end_user` (`login`),
  ADD CONSTRAINT `questions_ibfk_2` FOREIGN KEY (`cr_login`) REFERENCES `customer_rep` (`login`);

--
-- Constraints for table `sub_category_1`
--
ALTER TABLE `sub_category_1`
  ADD CONSTRAINT `sub_category_1_ibfk_1` FOREIGN KEY (`category_number`) REFERENCES `category` (`category_number`);

--
-- Constraints for table `sub_category_2`
--
ALTER TABLE `sub_category_2`
  ADD CONSTRAINT `sub_category_2_ibfk_1` FOREIGN KEY (`category_number`) REFERENCES `category` (`category_number`);

--
-- Constraints for table `sub_category_3`
--
ALTER TABLE `sub_category_3`
  ADD CONSTRAINT `sub_category_3_ibfk_1` FOREIGN KEY (`category_number`) REFERENCES `category` (`category_number`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
