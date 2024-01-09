-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 09, 2024 at 11:59 AM
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
-- Database: `api_web_rest`
--

-- --------------------------------------------------------

--
-- Table structure for table `motivasi`
--

CREATE TABLE `motivasi` (
  `id` int(11) NOT NULL,
  `isi_motivasi` text NOT NULL,
  `iduser` int(11) NOT NULL,
  `tanggal_input` datetime NOT NULL,
  `tanggal_update` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `motivasi`
--

INSERT INTO `motivasi` (`id`, `isi_motivasi`, `iduser`, `tanggal_input`, `tanggal_update`) VALUES
(1, 'Lorem Ipsum', 1, '2024-01-09 11:32:51', '2024-01-09 11:32:51'),
(2, 'Dolor Sit Amet', 1, '2024-01-09 11:32:51', '2024-01-09 11:32:51');

-- --------------------------------------------------------

--
-- Table structure for table `profesi`
--

CREATE TABLE `profesi` (
  `profesi_id` int(11) NOT NULL,
  `profesi` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `profesi`
--

INSERT INTO `profesi` (`profesi_id`, `profesi`) VALUES
(1, 'Dosen'),
(2, 'Mahasiswa');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL,
  `role` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `role`) VALUES
(1, 'admin'),
(2, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `saran`
--

CREATE TABLE `saran` (
  `id` int(11) NOT NULL,
  `isi_saran` text NOT NULL,
  `iduser` int(11) NOT NULL,
  `tanggal_input` datetime NOT NULL,
  `tanggal_update` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `saran`
--

INSERT INTO `saran` (`id`, `isi_saran`, `iduser`, `tanggal_input`, `tanggal_update`) VALUES
(1, 'Lorem Ipsum', 1, '2024-01-09 11:42:16', '2024-01-09 11:42:16'),
(2, 'Dolor Sit Amet', 1, '2024-01-09 11:42:16', '2024-01-09 11:42:16');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `iduser` int(11) NOT NULL,
  `nama` varchar(128) NOT NULL,
  `id_profesi` int(11) NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `role_id` int(11) NOT NULL,
  `is_active` int(11) NOT NULL,
  `tanggal_input` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`iduser`, `nama`, `id_profesi`, `email`, `password`, `role_id`, `is_active`, `tanggal_input`, `modified`) VALUES
(111, 'Tes 2', 2, 'tes1@bsi.ac.id', 'tes', 1, 1, '2024-01-09 11:50:55', '2024-01-09 11:53:02'),
(123, 'Nicky Thiantnandra', 1, '12200961@bsi.ac.id', '1234', 1, 1, '2023-11-19 12:35:14', '2023-11-19 12:35:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `motivasi`
--
ALTER TABLE `motivasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `iduser` (`iduser`);

--
-- Indexes for table `profesi`
--
ALTER TABLE `profesi`
  ADD PRIMARY KEY (`profesi_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `saran`
--
ALTER TABLE `saran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`iduser`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `motivasi`
--
ALTER TABLE `motivasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `profesi`
--
ALTER TABLE `profesi`
  MODIFY `profesi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `saran`
--
ALTER TABLE `saran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
