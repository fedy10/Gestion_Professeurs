-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 08, 2023 at 10:10 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gestion_des_autorisations_des_enseignants`
--

-- --------------------------------------------------------

--
-- Table structure for table `administration`
--

CREATE TABLE `administration` (
  `id_Admin` int NOT NULL,
  `login` varchar(30) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `administration`
--

INSERT INTO `administration` (`id_Admin`, `login`, `password`) VALUES
(1, 'admin@iit.ens.tn', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `autorisation`
--

CREATE TABLE `autorisation` (
  `id_Autorisation` int NOT NULL,
  `id_professeur` int NOT NULL,
  `date_début` date NOT NULL,
  `date_fin` date NOT NULL,
  `nbheuredecontra` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `professeurs`
--

CREATE TABLE `professeurs` (
  `id_professeur` int NOT NULL,
  `nom` varchar(255) NOT NULL,
  `sex` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `date_ins` date NOT NULL,
  `nbheure_restant` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `professeurs`
--

INSERT INTO `professeurs` (`id_professeur`, `nom`, `sex`, `date_ins`, `nbheure_restant`) VALUES
(30, 'Fedy Ben Slime', 'Homme', '2023-07-02', 0),
(52, 'said taktak', 'Homme', '2023-09-20', 208),
(53, 'Med Amine ', 'Homme', '2023-12-20', 0),
(55, 'Kamoucha belgacem', 'Homme', '2023-07-03', 0),
(57, 'slah bahri', 'Homme', '2023-09-20', 208),
(58, 'taoufik ', 'Homme', '2023-10-11', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administration`
--
ALTER TABLE `administration`
  ADD PRIMARY KEY (`id_Admin`);

--
-- Indexes for table `autorisation`
--
ALTER TABLE `autorisation`
  ADD PRIMARY KEY (`id_Autorisation`),
  ADD KEY `fk_autorisation_professeurs` (`id_professeur`);

--
-- Indexes for table `professeurs`
--
ALTER TABLE `professeurs`
  ADD PRIMARY KEY (`id_professeur`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administration`
--
ALTER TABLE `administration`
  MODIFY `id_Admin` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `autorisation`
--
ALTER TABLE `autorisation`
  MODIFY `id_Autorisation` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `professeurs`
--
ALTER TABLE `professeurs`
  MODIFY `id_professeur` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `autorisation`
--
ALTER TABLE `autorisation`
  ADD CONSTRAINT `fk_autorisation_professeurs` FOREIGN KEY (`id_professeur`) REFERENCES `professeurs` (`id_professeur`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
