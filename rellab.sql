-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 23, 2022 at 03:36 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.0.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rellab`
--

-- --------------------------------------------------------

--
-- Table structure for table `machine_data`
--

CREATE TABLE `machine_data` (
  `name` varchar(255) NOT NULL,
  `temp` varchar(255) NOT NULL,
  `humid` varchar(255) NOT NULL,
  `timestamp` varchar(255) NOT NULL,
  `LOG_600` varchar(255) NOT NULL,
  `LOG` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `machine_data`
--

INSERT INTO `machine_data` (`name`, `temp`, `humid`, `timestamp`, `LOG_600`, `LOG`) VALUES
('TEMPCYCLE#01', '128.42', '25.48', '05:17:36', '{\r\n    \"temp\": \"128.42\",\r\n    \"humid\": \"25.48\",\r\n    \"time\": \"05:07:58\"\r\n},\r\n{\r\n    \"temp\": \"128.42\",\r\n    \"humid\": \"25.48\",\r\n    \"time\": \"05:07:58\"\r\n},', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `machine_data`
--
ALTER TABLE `machine_data`
  ADD UNIQUE KEY `name` (`name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
