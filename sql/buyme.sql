-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Mar 26, 2021 at 02:53 PM
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
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `login` varchar(30) NOT NULL,
  `password` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `type` enum('END_USER','CUSTOMER_REP','ADMIN') NOT NULL DEFAULT 'END_USER'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`login`, `password`, `email`, `type`) VALUES
('Admin', 'testpassword5', 'Admin@buyme.com', 'ADMIN'),
('Customer', 'testpassword6', 'customer@buyme.com', 'END_USER'),
('Dorian_Hobot', 'testpassword1', 'djh242@scarletmail.rutgers.edu', 'CUSTOMER_REP'),
('Jared_Tulayan', 'testpassword4', 'jared.tulayan@rutgers.edu', 'CUSTOMER_REP'),
('Mikita_Belausau', 'testpassword3', 'mikita.belausau@rutgers.edu', 'CUSTOMER_REP'),
('Muskan_Burman', 'testpassword2', 'mb1966@rutgers.edu', 'CUSTOMER_REP');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`login`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
