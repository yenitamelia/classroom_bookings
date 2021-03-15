-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 15, 2021 at 02:18 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ppl`
--

-- --------------------------------------------------------

--
-- Table structure for table `academicyears`
--

CREATE TABLE `academicyears` (
  `date_start` date NOT NULL,
  `date_end` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `academicyears`
--

INSERT INTO `academicyears` (`date_start`, `date_end`) VALUES
('2021-03-10', '2022-03-10');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(6) UNSIGNED NOT NULL,
  `period_id` int(6) UNSIGNED NOT NULL,
  `week_id` int(6) UNSIGNED DEFAULT NULL,
  `day_num` tinyint(1) UNSIGNED DEFAULT NULL,
  `room_id` int(6) UNSIGNED NOT NULL,
  `user_id` int(6) UNSIGNED DEFAULT NULL,
  `date` date DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `cancelled` tinyint(1) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `period_id`, `week_id`, `day_num`, `room_id`, `user_id`, `date`, `notes`, `cancelled`) VALUES
(1, 1, 1, 1, 1, 2, '2021-03-03', NULL, 0),
(2, 3, NULL, NULL, 5, 1, '2021-03-10', 'APG', 0),
(3, 4, NULL, NULL, 5, 1, '2021-03-10', 'Metnum', 0),
(4, 1, NULL, NULL, 5, 1, '2021-03-16', 'KDJ', 0),
(5, 1, NULL, NULL, 1, 7, '2021-03-16', 'PPL', 0),
(6, 1, NULL, NULL, 5, 7, '2021-03-11', 'IMK', 0),
(7, 3, NULL, NULL, 2, 7, '2021-02-19', 'DMKM', 0),
(10, 1, NULL, NULL, 5, 7, '2021-03-09', 'KDJ', 0);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `department_id` int(6) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`department_id`, `name`, `description`, `icon`) VALUES
(1, 'Statistika', NULL, NULL),
(2, 'Komputasi Statistik', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `holiday_id` int(6) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `lang`
--

CREATE TABLE `lang` (
  `id` int(6) UNSIGNED NOT NULL,
  `language` varchar(255) NOT NULL DEFAULT 'english',
  `set` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `version` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`version`) VALUES
(20200911171900);

-- --------------------------------------------------------

--
-- Table structure for table `periods`
--

CREATE TABLE `periods` (
  `period_id` int(6) UNSIGNED NOT NULL,
  `time_start` time NOT NULL,
  `time_end` time NOT NULL,
  `name` varchar(30) NOT NULL,
  `days` int(2) UNSIGNED NOT NULL,
  `bookable` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `day_1` tinyint(1) UNSIGNED DEFAULT 0,
  `day_2` tinyint(1) UNSIGNED DEFAULT 0,
  `day_3` tinyint(1) UNSIGNED DEFAULT 0,
  `day_4` tinyint(1) UNSIGNED DEFAULT 0,
  `day_5` tinyint(1) UNSIGNED DEFAULT 0,
  `day_6` tinyint(1) UNSIGNED DEFAULT 0,
  `day_7` tinyint(1) UNSIGNED DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `periods`
--

INSERT INTO `periods` (`period_id`, `time_start`, `time_end`, `name`, `days`, `bookable`, `day_1`, `day_2`, `day_3`, `day_4`, `day_5`, `day_6`, `day_7`) VALUES
(1, '07:30:00', '10:00:00', 'Sesi 1', 0, 1, 1, 1, 1, 1, 1, 0, 0),
(2, '13:30:00', '16:00:00', 'Sesi 3', 0, 1, 1, 1, 1, 1, 1, 0, 0),
(3, '10:15:00', '12:45:00', 'Sesi 2', 0, 1, 1, 1, 1, 1, 1, 0, 0),
(4, '16:15:00', '18:45:00', 'Sesi 4', 0, 1, 1, 1, 1, 1, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `roomfields`
--

CREATE TABLE `roomfields` (
  `field_id` int(6) UNSIGNED NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `roomoptions`
--

CREATE TABLE `roomoptions` (
  `option_id` int(6) UNSIGNED NOT NULL,
  `field_id` int(6) UNSIGNED NOT NULL,
  `value` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `room_id` int(6) UNSIGNED NOT NULL,
  `user_id` int(6) UNSIGNED DEFAULT NULL,
  `name` varchar(20) NOT NULL,
  `location` varchar(40) DEFAULT NULL,
  `bookable` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `icon` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_id`, `user_id`, `name`, `location`, `bookable`, `icon`, `notes`, `photo`) VALUES
