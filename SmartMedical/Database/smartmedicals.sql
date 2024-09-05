-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 23, 2024 at 07:58 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smartmedicals`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `aid` int(11) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password1` varchar(20) DEFAULT NULL,
  `date1` date DEFAULT NULL,
  `special` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`aid`, `username`, `password1`, `date1`, `special`) VALUES
(19201, 'darshan@7017', 'darshan@7017', '2024-07-04', 'Y'),
(39056, 'harsh@567', 'harsh@567', '2024-08-11', 'N'),
(86591, 'mahek@123', 'mahek@123', '2024-08-11', 'N'),
(93410, 'jeet@222', 'jeet@222', '2024-08-11', 'N');

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `bill_no` int(11) NOT NULL,
  `cusname` varchar(50) DEFAULT NULL,
  `dname` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `date1` varchar(30) NOT NULL,
  `contactno` varchar(10) DEFAULT NULL,
  `paymenttype` varchar(10) DEFAULT NULL,
  `aname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`bill_no`, `cusname`, `dname`, `address`, `date1`, `contactno`, `paymenttype`, `aname`) VALUES
(15910, 'Price Joshi', 'KINAL DAVE', 'BHAVNAGER', '11/08/2024', '1234567890', 'online', 'darshan@7017'),
(52556, 'rajan12 bhatt12', 'RAJESH SOLANKI', 'AHEMDABAD', '08/08/2024', '9427284780', 'online', 'tirth@234'),
(53536, 'harsh sonani', 'KINAL JOSHI', 'ARISTO BOYS PG, NEAR NIRMA UNIVERSITY', '08/08/2024', '9427284780', 'cheque', 'tirth@234'),
(55358, 'darshan sukhadiya', 'KINAL JOSHI', 'VRAJ VIHAR APARTMENT, SUBHASNAGER, BHAVNAGER', '08/08/2024', '9427284780', 'cash', 'tirth@234'),
(55844, 'Jayesh Solanki', 'RAJIV SINGH', 'AHEMADABAD', '12/08/2024', '7878787878', 'cash', 'darshan@7017'),
(100074, 'Jeet Kanada', 'DARSHAN SUKHADIYA', 'BHAVNAGER', '11/08/2024', '1234567890', 'cheque', 'darshan@7017');

-- --------------------------------------------------------

--
-- Table structure for table `bill_details`
--

CREATE TABLE `bill_details` (
  `bdid` int(11) NOT NULL,
  `bill_no` int(11) DEFAULT NULL,
  `mname` varchar(255) DEFAULT NULL,
  `co_name` varchar(100) DEFAULT NULL,
  `edate` varchar(30) DEFAULT NULL,
  `pack_size` varchar(10) DEFAULT NULL,
  `quantity` varchar(5) DEFAULT NULL,
  `price` varchar(30) DEFAULT NULL,
  `total_price` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bill_details`
--

INSERT INTO `bill_details` (`bdid`, `bill_no`, `mname`, `co_name`, `edate`, `pack_size`, `quantity`, `price`, `total_price`) VALUES
(22089, 55844, 'Ativan', ' Divi\'s Laboratories', '2024-08-14', '10', '120', '120.00', '14400.00'),
(26517, 52556, 'FaceWash', 'Lupin', '2024-08-31', '1', '100', '140.00', '14000.00'),
(28094, 53536, 'FaceWash', 'Lupin', '2024-08-31', '1', '200', '140.00', '28000.00'),
(37205, 15910, 'FaceWash', 'Lupin', '2024-08-08', '1', '290', '220.00', '63800.00'),
(50213, 55844, 'FaceWash', 'Lupin', '2024-08-31', '1', '190', '220.00', '41800.00'),
(57176, 55358, 'FaceWash', 'Lupin', '2024-08-31', '1', '100', '140.00', '14000.00'),
(68025, 100074, 'FaceWash', 'Lupin', '2024-08-31', '1', '200', '220.00', '44000.00');

-- --------------------------------------------------------

--
-- Table structure for table `bill_total_details`
--

