-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2024 at 02:09 PM
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
-- Database: `pendaftaran`
--

-- --------------------------------------------------------

--
-- Table structure for table `pendaftar`
--

CREATE TABLE `pendaftar` (
  `id` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `jenis_kelamin` enum('laki-laki','perempuan') DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `asal_sekolah` varchar(50) DEFAULT NULL,
  `nisn` varchar(10) DEFAULT NULL,
  `nilai` double DEFAULT NULL,
  `nama_prodi` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pendaftar`
--

INSERT INTO `pendaftar` (`id`, `nama`, `email`, `no_hp`, `jenis_kelamin`, `tanggal_lahir`, `alamat`, `asal_sekolah`, `nisn`, `nilai`, `nama_prodi`) VALUES
(2, 'NamaPendaftar1', 'email1@example.com', '08123456789', 'laki-laki', '2000-01-01', 'Alamat Pendaftar 1', 'SMA Contoh 1', '1234567890', 87.5, 'Teknik Informatika'),
(3, 'NamaPendaftar2', 'email2@example.com', '0876543210', 'perempuan', '2001-02-02', 'Alamat Pendaftar 2', 'SMA Contoh 2', '0987654321', 78.9, 'Sistem Informasi'),
(4, 'NamaPendaftar3', 'email3@example.com', '08111223344', 'laki-laki', '1999-03-03', 'Alamat Pendaftar 3', 'SMA Contoh 3', '9876543210', 92.3, 'Desain Komunikasi Visual'),
(5, 'ucup', 'john.doe@example.com', '08123456789', 'laki-laki', '2000-01-01', 'Jalan Contoh No. 123', 'SMA Contoh 1', '1234567890', 87.5, 'Teknik Informatika'),
(6, 'Jane Doe', 'jane.doe@example.com', '0876543210', 'perempuan', '2001-02-02', 'Jalan Contoh No. 456', 'SMA Contoh 2', '0987654321', 78.9, 'Sistem Informasi'),
(7, 'Michael Smith', 'michael.smith@example.com', '08566778899', 'laki-laki', '1999-03-03', 'Jalan Contoh No. 789', 'SMA Contoh 3', '9876543210', 92.3, 'Desain Komunikasi Visual'),
(8, 'Emily Johnson', 'emily.johnson@example.com', '08111223344', 'perempuan', '2002-04-04', 'Jalan Contoh No. 1011', 'SMA Contoh 4', '8765432109', 79.8, 'Akuntansi'),
(9, 'David Lee', 'david.lee@example.com', '08123456789', 'laki-laki', '2003-05-05', 'Jalan Contoh No. 1213', 'SMA Contoh 5', '7654321098', 85.6, 'Manajemen'),
(10, 'budi', 'budi@gmail.com', '1234567890', 'perempuan', '2022-04-03', 'qertyuiolknbvcdrtyujnbvfrtyuiknbvftyuikmnbgyuikmnbgtyujbgy', 'SMA N 1 BikiniBotom', '99999', 95.5, 'Bahasa Inggris'),
(11, 'alexander supri', 'supriganteng@halu.com', '0987654321', 'laki-laki', '2000-02-11', 'uhjhgfdtyhbvgfty', 'SMA N 1 Isekai', '88888', 99, 'Sistem Informasi');

--
-- Triggers `pendaftar`
--
DELIMITER $$
CREATE TRIGGER `after_insert_pendaftar` AFTER INSERT ON `pendaftar` FOR EACH ROW BEGIN
    DECLARE v_status ENUM('diterima', 'ditolak');
    DECLARE v_nim VARCHAR(20);
    DECLARE v_kode VARCHAR(3);

    
    IF NEW.nilai >= 85 THEN
        SET v_status = 'diterima';
    ELSE
        SET v_status = 'ditolak';
    END IF;

    
    SELECT kode INTO v_kode FROM prodi WHERE nama_prodi = NEW.nama_prodi;

    
    INSERT INTO pendaftaran (nama, nilai, nama_prodi, status, nim)
    VALUES (NEW.nama, NEW.nilai, NEW.nama_prodi, v_status, NULL);

    
    IF v_status = 'diterima' THEN
        
        SET v_nim = CONCAT(v_kode, '.', YEAR(CURRENT_DATE), '.', LPAD((SELECT COUNT(*) + 1 FROM pendaftaran WHERE status = 'diterima'), 5, '0'));
        
        
        UPDATE pendaftaran SET nim = v_nim WHERE id = LAST_INSERT_ID();
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pendaftaran`
--

CREATE TABLE `pendaftaran` (
  `id` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `nilai` double DEFAULT NULL,
  `nama_prodi` varchar(50) DEFAULT NULL,
  `tanggal_pendaftaran` date DEFAULT curdate(),
  `status` enum('diterima','ditolak') DEFAULT NULL,
  `nim` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pendaftaran`
--

INSERT INTO `pendaftaran` (`id`, `nama`, `nilai`, `nama_prodi`, `tanggal_pendaftaran`, `status`, `nim`) VALUES
(1, 'NamaPendaftar1', 87.5, 'Teknik Informatika', '2024-07-09', 'diterima', 'A11.2024.00002'),
(2, 'NamaPendaftar2', 78.9, 'Sistem Informasi', '2024-07-09', 'ditolak', NULL),
(3, 'NamaPendaftar3', 92.3, 'Desain Komunikasi Visual', '2024-07-09', 'diterima', 'A14.2024.00003'),
(4, 'John Doe', 87.5, 'Teknik Informatika', '2024-07-09', 'diterima', 'A11.2024.00004'),
(5, 'Jane Doe', 78.9, 'Sistem Informasi', '2024-07-09', 'ditolak', NULL),
(6, 'Michael Smith', 92.3, 'Desain Komunikasi Visual', '2024-07-09', 'diterima', 'A14.2024.00005'),
(7, 'Emily Johnson', 79.8, 'Akuntansi', '2024-07-09', 'ditolak', NULL),
(8, 'David Lee', 85.6, 'Manajemen', '2024-07-09', 'diterima', 'B11.2024.00006'),
(9, 'budi', 95.5, 'Bahasa Inggris', '2024-07-09', 'diterima', 'C11.2024.00007'),
(10, 'alexander supri', 99, 'Sistem Informasi', '2024-07-09', 'diterima', 'A12.2024.00008');

-- --------------------------------------------------------

--
-- Table structure for table `prodi`
--

CREATE TABLE `prodi` (
  `nama_prodi` varchar(50) NOT NULL,
  `fakultas` varchar(50) DEFAULT NULL,
  `kode` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prodi`
--

INSERT INTO `prodi` (`nama_prodi`, `fakultas`, `kode`) VALUES
('Akuntansi', 'Fakultas Ekonomi dan Bisnis', 'B12'),
('Bahasa Inggris', 'Fakultas Ilmu Budaya', 'C11'),
('Desain Komunikasi Visual', 'Fakultas Ilmu Komputer', 'A14'),
('Manajemen', 'Fakultas Ekonomi dan Bisnis', 'B11'),
('Sastra Jepang', 'Fakultas Ilmu Budaya', 'C12'),
('Sistem Informasi', 'Fakultas Ilmu Komputer', 'A12'),
('Teknik Elektro', 'Fakultas Teknik', 'E11'),
('Teknik Industri', 'Fakultas Teknik', 'E12'),
('Teknik Informatika', 'Fakultas Ilmu Komputer', 'A11');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pendaftar`
--
ALTER TABLE `pendaftar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nama_prodi` (`nama_prodi`);

--
-- Indexes for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `prodi`
--
ALTER TABLE `prodi`
  ADD PRIMARY KEY (`nama_prodi`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pendaftar`
--
ALTER TABLE `pendaftar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pendaftar`
--
ALTER TABLE `pendaftar`
  ADD CONSTRAINT `pendaftar_ibfk_1` FOREIGN KEY (`nama_prodi`) REFERENCES `prodi` (`nama_prodi`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
