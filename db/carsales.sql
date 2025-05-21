-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 20, 2024 at 06:20 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `carsales`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_user`
--

CREATE TABLE `app_user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `user_role` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_user`
--

INSERT INTO `app_user` (`id`, `username`, `email`, `password`, `user_role`) VALUES
(1, 'shiehrou', 'tp056135@mail.apu.edu.my', 'demo', 'managing'),
(2, 'ivy', 'ivy@gmail.com', 'demo', 'customer'),
(3, 'amy', 'amy@gmail.com', 'demo', 'salesman'),
(4, 'jack', 'jackgoh@gmail.com', 'demo', 'customer'),
(5, 'emily', 'emily@gmail.com', 'demo', 'customer'),
(6, 'jane', 'janelim@gmail.com', 'demo', 'customer'),
(7, 'sinyin', 'sinyin@gmail.com', 'demo', 'customer'),
(8, 'han', 'shaohan@gmail.com', 'demo', 'customer'),
(9, 'chamby', 'chamby@gmail.com', 'demo', 'customer'),
(10, 'kelly', 'kelly@gmail.com', 'demo', 'customer'),
(11, 'meilin', 'meilin@gmail.com', 'demo', 'customer'),
(12, 'jimmy', 'jimmy@gmail.com', 'demo', 'customer'),
(13, 'ryan', 'ryanloh@gmail.com', 'demo', 'customer'),
(16, 'zhenyang', 'zhenyang@gmail.com', 'demo', 'customer'),
(17, 'angela', 'angela@gmail.com', 'demo', 'customer'),
(18, 'emma', 'emma@gmail.com', 'demo', 'salesman');

-- --------------------------------------------------------

--
-- Table structure for table `car`
--

CREATE TABLE `car` (
  `id` int(11) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `year` int(4) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `mileage` int(11) NOT NULL,
  `color` varchar(20) NOT NULL,
  `fuel_type` varchar(50) NOT NULL,
  `transmission` varchar(50) NOT NULL,
  `engine_capacity` decimal(4,1) NOT NULL,
  `img_path` varchar(200) DEFAULT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `car`
--

INSERT INTO `car` (`id`, `brand`, `model`, `year`, `price`, `mileage`, `color`, `fuel_type`, `transmission`, `engine_capacity`, `img_path`, `status`) VALUES
(5, 'Toyota', 'Camry', 2023, 200000.00, 7800, 'Grey', 'Petrol', 'Automatic', 2.5, 'images\\Toyota_Camry.jpg', 'Paid'),
(6, 'Honda', 'HR-V', 2021, 88000.00, 8750, 'White', 'Petrol', 'Automatic', 1.8, 'images\\Honda_HR-V.jpg', 'Paid'),
(7, 'BMW', 'X1', 2021, 280000.00, 9000, 'White', 'Petrol', 'Automatic', 2.0, 'images\\BMW_X1.webp', 'Paid'),
(8, 'Honda', 'City', 2023, 75000.00, 10800, 'Red', 'Petrol', 'Automatic', 1.5, 'images\\Honda_City_20240914_225211.jpg', 'Paid'),
(9, 'Toyota', 'Camry', 2010, 32000.00, 98000, 'White', 'Petrol', 'Automatic', 2.0, 'images\\Toyota_Camry_20240916_165102.jpg', 'Booked'),
(10, 'Toyota', 'Camry', 2010, 30500.00, 99990, 'Silver', 'Petrol', 'Automatic', 1.8, 'images\\Toyota_Camry_20240916_233355.jpg', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `car_brand`
--

CREATE TABLE `car_brand` (
  `id` int(11) NOT NULL,
  `brand_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `car_brand`
--

INSERT INTO `car_brand` (`id`, `brand_name`) VALUES
(1, 'Toyota'),
(2, 'Honda'),
(3, 'BMW'),
(4, 'Audi');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `gender` char(1) NOT NULL,
  `dob` date NOT NULL,
  `street` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `zip_code` varchar(10) NOT NULL,
  `country` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `customer_name`, `username`, `email`, `phone`, `gender`, `dob`, `street`, `city`, `state`, `zip_code`, `country`) VALUES