CREATE TABLE `bill_total_details` (
  `btd` int(11) NOT NULL,
  `bill_no` int(11) DEFAULT NULL,
  `total` bigint(20) DEFAULT NULL,
  `discount` decimal(10,3) DEFAULT NULL,
  `afterdtotal` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bill_total_details`
--

INSERT INTO `bill_total_details` (`btd`, `bill_no`, `total`, `discount`, `afterdtotal`) VALUES
(19283, 55358, 14000, 0.100, 13986),
(27105, 52556, 14000, 0.000, 14000),
(31476, 15910, 63800, 0.000, 63800),
(36759, 55844, 56200, 1.000, 55638),
(68898, 100074, 44000, 1.000, 43560),
(86060, 53536, 28000, 0.000, 28000);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `cat_id` int(11) NOT NULL,
  `cat_name` varchar(30) DEFAULT NULL,
  `added_date` date NOT NULL,
  `update_date` date NOT NULL,
  `co_id` int(11) NOT NULL,
  `aname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`cat_id`, `cat_name`, `added_date`, `update_date`, `co_id`, `aname`) VALUES
(68813, 'SkinCare', '2024-08-08', '2024-08-08', 43972, 'tirth@234'),
(105256, 'SkinCare', '2024-08-11', '2024-08-11', 42014, 'darshan@7017');

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `co_id` int(11) NOT NULL,
  `co_name` varchar(100) NOT NULL,
  `co_batchno` varchar(30) DEFAULT NULL,
  `co_phoneno` varchar(12) DEFAULT NULL,
  `co_email` varchar(50) DEFAULT NULL,
  `added_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `aname` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`co_id`, `co_name`, `co_batchno`, `co_phoneno`, `co_email`, `added_date`, `update_date`, `aname`) VALUES
(42014, ' Divi\'s Laboratories', 'ADCBR89', '9999999999', 'DV@gmail.com', '2024-08-11', '2024-08-11', 'jeet@222'),
(43972, 'Lupin', '78492B', '1234567890', 'lupin@gmail.com', '2024-08-08', '2024-08-08', 'tirth@234');

-- --------------------------------------------------------

--
-- Table structure for table `medicine`
--

CREATE TABLE `medicine` (
  `mid` int(11) NOT NULL,
  `mname` varchar(255) NOT NULL,
  `packsize` bigint(20) NOT NULL,
  `totalpack` bigint(20) NOT NULL,
  `priceperpack` decimal(10,2) NOT NULL,
  `selling_price` decimal(10,2) DEFAULT NULL,
  `discount` decimal(10,2) NOT NULL,
  `priceperqty` decimal(10,2) NOT NULL,
  `discountinrs` decimal(10,2) DEFAULT NULL,
  `totalprice` decimal(10,2) NOT NULL,
  `edate` date DEFAULT NULL,
  `added_date` date DEFAULT NULL,
  `cat_id` int(11) NOT NULL,
  `aname` varchar(20) NOT NULL,
  `maxqty` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medicine`
--

INSERT INTO `medicine` (`mid`, `mname`, `packsize`, `totalpack`, `priceperpack`, `selling_price`, `discount`, `priceperqty`, `discountinrs`, `totalprice`, `edate`, `added_date`, `cat_id`, `aname`, `maxqty`) VALUES
(19982, 'FaceWash', 1, 10, 130.00, 220.00, 0.00, 130.00, 0.00, 130000.00, '2024-08-31', '2024-08-11', 68813, 'darshan@7017', 30),
(98499, 'Ativan', 10, 1080, 100.00, 120.00, 0.00, 12.00, 0.00, 14400.00, '2024-08-14', '2024-08-12', 105256, 'darshan@7017', 30);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`aid`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`bill_no`);

--
-- Indexes for table `bill_details`
--
ALTER TABLE `bill_details`
  ADD PRIMARY KEY (`bdid`);

--
-- Indexes for table `bill_total_details`
--
ALTER TABLE `bill_total_details`
  ADD PRIMARY KEY (`btd`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`cat_id`);
ALTER TABLE `category` ADD FULLTEXT KEY `cat_name` (`cat_name`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`co_id`),
  ADD UNIQUE KEY `co_name` (`co_name`),
  ADD UNIQUE KEY `co_name_unique` (`co_name`),
  ADD UNIQUE KEY `co_batchno` (`co_batchno`),
  ADD UNIQUE KEY `co_batchno_unique` (`co_batchno`);

--
-- Indexes for table `medicine`
--
ALTER TABLE `medicine`
  ADD PRIMARY KEY (`mid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
