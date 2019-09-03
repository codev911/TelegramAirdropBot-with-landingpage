-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 09 Mar 2019 pada 15.21
-- Versi server: 5.7.25-log
-- Versi PHP: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `levyteco_airdropbot`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `activation`
--

CREATE TABLE `activation` (
  `reff_id` varchar(8) NOT NULL,
  `timestamp_active` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `telegram_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Trigger `activation`
--
DELIMITER $$
CREATE TRIGGER `earned action` AFTER INSERT ON `activation` FOR EACH ROW BEGIN
	DECLARE datareff VARCHAR(8);
    
	SELECT reffered_by FROM user WHERE reff_id=NEW.reff_id INTO datareff;
    
    IF(datareff != 'SYSTEM') THEN
    	UPDATE user SET earned=earned+2222 WHERE reff_id=datareff;
        UPDATE user SET earned=earned+22222, activated='yes' WHERE reff_id=NEW.reff_id;
    ELSE
        UPDATE user SET earned=earned+22222, activated='yes' WHERE reff_id=NEW.reff_id;
    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `reff_id` varchar(8) NOT NULL,
  `erc20` varchar(42) NOT NULL,
  `ip_reg` text NOT NULL,
  `unique_browser` varchar(25) NOT NULL,
  `timestamp_reg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `earned` int(11) NOT NULL,
  `reffered_by` varchar(8) NOT NULL,
  `activated` enum('no','yes') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `activation`
--
ALTER TABLE `activation`
  ADD PRIMARY KEY (`reff_id`),
  ADD UNIQUE KEY `telegram_id` (`telegram_id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`reff_id`),
  ADD UNIQUE KEY `erc20` (`erc20`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `activation`
--
ALTER TABLE `activation`
  ADD CONSTRAINT `activation_ibfk_1` FOREIGN KEY (`reff_id`) REFERENCES `user` (`reff_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