(1, 'Ivy Lim Hui Yi', 'ivy', 'ivy@gmail.com', '0125679090', 'F', '1985-09-03', '123, Lorong Cheras', 'Cheras', 'KL', '50450', 'Malaysia'),
(2, 'Jane Lim', 'jane', 'janelim@gmail.com', '0128980099', 'F', '1980-11-09', '32, Jalan Bunga', 'Ampang', 'KL', '50200', 'Malaysia'),
(3, 'Jack Goh', 'jack', 'jackgoh@gmail.com', '0189892332', 'M', '1992-06-04', '66, Lorong Gamelan 1', 'Nibong Tebal', 'Penang', '15000', 'Malaysia'),
(4, 'Emily Lim', 'emily', 'emily@gmail.com', '0198782644', 'F', '1991-02-06', '22, Jalan ABC 1', 'Cheras', 'Wilayah Persekutuan', '50450', 'Malaysia');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `sales_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `feedback` longtext DEFAULT NULL,
  `rating` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `sales_id`, `customer_id`, `feedback`, `rating`) VALUES
(1, 1, 1, 'The car condition is good', 5),
(2, 3, 2, '', 4);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `sales_id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `balance` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_date` date NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`id`, `sales_id`, `price`, `amount_paid`, `balance`, `payment_method`, `payment_date`, `status`) VALUES
(1, 3, 200000.00, 200000.00, 0.00, 'Credit Card', '2024-09-15', 'Paid'),
(2, 1, 88000.00, 89000.00, 1000.00, 'Cash', '2024-09-15', 'Paid'),
(3, 4, 280000.00, 280000.00, 0.00, 'Credit Card', '2024-09-19', 'Paid'),
(4, 5, 75000.00, 75000.00, 0.00, 'Credit Card', '2024-09-20', 'Paid');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `car_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `sales_date` date NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `comment` longtext DEFAULT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `car_id`, `customer_id`, `staff_id`, `sales_date`, `price`, `comment`, `status`) VALUES
(1, 6, 1, 9, '2024-09-15', 88000.00, 'Sale went through without issues. Customer might return for accessories.', 'Completed'),
(3, 5, 2, 9, '2024-09-15', 200000.00, NULL, 'Completed'),
(4, 7, 3, 9, '2024-09-15', 280000.00, NULL, 'Completed'),
(5, 8, 1, 9, '2024-09-16', 75000.00, NULL, 'Completed'),
(6, 9, 4, 9, '2024-09-20', 32000.00, NULL, 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` int(11) NOT NULL,
  `role` varchar(20) NOT NULL,
  `staff_name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `gender` char(1) NOT NULL,
  `dob` date NOT NULL,
  `street` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `zip_code` varchar(10) NOT NULL,
  `country` varchar(50) NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `hired_date` date NOT NULL,
  `terminated_date` date DEFAULT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `role`, `staff_name`, `username`, `email`, `phone`, `gender`, `dob`, `street`, `city`, `state`, `zip_code`, `country`, `salary`, `hired_date`, `terminated_date`, `status`) VALUES
(1, 'managing', 'Shieh Rou Goh', 'shiehrou', 'tp056135@mail.apu.edu.my', '0125628800', 'F', '2001-09-04', '8, Lorong Valdor 31, Kampung Valdor', 'Sungai Jawi', 'Pulau Pinang', '14000', 'Malaysia', 12000.00, '2024-09-12', NULL, 'Active'),
(9, 'salesman', 'Amy Wong', 'amy', 'amy@gmail.com', '0127638928', 'F', '1989-07-15', '123, Jalan 123', 'Setapak', 'KL', '50000', 'Malaysia', 7000.00, '2024-09-13', NULL, 'Active'),
(10, 'salesman', 'Emma Williams', 'emma', 'emma@gmail.com', '0198728900', 'F', '1881-09-03', 'No. 12, Jalan Ampang', 'Kuala Lumpur', 'Wilayah Persekutuan', '50450', 'Malaysia', 15000.00, '2024-09-15', NULL, 'Active');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_user`
--
ALTER TABLE `app_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `car_brand`
--
ALTER TABLE `car_brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `app_user`
--
ALTER TABLE `app_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `car`
--
ALTER TABLE `car`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `car_brand`
--
ALTER TABLE `car_brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
