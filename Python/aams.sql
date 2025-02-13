-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 13, 2025 at 01:09 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aams`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `Id` int(11) NOT NULL,
  `AdminId` varchar(20) DEFAULT NULL,
  `Password` varchar(20) DEFAULT NULL,
  `AUTHNEW` varchar(50) DEFAULT NULL,
  `Name` varchar(20) DEFAULT NULL,
  `Details` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`Id`, `AdminId`, `Password`, `AUTHNEW`, `Name`, `Details`) VALUES
(1, '003006009', 'Admin', '@f5sdf$5sdfr5httrh0df50', 'Sameer', '9511606451'),
(3, 'Sameer0075', 'Sam@123Know$', 'Sam@123Know$autogen', 'Sameer Sayyed', '9511606451');

-- --------------------------------------------------------

--
-- Table structure for table `admit`
--

CREATE TABLE `admit` (
  `Id` int(11) NOT NULL,
  `FormId` int(11) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Course` varchar(20) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  `Message` varchar(20) DEFAULT NULL,
  `AdhaarId` int(11) NOT NULL,
  `Pic` varchar(100) DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `Fee` int(11) DEFAULT NULL,
  `AdmitBy` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admit`
--

INSERT INTO `admit` (`Id`, `FormId`, `Name`, `Course`, `Status`, `Message`, `AdhaarId`, `Pic`, `Age`, `Fee`, `AdmitBy`) VALUES
(1, 404022, 'Sameer Sayyed', 'MCA', 'Admitted', 'Please Visit College', 64116115, 'http://eeewrwer.com/cdn/img.png', 19, 100, 'Sameer'),
(3, 404023, 'Sr. Sameer', 'MCA', 'Pending', 'Please Visit Collleg', 64116116, 'http://url.com/cdn/pic.png', 19, 0, 'Sameer'),
(4, 404022, 'Sameer Sayyed', 'MCA', 'Admitted', 'Please Visit College', 64116116, 'http://eeewrwer.com/cdn/img.png', 19, 100, 'Sameer'),
(5, 404025, 'Rehan Shaikh', 'BCA', 'Canceled', 'Please Visit College', 64116115, 'http://Url.com/cdn/img2.png', 19, 0, 'Sameer'),
(6, 404028, 'Aslam Sayedu', 'Physics', 'Pending', 'Please Visit College', 6445161, 'none', 20, 0, 'Sameer');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `Id` int(11) NOT NULL,
  `FormId` int(11) NOT NULL,
  `Course` varchar(20) DEFAULT NULL,
  `Fee` int(11) DEFAULT NULL,
  `Description` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`Id`, `FormId`, `Course`, `Fee`, `Description`) VALUES
(1, 555, 'BCA', 20000, 'Course Description I'),
(2, 555, 'MCA', 24000, 'Course Description I'),
(3, 555, 'Bsc', 24000, 'Course Description I');

-- --------------------------------------------------------

--
-- Table structure for table `forms`
--

CREATE TABLE `forms` (
  `Id` int(11) NOT NULL,
  `FormId` int(11) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Course` varchar(20) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  `Message` varchar(20) DEFAULT NULL,
  `AdhaarId` text NOT NULL,
  `Pic` varchar(100) DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `Fee` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `forms`
--

INSERT INTO `forms` (`Id`, `FormId`, `Name`, `Course`, `Status`, `Message`, `AdhaarId`, `Pic`, `Age`, `Fee`) VALUES
(1, 404022, 'Sameer Sayyed', 'MCA', 'Admitted', 'Please Visit College', '64116116', 'http://eeewrwer.com/cdn/img.png', 19, 100),
(6, 404023, 'Sr. Sameer', 'MCA', 'Admitted', 'Please Visit Collleg', '64116116', 'http://url.com/cdn/pic.png', 19, 0),
(7, 404024, 'Sameer Najir Sayyed', 'MCA', 'Admitted', 'Please Visit College', '64116116', 'none', 19, 0),
(8, 404025, 'Rehan Shaikh', 'BCA', 'Admitted', 'Please Visit College', '64116115', 'http://Url.com/cdn/img2.png', 19, 0),
(9, 404026, 'Najir Sayyed', 'MCA', 'Pending', 'Please Visit College', '6445161', 'none', 20, 0),
(10, 404027, 'Khurshid Sayyed', 'MCA', 'Pending', 'Please Visit College', '6445161', 'none', 20, 0),
(11, 404028, 'Aslam Shaikh', 'Physics', 'Admitted', 'Please Visit College', '6445161', 'none', 20, 0),
(12, 404029, 'Hatim Tai', 'BCA', 'Pending', 'Please Visit College', '64116116', 'none', 22, 0),
(13, 404030, 'Altaf Sayyed', 'MCA', 'Pending', 'Please Visit College', '6445161', 'none', 20, 0),
(14, 404031, 'Bala Hatun', 'MCA', 'Pending', 'Please Visit College', '969668', 'NoSetup', 19, 0),
(15, 404032, 'Bala Hatun ', 'MCA', 'Pending', 'Please Visit College', '641164', 'NoSetup', 21, 0),
(16, 404033, 'Bill Gates', 'MCA', 'Pending', 'Please Visit College', '6009003', 'NoSetup', 63, 0),
(17, 404034, 'Sameer', 'MCA', 'Pending', 'Please Visit College', '2147483647', 'none', 18, 0),
(18, 404035, 'Sameer Bhai', 'Bsc, cs', 'Pending', 'Please Visit College', '641161169350', 'none', 20, 0),
(19, 404036, 'Sameer Najir Sayyed', 'MCA', 'Pending', 'Please Visit College', '641161169350', 'NoSetup', 18, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `admit`
--
ALTER TABLE `admit`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `admit`
--
ALTER TABLE `admit`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `forms`
--
ALTER TABLE `forms`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
