-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 29 Nov 2022 pada 16.19
-- Versi server: 10.4.17-MariaDB
-- Versi PHP: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pelatihan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `absensi`
--

CREATE TABLE `absensi` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) COLLATE utf8_bin NOT NULL,
  `kelas` varchar(55) COLLATE utf8_bin NOT NULL,
  `pertemuan` varchar(25) COLLATE utf8_bin NOT NULL,
  `kehadiran` varchar(15) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data untuk tabel `absensi`
--

INSERT INTO `absensi` (`id`, `nama`, `kelas`, `pertemuan`, `kehadiran`) VALUES
(1, 'ADINDA OKTAVIA RAHMA', 'X AKL 1', 'Pertemuan-1', 'Hadir'),
(2, 'ALDI SAPUTRA', 'X AKL 2', 'Pertemuan-1', 'Hadir'),
(3, 'ANANDA ADELITA IZATI', 'X AKL 3', 'Pertemuan-1', 'Hadir'),
(4, 'ADINDA OKTAVIA RAHMA', 'X AKL 1', 'Pertemuan-2', 'Hadir'),
(5, 'ALDI SAPUTRA', 'X AKL 2', 'Pertemuan-2', 'Hadir'),
(6, 'ANANDA ADELITA IZATI', 'X AKL 3', 'Pertemuan-2', 'Tidak Hadir'),
(7, 'ADINDA OKTAVIA RAHMA', 'X AKL 1', 'Pertemuan-3', 'Hadir'),
(8, 'ALDI SAPUTRA', 'X AKL 2', 'Pertemuan-3', 'Tidak Hadir'),
(9, 'ANANDA ADELITA IZATI', 'X AKL 3', 'Pertemuan-3', 'Hadir');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dummy`
--

CREATE TABLE `dummy` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) COLLATE utf8_bin NOT NULL,
  `kelas` varchar(55) COLLATE utf8_bin NOT NULL,
  `pertemuan` varchar(25) COLLATE utf8_bin NOT NULL,
  `kehadiran` varchar(15) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data untuk tabel `dummy`
--

INSERT INTO `dummy` (`id`, `nama`, `kelas`, `pertemuan`, `kehadiran`) VALUES
(1, 'ADINDA OKTAVIA RAHMA', 'X AKL 1', '', ''),
(2, 'ALDI SAPUTRA', 'X AKL 2', '', ''),
(3, 'ANANDA ADELITA IZATI', 'X AKL 3', '', ''),
(4, 'ABBIHA MAULIDINA ZULVA', 'X MM 1', '', ''),
(5, 'AHMAT PARIHIN', 'X MM 2', '', ''),
(6, 'ALIF HUSNI MUBAROK', 'X MM 3', '', ''),
(7, 'AFNI MEI SUROH', 'X PS 1', '', ''),
(8, 'ADITIYA MUHSININ', 'X PS 2', '', ''),
(9, 'ABDUL ROJAK', 'X TBSM 1', '', ''),
(10, 'ABY RIZKI HIDAYATULLOH', 'X TBSM 2', '', ''),
(11, 'ACHMAD CHOERUL AZMI', 'X TBSM 3', '', ''),
(12, 'AAS KHUSAEISA', 'X TKJ 1', '', ''),
(13, 'AFRILIANA DWI OFTAVIANI', 'X TKJ 2', '', ''),
(14, 'ANDREA MILANO', 'X TKJ 3', '', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pertemuan`
--

