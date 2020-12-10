-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 05, 2020 at 01:54 PM
-- Server version: 5.7.24
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `objet`
--

-- --------------------------------------------------------

--
-- Table structure for table `objet`
--

CREATE TABLE `objet` (
  `ID` int(11) NOT NULL,
  `Nom` text NOT NULL,
  `Latitude` float NOT NULL,
  `Longitude` float NOT NULL,
  `Zoom_min` int(11) NOT NULL,
  `Icone` text NOT NULL,
  `Type` text NOT NULL,
  `Indice` text NOT NULL,
  `Depart` tinyint(1) NOT NULL,
  `Lien` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `objet`
--

INSERT INTO `objet` (`ID`, `Nom`, `Latitude`, `Longitude`, `Zoom_min`, `Icone`, `Type`, `Indice`, `Depart`, `Lien`) VALUES
(1, 'Porte', 48.8574, 2.2935, 3, 'https://images.homedepot-static.com/productImages/4e35c76d-2d4c-456c-897c-eaf9b0690c02/svn/rustic-antique-distressed-finish-main-door-doors-without-glass-sh-904-ph-lh-64_1000.jpg', 'bloque_cadenas', 'Le code est caché dans un coffre qui touche le ciel de la France', 1, 0),
(2, 'Coffre', 45.8316, 6.8641, 13, 'http://atlas-content-cdn.pixelsquid.com/stock-images/old-wooden-chest-9GeqQG6-600.jpg', 'bloque_cle', 'La clé se trouve dans un des lieux touristiques les plus visités en France connu pour ces petits gâteaux.', 1, 4),
(3, 'Cle', 48.6364, -1.512, 12, 'http://www.pngall.com/wp-content/uploads/2016/03/Key-Transparent.png', 'recuperable', '', 1, NULL),
(4, 'Code : 6536', 45.835, 6.87, 11, 'https://previews.123rf.com/images/talithait/talithait1302/talithait130200036/17882324-parchemin-roul%C3%A9-avec-ruban.jpg', 'code', '', 0, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `objet`
--
ALTER TABLE `objet`
  ADD PRIMARY KEY (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
