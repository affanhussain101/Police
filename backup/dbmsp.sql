-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 21, 2022 at 11:46 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbmsp`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `NAME` varchar(20) DEFAULT NULL,
  `EMAIL` varchar(30) NOT NULL,
  `MESSAGE` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `crime`
--

CREATE TABLE `crime` (
  `CRIME_ID` int(11) NOT NULL,
  `TYPE` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `crime`
--

INSERT INTO `crime` (`CRIME_ID`, `TYPE`) VALUES
(302, 'Murder'),
(376, 'Rape'),
(378, 'Theft');

-- --------------------------------------------------------

--
-- Table structure for table `criminal`
--

CREATE TABLE `criminal` (
  `NAME` varchar(30) DEFAULT NULL,
  `CRIMINAL_ID` int(11) NOT NULL,
  `ADDRESS` varchar(30) DEFAULT NULL,
  `CRIME_ID` int(11) DEFAULT NULL,
  `FIR_NO` varchar(10) DEFAULT NULL,
  `POLICE_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `does`
--

CREATE TABLE `does` (
  `CRIME_ID` int(11) DEFAULT NULL,
  `CRIMINAL_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `fir`
--

CREATE TABLE `fir` (
  `FIR_NO` varchar(10) NOT NULL,
  `DATE` date DEFAULT NULL,
  `INFORMANT_NAME` varchar(30) DEFAULT NULL,
  `CRIME_PLACE` varchar(60) DEFAULT NULL,
  `CRIME_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fir`
--

INSERT INTO `fir` (`FIR_NO`, `DATE`, `INFORMANT_NAME`, `CRIME_PLACE`, `CRIME_ID`) VALUES
('777', '2022-01-21', 'yatin', 'ise', 302);

-- --------------------------------------------------------

--
-- Table structure for table `police`
--

CREATE TABLE `police` (
  `POLICE_ID` int(11) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL,
  `DESIGNATION` varchar(30) DEFAULT NULL,
  `CONTACT_NO` bigint(20) DEFAULT NULL,
  `STATION_ID` int(11) DEFAULT NULL,
  `PASSWORD` varchar(20) DEFAULT NULL,
  `EMAIL` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `police`
--

INSERT INTO `police` (`POLICE_ID`, `NAME`, `DESIGNATION`, `CONTACT_NO`, `STATION_ID`, `PASSWORD`, `EMAIL`) VALUES
(6969, 'aayush', 'Hawaldaar', 98765432, 123456, '9999', 'hawaldaar@gmail.com'),
(7549, 'Md Affan', 'SP', 9110051293, 123456, 'affan', 'hussainaffan911@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `station`
--

CREATE TABLE `station` (
  `STATION_ID` int(11) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL,
  `ADDRESS` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `station`
--

INSERT INTO `station` (`STATION_ID`, `NAME`, `ADDRESS`) VALUES
(123456, 'SOLDEVANHALLI', 'ACHIT NAGAR,SOLDEVANHALLI');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`EMAIL`);

--
-- Indexes for table `crime`
--
ALTER TABLE `crime`
  ADD PRIMARY KEY (`CRIME_ID`);

--
-- Indexes for table `criminal`
--
ALTER TABLE `criminal`
  ADD PRIMARY KEY (`CRIMINAL_ID`),
  ADD KEY `FK3` (`CRIME_ID`),
  ADD KEY `FK4` (`FIR_NO`),
  ADD KEY `FK5` (`POLICE_ID`);

--
-- Indexes for table `does`
--
ALTER TABLE `does`
  ADD KEY `FK6` (`CRIME_ID`),
  ADD KEY `FK7` (`CRIMINAL_ID`);

--
-- Indexes for table `fir`
--
ALTER TABLE `fir`
  ADD PRIMARY KEY (`FIR_NO`),
  ADD KEY `FK2` (`CRIME_ID`);

--
-- Indexes for table `police`
--
ALTER TABLE `police`
  ADD PRIMARY KEY (`POLICE_ID`),
  ADD KEY `FK1` (`STATION_ID`);

--
-- Indexes for table `station`
--
ALTER TABLE `station`
  ADD PRIMARY KEY (`STATION_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `criminal`
--
ALTER TABLE `criminal`
  ADD CONSTRAINT `FK3` FOREIGN KEY (`CRIME_ID`) REFERENCES `crime` (`CRIME_ID`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK4` FOREIGN KEY (`FIR_NO`) REFERENCES `fir` (`FIR_NO`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK5` FOREIGN KEY (`POLICE_ID`) REFERENCES `police` (`POLICE_ID`) ON DELETE SET NULL;

--
-- Constraints for table `does`
--
ALTER TABLE `does`
  ADD CONSTRAINT `FK6` FOREIGN KEY (`CRIME_ID`) REFERENCES `crime` (`CRIME_ID`),
  ADD CONSTRAINT `FK7` FOREIGN KEY (`CRIMINAL_ID`) REFERENCES `criminal` (`CRIMINAL_ID`);

--
-- Constraints for table `fir`
--
ALTER TABLE `fir`
  ADD CONSTRAINT `FK2` FOREIGN KEY (`CRIME_ID`) REFERENCES `crime` (`CRIME_ID`);

--
-- Constraints for table `police`
--
ALTER TABLE `police`
  ADD CONSTRAINT `FK1` FOREIGN KEY (`STATION_ID`) REFERENCES `station` (`STATION_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