CREATE TABLE `pertemuan` (
  `id` int(11) NOT NULL,
  `pertemuan` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pertemuan`
--

INSERT INTO `pertemuan` (`id`, `pertemuan`) VALUES
(1, 'Pertemuan-1'),
(2, 'Pertemuan-2'),
(3, 'Pertemuan-3'),
(4, 'Pertemuan-4'),
(5, 'Pertemuan-5'),
(6, 'Pertemuan-6'),
(7, 'Pertemuan-7'),
(8, 'Pertemuan-8'),
(9, 'Pertemuan-9'),
(10, 'Pertemuan-10'),
(11, 'Pertemuan-11'),
(12, 'Pertemuan-12'),
(13, 'Pertemuan-13'),
(14, 'Pertemuan-14');

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswa`
--

CREATE TABLE `siswa` (
  `id` int(11) NOT NULL,
  `nisn` varchar(10) COLLATE utf8_bin NOT NULL,
  `password` varchar(55) COLLATE utf8_bin NOT NULL,
  `nipd` varchar(10) COLLATE utf8_bin NOT NULL,
  `nama` varchar(255) COLLATE utf8_bin NOT NULL,
  `jk` varchar(1) COLLATE utf8_bin NOT NULL,
  `kelas` varchar(55) COLLATE utf8_bin NOT NULL,
  `jurusan` varchar(25) COLLATE utf8_bin NOT NULL,
  `no_hp` varchar(13) COLLATE utf8_bin NOT NULL,
  `email` varchar(255) COLLATE utf8_bin NOT NULL,
  `alamat` varchar(255) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data untuk tabel `siswa`
--

INSERT INTO `siswa` (`id`, `nisn`, `password`, `nipd`, `nama`, `jk`, `kelas`, `jurusan`, `no_hp`, `email`, `alamat`) VALUES
(1, '0062484294', '31d1e5ca6396d9360c97616656a5dd93', '2115192', 'ADINDA OKTAVIA RAHMA', 'P', 'X AKL 1', '', '', '', ''),
(2, '0056906892', '0056906892', '2115234', 'ALDI SAPUTRA', 'L', 'X AKL 2', '', '', '', ''),
(3, '0068937617', '0068937617', '2115276', 'ANANDA ADELITA IZATI', 'P', 'X AKL 3', '', '', '', ''),
(4, '0065278582', '0065278582', '2114983', 'ABBIHA MAULIDINA ZULVA', 'L', 'X MM 1', '', '', '', ''),
(5, '0054743358', '0054743358', '2115025', 'AHMAT PARIHIN', 'L', 'X MM 2', '', '', '', ''),
(6, '3067844195', '3067844195', '2115066', 'ALIF HUSNI MUBAROK', 'L', 'X MM 3', '', '', '', ''),
(7, '0068498839', '0068498839', '2115109', 'AFNI MEI SUROH', 'P', 'X PS 1', '', '', '', ''),
(8, '0062066120', '0062066120', '2115150', 'ADITIYA MUHSININ', 'L', 'X PS 2', '', '', '', ''),
(9, '0065686851', '0065686851', '2115317', 'ABDUL ROJAK', 'L', 'X TBSM 1', '', '', '', ''),
(10, '0062573361', '0062573361', '2115359', 'ABY RIZKI HIDAYATULLOH', 'L', 'X TBSM 2', '', '', '', ''),
(11, '0065983574', '0065983574', '2115401', 'ACHMAD CHOERUL AZMI', 'L', 'X TBSM 3', '', '', '', ''),
(12, '0067301349', '0067301349', '2114857', 'AAS KHUSAEISA', 'P', 'X TKJ 1', '', '', '', ''),
(13, '0067646460', '0067646460', '2114905', 'AFRILIANA DWI OFTAVIANI', 'P', 'X TKJ 2', '', '', '', ''),
(14, '0057963389', '0057963389', '2114941', 'ANDREA MILANO', 'L', 'X TKJ 3', '', '', '', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(11) NOT NULL,
  `username` varchar(255) COLLATE utf8_bin NOT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  `level` enum('admin','member') COLLATE utf8_bin NOT NULL,
  `nip` varchar(18) COLLATE utf8_bin NOT NULL,
  `nama` varchar(55) COLLATE utf8_bin NOT NULL,
  `jk` varchar(1) COLLATE utf8_bin NOT NULL,
  `alamat` varchar(255) COLLATE utf8_bin NOT NULL,
  `no_hp` varchar(13) COLLATE utf8_bin NOT NULL,
  `email` varchar(55) COLLATE utf8_bin NOT NULL,
  `keahlian` varchar(55) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `level`, `nip`, `nama`, `jk`, `alamat`, `no_hp`, `email`, `keahlian`) VALUES
(1, 'admin', '0192023a7bbd73250516f069df18b500', 'admin', '', '', '', '', '', '', ''),
(2, 'user', '6ad14ba9986e3615423dfca256d04e3f', 'member', '', '', '', '', '', '', ''),
(4, '0554762665210023', '16adca60f52a041817173a99beff4499', 'member', '0554762665210023', 'Wiwi Erpina', 'P', 'KARANGTENGAH', '', '', 'AKL'),
(5, '8534760661130322', '4f5f305632e85ecf7a77b24643eee7be', 'member', '8534760661130322', 'Aba Umar', 'L', 'Kejene', '', '', 'TBSM'),
(6, '0939760662300042', '625898302f6d4f6fdeb6efede813f2d0', 'member', '0939760662300042', 'Sumarni', 'P', 'Randudongkal\r\n', '', '', 'PS'),
(7, '7040765666130173', 'ce79d33365a1e8da9611fd8b89390df6', 'member', '7040765666130173', 'Afwan Yulianto', 'L', 'SIMA', '', '', 'TKJ'),
(8, '5653763664130192', '0ed4255ddee0230693655a011656b08f', 'member', '5653763664130192', 'Mukholik', 'L', 'Randudongkal', '', '', '');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `dummy`
--
ALTER TABLE `dummy`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pertemuan`
--
ALTER TABLE `pertemuan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `absensi`
--
ALTER TABLE `absensi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `dummy`
--
ALTER TABLE `dummy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT untuk tabel `pertemuan`
--
ALTER TABLE `pertemuan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