(1, NULL, '251', 'Gedung 2', 1, NULL, NULL, NULL),
(2, NULL, '341', 'Gedung 3', 1, NULL, NULL, NULL),
(3, NULL, '252', 'Gedung 2', 1, NULL, NULL, NULL),
(4, NULL, '342', 'Gedung 3', 1, NULL, NULL, NULL),
(5, 0, '241', 'Gedung 2', 1, NULL, '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roomvalues`
--

CREATE TABLE `roomvalues` (
  `value_id` int(6) UNSIGNED NOT NULL,
  `room_id` int(6) UNSIGNED NOT NULL,
  `field_id` int(6) UNSIGNED NOT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `group` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`group`, `name`, `value`) VALUES
('crbs', 'bia', '0'),
('crbs', 'bookings_show_user_recurring', '1'),
('crbs', 'bookings_show_user_single', '1'),
('crbs', 'colour', '468ED8'),
('crbs', 'date_format_long', 'l jS F Y'),
('crbs', 'date_format_weekday', 'jS M'),
('crbs', 'displaytype', 'day'),
('crbs', 'd_columns', 'periods'),
('crbs', 'login_message_enabled', '0'),
('crbs', 'login_message_text', ''),
('crbs', 'logo', ''),
('crbs', 'name', 'STIS'),
('crbs', 'num_max_bookings', '0'),
('crbs', 'time_format_period', 'g:i'),
('crbs', 'website', '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(6) UNSIGNED NOT NULL,
  `department_id` int(6) UNSIGNED DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `authlevel` tinyint(1) UNSIGNED NOT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  `ext` varchar(255) DEFAULT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `enabled` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `created` datetime DEFAULT NULL,
  `foto` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `department_id`, `username`, `firstname`, `lastname`, `email`, `password`, `authlevel`, `displayname`, `ext`, `lastlogin`, `enabled`, `created`, `foto`) VALUES
(1, NULL, 'admin', 'Ruth', 'Madeline', 'ruth@stis.ac.id', '$2y$10$7Kk1s0CwiQUWksbksh7No.5M0uvmFUxGLmB02PKERzlFV2vvuOjDm', 1, '', '', '2021-03-13 09:09:03', 1, NULL, 'logo.png'),
(2, 1, 'ulya', 'Ulya', 'Adiwena', 'ulya@stis.ac.id', '$2y$10$LjQKM204XLkgAQTQv/DBHOl3ks8xi8vFnlP6ZzSukFZW0OOo0pRU.', 0, 'ulyaadiwena', '', NULL, 1, NULL, ''),
(3, 2, 'yenita', 'Yenita', 'Amelia', 'yenita@stis.ac.id', '$2y$10$rGjUxkUMx5UTKgQKVKz3oOaid1TJNVfPwBWiYrMePzn2gBhvlYmbm', 0, 'yenitaamelia', '', '2021-03-10 07:03:01', 1, NULL, ''),
(7, 2, 'Ruth', 'Ruth', 'Madeline', '221810589@stis.ac.id', '$2y$10$I3rf6dAbhWocbbsljGA8WeCDRJT.feqWTdxeNwOCPzVyT.qtWMZ9.', 2, '', '', '2021-03-15 01:38:54', 1, NULL, 'IMG_82171.JPG');

-- --------------------------------------------------------

--
-- Table structure for table `weekdates`
--

CREATE TABLE `weekdates` (
  `week_id` int(6) UNSIGNED NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `weekdates`
--

INSERT INTO `weekdates` (`week_id`, `date`) VALUES
(2, '2021-03-08'),
(2, '2021-03-15'),
(2, '2021-03-22'),
(2, '2021-03-29'),
(2, '2021-04-05'),
(2, '2021-04-12'),
(2, '2021-04-19');

-- --------------------------------------------------------

--
-- Table structure for table `weeks`
--

CREATE TABLE `weeks` (
  `week_id` int(6) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `fgcol` char(6) DEFAULT NULL,
  `bgcol` char(6) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `weeks`
--

INSERT INTO `weeks` (`week_id`, `name`, `fgcol`, `bgcol`, `icon`) VALUES
(1, 'week1', NULL, NULL, NULL),
(2, 'week2', 'FFFFFF', '666666', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `period_id_room_id_user_id` (`period_id`,`room_id`,`user_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`department_id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`holiday_id`);

--
-- Indexes for table `lang`
--
ALTER TABLE `lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `language_set` (`language`,`set`);

--
-- Indexes for table `periods`
--
ALTER TABLE `periods`
  ADD PRIMARY KEY (`period_id`);

--
-- Indexes for table `roomfields`
--
ALTER TABLE `roomfields`
  ADD PRIMARY KEY (`field_id`);

--
-- Indexes for table `roomoptions`
--
ALTER TABLE `roomoptions`
  ADD PRIMARY KEY (`option_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `roomvalues`
--
ALTER TABLE `roomvalues`
  ADD PRIMARY KEY (`value_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD UNIQUE KEY `group_name` (`group`,`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `authlevel` (`authlevel`),
  ADD KEY `enabled` (`enabled`);

--
-- Indexes for table `weekdates`
--
ALTER TABLE `weekdates`
  ADD KEY `week_id` (`week_id`);

--
-- Indexes for table `weeks`
--
ALTER TABLE `weeks`
  ADD PRIMARY KEY (`week_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `department_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `holiday_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lang`
--
ALTER TABLE `lang`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `periods`
--
ALTER TABLE `periods`
  MODIFY `period_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `roomfields`
--
ALTER TABLE `roomfields`
  MODIFY `field_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roomoptions`
--
ALTER TABLE `roomoptions`
  MODIFY `option_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `roomvalues`
--
ALTER TABLE `roomvalues`
  MODIFY `value_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `weeks`
--
ALTER TABLE `weeks`
  MODIFY `week_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
