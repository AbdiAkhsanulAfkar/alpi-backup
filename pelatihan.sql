-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 21, 2022 at 01:26 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tahun_akad_baru` ()   BEGIN

INSERT INTO tahun_akademik
SELECT CONCAT(RIGHT(YEAR(SYSDATE()),2),RIGHT(YEAR(SYSDATE()),2)+1) AS ID,
       CONCAT(YEAR(SYSDATE()),'/',YEAR(SYSDATE())+1) AS tahun,
       CONCAT(YEAR(SYSDATE()),'-07-01') AS mulai,
       CONCAT(YEAR(SYSDATE())+1,'-06-30') AS selesai;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `absensi`
--

CREATE TABLE `absensi` (
  `id` char(8) NOT NULL,
  `tanggal` date NOT NULL,
  `materi` varchar(35) NOT NULL,
  `uraian` varchar(225) DEFAULT NULL,
  `guru_nip` char(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `absensi`
--
DELIMITER $$
CREATE TRIGGER `absensi_before_insert` BEFORE INSERT ON `absensi` FOR EACH ROW BEGIN
   DECLARE vid char(8);
   SELECT CONCAT(RIGHT(YEAR(SYSDATE()),2),RIGHT(100+MONTH(SYSDATE()),2),RIGHT(100+DAY(SYSDATE()),2),RIGHT(100+COUNT(*)+1,2)) 
   FROM absensi WHERE tanggal = CURRENT_DATE INTO vid;  
   SET NEW.id = vid;
   SET NEW.tanggal = SYSDATE();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bagi_kelas`
--

CREATE TABLE `bagi_kelas` (
  `id` char(4) NOT NULL,
  `guru_nip` char(16) NOT NULL,
  `tahun_akademik_id` char(4) NOT NULL,
  `kelas_id` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bagi_kelas`
--

INSERT INTO `bagi_kelas` (`id`, `guru_nip`, `tahun_akademik_id`, `kelas_id`) VALUES
('21A1', '0554762665210023', '2122', 'A1'),
('21A2', '0760768669130072', '2122', 'A2'),
('21A3', '3853744645230062', '2122', 'A3'),
('22A1', '0554762665210023', '2223', 'A1'),
('22A2', '0760768669130072', '2223', 'A2'),
('22A3', '0939760662300042', '2223', 'A3'),
('22B1', '1457763663210052', '2223', 'B1'),
('22B2', '1461768669230242', '2223', 'B2'),
('22B3', '1549753656200023', '2223', 'B3'),
('22K1', '1557764665130392', '2223', 'K1'),
('22k2', '1851772673230172', '2223', 'k2'),
('22K3', '2353770671230203', '2223', 'K3'),
('22M1', '9440772673130162', '2223', 'M1'),
('22M2', '2554766667130142', '2223', 'M2'),
('22M3', '3244772673130183', '2223', 'M3'),
('22T1', '3249768669130083', '2223', 'T1'),
('22T2', '3734769670230272', '2223', 'T2'),
('22T3', '3757772673130192', '2223', 'T3');

--
-- Triggers `bagi_kelas`
--
DELIMITER $$
CREATE TRIGGER `bagi_kelas_before_insert` BEFORE INSERT ON `bagi_kelas` FOR EACH ROW BEGIN

   DECLARE vid char(4);

   SELECT CONCAT(RIGHT(YEAR(SYSDATE()),2),NEW.kelas_id) INTO vid;

   SET NEW.id = vid;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `guru`
--

CREATE TABLE `guru` (
  `nip` char(16) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `password` char(32) NOT NULL,
  `jk` char(1) NOT NULL,
  `no_hp` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `level_id` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guru`
--

INSERT INTO `guru` (`nip`, `nama`, `password`, `jk`, `no_hp`, `email`, `alamat`, `level_id`) VALUES
('0554762665210023', 'Wiwi Erpina', '16adca60f52a041817173a99beff4499', 'P', '', '', 'rt 4 rw 4 KARANGTENGAH WARUNGPRING Kec. Warungpring	52458\r\n', '3'),
('0760768669130072', 'Ana Nur Fitriana', 'c21b7db04a9f5679a03623580cfebfbd', 'P', '', '', '', '3'),
('0939760662300042', 'Sumarni', '625898302f6d4f6fdeb6efede813f2d0', 'P', '', '', 'rt 3	rt 1	Krajan RANDUDONGKAL\r\n', '3'),
('12345', 'sfs', '827ccb0eea8a706c4c34a16891f84e7b', '', '', '', '', '1'),
('1457763663210052', 'Putri Anggit Hapsari', '6e21b2dddee675d5aa9477de56a9e0ca', 'P', '', '', '', '3'),
('1461768669230242', 'Rina Setiyowati', '0db690af4fdf1e150dd8bf175e84532e', 'P', '', '', '', '3'),
('1549753656200023', 'Faozi', 'cbad7f3eb767cfb3ccfd71b8da4aa015', 'L', '', '', '', '3'),
('1557764665130392', 'AKHMAD LUTFI', 'f367cb1da20113bae84540880850f769', 'L', '', '', '', '3'),
('1851772673230172', 'FINA ALFIN FARKHATI', 'dab3e797a537d48d20df03cb25e6ea4e', 'P', '', '', '', '3'),
('2353770671230203', 'ANISATUL MA\'DIYAH', '874b4ddebc7b2866122e75518dd1e978', 'P', '', '', '', '3'),
('2554766667130142', 'Farikhatun', 'fadd2df8358227f22635d8fcc7b3ef02', 'P', '', '', '', '3'),
('3244772673130183', 'RULLY AMRIZAL', '3244772673130183', 'L', '', '', '', '3'),
('3249768669130083', 'Mila Septiani', '2dd5ee1fcca54ab8ad9ea080cfdbdbe8', 'P', '', '', '', '3'),
('3734769670230272', 'ESTORINA', '221b1b2ef9f425d7cf71fae52bfd4338', 'P', '', '', '', '3'),
('3757772673130192', 'MOCHAMMAD ABDUL HAFID', 'ec90ce81437ccf6d33bed94cefcfd698', 'L', '', '', '', '3'),
('3853744645230062', 'HARJANTI KAPYASTUTI', '49112808a6e3c4bd675de08dacff2bfd', 'P', '', '', '', '3'),
('3958762663130202', 'Muhammad Faizin', '513f4030a961632aca240c5c8afdeefc', 'L', '', '', '', '3'),
('4039762663130313', 'AGUNG HIDAYAT', '19148c626124bb93799208f98c074968', 'L', '', '', '', '3'),
('4233766667130143', 'Lukman Nulhakim', '177e627c978d71640023436c953211e9', 'L', '', '', '', '3'),
('4337769670130063', 'Gilar Rizqi Nugroho', '5f1869307aeedb461983f4326f8662c6', 'L', '', '', '', '3'),
('4454759660130142', 'AGUS BUDI JAYA', 'dd68b457c5bd7745ae63bac47c174aca', 'L', '', '', '', '3'),
('4539773674230152', 'LINA MUZAYYANAH SABILA', '0d6427f3ff0d3a75c65ace2f7049724e', 'L', '', '', '', '3'),
('4550763664130142', 'Kunto Pambudiraharjo', '5c4fceabd651cad5c2a0e065a7358200', 'L', '', '', '', '3'),
('5345765666130083', 'Robbiyanto', 'f815723084205aed9f5c381d9d3c9c9d', 'L', '', '', '', '3'),
('5353767668230043', 'Ermanita Pradina', '63795f7052ed0fb1c1624ef978b14947', 'P', '', '', '', '3'),
('5439761662230113', 'Anis Faoziyah', '37c3e884f23f3d159b002777fb8fee3f', 'P', '', '', '', '3'),
('5550765666210102', 'Maslakha', 'b2ddfb418147e6b6ab3dac8d4fc49904', 'P', '', '', '', '3'),
('5653763664130190', 'Mukholik', '51347eafe8a12038d3658e8062d47532', 'L', '', '', 'rt 17	rw 5	Dukuh Bongkot	Karangmoncol	Kec. Randudongkal\r\n', '3'),
('6233752653130083', 'Karnadi', 'c09a45f5a13fffce151632e6ba8c2e95', 'L', '', '', '', '3'),
('6354770671130033', 'Abdullah Azam', 'ff39404f3f446efeb71fa0cc7c7058aa', 'L', '', '', '', '3'),
('6833768669230282', 'FIKRI MELI SANTI', 'de178bd62fd971e9cd9577c029860652', 'P', '', '', '', '3'),
('6946763664120002', 'Asep Abdul Gafur', '4d9e8ad01085b5b188fa03239475eb1f', 'L', '', '', '', '3'),
('7040765666130173', 'Afwan Yulianto', 'ce79d33365a1e8da9611fd8b89390df6', 'L', '', '', 'rt 1	rw 7	SIMA	Kec. Randudongkal\r\n', '3'),
('7049764665131093', 'Niken Ratna Swandhany', '81a9d5d272e4802e5fe668c8e28306f5', 'P', '', '', '', '3'),
('7063765666130093', 'Dewitika', '8457fe58d13f97b6bd291f7e1f9338f7', 'P', '', '', '', '3'),
('7458772673130163', 'Eko Hardiyanto', '120bebedfe4d279d7a5a4295bd7a3dab', 'L', '', '', '', '3'),
('7551768669130213', 'NAUFAL ULINNUHA', 'cfd8730a1e9edd510e7c855857a4c695', 'L', '', '', '', '3'),
('8039772673230253', 'EKA SUSANTI', '5a94c8f056a6f143406478bad96acffd', 'P', '', '', '', '3'),
('8250762663230173', 'ETI PRIHARTANTI', '3f1ad1c2da1041e90f1989dc7beda102', 'P', '', '', '', '3'),
('8363761662300003', 'Nurul Istiqomah', 'dae1a1d6b25000f0a83393128ec1ffdc', 'P', '', '', '', '3'),
('8534760661130322', 'Aba Umar', '4f5f305632e85ecf7a77b24643eee7be', 'L', '', '', 'rt 50	rw 4	KEJENE	Kec. Randudongkal\r\n', '3'),
('8557763664130132', 'Eko Budi Susilo', '1f6058a0e299a9c7f4dc2b23e8dfdf6b', 'L', '', '', '', '3'),
('8834770671230362', 'MASFUFAH', '8792928d437c3f7d70094705edec40fe', 'P', '', '', '', '3'),
('9139763664110043', 'Agus Zaeni Nu\'man', 'e81c6e6f1950aef3fd7aba34d52edba9', 'L', '', '', '', '3'),
('9440772673130162', 'MUHAMMAD RIZQIE ARIS', '287e7aa9b72a73a0917f7d40f44f7a39', 'L', '', '', '', '3'),
('9561757659300093', 'Nuning Tri Aryanti', 'cbc95744e0cc0eb35c273e0da0c5b19c', 'P', '', '', '', '3');

-- --------------------------------------------------------

--
-- Table structure for table `jurusan`
--

CREATE TABLE `jurusan` (
  `id` char(2) NOT NULL,
  `jurusan` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jurusan`
--

INSERT INTO `jurusan` (`id`, `jurusan`) VALUES
('ak', 'Akuntansi'),
('kj', 'Teknik Komputer Jaringan'),
('mm', 'Multimedia'),
('ot', 'Automotif'),
('ps', 'Perbankan Syariah');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_soal`
--

CREATE TABLE `kategori_soal` (
  `id` char(1) NOT NULL,
  `kategori` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori_soal`
--

INSERT INTO `kategori_soal` (`id`, `kategori`) VALUES
('T', 'Teknologi');

-- --------------------------------------------------------

--
-- Table structure for table `kehadiran`
--

CREATE TABLE `kehadiran` (
  `id` int(11) NOT NULL,
  `siswa_nipd` char(7) NOT NULL,
  `keterangan_id` char(1) NOT NULL,
  `pertemuan_id` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id` char(2) NOT NULL,
  `kelas` varchar(10) NOT NULL,
  `jurusan_id` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id`, `kelas`, `jurusan_id`) VALUES
('A1', 'X AKL 1', 'ak'),
('A2', 'X AKL 2', 'ak'),
('A3', 'X AKL 3', 'ak'),
('A4', 'XI AKL 1', 'ak'),
('A5', 'XI AKL 2', 'ak'),
('A6', 'XI AKL 3', 'ak'),
('B1', 'X PS 1', 'ps'),
('B2', 'X PS 2', 'ps'),
('B3', 'X PS 3', 'ps'),
('B4', 'XI PS 1', 'ps'),
('B5', 'XI PS 2', 'ps'),
('B6', 'XI PS 3', 'ps'),
('K1', 'X TKJ 1', 'kj'),
('k2', 'X TKJ 2', 'kj'),
('K3', 'X TKJ 3', 'kj'),
('K4', 'XI TKJ 1', 'kj'),
('K5', 'XI TKJ 2', 'kj'),
('K6', 'XI TKJ 3', 'kj'),
('M1', 'X MM 1', 'mm'),
('M2', 'X MM 2', 'mm'),
('M3', 'X MM 3', 'mm'),
('M4', 'XI MM 1', 'mm'),
('M5', 'XI MM 2', 'mm'),
('M6', 'XI MM 3', 'mm'),
('T1', 'X TBSM 1', 'ot'),
('T2', 'X TBSM 2', 'ot'),
('T3', 'X TBSM 3', 'ot'),
('T4', 'XI TBSM 1', 'ot'),
('T5', 'XI TBSM 2', 'ot'),
('T6', 'XI TBSM 3', 'ot');

-- --------------------------------------------------------

--
-- Stand-in structure for view `kelas_belum_ploting_walinya`
-- (See below for the actual view)
--
CREATE TABLE `kelas_belum_ploting_walinya` (
`id` char(2)
,`kelas` varchar(10)
);

-- --------------------------------------------------------

--
-- Table structure for table `keterangan`
--

CREATE TABLE `keterangan` (
  `id` char(1) NOT NULL,
  `keterangan` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keterangan`
--

INSERT INTO `keterangan` (`id`, `keterangan`) VALUES
('A', 'Alfa'),
('H', 'Hadir'),
('I', 'Ijin'),
('S', 'Sakit');

-- --------------------------------------------------------

--
-- Table structure for table `level`
--

CREATE TABLE `level` (
  `id` char(1) NOT NULL,
  `level` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `level`
--

INSERT INTO `level` (`id`, `level`) VALUES
('1', 'admin'),
('2', 'member'),
('3', 'guru');

-- --------------------------------------------------------

--
-- Table structure for table `pertemuan`
--

CREATE TABLE `pertemuan` (
  `id` char(2) NOT NULL,
  `pertemuan` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pertemuan`
--

INSERT INTO `pertemuan` (`id`, `pertemuan`) VALUES
('01', 'Pertemuan-1'),
('02', 'Pertemuan-2'),
('03', 'Pertemuan-3'),
('04', 'Pertemuan-4'),
('05', 'Pertemuan-5'),
('06', 'Pertemuan-6'),
('07', 'Pertemuan-7'),
('08', 'Pertemuan-8'),
('09', 'Pertemuan-9'),
('10', 'Pertemuan-10'),
('11', 'Pertemuan-11'),
('12', 'Pertemuan-12'),
('13', 'Pertemuan-13'),
('14', 'Pertemuan-14');

-- --------------------------------------------------------

--
-- Table structure for table `plot_kelas`
--

CREATE TABLE `plot_kelas` (
  `id` int(11) NOT NULL,
  `bagi_kelas_id` char(4) NOT NULL,
  `siswa_nipd` char(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `plot_kelas`
--

INSERT INTO `plot_kelas` (`id`, `bagi_kelas_id`, `siswa_nipd`) VALUES
(630, '22A1', '2115192'),
(631, '22A1', '2115193'),
(632, '22A1', '2115195'),
(633, '22A1', '2115196'),
(634, '22A1', '2115197'),
(635, '22A1', '2115198'),
(636, '22A1', '2115199'),
(637, '22A1', '2115200'),
(638, '22A1', '2115201'),
(639, '22A1', '2115202'),
(640, '22A1', '2115203'),
(641, '22A1', '2115204'),
(642, '22A1', '2115205'),
(643, '22A1', '2115206'),
(644, '22A1', '2115207'),
(645, '22A1', '2115208'),
(646, '22A1', '2115209'),
(647, '22A1', '2115210'),
(648, '22A1', '2115211'),
(649, '22A1', '2115213'),
(650, '22A1', '2115212'),
(651, '22A1', '2115214'),
(652, '22A1', '2115215'),
(653, '22A1', '2115216'),
(654, '22A1', '2115217'),
(655, '22A1', '2115218'),
(656, '22A1', '2115219'),
(657, '22A1', '2115220'),
(658, '22A1', '2115221'),
(659, '22A1', '2115222'),
(660, '22A1', '2115223'),
(661, '22A1', '2115224'),
(662, '22A1', '2115225'),
(663, '22A1', '2115226'),
(664, '22A1', '2115227'),
(665, '22A1', '2115229'),
(666, '22A1', '2115230'),
(667, '22A1', '2115231'),
(668, '22A1', '2115232'),
(669, '22A1', '2115233'),
(670, '22A2', '2115234'),
(671, '22A2', '2115235'),
(672, '22A2', '2115236'),
(673, '22A2', '2115237'),
(674, '22A2', '2115238'),
(675, '22A2', '2115239'),
(676, '22A2', '2115240'),
(677, '22A2', '2115241'),
(678, '22A2', '2115242'),
(679, '22A2', '2115243'),
(680, '22A2', '2115245'),
(681, '22A2', '2115246'),
(682, '22A2', '2115247'),
(683, '22A2', '2115248'),
(684, '22A2', '2115249'),
(685, '22A2', '2115250'),
(686, '22A2', '2115251'),
(687, '22A2', '2115252'),
(688, '22A2', '2115253'),
(689, '22A2', '2115254'),
(690, '22A2', '2115255'),
(691, '22A2', '2115256'),
(692, '22A2', '2115257'),
(693, '22A2', '2115258'),
(694, '22A2', '2115259'),
(695, '22A2', '2115260'),
(696, '22A2', '2115261'),
(697, '22A2', '2115262'),
(698, '22A2', '2115263'),
(699, '22A2', '2115264'),
(700, '22A2', '2115265'),
(701, '22A2', '2115266'),
(702, '22A2', '2115268'),
(703, '22A2', '2115269'),
(704, '22A2', '2115270'),
(705, '22A2', '2115271'),
(706, '22A2', '2115272'),
(707, '22A2', '2115273'),
(708, '22A2', '2115274'),
(709, '22A2', '2115275'),
(710, '22A3', '2115276'),
(711, '22A3', '2115277'),
(712, '22A3', '2115278'),
(713, '22A3', '2115279'),
(714, '22A3', '2115280'),
(715, '22A3', '2115281'),
(716, '22A3', '2115282'),
(717, '22A3', '2115283'),
(718, '22A3', '2115284'),
(719, '22A3', '2115285'),
(720, '22A3', '2115286'),
(721, '22A3', '2115287'),
(722, '22A3', '2115288'),
(723, '22A3', '2115289'),
(724, '22A3', '2115290'),
(725, '22A3', '2115291'),
(726, '22A3', '2115292'),
(727, '22A3', '2115293'),
(728, '22A3', '2115294'),
(729, '22A3', '2115295'),
(730, '22A3', '2115298'),
(731, '22A3', '2115296'),
(732, '22A3', '2115297'),
(733, '22A3', '2115299'),
(734, '22A3', '2115300'),
(735, '22A3', '2115301'),
(736, '22A3', '2115302'),
(737, '22A3', '2115303'),
(738, '22A3', '2115304'),
(739, '22A3', '2115305'),
(740, '22A3', '2115306'),
(741, '22A3', '2115307'),
(742, '22A3', '2115308'),
(743, '22A3', '2115309'),
(744, '22A3', '2115310'),
(745, '22A3', '2115311'),
(746, '22A3', '2115312'),
(747, '22A3', '2115313'),
(748, '22A3', '2115314'),
(749, '22A3', '2115315'),
(750, '22A3', '2115316'),
(751, '22M1', '2114983'),
(752, '22M1', '2114984'),
(753, '22M1', '2114985'),
(754, '22M1', '2114986'),
(755, '22M1', '2114987'),
(756, '22M1', '2114988'),
(757, '22M1', '2114989'),
(758, '22M1', '2114990'),
(759, '22M1', '2114991'),
(760, '22M1', '2114992'),
(761, '22M1', '2114993'),
(762, '22M1', '2114994'),
(763, '22M1', '2114996'),
(764, '22M1', '2114997'),
(765, '22M1', '2114998'),
(766, '22M1', '2114999'),
(767, '22M1', '2115000'),
(768, '22M1', '2115001'),
(769, '22M1', '2115003'),
(770, '22M1', '2115004'),
(771, '22M1', '2115005'),
(772, '22M1', '2115006'),
(773, '22M1', '2115007'),
(774, '22M1', '2115008'),
(775, '22M1', '2115009'),
(776, '22M1', '2115010'),
(777, '22M1', '2115011'),
(778, '22M1', '2115013'),
(779, '22M1', '2115014'),
(780, '22M1', '2115015'),
(781, '22M1', '2115016'),
(782, '22M1', '2115017'),
(783, '22M1', '2115018'),
(784, '22M1', '2115019'),
(785, '22M1', '2115020'),
(786, '22M1', '2115021'),
(787, '22M1', '2115022'),
(788, '22M1', '2115023'),
(789, '22M1', '2115024'),
(790, '22M2', '2115025'),
(791, '22M2', '2115026'),
(792, '22M2', '2115027'),
(793, '22M2', '2115028'),
(794, '22M2', '2115029'),
(795, '22M2', '2115030'),
(796, '22M2', '2115031'),
(797, '22M2', '2115032'),
(798, '22M2', '2115033'),
(799, '22M2', '2115034'),
(800, '22M2', '2115035'),
(801, '22M2', '2115036'),
(802, '22M2', '2115037'),
(803, '22M2', '2115038'),
(804, '22M2', '2115039'),
(805, '22M2', '2115040'),
(806, '22M2', '2115041'),
(807, '22M2', '2115042'),
(808, '22M2', '2115043'),
(809, '22M2', '2115044'),
(810, '22M2', '2115045'),
(811, '22M2', '2115046'),
(812, '22M2', '2115052'),
(813, '22M2', '2115047'),
(814, '22M2', '2115048'),
(815, '22M2', '2115049'),
(816, '22M2', '2115050'),
(817, '22M2', '2115051'),
(818, '22M2', '2115053'),
(819, '22M2', '2115054'),
(820, '22M2', '2115055'),
(821, '22M2', '2115056'),
(822, '22M2', '2115057'),
(823, '22M2', '2115058'),
(824, '22M2', '2115059'),
(825, '22M2', '2115061'),
(826, '22M2', '2115062'),
(827, '22M2', '2115063'),
(828, '22M2', '2115064'),
(829, '22M2', '2115065'),
(830, '22M3', '2115066'),
(831, '22M3', '2115067'),
(832, '22M3', '2115068'),
(833, '22M3', '2115069'),
(834, '22M3', '2115070'),
(835, '22M3', '2115071'),
(836, '22M3', '2115072'),
(837, '22M3', '2115073'),
(838, '22M3', '2115074'),
(839, '22M3', '2115075'),
(840, '22M3', '2115076'),
(841, '22M3', '2115077'),
(842, '22M3', '2115078'),
(843, '22M3', '2115079'),
(844, '22M3', '2115080'),
(845, '22M3', '2115081'),
(846, '22M3', '2115083'),
(847, '22M3', '2115090'),
(848, '22M3', '2115084'),
(849, '22M3', '2115085'),
(850, '22M3', '2115086'),
(851, '22M3', '2115087'),
(852, '22M3', '2115088'),
(853, '22M3', '2115089'),
(854, '22M3', '2115091'),
(855, '22M3', '2115092'),
(856, '22M3', '2115093'),
(857, '22M3', '2115094'),
(858, '22M3', '2115095'),
(859, '22M3', '2115096'),
(860, '22M3', '2115097'),
(861, '22M3', '2115098'),
(862, '22M3', '2115099'),
(863, '22M3', '2115100'),
(864, '22M3', '2115101'),
(865, '22M3', '2115102'),
(866, '22M3', '2115103'),
(867, '22M3', '2115104'),
(868, '22M3', '2115105'),
(869, '22M3', '2115106'),
(870, '22M3', '2115107'),
(871, '22B1', '2115108'),
(872, '22B1', '2115109'),
(873, '22B1', '2115110'),
(874, '22B1', '2115111'),
(875, '22B1', '2115112'),
(876, '22B1', '2115113'),
(877, '22B1', '2115114'),
(878, '22B1', '2115115'),
(879, '22B1', '2115116'),
(880, '22B1', '2115117'),
(881, '22B1', '2115118'),
(882, '22B1', '2115119'),
(883, '22B1', '2115120'),
(884, '22B1', '2115121'),
(885, '22B1', '2115122'),
(886, '22B1', '2115123'),
(887, '22B1', '2115124'),
(888, '22B1', '2115125'),
(889, '22B1', '2115126'),
(890, '22B1', '2115127'),
(891, '22B1', '2115128'),
(892, '22B1', '2115129'),
(893, '22B1', '2115130'),
(894, '22B1', '2115131'),
(895, '22B1', '2115133'),
(896, '22B1', '2115132'),
(897, '22B1', '2115134'),
(898, '22B1', '2115135'),
(899, '22B1', '2115136'),
(900, '22B1', '2115137'),
(901, '22B1', '2115138'),
(902, '22B1', '2115139'),
(903, '22B1', '2115140'),
(904, '22B1', '2115142'),
(905, '22B1', '2115143'),
(906, '22B1', '2115144'),
(907, '22B1', '2115145'),
(908, '22B1', '2115146'),
(909, '22B1', '2115147'),
(910, '22B1', '2115148'),
(911, '22B2', '2115150'),
(912, '22B2', '2115151'),
(913, '22B2', '2115152'),
(914, '22B2', '2115153'),
(915, '22B2', '2115154'),
(916, '22B2', '2115155'),
(917, '22B2', '2115156'),
(918, '22B2', '2115157'),
(919, '22B2', '2115158'),
(920, '22B2', '2115159'),
(921, '22B2', '2115160'),
(922, '22B2', '2115161'),
(923, '22B2', '2115162'),
(924, '22B2', '2115163'),
(925, '22B2', '2115164'),
(926, '22B2', '2115165'),
(927, '22B2', '2115166'),
(928, '22B2', '2115167'),
(929, '22B2', '2115168'),
(930, '22B2', '2115169'),
(931, '22B2', '2115170'),
(932, '22B2', '2115171'),
(933, '22B2', '2115172'),
(934, '22B2', '2115173'),
(935, '22B2', '2115179'),
(936, '22B2', '2115174'),
(937, '22B2', '2115175'),
(938, '22B2', '2115176'),
(939, '22B2', '2115177'),
(940, '22B2', '2115178'),
(941, '22B2', '2115180'),
(942, '22B2', '2115181'),
(943, '22B2', '2115182'),
(944, '22B2', '2115183'),
(945, '22B2', '2115184'),
(946, '22B2', '2115185'),
(947, '22B2', '2115186'),
(948, '22B2', '2115188'),
(949, '22B2', '2115187'),
(950, '22B2', '2115189'),
(951, '22B2', '2115190'),
(952, '22B2', '2115191'),
(953, '22T1', '2115317'),
(954, '22T1', '2115318'),
(955, '22T1', '2115319'),
(956, '22T1', '2115320'),
(957, '22T1', '2115321'),
(958, '22T1', '2115322'),
(959, '22T1', '2115323'),
(960, '22T1', '2115324'),
(961, '22T1', '2115325'),
(962, '22T1', '2115326'),
(963, '22T1', '2115327'),
(964, '22T1', '2115328'),
(965, '22T1', '2115329'),
(966, '22T1', '2115330'),
(967, '22T1', '2115331'),
(968, '22T1', '2115332'),
(969, '22T1', '2115333'),
(970, '22T1', '2115334'),
(971, '22T1', '2115335'),
(972, '22T1', '2115336'),
(973, '22T1', '2115337'),
(974, '22T1', '2115338'),
(975, '22T1', '2115339'),
(976, '22T1', '2115340'),
(977, '22T1', '2115341'),
(978, '22T1', '2115342'),
(979, '22T1', '2115343'),
(980, '22T1', '2115344'),
(981, '22T1', '2115345'),
(982, '22T1', '2115346'),
(983, '22T1', '2115347'),
(984, '22T1', '2115348'),
(985, '22T1', '2115349'),
(986, '22T1', '2115350'),
(987, '22T1', '2115351'),
(988, '22T1', '2115352'),
(989, '22T1', '2115353'),
(990, '22T1', '2115354'),
(991, '22T1', '2115355'),
(992, '22T1', '2115356'),
(993, '22T1', '2115357'),
(994, '22T1', '2115358'),
(995, '22T2', '2115359'),
(996, '22T2', '2115360'),
(997, '22T2', '2115361'),
(998, '22T2', '2115362'),
(999, '22T2', '2115363'),
(1000, '22T2', '2115364'),
(1001, '22T2', '2115365'),
(1002, '22T2', '2115366'),
(1003, '22T2', '2115367'),
(1004, '22T2', '2115368'),
(1005, '22T2', '2115369'),
(1006, '22T2', '2115370'),
(1007, '22T2', '2115372'),
(1008, '22T2', '2115373'),
(1009, '22T2', '2115374'),
(1010, '22T2', '2115375'),
(1011, '22T2', '2115376'),
(1012, '22T2', '2115377'),
(1013, '22T2', '2115378'),
(1014, '22T2', '2115379'),
(1015, '22T2', '2115380'),
(1016, '22T2', '2115382'),
(1017, '22T2', '2115383'),
(1018, '22T2', '2115384'),
(1019, '22T2', '2115385'),
(1020, '22T2', '2115386'),
(1021, '22T2', '2115387'),
(1022, '22T2', '2115388'),
(1023, '22T2', '2115389'),
(1024, '22T2', '2115390'),
(1025, '22T2', '2115391'),
(1026, '22T2', '2115392'),
(1027, '22T2', '2115393'),
(1028, '22T2', '2115394'),
(1029, '22T2', '2115395'),
(1030, '22T2', '2115396'),
(1031, '22T2', '2115397'),
(1032, '22T2', '2115398'),
(1033, '22T2', '2115399'),
(1034, '22T2', '2115400'),
(1035, '22T3', '2115401'),
(1036, '22T3', '2115402'),
(1037, '22T3', '2115403'),
(1038, '22T3', '2115404'),
(1039, '22T3', '2115405'),
(1040, '22T3', '2115406'),
(1041, '22T3', '2115407'),
(1042, '22T3', '2115408'),
(1043, '22T3', '2115409'),
(1044, '22T3', '2115410'),
(1045, '22T3', '2115411'),
(1046, '22T3', '2115412'),
(1047, '22T3', '2115413'),
(1048, '22T3', '2115414'),
(1049, '22T3', '2115415'),
(1050, '22T3', '2115416'),
(1051, '22T3', '2115417'),
(1052, '22T3', '2115418'),
(1053, '22T3', '2115419'),
(1054, '22T3', '2115420'),
(1055, '22T3', '2115421'),
(1056, '22T3', '2115422'),
(1057, '22T3', '2115423'),
(1058, '22T3', '2115424'),
(1059, '22T3', '2115425'),
(1060, '22T3', '2115426'),
(1061, '22T3', '2115427'),
(1062, '22T3', '2115428'),
(1063, '22T3', '2115429'),
(1064, '22T3', '2115430'),
(1065, '22T3', '2115431'),
(1066, '22T3', '2115432'),
(1067, '22T3', '2115433'),
(1068, '22T3', '2115434'),
(1069, '22T3', '2115435'),
(1070, '22T3', '2115436'),
(1071, '22T3', '2115437'),
(1072, '22T3', '2115438'),
(1073, '22T3', '2115439'),
(1074, '22T3', '2115440'),
(1075, '22T3', '2115441'),
(1076, '22T3', '2115442'),
(1077, '22K1', '2114857'),
(1078, '22K1', '2114858'),
(1079, '22K1', '2114859'),
(1080, '22K1', '2114860'),
(1081, '22K1', '2114861'),
(1082, '22K1', '2114862'),
(1083, '22K1', '2114863'),
(1084, '22K1', '2114864'),
(1085, '22K1', '2114865'),
(1086, '22K1', '2114866'),
(1087, '22K1', '2114867'),
(1088, '22K1', '2114868'),
(1089, '22K1', '2114869'),
(1090, '22K1', '2114870'),
(1091, '22K1', '2114871'),
(1092, '22K1', '2114872'),
(1093, '22K1', '2114873'),
(1094, '22K1', '2114874'),
(1095, '22K1', '2114875'),
(1096, '22K1', '2114876'),
(1097, '22K1', '2114877'),
(1098, '22K1', '2114878'),
(1099, '22K1', '2114879'),
(1100, '22K1', '2114880'),
(1101, '22K1', '2114881'),
(1102, '22K1', '2114882'),
(1103, '22K1', '2114883'),
(1104, '22K1', '2114884'),
(1105, '22K1', '2114885'),
(1106, '22K1', '2114886'),
(1107, '22K1', '2114887'),
(1108, '22K1', '2114888'),
(1109, '22K1', '2114889'),
(1110, '22K1', '2114890'),
(1111, '22K1', '2114891'),
(1112, '22K1', '2114892'),
(1113, '22K1', '2114893'),
(1114, '22K1', '2114894'),
(1115, '22K1', '2114895'),
(1116, '22K1', '2114896'),
(1117, '22K1', '2114897'),
(1118, '22K1', '2114898'),
(1119, '22k2', '2114905'),
(1120, '22k2', '2114899'),
(1121, '22k2', '2114900'),
(1122, '22k2', '2114901'),
(1123, '22k2', '2114902'),
(1124, '22k2', '2114903'),
(1125, '22k2', '2114904'),
(1126, '22k2', '2114906'),
(1127, '22k2', '2114907'),
(1128, '22k2', '2114908'),
(1129, '22k2', '2114909'),
(1130, '22k2', '2114910'),
(1131, '22k2', '2114911'),
(1132, '22k2', '2114912'),
(1133, '22k2', '2114913'),
(1134, '22k2', '2114914'),
(1135, '22k2', '2114915'),
(1136, '22k2', '2114916'),
(1137, '22k2', '2114917'),
(1138, '22k2', '2114918'),
(1139, '22k2', '2114919'),
(1140, '22k2', '2114925'),
(1141, '22k2', '2114921'),
(1142, '22k2', '2114923'),
(1143, '22k2', '2114924'),
(1144, '22k2', '2114920'),
(1145, '22k2', '2114922'),
(1146, '22k2', '2114926'),
(1147, '22k2', '2114927'),
(1148, '22k2', '2114928'),
(1149, '22k2', '2114929'),
(1150, '22k2', '2114930'),
(1151, '22k2', '2114931'),
(1152, '22k2', '2114932'),
(1153, '22k2', '2114933'),
(1154, '22k2', '2114934'),
(1155, '22k2', '2114935'),
(1156, '22k2', '2114936'),
(1157, '22k2', '2114937'),
(1158, '22k2', '2114938'),
(1159, '22k2', '2114939'),
(1160, '22k2', '2114940'),
(1161, '22K3', '2114941'),
(1162, '22K3', '2114942'),
(1163, '22K3', '2114943'),
(1164, '22K3', '2114944'),
(1165, '22K3', '2114945'),
(1166, '22K3', '2114946'),
(1167, '22K3', '2114947'),
(1168, '22K3', '2114948'),
(1169, '22K3', '2114949'),
(1170, '22K3', '2114950'),
(1171, '22K3', '2114951'),
(1172, '22K3', '2114952'),
(1173, '22K3', '2114954'),
(1174, '22K3', '2114956'),
(1175, '22K3', '2114957'),
(1176, '22K3', '2114958'),
(1177, '22K3', '2114959'),
(1178, '22K3', '2114961'),
(1179, '22K3', '2114967'),
(1180, '22K3', '2114962'),
(1181, '22K3', '2114963'),
(1182, '22K3', '2114965'),
(1183, '22K3', '2114968'),
(1184, '22K3', '2114969'),
(1185, '22K3', '2114970'),
(1186, '22K3', '2114971'),
(1187, '22K3', '2114972'),
(1188, '22K3', '2114973'),
(1189, '22K3', '2114974'),
(1190, '22K3', '2114975'),
(1191, '22K3', '2114976'),
(1192, '22K3', '2114977'),
(1193, '22K3', '2114978'),
(1194, '22K3', '2114979'),
(1195, '22K3', '2114980'),
(1196, '22K3', '2114981'),
(1197, '22K3', '2114982'),
(1198, '21A1', '1234567');

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `nipd` char(7) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `nisn` char(10) NOT NULL,
  `password` char(32) NOT NULL,
  `jk` char(1) NOT NULL,
  `jurusan_id` char(2) NOT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `tempat_lahir` varchar(20) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `asal_sekolah` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`nipd`, `nama`, `nisn`, `password`, `jk`, `jurusan_id`, `no_hp`, `email`, `alamat`, `tempat_lahir`, `tanggal_lahir`, `asal_sekolah`) VALUES
('1234567', 'papa', '1234567890', 'e807f1fcf82d132f9bb018ca6738a19f', 'L', 'ak', NULL, NULL, 'hjj', NULL, NULL, NULL),
('2114857', 'AAS KHUSAEISA', '67301349', '6587a87225820ab089d137fd3cfc82f3', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114858', 'ABI SAPUTRA', '63094866', 'c79955d675a1e3cb106009694a925207', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114859', 'ADAM WAHYU FEBRIAN', '63928621', 'ff5a062d29292998540547b5c11ddf76', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114860', 'ADHEA SEPTI RAHMADINI', '3060905124', '47b407d44af01ababed9b89887515673', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114861', 'AHMAD VAJAR MIHROJI', '59119981', 'd991984dd0dd38e038b8c8d41bf7fc14', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114862', 'AINA NUR AZIZAH', '65784987', 'a7ad199c686a71e25110c8b4ca51766d', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114863', 'AL HAIN FAHMI AISYI', '64238697', '5fa2241232a44f746bf9982485dc65dc', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114864', 'ALFIA ZAHRA', '67695661', '1d3cc05bfe941f37db0a413a5b22e3ec', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114865', 'ALIF SURYO ROMADLON', '55146139', 'a4c792d3a1e189173cf460ce7a8ca1de', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114866', 'ARDIANSYAH SAPUTRA', '54532613', '7a0868646ad4a09fdd5b01aec19b8db4', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114867', 'DELILA ARUM WINESTI', '69199879', 'f4747af5671a4580b79f192772afc923', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114868', 'DIDA ADI PUTRA', '69898987', '322eb3cfa9863c81275d307fd5f8021c', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114869', 'EKA ALSSAH PUTRA', '67653554', 'b44b8f2cd63b531998d65ed6860d4040', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114870', 'EPI NOVITA SARI', '58468658', 'afad51ff771dd3998ece811ceda3dcb6', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114871', 'ERNI FITRIANI', '64671134', '41a38678c66891b0b53c5901a0bd494f', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114872', 'FATNAN AL NGAKLI', '3053208347', '0e0d77f0d37f0a1901771f97cb26267d', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114873', 'FIKRI FATRUL FATONI', '55257354', '9dcbf6d1fced1625a54c2e014062e300', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114874', 'IBNU FAJAR ROZABI', '47051642', 'e701ffe0e9c5fd5ebe45b9a00c48f2a2', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114875', 'IFQI NAFIS ZAHRANI', '79690698', '9c39ebb5603e5c9fa0499e51a61951f6', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114876', 'IKFINA NAELA NIMAH', '53419342', '26af9b1689d18e6b3dd24380fe484e49', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114877', 'IMAN AULIA AL FAQIH', '65904987', '986475e2bd919c11118db501a231ba3e', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114878', 'LABIB SOQI', '69631792', '5d5300bdcc5d3a5f0e6b88ede22c4426', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114879', 'LULU RIFANTI HANIFA', '76586415', '218bcd68f068cd5a7229beac30e3ac74', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114880', 'MAULANA IRHAM MUZAKI', '55545516', '3e2ac27c949afc0a6ee62d28ed1129b9', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114881', 'MUCHAMAD RIAN AJINUGROHO', '66467520', '419ed04d772397cd7ec8a65deace9eb7', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114882', 'MUHAMAD ASYIQ SULTHONUROSYID', '56247077', '5c46e2d9bc6e37df171f29c944607950', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114883', 'MUHAMAD AZKAL HIKAM', '59933593', 'f01a65f890bed5a864a4f25398fe5f18', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114884', 'MUHAMAD DANI RAMADANSYAH', '64172953', '9abd41ae122ea34106a556ea2bab182c', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114885', 'NANDA TRI LESTARI', '75775579', 'afccfcdba1a60082d7dced5ceb7a5d27', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114886', 'NUNUNG FADILAH', '66076143', '888696bff035b8431cfd4279fee82627', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114887', 'RAHMADANI PUTRI', '66694561', 'fdee5dd25d7b04740f058b4a4d525983', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114888', 'REFIYAL AULIANA MEZA', '68578780', 'aeb1c43523eb524ec553debef50c86cf', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114889', 'RERE SAPUTRA', '59009251', 'ec39d13a67847e91631095163c932188', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114890', 'RESTU STIAWAN', '65663045', '6ebbc55ae3d816dfb676148bb1568863', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114891', 'SAHILA RAHMAWATI', '64813448', 'e27065732fc3a9718c238adefd8e2afb', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114892', 'SAHRIL ADI PANGESTU', '53419185', 'b641f299cfa78f0ae3bcc3b3ecd28101', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114893', 'SALWA NABILA NAHDA', '52807007', 'f68ed401527e1f24f1612c590f2cd1d2', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114894', 'SILVIYA', '51294186', 'ab4d30ceabdb420e3c1f297ea1c65b40', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114895', 'TEGAR ALHABSI', '69488540', 'e69d9d4fc9d4aaefca5e6a35830119ac', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114896', 'WIWIT FIKA YULIYANI', '56253247', '8d1217d8e6a645b40a7ebeabe6d35403', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114897', 'ZAHWA SOFIATUN NABILA', '55439508', '76db972f00832f09d81dc84b7b4a7d11', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114898', 'ZASKIA MELANI', '65564741', 'ddcd959f2d95b788c441beaa5cf89f86', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114899', 'AHMAD RIZAL ARIFIN', '56203772', '1f69d348c64229d1e3aa5ef84388d72c', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114900', 'ALDI SETIAWAN', '62739189', 'f86c8e0b5b2993a75307cb388d215f61', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114901', 'ALFI ARDIYANSYAH', '69183657', 'b9b341ea3f98069473cba7549d9c6324', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114902', 'ALYA HEMAYATI', '68889255', '5779f2d6132d78a3d369124131cfdef1', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114903', 'AMRU ROSYADI', '63933195', '74fcdb99a68c3c5bf7ecca9d94e39b8c', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114904', 'ANISA ASHURUL ULUM', '68921953', '7137dc2f509b76941b53ae3c7ac24f48', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114905', 'AFRILIANA DWI OFTAVIANI', '67646460', '85c2595fa997f7538c4eef4a613288c8', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114906', 'ARUMA WARDA', '72810934', '4cd01e2d838fee6154cff1afa582d3c9', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114907', 'CHAERUL ANWAR', '65567204', '805ab667f837e3a6f6f4fe13b97b497d', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114908', 'DELIYANA RIMBI PERTIWI', '57253429', '61c37fb5a6bd6d4b10cb7031fb62a62a', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114909', 'DEVI NURMALA', '69124724', 'cdfc0ec4effff0f2bc57238c50c58ace', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114910', 'DINAR ABIDIN', '60217817', '077522f12de52b11dd1e58242c31ba97', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114911', 'ELAN HIDAYAT', '60215304', '59b63c4ae3e2e31d3799dc0953aa3f81', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114912', 'FAREL FEBIAN SAPUTRO', '64741236', '197b407a3a44f7237f5c0f19ca342a12', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114913', 'FITRIA RAMADHANI', '56850254', '42dc5cde36c500f29f53a84bf4d2ec08', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114914', 'GAGAH SATRIYO', '58029775', 'afc1578295ac541b63006afb39cd79f1', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114915', 'IMEL DARA YONA AFITRIYANTO', '56832224', 'f542e39e8ffa65010919a06b1a9a9bb5', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114916', 'INDAH AYU LESTARI', '62374338', '9c5be4135ab64846d623d88893020446', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114917', 'INDRA FIRMANSYAH', '73943729', '9d330aa9722f2704cbb0bbfbd09d44f4', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114918', 'ISYANA YUDEVA DASTIN', '52539341', '763d6dcb47f146138e136e7290f40f76', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114919', 'LENI TRI AGUSTINA', '67956308', '95c0ea41886fb68d2c1ad05ff7841e5f', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114920', 'MUHAMMAD IFAN MAULANA', '3063754847', '1f682c99c5c19cc13dda6644d02cd789', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114921', 'MUHAMAD LUTFAN AL FARIS', '67600037', '736e287b0daf2862e66a753479d3d5a2', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114922', 'MUHAMMAD RAEKHAN SOFYANUDIN', '64008355', 'd0c3852dc40f0f10151b756db4458a01', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114923', 'MUHAMAD RIPKI SARIPUDIN', '59457367', '1a6e6cc003ba907887323d1d73a5cb33', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114924', 'MUHAMAD SYAFIQ ANFAANI', '66963718', 'cee3e69f5467cc0f8269bb717f414c99', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114925', 'MUHAMAD DAFFA ALFIANSYAH', '65829611', 'f592b037cf44c06d25b32be90a73cfe8', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114926', 'NELA ARMITA RAHMA', '69879924', 'baa3c5cc61915dcbc76a0f7792f8f4e2', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114927', 'NEYLI AULIA AZ ZAHRA', '78887050', '457f98015d14ac81080c205a0a048269', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114928', 'RAKA HIZRIAN ARSYAH PUTRA', '66448516', 'b0b6a27e6d5d26e05981d1ec2af01415', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114929', 'REVIYANA WULANDARI', '53393297', '5184e48c0015a432e9895394859b569c', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114930', 'RIFKI JAZATULLOHI', '52876734', '85f08aa42bfdc20dd823dcef55a7a05e', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114931', 'RISKA AMELIA', '3076952494', '4a77ae3318c19a0fa0028575762335cc', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114932', 'RIZKI AGUSTIANTO', '67605711', '414f9e872704adbd255c886e2a05d288', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114933', 'SALALUDIN', '55210364', 'f6f1484f0b96d6b367cee094975a154d', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114934', 'SITI RAHAYU NINGSIH', '67674539', 'f8bdfc35f5bfd9c634e4eaf31ddc549d', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114935', 'SUCI RAMADANI', '68005104', '3401c8691104960ecd73e1703dce7bb2', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114936', 'SYIFA KHOERUNNISA', '63294501', '786b4d0b005157e8e54c325044828eeb', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114937', 'WAHYU DWI SAPUTRA NUGROHO', '51763003', 'f1373fd2b170cc0733352a306313562e', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114938', 'WIWIT NILAM NABILA', '64544777', '99fdd6ff684ed753bc9064603316b083', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114939', 'YAYAH MELISA', '63608949', '47d1a0fd4cb629721ee57741aebe0089', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114940', 'ZIKA ZASKIA SALMA', '67081760', '13651123076cec9105675712ecb14137', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114941', 'ANDREA MILANO', '57963389', 'e8ea908b794561986e0aa133fd645324', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114942', 'APRILLIA', '77854919', 'c86b9466015b863e2228ed9e52909874', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114943', 'ARI MAULANA', '56422866', '3818a29ffacede0788d5cd1095746f5f', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114944', 'ARIF MUZAKKY', '63327054', 'b32a698878be3d227f6b755fe887117d', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114945', 'ARJU AL MUHAKIKIN', '69221338', '3aa94f020743e702545f23d7e7685284', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114946', 'ATIAH NURIYANA PATMAWATI', '61796946', 'f120371a0ce2ff35c0652360786351ce', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114947', 'ATINA ISMATUL HAWA', '63242008', 'fb4394f25225f2ae0394bc9aee15d68f', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114948', 'AYU AMELIA PUTRI', '49460724', 'c1b5c86d1beda40c6b53b09995aab41a', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114949', 'AZKI SAPUTRA', '64015886', '1c896149ac72daa8483a16a4c7c4cd1f', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114950', 'DIFA PRAMIFTA TRI AHYANI', '67859726', '3d7caaa4a9da99ccc7993882a5c328a9', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114951', 'DIPA PRATAMA', '48298154', '348e7bfa899af154a798e4f5687b40e6', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114952', 'FADLI SAPUTRA', '66506416', '77cd2e0b77e0a0ea8ebd50c87db65f1b', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114954', 'GIZZA SASSI RAMADANI', '52451660', '1aaec4d53dfaa138f71e640a8a9eace4', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114956', 'HERU TRI SAPUTRA', '61792560', '1ed4112976909a83546c6b3ed16422c5', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114957', 'HESTI NURANI', '3053041422', 'ff0355be737ded82f0282c404f6e5958', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114958', 'INDI AMALIA DESI', '57187939', 'd6fa1eae6d529ea941d6eb25d7701890', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114959', 'ISMA MAULIDIA', '75394872', '6ef10e276d524d9ddd768badca77292c', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114961', 'LAILA RAHMAWATI', '69253553', '5845ad0a9c3113d7aa59188d5983c7d6', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114962', 'MUHAMMAD FAHMI AZMI', '67033937', '8c577b66e3c25fd2c604f0b537fc7084', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114963', 'MUHAMMAD HUSNI MUBAROK', '66238293', 'e1fcb7c48e38f21e953537e176f89e8d', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114965', 'MUHAMMAD RIYANSYAH', '61408578', '1833034eeb1cfb7bd0ffb0fe06b5f1b5', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114967', 'MUHAMAD ULUL AZMI', '52320108', 'f331738cc06d10a0ac7acf5d6593ed2f', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114968', 'NOVITA DEWI PUSPARINI', '67591945', '7c47c3b64500592469c6801cac1c0091', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114969', 'OYAN SAFITRI', '38838780', '35a65823ae0992b71fa02994290c1374', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114970', 'RISKA AMELIA', '67528508', 'eaa94e88d60db391e97688fa4304d9ee', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114971', 'RISMA DWI YANTI', '69295613', '4705eefd2656df5f5b3da6b5e971e5e4', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114972', 'RIYANI FITRIYAH', '3066338513', '95ec3ffc3f187257125894082c3cf214', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114973', 'ROYAN BAYHAQI ROMADONI', '58325692', 'd8b85f0973268ff82b98af322a890c5c', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114974', 'ROZAANI RIZKI RAMADHANI', '64572329', '20886bc8ae187fafbfd2d1e4602976ad', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114975', 'SATRIO JATI KESUMO', '88458260', '325028f427040615a0ca2c5676622850', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114976', 'SITI NUR AINI RAMADANI', '52466254', '9c45cb8e1a94872657e55352126e9e82', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114977', 'SUGIARTO PRABOWO', '53419227', '3d25f08ab3cc2499face602871a28626', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114978', 'TALITA RISQIANA', '73555106', '2c1cc278bc83acbf762725428bf7535f', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114979', 'VIVI AYU WINDA SARI', '3060967732', 'cf2c8b3841a2c59d184a4e2241ca0026', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114980', 'WANDI SAPUTRA', '65475464', 'b0c19c523f80d93bda48a70a9c01542b', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114981', 'ZIYADDATAN PRATAMA BORNEO', '69494065', '158f5315134307750233cc10dcdc7c42', 'L', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114982', 'ZULFATUN NAZAH', '3062277367', 'b2cf85fa9e40c7d3afaead8705d2fca9', 'P', 'kj', NULL, NULL, '', NULL, NULL, NULL),
('2114983', 'ABBIHA MAULIDINA ZULVA', '65278582', 'c132e437046c151963cf2b8ba9839867', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114984', 'AHMAD FAUZAN', '57001295', '19f2d58d43c2096acf0cb5524c4a39ba', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114985', 'ALDI PRATAMA', '43183346', '0d5b15f9279f268cf47f1bd004df1dc9', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114986', 'ALI MUSYAFA', '75438615', '444abe4bbd878eb464824c7993389937', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114987', 'ALIFATUL KHOIRI', '63421458', '10e2df73cffe54dd9ade26aa68be00cb', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114988', 'ALMAS SYAFIQ', '65072449', '8667b700b3127c03b2974c3b0c61f2d7', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114989', 'ANISA RIA FEBRIYAN', '71975629', '52e194dd584996241beb88a2281a08aa', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114990', 'ARLAN ALFALAH', '58095871', '6e65768f6190da2d09a75453ed94809b', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114991', 'BAGAS ALI ROMADON', '59351844', '0d78233354847af85aeba903c40dec89', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114992', 'BAYU JANUAR', '65141098', '9ccba1791e55857f27f09f4981fbd619', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114993', 'DIAN SAPUTRA', '69058263', 'a0fd20632cb7e61ee3be8533a601a39c', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114994', 'ELIN RAHMADIANA', '56916144', '82c53ac6fbd873ca318b79f75f641105', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114996', 'FAHREZA WIRA LESMANA', '58385728', 'eed071457882a0501f1f4c09d5aa5131', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114997', 'FAJAR APRILIANTO', '52627420', 'd5bea1410de948aabda78580fddd6553', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114998', 'GALANG IMAN WIDHIANTO', '53419700', 'faeaf29bac11dd8a21120153b39b6dd4', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2114999', 'HAIKAL SAEFUL JAMIL', '64875743', '41767a1df86cc49896e1f9297068c1b2', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115000', 'IHSAN NURHALIM', '68753447', '2adda0353971403b0754a53790b8a7ea', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115001', 'IKHWATUN NISSA', '67103064', '9a27910180414bd96b9e57a57578a905', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115003', 'INTAN NURI DINANTI', '75056408', 'a82c28c2394b61278648ce53f63487b9', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115004', 'LUKI HERMAWAN', '66284380', '0bdb5322c7e7f86d4dbca494472b87b5', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115005', 'M NUR ALI SIDIK', '63907035', 'e8a1d94d1c5ab38689393cb1cdf0e967', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115006', 'MAULANA GENTA FAJRIANSYAH', '71519821', '269b242ceab82d8926877143276058ba', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115007', 'MAULIDATU AZALIA', '58138941', 'e9b1444a68c4413bbd6a26b75a987dcf', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115008', 'MEGA NANDA', '61389457', 'acd757bc35025a19fac9e071b84a5c55', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115009', 'MEI LANI PRIHATIN', '67733271', '593f30ffee875ec813ad5a10155c82fe', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115010', 'MESSI YATUL HAKIM', '65053054', '65b9d7b3c7c518c3d77da89b7222df26', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115011', 'MIRZA FIRMAN ATTORIQ', '3061633621', 'fbce8c0adbcfa77ed17b9e48c62f444f', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115013', 'MUHAMAD DESTA HERIA FEIANI', '3058582540', '9cc003bd7cf3f4d61e8809a67559e513', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115014', 'MUHAMAD RIFAL', '3042804490', 'aa6122266cffe78b2c003cd0fe28fe6c', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115015', 'NEZA SUGENG RIYADI', '55171571', '2e5573605f2b5a2a6b5a7abfc6de418c', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115016', 'PATMIL KHATUN', '48615846', '6029ddf58920c34daa3c41388711c322', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115017', 'RAHMA AMELIA MUMTAZAH', '69782820', 'aec1277798ef9798934d6b6a63fdc56f', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115018', 'REGINA SANDI RAMADHAN', '67902849', '0752228cbae04887a6b5ba40f2096029', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115019', 'REZA ABDUL FALAKH', '54673926', '2c908d203cf91daac85b480ddf2c00d3', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115020', 'SOFI MEILINA ZULFAH', '3069914743', '58efe5b5b152f46066d9eb2c4b77f062', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115021', 'SUCI ANJANI DWI LESTARI', '63972974', '38121d48476423fec7cacf5c4c62bad2', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115022', 'WAHYANI', '59582188', 'c3ec1cb2ec534407b133a6184ca5a0fe', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115023', 'WULAN ROMADONA RAKASIWI SUWOND', '62629758', 'c20f51bb222d30351a0f5d14900b47a0', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115024', 'ZAFIRA KHOERUNNISA', '3068430389', 'ae8e88225ab75717935e23347637418e', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115025', 'AHMAT PARIHIN', '54743358', '21df450c484a3f4ee6f9f126e77205cf', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115026', 'ANAM HIMAWAN', '44893170', '06c9736d02c8be1f0a51d27aabbef2f7', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115027', 'ANANDIQTA SUKMA PRAYOGI', '61762300', '3f98a0054344f98df1e0674defbd94dd', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115028', 'ANNA MARISA FITRI', '51133972', '90bbf100543d57e3faf69b69fb29e114', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115029', 'ANTENG YUDISTIRA', '67696853', 'c03521e4fd5844d384b3046eb8ef0d84', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115030', 'APRILA DANU WIRAWAN', '62129390', '95651d43a2ad092c6b1b86bef2539f25', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115031', 'ARAFI JUNIANTO NUGROHO', '65467600', '9a64c99efdd3c2cb9a30f40dfb519cd8', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115032', 'BAGAS WAHYU UTOMO', '3069879099', 'adcc61a266d05b63a79e7307b6577bab', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115033', 'BAYU RUDIANTO', '64184901', '16f36ffb322c1b1bd7b85173c4b1ba4a', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115034', 'DIDI ARIYANSAH', '62737521', 'bc0d282c5cac730c9bca3a96b084fb31', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115035', 'ERLIN KUSUMA WATI', '53455650', '7cb6fe9e49752551605a1ebf555049bc', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115036', 'FACHRI BUSYAIRI', '61902530', '230e033ac244fd737d6285a934692753', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115037', 'FAISAL AKBAR DWI SAPUTRA', '68811826', '93b7bfe3804073f03f11c3af7a76429e', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115038', 'FAJAR RIZQI RAMADHAN', '64507551', 'c3acf7042bc26bd654e54c23b96ff214', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115039', 'FARIS ADE WILDANI', '77535514', 'd90c3f29386a2ff4db1b0c5011f06bde', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115040', 'GALIH RAKA SIWI', '65442527', '391a4ca1fadcb6db9023f10fd5e24e3b', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115041', 'INDRIANA SULISTYANINGRUM', '62477806', 'c7fffae86f778fa472fd2cd2e158b433', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115042', 'INTAN SALSABILLA', '62189760', 'c05bae54d16b1e12c85873b624880f41', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115043', 'IRWANDANI', '55563702', '71e12a434ae686bc4f8becb1a923c9d5', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115044', 'KUMALA SALSABILA LESTARI', '3061572788', 'e27fdbc8134ddc07d4acda831a898381', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115045', 'LAELATUL MAGHFIROH', '61386521', 'cd20b83964cd6baa25755449f1cb2654', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115046', 'LUKI YUSUP AFANDI', '64154645', '22b6be38029e6460419242d925c842a4', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115047', 'MAULANA SAPUTRA', '3066398127', '9488af3436acb39cfa3d868626d2c2a7', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115048', 'MELISA AMELIA', '62094796', '06efe8124514be55e278d68ca2b78ee9', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115049', 'MEYZWA SHIVA KHAERUNNISA', '44737470', '67211b4b79a12b66d78edc5feacf7f00', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115050', 'MUHAMAD ALBARIGI ABDILLAH', '58110899', 'eb0fd72a45ead068821d4adb07a98d00', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115051', 'MUHAMAD HUSNI ZAKARIA', '56976301', 'faca8b4a94739a7cfcfa1103738fb68b', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115052', 'M ILMAL MAULANA AINAL YAQIN', '48908179', 'cfc3b7130d54859bfdda33a290fef0e9', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115053', 'MUHAMAD MAESA NURDIN', '65482096', 'f809b4600a44900dd061c357bdd8196f', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115054', 'MUHAMMAD RAFLI KURNIAWAN', '62061189', '2779d4e5503620676ab5664540f872de', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115055', 'NOVITA AYU WULANDARI', '68268152', '3634da3244c8379868a5b7fc9dd43b42', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115056', 'RANI SEPTIYANI', '59424162', '620ebdb257c3a2face2293d20da79b75', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115057', 'REZA SAPUTRA', '56206859', 'a95495910a987f32036317b6610440f8', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115058', 'RIYAN AFANDI', '63737988', '25926bb9790ba091237e37e68417578e', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115059', 'SALMAN ZAKY', '63760498', 'e97eabb2759dae1b0900975203853d51', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115061', 'VILLARSIH WIDIYA ASTUTI', '66454280', 'fcb5f4bd53f38a1be2fe012d6901fbd2', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115062', 'WILDAN HIDAYAT', '53173934', '4d2bbae8b32bc53e3dea206b4eb2ccfa', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115063', 'YASTIKA JUNIAR', '69837867', '2e8fc6f2d41f6af7b992d006ce15ebc3', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115064', 'ZAENAL ARIFIN', '65173123', 'a8da3a32465b09b4c382ad81671fc7b9', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115065', 'ZASKYA MAULA AZNI', '67221179', '3d5135c8e1f82d74627605f6e1f86a08', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115066', 'ALIF HUSNI MUBAROK', '3067844195', '6d0aefa3703aabbe08d76f85e6fe2767', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115067', 'ARJUNA SAPUTRA', '65104927', '39b7aa8a9e8619935f0476acdc1196c2', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115068', 'ARKA YUSUF FAHARJO', '61274572', 'aec0def0b03996548c94a3e721fd09c1', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115069', 'ASEF ABDAN SYAKURO', '56597038', '6ed3a9e97db378929c0aa8269410cadf', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115070', 'ASY SYFA NURFAUZIZAH', '56435241', '3482aa18369f95acef85653e2edb4ead', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115071', 'ATSAY PAWANDA', '62667325', '1190b96067a98683fa6a644f2d8d4a2d', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115072', 'AZRIL AISALIL MUSHOFA', '69066219', 'a4425dc971c94d6b955bb9dc3ca8f782', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115073', 'BAGAS FAQIYUDIN', '62635493', 'fe9975daf8f219b646e1f2084d1e5ea5', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115074', 'BAGAS SUSANTO', '67024321', '7cf24346187569941076cd94508ada3e', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115075', 'BAYU SAKETI', '51440191', 'c7a41665a01d9bee1dddfff920de6930', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115076', 'DENIS AULIA AGUSTIN', '69482993', '5e84e44f2009a0a8c7eef6c6fa7aa941', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115077', 'FAJAR ARIYANTO', '66493282', '0d7c283967ffc4fbdf0d2dbcc8ea3eab', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115078', 'FAQIH EKA SATRIA', '68396362', '813d950f9a7899282e8d6b9eda96f9d8', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115079', 'FAZA CHOIRON', '61424030', '5e4ac2e7fb47a9c192c7806a3d26cd3a', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115080', 'FIKRI NAJMU SAQIB', '64280501', 'b379cad2916afd7eace5927389722249', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115081', 'HARIS SASONGKO', '64536775', '012ae8030df0f54f36eaad7db9abfa52', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115083', 'ISABELA', '53419181', '96695d8316c104933bf3dcf9b54e96cd', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115084', 'JIAN MAULANA', '65945727', 'b3c0213e4dc515ac40227d904ed9d4be', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115085', 'KHAFIQ KHAFIYAH', '3066893660', '9b6e1d443493b91b1744b49420919202', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115086', 'KHUSNUL SAPUTRA', '63989379', '06501243932e9b7cc4f5a9c1440ea275', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115087', 'LAELY NOER IZZATI', '44987464', '3008e829dfd7abcf8f22e4e261265d72', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115088', 'MAULANA YORDA', '78560861', '5e92d0c97e9560835f0e3194baee0f39', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115089', 'MUFTATIKHATUSSALIS', '65318446', 'bab840ffb784bd9aab656d8c7ebb5c28', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115090', 'ISMAYANA', '66895652', '818f13f82367ce8da0e5d1e644ba978f', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115091', 'MUHAMAD REZA UMAMI', '3066651156', 'b2f7ec8607e5947a5617d45a1c7d6e0a', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115092', 'MUHAMAD RIDHO RAMADANI', '67767179', '4870ffb1734d9f5572b53e4eaf7b142e', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115093', 'MUHAMMAD ELDI DAROJAT PUTRA HI', '3051582784', '8da43fb8c51d11663241c8988fa7230b', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115094', 'MUHAMMAD NIZAR ARZU', '55379725', 'cfc2a658ff7bdeeedaa78084939f2169', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115095', 'MUHAMMAD RAFLI RAMADHANI', '3058896243', '38f4403017b6a74dd3f57456a017b7b8', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115096', 'MUHAMMAD ZACKY HIDAYATULLAH', '65191529', 'a2b9e3e53975b46b92b8b470fe84aef1', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115097', 'MUSFIROTUN NIMAH', '64785088', '91f2e76e7392131e09fdf7e9bb090830', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115098', 'NANDA MARTHALIA SHAFARIANTI', '68277748', '75e8ac6deb63e6acb8e762b48e04da9e', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115099', 'REFA MUTIA ARFANDI', '67442507', 'd145bb36e5b3b1f01bd17998f6ae27ad', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115100', 'REZA PUTRA PRATAMA', '46593248', '8c7c158724ad41641c9c1ec2ab98f0a0', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115101', 'RIYAN PRASTIYO', '63957792', '9047ad2c95c8f8ff0ca105235f4e9095', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115102', 'SALSA ATIKA SARI', '64006571', 'b55eed0b18e425fd08dcd023357549fb', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115103', 'UNTUNG ADE SETIAWAN', '44893524', '4a6db71e6c44bc265636aa86af7d3f23', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115104', 'WINDA APRILIYANTI', '64296234', '3fb3e7e8cf8cc8ce4803546f6b9e2a97', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115105', 'WITNO SUGIANTO', '46548739', '892c41c025ce2566a721efdad307c6c4', 'L', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115106', 'YULITA BUDI UTAMI', '44496950', 'bcf1ce8979c1aae8906407faa275eb38', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115107', 'ZULVIA NAHDATUN AIS', '3051488293', '5570f10296eb3a9ddbc9a30aeebb1927', 'P', 'mm', NULL, NULL, '', NULL, NULL, NULL),
('2115108', 'ABDUL MUTAKIM', '66453548', 'b8fa446065e3645e16937cce145851d8', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115109', 'AFNI MEI SUROH', '68498839', 'aaab53230c58d377022a84a5d19ffff8', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115110', 'AHMAD SLAMET', '67637802', 'dfe4e3e248d38a2dce7666beee0c02b6', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115111', 'AJENG DWI SETIANINGSIH', '60217878', 'b0ec637d454ab9f665c1d7a63833c88c', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115112', 'ALAMSYAH AGIL ARRIZIQ', '69424745', '23859a7941a5d7680d50c91db84419c5', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115113', 'ALI MUKTI', '64442746', 'df85d0b8c16e52773c967d8c40a17909', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115114', 'AMAR SAEFUDIN', '69024819', 'b7e4eda60515001818b7444391db9ceb', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115115', 'ARINIA AGUSTIN', '68605912', 'cc7b0146dc7d75bb87b9f6d8ee9c3192', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115116', 'AULA DAFFA RAMADHANI', '55967604', '17f6c3e09c7dcbe15cd781d32e9ceb0e', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115117', 'DESFITA TRIJAYANTI', '65243169', '01cf1de18e11d94af1d34b10681d5659', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115118', 'DEVINA ARIANI PUTRI', '69537163', '0bc683f258fd510554e7f181efb9b21d', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115119', 'DIKA ARYA SAPUTRA', '56645885', '269b8f3f678106f092729e44efb87fbd', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115120', 'DIMAS DWI SETIAWAN', '61891160', '644cb7463546178549bb89c0a1bdcceb', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115121', 'DIVA NABILA SANIK', '69232448', '182902b816d1d379aaba4a9dbe75d645', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115122', 'FEBRIANA ANNISA', '63198372', '1193492326d743ca16a0d2e7e7e9501b', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115123', 'FITRIANI NUR KHAZIZAH', '61421291', '5240a8047c49dadc4af70c56634e1188', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115124', 'GALAH ANGGAR KUSUMA', '67200919', '71897104a45e65119692cf25073cd626', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115125', 'GISTA AULIA', '72043824', '8327a165e0e9714b850b0efabe3485e0', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115126', 'HADI TURMINO', '51639287', '64d42c42967cf9feab8a0a6256adb041', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115127', 'ILHAM IGO SATRIO', '44547467', 'ae0187267674b1fece64246fb9ea9100', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115128', 'JIHAN KAMILA', '3068442785', 'f8155d2020569c813be21c98fb027bea', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115129', 'KEISYALUNA DWI MAANI', '75756384', '879bf081b03907eb53e35c698299bbc4', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115130', 'MAYRIO DWI ALFIYAN', '82471551', 'c258c4a1245b029a891d1e900047893a', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115131', 'MEISA NAELI SOLIHAH', '3063894084', 'be26214b992d6a48a2fad71376d165c2', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115132', 'MUHAMMAD RISWANDI', '63560127', 'd52373dd5d414731231dd103e0d57e47', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115133', 'MUHAMAD SAFARUDIN', '68284250', '42e0e7ef7124c66bb063f46cb67f0cf3', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115134', 'MUHAMMAD SOHIBUL MIRBAT AL-AKB', '45366202', '8bd1ba399abdac88348db07122a6724c', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115135', 'MUNASATI NISA APRILIANI', '67225562', '7f9a14bcafaa1746d4f34591ebee014e', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115136', 'NAZILA PANGESTU', '63925402', '065d147bfd062534c47dc71316fb4d25', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115137', 'NIHAYATUS SAADAH', '64738942', '254416106aa49ada5ea6d13c22f33141', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115138', 'NOVAL SAPUTRA', '64120730', '75b9dc3218cca444ab77af6a7fe75741', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115139', 'NOVITA PUJI ASTUTI', '76173302', 'ba6949a8e22fb891ee59ec53ad83ad62', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115140', 'PUTRI AYU WULANDARI', '63483756', 'd1e8d269683c7b98399a6669554f7bd7', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115142', 'REGINA AFRILLA', '62576499', '21e21303c80adcb6f5194799581f99d0', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115143', 'RERE AFFANA', '67994229', 'a646e467a5bbc7406201535d6d77c3f5', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115144', 'RINA RAHMAWATI', '47138203', 'e1a1c2915fe09ceb3d26521b492ce270', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115145', 'RIZAT MUFARIZ', '68578363', 'cdad020e0744376714cd091818a63935', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115146', 'SUPRIYADI', '53419607', '50fa64c0a0447c5c3d45bf74d038c920', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115147', 'TEGAR ARDIANSAH', '60217915', 'dc779f66f83f951e389730bffe7e05c8', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115148', 'VIKKA NATASYA', '66095390', 'fed7f9ccc3afd964c1947aa4d5749f26', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115150', 'ADITIYA MUHSININ', '62066120', '11b5c5e6ade2ecebf86a17264a78180c', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115151', 'AGUNG KURNIAWAN', '55795926', '70522063d35effdd8e84efaa3595b6ca', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115152', 'AIDI ULIL ALBAB', '67179097', 'bc499ae160589c2d782dbab880042be8', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115153', 'ANANTI ISTI', '3067594478', 'ad46fca3ae2c943eb5f503d86aca75f8', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115154', 'ANDINI KHOERUNNISA', '3067154278', '7b68fe8659ee7ad9002f259d2167f645', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115155', 'ANGGI YULIANA SAFARA', '72593667', 'f593b3b7b455fe42238e1d40cc5bd0ee', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115156', 'ANISYA FEBRIYANTI', '65138877', 'c07169c07a99bd90d33ff4889db3eb39', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115157', 'AZAHWA MAOZA', '64345185', 'cdfa516bb7fc318f6bd227fc2d1221d4', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115158', 'CHELSEA RAFA NATASYA', '79537420', '5c9a24ba3fe9f93822302dd2f08a2fc0', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115159', 'DELA LESTARI', '57776620', '8573e6c1b37590b1eb1b8254c37875cc', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115160', 'DESTIATUL ISLAMI', '65347620', 'b5456ae7d76722c411a61663e57d5c43', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115161', 'DIAH ANANDA PUTRI', '61006125', 'a2174ecea38c1d8b3bd642e8df31897e', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115162', 'DIVA VIRGINAA CLAUDYA ERLANGGA', '3066935446', '33e3a7d8e5b58f90f154c8d4286bb55b', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115163', 'DWI HARYANTI', '66104574', 'c6c042910581e95def928bea289d41ed', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115164', 'EKA FEBIOLA', '74191209', 'f7d0fe31f5a470000f18bd6d5b37338d', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115165', 'FANAYA KHOERUNNISA', '67006319', 'be1755eb5a66bd7ece46aecb5edb7a47', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115166', 'FANY RAHMA DANI', '57602370', 'd1fa48a2837750c03a9a2200701ec57c', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115167', 'FAUZIAH FITRIANA', '61493108', '8173483d8ddef29c892e42ba2c71b045', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115168', 'FIRMAN RIYADI', '65659722', '9843fad093234974c5154589340bf9b4', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115169', 'INA AGUSTIN ALKHOSANI', '64592705', 'c37880a8d400c28d7084139aea237891', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115170', 'JUANDA ALFA SENO', '51985106', 'fa318b0a8f4d8d28b4a569dd7feace61', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115171', 'KHALIF MAULANA', '66307340', '309d7bff7a47f070e0488c490f885980', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115172', 'LAELA MUNZILATUL ROHMAH', '67029052', '020097231563482701775608307b492b', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115173', 'LIA FEBRIANITA', '64984643', 'b43cf491559bb5d3d87429548daecac8', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115174', 'MELANI', '55028417', 'a9f078c01320d23d91f8e222eb19c039', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115175', 'MOH RIFKI MAULANA', '74286584', '292a7aa8eb3c4c3da30da2ee9ea70d8f', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115176', 'MOZZA ABDI FIRDAUS', '85686758', '8d4a3ffb95ddd2357ed1837f7fcb4d9a', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115177', 'MUHAMAD HAFIZ', '44044846', 'a80159b229e5cfa178cb3c89f701a07e', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115178', 'MUHAMAD VIGO ALBAR JANUAR', '65045173', '45fcd0973362d2c0e5115fd84c97e8f4', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115179', 'M WAL NUR ARIF', '51864078', 'f6f6c99653c1cf190136a301f212d73b', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115180', 'NESA DESTIANAH PUTRI', '51719236', 'db3d16e17b3a30e4e5887cad9d19aad6', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115181', 'NUNUN ASIYATUN', '68792516', '10aabc02be7bd41040c075b0488b12b5', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115182', 'NURKHOLIS MAJID', '3065540415', 'd6ae3def3e3e7810059c70d3c0cae968', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115183', 'NURTIA ANDRIANA', '65530363', 'aa898b57f09d628de303cf839c53431c', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115184', 'RAGIL YANUAR SUSILO', '65924949', '0eaa1b9825d306f36aede028053436d5', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115185', 'RESTI UMULLINA', '64876369', '506193a4e04498b47c3e77da5123558c', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115186', 'SATRIO ADI', '64086226', '35d72c4bf0c29e5d30b391c81a64a0da', 'L', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115187', 'SIFA FILIANA', '68638656', 'd5f067f83e65b9ecec9c5360e16e1252', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115188', 'SHAFA DHINI ZAYANTI', '73491326', '8e6c376030494820de9319fc083fb387', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115189', 'TINA PUSPITASARI', '77252383', '4a44e48d22ed2c4c04c94d0f7a11499b', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115190', 'WULAN ROHMADONAH', '64955183', '8e1043fb1f69a2d2473bb0d8ebb4e62b', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115191', 'ZAKILA MESA DEA AULIA', '3067786387', '93650f582117c7f03c67057482a9d8b8', 'P', 'ps', NULL, NULL, '', NULL, NULL, NULL),
('2115192', 'ADINDA OKTAVIA RAHMA', '62484294', '31d1e5ca6396d9360c97616656a5dd93', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115193', 'ANGGI ANGGARA SAMUDRA', '65640797', 'd723c163a935e4ac8876fbdf742d264f', 'L', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115195', 'ATIK UZAENIYAH', '65534998', 'fe06ed467f53eccffdb7e88f4aeb3b18', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115196', 'AYU NIR ROHMAH', '53888292', '8552a3027b65b552c35d35619f421edc', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115197', 'DELA TRI NUR AZIZAH', '51715893', 'd86c067d5e98302e146a3e1a287b4f2b', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115198', 'DELVIA RAHMANDA', '53504648', 'cb7624ae077344744f11d9de5bd92b85', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115199', 'DINI NURSIFA DIKRIATUN', '52046974', 'fd4a16af380d4776d6e5438834099620', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115200', 'DWI APRIYANTI', '66433369', '7d00efa846bc55059790df9ad132a04d', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115201', 'ELSA AMELIYA', '64361875', '66e37277b37f76b46e04b2961cab03d3', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115202', 'EVA RAHMA DANI', '63922609', '32dc276bcdd7c7e277fdabd8d94180ad', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115203', 'FITA NUR AZIMAH', '51693334', '74bc1ea7013887fe01056187c9b6b6ff', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115204', 'HOESA AGUSTINA', '69852611', 'adc1dcae9bce590d2e03f20e5f66da5c', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115205', 'INDAH NUR AGUSTINA', '61653536', '4a172db36492abe9ee7cbd49cd5bad8a', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115206', 'INTAN FAUZIYAH', '52617221', 'b8f81d57f89d2c1a4ffc05f94c47442d', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115207', 'ISNAENI AULIYA', '59979476', '81bcffe4c4ca8c83f4b8d620b72c552f', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115208', 'JENAR KESA MAULANA', '71455663', '5d83dac750dad2187e152f867f89bb36', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115209', 'KARINA ISMATUL HAWA', '63062882', '6f6cc27c7c60885946a67308b05926fa', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115210', 'KRISTIANA AFNI', '68837148', '1d59e1fa8d00ec7897727a606958594a', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115211', 'LAILATUL KHOIRIYAH', '3067516439', 'bd5c2f03d6cfca6d1e45f1592777d156', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115212', 'MUHAMAD JAMALU RIZQI', '46933452', '86c3a30253c9b97c740d26041dc0eb15', 'L', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115213', 'MAULIDIA MAHARANI HUMERA', '68237112', '5c8ccf0c6ad6e493e19e297a1a413087', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115214', 'NADIA ZULFA', '65155097', '555d74197473067747ff31b58784971e', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115215', 'NADINI APRILIANI ADIBAH', '62184978', '306896ecf3649f25d551e81b7f0aa1df', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115216', 'NASYA AYU SEPTIYANI', '68548491', '6d6d422a7d9f50a3f0f300d851ab0211', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115217', 'NESYA AMELIA PUTRI', '66378940', '26937c1b4917511debd76cc2191f2fee', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115218', 'NISRINA MAHFUDLOH', '65236178', '5f3af0f355c10006a1feb2dfeda7b762', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115219', 'NOVITA', '51308692', 'fd1fad2d229dabbd8ac6f214a8b6ab19', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115220', 'NURUL AWALIYAH', '55959314', 'f6d5c2724b32eaa3d269f1eb5e7c2d58', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115221', 'PUTRI AULIA DWI YANTI', '67726669', '9deade1dda05c947520b41ca22960e30', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115222', 'RANDI TRIS SAPUTRA', '64418977', '543b618dc972030a351bc35ddf7bf347', 'L', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115223', 'RINI SETIAWATI', '54075389', 'f1045f07b876da1277e7eac38de09557', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115224', 'RIZKA KAMILA', '51683735', '1dfdf1e87230c69c1610b4013957c74d', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115225', 'SABILA MUSYAFENA', '62667700', '001b430c0faed8913c7b7b0a7c8dc7c9', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115226', 'SELVIANA AULIA', '68793702', '99a64d8a32b55d50bf70ddc15a5e9aeb', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115227', 'SEPTIANI AYU LESTARI', '66456576', '8e5c5c082f7f9b62972d5d8d6773aeb5', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115229', 'TAUFIQUL HAKIM', '3050353076', 'c147060f35f46eefdf277e1908629986', 'L', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115230', 'TRISNA KURNIATI', '67343484', '297746500f76367f398a12d4ce360822', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115231', 'VINA NADIYA', '58940828', 'b9797accb435cb6570180246b750aeb0', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115232', 'YULIANA', '64068563', 'da2db53137a3a487cb0c31c94a9c216c', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115233', 'ZARINA', '46580585', 'fc037883bd1f5c8a63f0712a49c2bbce', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115234', 'ALDI SAPUTRA', '56906892', '5e8be47036c21d7d000387ef1bee00f9', 'L', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115235', 'ANIQ ILMA FIRDAUSI', '63873265', '7bb7d8dc87554ae195d3f6d77998b1cc', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115236', 'ASYFA ASFIA', '57008271', '8d9d3739e54770442f611b83d126db56', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115237', 'AULIYA FATIHATIL LATIFAH', '68463607', '1d78faa281ce6e56b63dbfaea840889f', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115238', 'BINTAN KHARISMATU FARDAH', '77287934', 'dee541eecd3f06dbaea1b8147385ccbf', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115239', 'DELISTA SASTA REVALINA', '75853440', 'babc6f249ee7c00a0f18049cc8ce601e', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115240', 'DINDA SEPTIAWATI', '68496599', '285070827d9d91bce881b0a162a4e47c', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115241', 'DINNY AULIYA ALMAS', '66075748', 'bef8797f217703f0c9f11d9c461ea6d9', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115242', 'DWI LARASATI', '55798053', '5accef983ceb3fe662461f780f48d448', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115243', 'ESTU MULIANINGSIH', '67271056', 'c97770f0235416e05684c7c1736217cd', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115245', 'GITA AYU KIRANA', '61267648', '1c57acb40784086e3aac868a92ed2f27', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115246', 'IBNI ALVANIA', '73917173', '5bd9b702aa935874ded22bc3fa112be1', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115247', 'INDANA ZULFI', '62163085', '18f8f27de61d5a120558cdea4bfc7c7f', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115248', 'IRGI ALVIANSAH', '67058412', '8f77cb333ba83755e85685c815c1145c', 'L', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115249', 'IXLIMA NURZANZANI', '67834356', '071f721c0447eca5ed4703f6e98dca53', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115250', 'JULIANA MELISA', '64373753', 'dd8c10f14be19bb1f98d0783dfced36e', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115251', 'KHARISATUL MAULA', '68647863', '398e5b3de41a7bce1b36579a079ce006', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115252', 'KINAN EGI RAMADHANI', '3069649655', '1b4c48bcf37c19c61e376db188f3c768', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115253', 'LILI AMBARWATI', '58805943', '667af790c82767d8fd39b7b88bdc6e72', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115254', 'MAHFUDHOTUN NISA', '76108801', 'e056d10f681a001cb487d69cb1b3cbfb', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115255', 'MOH ATHIR NADHIF', '3067214053', 'b002d3ca2849af1fb2bcd83410d1f7c2', 'L', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115256', 'MUHAMAD DWI GONO', '3051796368', '5d6a6d7ad22b1cc6e70d6d9e4e5d0c71', 'L', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115257', 'NADIRA ANGGRAENI', '66766951', 'b54581c0393942eadf27ef4e18cbc6aa', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115258', 'NAZILA ISMATUL HAWA', '52823182', '12bda65c6e43defefff53b2c967ca824', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115259', 'NESYA SAFITRI', '59961396', 'a5b0eae55fae7a905db1022ed9953c05', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115260', 'NOGITASARI', '67293460', '31b32cdfaecbecc463feff8200e0bc7b', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115261', 'NUR KHIKMAH', '61375072', '8ad07820d4c2f407811fc7f4b6ff938b', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115262', 'OKTA FIKRIYATUN HAZIZAH', '61972462', '68dc479998145a5bce5bfc292fa627ac', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115263', 'REGINA AYU JELITA', '78564066', 'bdb168a80b6e754edac47b667ead3a9d', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115264', 'RENITA REFALINA AGUSTIN', '68535469', '3250a0dce93834011782a82d7c00c070', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115265', 'RINTAN SEPTIANI ROHMI', '65802270', '0b1bf6a3d6de75093e254d48180fae6d', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115266', 'RIZKI AMANAHILLAH', '67143409', 'faac3f1b0c91e6ad3f56337c591c5811', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115268', 'SILVIANA RIZKI', '49501537', 'e94276c9beb73e339109f264c3722b33', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115269', 'SITI NURFADILAH', '66561207', '1a12ebcbfab17a606766c200eda2dfe1', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115270', 'SYIFA UR ROHMAH', '61062041', '78e61a1dca2c9fc405c65e2a8f3c58f8', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL);
INSERT INTO `siswa` (`nipd`, `nama`, `nisn`, `password`, `jk`, `jurusan_id`, `no_hp`, `email`, `alamat`, `tempat_lahir`, `tanggal_lahir`, `asal_sekolah`) VALUES
('2115271', 'TIA MAULIDA', '65339751', '6af5f43928c5638ca24a900814c68e83', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115272', 'UKHTUNNISA UMI NASIROH', '65194901', 'f4832a18dce65a1a5ef3bce5314fb985', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115273', 'WILDA KHOIRUNNISA', '66831522', '68313d9757d48fb4d0d6087da409bc04', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115274', 'ZAHWA MAE SAFIRA', '76435717', 'ea704f8ea31b3085c509771ba3001f3b', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115275', 'ZUWAENATA ADRIYANI', '52120132', 'b8a5f57441af4c3ef23b0f7e3d0c4071', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115276', 'ANANDA ADELITA IZATI', '68937617', 'a3083ca59fcbf2554c844d7d2445341b', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115277', 'ANNISA KURNIASIH', '61487811', '93fc4e9fce57c672751fbe4b3b61541b', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115278', 'ATIK AL AZIZAH', '75767027', '44d0ebb396da62892ee34967f5239291', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115279', 'AYU EKA SULISTIA', '76763198', '8346f0dc06b78e4c8a83375262cead2a', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115280', 'CELSI CLAUDIA INDIASARI', '64546832', 'a71b6ee793176bfcd36ff66e727e8ee3', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115281', 'DELLA ALYSA SALSABILA', '69446929', '18775c85d8cca118286da0c8a4cee7a9', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115282', 'DENI KURNIAWAN', '67891430', '4a2074ec7a04e70ce63a699982673210', 'L', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115283', 'DUROTUN NASIHAH', '3044555775', '543933992977ce3a5938ec2d0a78fc58', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115284', 'EKA LYDIA LEILANY', '79075982', '10b120708485c34d527ad385bf6e7cfc', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115285', 'ERSA SETIA DAMAYANTI', '69828662', '05c189af685264500fb737a5f717ad9c', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115286', 'FIKRIA ALLIFFIA', '63656559', '8835cee1ec73e02016671078e0fc2528', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115287', 'GITA DIAN RAHMAWATI AM', '52722178', 'ada4b5c4bbe23aff0316038e1362abc5', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115288', 'INAYATUL PITROH', '59965698', 'd413e689d1e6f6bb225298de2199a598', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115289', 'INEZ DEWI SASMITA', '64010500', '5113dbc132514639b88c93b2db06983a', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115290', 'ISABITA ARIFASYARAFINA', '65932560', 'e89d504b3ddfc5bdd4c142d634b7f2d8', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115291', 'IZA UMAMI', '69833445', '59154318bb7c20f755bea3b952d690c4', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115292', 'KALISTA LIDIYANA', '79675858', 'f037f91736654139dd8f71bc63b9a27b', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115293', 'KHOERUL BACHTIAR', '75003758', '2653e83e0c1a0d48fd5aec5eea5cb93d', 'L', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115294', 'KUN NAJMI FITRI RIZKIYA', '54660180', 'bb5287c241687d421c66312d6e580e8f', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115295', 'LUSIANA OKTAVIRANI SAFITRI', '67714506', '26c1e176eb94f9940952fe15e120e90a', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115296', 'MAULIDA NUR HIDAYAH', '69329617', '9044e6ca3fddba801c3c3e3895f24a9f', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115297', 'MUFTIANA NURHIKMAH', '67012514', '87d24c21386e0734bdf3a6588496751c', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115298', 'M AZZRIL NAJIB INDRIYANTO', '63417641', '539e4d5a7eac645d506ebbdb7ce16671', 'L', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115299', 'NAELLATUL HIKAMAH', '61055904', '60761bf6a207b917e87a85f3ace4beb7', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115300', 'NAZWA AMALIA', '62276590', 'a5d74d319b2a5b826c9adf5e78c6e91d', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115301', 'NINA MELINDA', '65229319', '40a82a47fd81e08daeb8048e480462dd', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115302', 'NOVI FITRIANI', '3047839878', 'f797d4e6c01ba64aa3a51653287ca6cc', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115303', 'NURSYAYIDATINA KHUMAIROH', '3063421696', '6a6d9bd57bdb79c1131579b4e4aa568e', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115304', 'PINA MUKAROMAH', '58986404', 'db62fa5f1b1ff95a39c65022f432169c', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115305', 'REFI ARFI ANDANI', '66975847', '80b66736f527512389e35befd08af5c3', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115306', 'REVINA RAMADHANI', '67081240', '69084f9e4a1374b49acb6dd9adff0ac5', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115307', 'RISKA MUSFITASARI', '62772393', '937d440afeb016b394ca951008d00ed1', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115308', 'ROSITA AMELIA', '64349358', '23673b61d1004289a80b8ce4cd75f64b', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115309', 'SINDI FAJAR SEPTIANI', '63775300', '56719c1aef1dca41aeea7e3dc5681e37', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115310', 'SIVA IKHWATUN HASANAH', '3064094272', '98596187c98085cd885f3ea24d9f878d', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115311', 'SOPANDI', '47745260', '85d0016122d036bacdf78c7f348237d7', 'L', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115312', 'TASYA KALISTA ADELIYA', '52302783', '5f2eca40fe1cb72620c562b551517072', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115313', 'TIA NOVIANA', '69157123', '2d594f3c8ec209dbc7ef974852ba287c', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115314', 'VINA AGUSTIN', '3068060967', '2e29415e5d4b68a333460886692bd446', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115315', 'WINDA RAHMAWATI', '62701187', '6b57f0453f86833c85e03c207e2b673b', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115316', 'ZALIYA PUTRI', '69213504', 'a1f17c2dd5f35d37a3f521a6d9a87c1f', 'P', 'ak', NULL, NULL, '', NULL, NULL, NULL),
('2115317', 'ABDUL ROJAK', '65686851', '0dc44112e076727ed80997c302fdaa1e', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115318', 'ADETIA KURNIAWAN', '68777408', 'eb6212bf481cb8f294bf307b7758c544', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115319', 'AHMAD FAJRI', '51448789', 'fa61196eba10a83b932fbd1da358436a', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115320', 'AHMAD MUDHOFAR', '66408572', 'f31ff2600c361acfbb756ff35453c884', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115321', 'AKMAL MUNTHOFIK', '57767022', '1fceb9a961f50013bea20c184b713190', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115322', 'ALFIN NASIKHUDDIN', '58215944', '5ea6f22ae95e05ace7d7875cd6b8ae06', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115323', 'AMAR', '66060053', '1906fcef38a24021aaac605bcbbaa48d', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115324', 'ANGGA ALFIANSYAH', '54348723', 'cc9b47e2b9e6db3cb92315559671405d', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115325', 'ARFA ARINAL ARDA', '66227097', '662c1740f0b385945268ff8066362371', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115326', 'ARIP MAULANA', '56642956', '0f2fc71e0b7fd2ff38bd9a1442a086f2', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115327', 'AZKA AMRI FUADI', '69137417', '5f1146fcb10a09af4a93db9cfdd3a61e', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115328', 'BAGUS SATRIYO', '62789542', '31715ddc4ed2dbffc7be98a0eb0ea5f3', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115329', 'DAPIT SUPRATMAN', '67696874', '8faa161a2183a085a7c872dbf1586e5d', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115330', 'DENI FAOZI WIBOWO', '67337093', 'c40ba033d11f4656eb0efa10848feac9', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115331', 'DESTA MAULANA', '69317397', 'ad2da6f76bcbab8ace467115862c1831', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115332', 'ERGA RAMALA KUDUNGGA', '61947534', 'ebb7fd51924f4e8f8345d874797f19b7', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115333', 'FAIZAL RAMADHAN PRASETIO', '59487686', 'a53fc8546cb2403d6ae46701fed4b165', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115334', 'FATHUR DEKA NIZAR', '56675374', '9191631674ad7f02c33befbeb6135d4a', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115335', 'GABRIEL AHMAD ZAKI', '75679020', '79db9222bb506a38bb68632ad7940bc3', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115336', 'HAKIM SENA MUAVA', '55784270', '61012836235fb64acf12fad9fa3411f0', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115337', 'IKBAL AJI SAPUTRA', '67098798', '3d3f47d15f29db10009101b55dadd708', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115338', 'IQBAL CHOERUL ANAM', '69023134', '9a93061b5d84dd3fe9f60342fc8a3cae', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115339', 'JODI SETIAWAN', '59852149', '0013f7546bd4a4ffa7d59addd678631b', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115340', 'KHOTIBUL UMAM', '63853434', '821538741aa20b29ccd5949fbf32895e', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115341', 'MOHAMAD ARYA MAULIDI PRATAMA', '63663223', '46192981561ab5ed85dfb1c17b4149f3', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115342', 'MUHAMAD AKROM KHASANI', '68546706', 'a15d9a3d7dad28b3cc6967ad6d9b85e8', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115343', 'MUHAMAD ARIF SAHERA', '63787952', 'a88c0d641f567e9e6758fdde24d2b40c', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115344', 'MUHAMAD AZIQIN', '53197760', 'df0baa8fc4169062d45bfc7a41efb68a', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115345', 'MUHAMAD FAHMI RIZQI', '47511847', '08eff91c581011f8b19a03de7a5a54a4', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115346', 'MUHAMAD HAFITZ MAULANA RAMADHA', '61153893', '97c70cd21f0f4e269a01cdea27223f61', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115347', 'MUHAMAD LUTFIL AZIZ', '55603675', '7c395b8faecbac5e529b41f1edd28efb', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115348', 'MUHAMAD NAZIRUL AZIZ', '3051983993', 'b54e612a5408a8482bef46f104029792', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115349', 'MUHAMMAD AINUL WAFA', '57355941', '36108d3dffa01c6e98f605388cc2a289', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115350', 'MUHAMMAD FAOZI', '53618098', '033b2d422624eae99e99089847a1abd4', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115351', 'NANDA NURDHANA', '64466214', 'ec45f04a8227df4c9aa172947523222a', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115352', 'REIHAN PUTRA RAMADHAN', '3061101306', '6868eb980188bd0344aecdb47b78d5c2', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115353', 'RIFQI HILMI NAZAR', '3061813496', 'bba6a60d22695ee82e99923eeb88cdca', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115354', 'RIZAL ARIFIAN', '63845594', '9d4e58953e54d720a5cf3c19ffd18a8d', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115355', 'SLAMET', '41009937', '40a4f6f0523d199d02c5df4e274c31a7', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115356', 'TEGAR AJI SAPUTRA', '61712641', 'b3d08299d1624d6fffa1a81e224bf2f5', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115357', 'YANUAR ISNANTO', '62986546', 'd2e4e49f174c58a90efe4bda1afea7bc', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115358', 'ZAKY HENDRA AL FAQIH', '48101214', '6d165252020820038a0c0220fdd2033f', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115359', 'ABY RIZKI HIDAYATULLOH', '62573361', '670d40a2e08b3df7abf17b382b607cde', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115360', 'AGIS MAULANA RIZIQ', '68427800', '1c100260fb29582993d80312f3e58abf', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115361', 'AHMAD ISKANDAR RISKI', '51926011', '6b895fc9365a22912430103c8ea26aad', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115362', 'AHMES SABITUL AZMI', '52968880', 'e7ef619f56d820e7fe0afb0eea04a21f', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115363', 'ALDI', '46615942', 'ac22d754402a29299b9446880933a0c3', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115364', 'ALI CHAMIM', '59076171', 'b68680ad87ba64355a8a2f948ac9766e', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115365', 'ANDHIKA GYMNAS RIFALSYA', '61896049', 'ddb2edc67a65505434eaa521a04392b7', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115366', 'ARDIAN SYAHRONI', '68898971', '7e43c1f8d2d5a24e2595eca061a8456c', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115367', 'ARIFUDIN', '49909985', 'f78c4745899a83210e1079de66b24d63', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115368', 'ARIS IRMAWAN', '3065398967', '27c0524e451dce1fe9ac1efbcccb06b1', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115369', 'BAGUS SAPUTRA', '34100440', '09933fedae538c5b566d964cbeebb1b0', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115370', 'BINTANG SETIAWAN SAPUTRA', '65471304', 'd90f1f112ace2c1cd975f9cb01347d84', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115372', 'DENIS FERDIANSYAH ROMADHON', '66273097', '81c45ea166d9ccce097846c664ffb361', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115373', 'DONI ARIF MAULANA', '67282581', 'e5e8b559a9f681a9628b88f5dfd5483d', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115374', 'FADIL EKA SAPUTRA', '67878069', 'afc5321dc707027409402ed9213ac756', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115375', 'FAJAR ILHAM ROMADON', '55929217', '0da168436bf1aabfbb5a41594ae3ea53', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115376', 'FAZA ANDHIKA PRATAMA', '3050948283', '112231e7a618905b7a5489e625f36e67', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115377', 'GATOT WAHYONO', '73670947', 'dd8a35ca54e75c8160d87c6c46e65616', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115378', 'HARIS ARMAN AKHSANI', '65886223', '727577687a4aaa3514d60b53f0e24c15', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115379', 'ILHAM KHAIRUMAN', '3075968267', '140707e633d5874099dea11327b9b2ac', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115380', 'IRKHAM DAFA SAPUTRA', '62830872', 'efeeb36227226053583489a604138985', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115382', 'M NIZAR KHOERU ZAKI', '57013542', '89a500403e23ba3c5ddd559dd0016b70', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115383', 'MOHAMAD RIDHO ALFARIS', '64800858', '6e58abdff796ddc8618f9b17384c635a', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115384', 'MUHAMAD ALI SUPARNO', '54301549', '32dfade7dbe912e48c8884c63effb04c', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115385', 'MUHAMAD ARIZA ARWAN', '66594526', '3cb675ab0ad4add265c605dc7f0bf871', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115386', 'MUHAMAD DIKA SAPUTRA', '74662177', 'b8f9acac6b5e5f7b12e53242125026f9', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115387', 'MUHAMAD FIQRI ARDI RIYANTO', '64996232', 'da018f93ec1df8ae3d253bba7fe3c8b7', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115388', 'MUHAMAD IHYA', '64395614', '43c41bed886bbd3aa6a5b5040e555998', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115389', 'MUHAMAD MASDARIL HUDA', '59614313', '3edb9d6879bf90bb7fc494dcd12b6300', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115390', 'MUHAMAD RAFLI SURYA PRATAMA', '67256851', 'd4605c26ddde4b44680006e769422db8', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115391', 'MUHAMMAD ALFATH JULIONO', '53197811', 'a16d4e301757353031630fc82b773f4c', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115392', 'MUHAMMAD FAREL FAQIHUDIN', '3066228677', 'e106caee1759f327fc5561b7e5d39d8a', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115393', 'NAZIHILL IRBADZ', '68735455', 'ba55485e02780ea1d5ce6efb6be5a65b', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115394', 'REVAL ADITYA PERMANA', '52965011', '6186424da1f07a936910a11f15f4d725', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115395', 'RIO SANDIKA', '65975756', '240f708b87ca99e77b0b708dc1b198d0', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115396', 'SADANA KRISTIANTO', '66464934', 'c4c670d405d3588ddd5f569222609910', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115397', 'SLAMET MUNAZAT', '42909702', '28d5d8239eced716e22e3d887886dd0b', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115398', 'TRI HINDAN', '67136069', 'bcda7eec9a5c823a13a04c06da00b392', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115399', 'YORDAN PRASETYO', '58313656', '62cb209bbeceab46a92ca69ed2c73d0c', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115400', 'ZIYADAL KAROM', '64342543', '2be85418661b250961412a362dc75d1f', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115401', 'ACHMAD CHOERUL AZMI', '65983574', 'e141d8f78b56e02eb9cba61377d8fa6f', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115402', 'AGUS NURIDWAN', '63983082', 'f9ce6b3c134ef8f5ffe081512e268a7b', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115403', 'AHMAD MIFTAHUN NAZAH', '3066305110', '580dc14ef643bf7a463a0088b1056ecc', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115404', 'AKHSAN FATONI', '52219990', '045fd553f4aff72b27c6ab74a5623f53', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115405', 'ALDI SAPUTRA', '53418949', 'e1a146dd7a4aa9ff998c55d075017adf', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115406', 'ALIF FEBRI YANTO', '78651890', '03bea98107ca58e29e22079ab60af785', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115407', 'ANDI ROZAK', '62868569', '6018d1b3829eee599f6aaa55dc118897', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115408', 'ARDIYAN SAPUTRA', '51733710', '7386ccc07f9daf097b5056f0f3e2637d', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115409', 'ARIL SUHERMAN', '57871245', '4a01599e8b3994776ebff412597e6992', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115410', 'ARIS MAULANA', '48689961', '88643313b39ec24bb174b3348f2a1238', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115411', 'BAGUS SAPUTRO', '72407583', '7d29893fc3aa8ebc6e066fc7eb7ee610', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115412', 'BUDI UTOMO', '56094403', '69cca33ca7145ec2a9775470713394d8', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115413', 'DAVID SURYANA', '73823973', '648a4ad906a19d386a71be2b02354547', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115414', 'DESTA ARDIANSYACH', '69138409', 'ecd78664762046b24449788866878def', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115415', 'EGY DIAZ PRATAMA PUTRA', '74607035', '288499e0c959cc24a68545702014c863', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115416', 'FAHMI DANIARSYAH', '67225520', 'e171b9765e2cd1bfb23daf5842fe4d39', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115417', 'FARHAN KAMAL', '41967077', 'e56be7fefa14a21315130e17ffb88ea6', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115418', 'FEMAS ANDRIYANTO', '3055378780', '78074060f392b7635d66021164cb88db', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115419', 'HAFIZD ROZIKIN', '55583679', 'e21c204eea4f450271eddcb1af9a935f', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115420', 'IHSAN NOVAL ZAKI', '44854149', 'cb2ad1886ec1183ae3a89f3516535b92', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115421', 'ILHAM MAULANA ARIFIN', '44447224', 'aa31847f4d010c4d78b685b201dc9743', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115422', 'IVAN FIRMANSYAH', '66333184', '8401eb6a0cca88c0116b95b32c941361', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115423', 'KHOERUL ANWAR', '63131680', 'f66af37b1bcc9e8f14ecc3b9060c6ddf', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115424', 'MIFTAHUL JINAN', '3065014768', '58c484c4e6804761577f320a12342733', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115425', 'MOHAMAD HAFIS HAKIM', '61124429', '19c22fd5966ede90dcb792d689448821', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115426', 'MUCHAMAD AKHIRIN', '68084809', 'c0f3708f6228d9167772fee9e23baefe', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115427', 'MUHAMAD ALZEFRI', '63095099', '94d8f02e9dab26e327616a8292a7e7c1', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115428', 'MUHAMAD ASRUL', '69999415', '37af6be46dcc0eeabbc2a4a348553a0c', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115429', 'MUHAMAD EFAN RIZQULLOH', '3054332432', '371c04a506757bd5fdadec8702a91ccc', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115430', 'MUHAMAD KHAMDAN KHOERUL ANAM', '56832802', '99e2b13fb1bf86fea37138a9bdf4ea7d', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115431', 'MUHAMAD MUZAKI SAPUTRA', '69347787', 'c472f5a8010bcd9a7bf2de3278391275', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115432', 'MUHAMAD SABIQULKHOIR', '56554756', '10d2622163167889c81cff7cdd552a77', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115433', 'MUHAMMAD ALI RIDHO', '49467270', '2e025d8cb66adb51487d4f4423bf0e5a', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115434', 'MUWAFIQ ABDUL AZIZ', '53513503', '3a011a9d68ee37c7df9a015fa7ea6010', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115435', 'PANGESTU GUSTI SANTOSO', '66922128', '90f0057fee951e0f00d2a58ff4c5db30', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115436', 'RIFQI AMIRUL KHAQIM', '55219082', '3fb002942bfc6c7ad2f96218a6503da4', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115437', 'RIYAN IQBAL PERMANA', '69008056', 'ba1f75f8997cd411f518143cfb580474', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115438', 'SATRIO TUBAGUS PAKIH', '66440880', '71989c6c503f3a3cd388290234803fa9', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115439', 'SYAFIQUR ROHMAN AKHMADI', '3065195427', 'd570ada3e01609f37dd4234cd40815b6', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115440', 'TUBAGUS ALAMUL YAQIN', '59331206', 'fd7d1d10c676c4b8b6282dc3233e515b', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115441', 'YUSUF SATRIO', '55242369', 'b584c28a68338b9566256841da16210a', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115442', 'ZULFANI FADLI', '68271143', '4e78bd681fbdb9bae842da542a613e97', 'L', 'ot', NULL, NULL, '', NULL, NULL, NULL),
('2115443', 'doraemon', '1234567891', '0f7e44a922df352c05c5f73cb40ba115', 'L', 'ak', NULL, NULL, NULL, NULL, NULL, NULL),
('2115444', 'AMANDA MARISAH SETYANI', '0052651443', 'a7cb8407e268188aa2312e1e5f2a8bdd', 'P', 'ak', '085640727433', '', 'Ketemberan Barat RT.02 RW.07 Kel.Tegalsari Kec.Tegal Barat Kota Tegal', 'Tegal', '2005-05-01', 'SMPN 3 Tegal'),
('2115445', 'DEGA ADI KUSUMA', '0056632754', '924694adbdcae93f9b68da7cb68ec068', 'L', 'ak', '083894886878', '', 'Jl. Hos Cokroaminoto RT. 04 RW.03 Ds. Lawang Kec.Pemalang Kab.Pemalang', 'Pemalang', '2005-08-21', 'SMP Islam Pemalang'),
('2115446', 'DIMAS HABIL AL KHAKIM', '0045075012', '347da765f508f449b37b283ffb9b54fc', 'L', 'ak', '085943080440', '', 'Jl. Nangka RT.03 RW.03 Ds.Warureja Kab.Tegal', 'Tegal', '2004-07-29', 'SMP N 1 Warureja'),
('2115447', 'DIPA NUR SHABANA', '0050875269', '590563fbc92ba0d8297901745a3d16aa', 'L', 'ak', '0859148287163', '', 'Jl. Layang Gg.Etong RT.09 RW.09 Kel.Tegalsari Kec.Tegal Barat Kota Tegal', 'Tegal', '2005-01-17', 'SMPN 8 Tegal'),
('2115448', 'ERZA ARDHIKA ALFIAN', '0044637032', '92e9d8e1e8e2032ef3c741f42eaa58d5', 'L', 'ak', '089628959266', '', 'Jl. Gatot Subroto RT.03 RW.02 Kel.Debong Kulon Kec.Tegal Selatan Kota Tegal', 'Tegal', '2004-12-24', 'SMPN 5 Tegal'),
('2115449', 'FAISAL BASRI', '0058487210', 'b31695e0e4a3e66fc3801f30acb70f59', 'L', 'ak', '089501786357', '', 'Ds.Kedungbanjar RT.02 RW.02 Kec.Taman Kab.Pemalang', 'Pemalang', '2005-01-20', 'MTs Al Furqon Demak'),
('2115450', 'FAJAR DANU PRATAMA', '0044654655', '95e004ba9efff38cf5181bb19e48b322', 'L', 'ak', '0895384232794', '', 'Jl.Tanjung Gg.2 No.15 RT.03 RW.04 Kel.Kejambon Kec.Tegal Timur Kota Tegal', 'Tegal', '2004-12-12', 'SMPN 12 Tegal'),
('2115451', 'FARREL ZIVEN ABIMANYU', '0044813978', 'a8b04c4311cf969db48ed36d7f4de21e', 'L', 'ak', '081326819278', '', 'Jl.Cucut No.21 RT.02 RW.08 Kel.Tegalsari Kec.Tegal Barat Kota Tegal', 'Tegal', '2004-10-19', 'SMPN 15 Tegal'),
('2115452', 'HADI WARTONO', '0043015582', 'f20069f6aba57fc281d86592adb0b256', 'L', 'ak', '089512855449', '', 'Jl. Nanas Utara Gg.Masjid No.7 RT.04 RW.04 Kel.Kraton Kec.Tegal Barat Kota Tegal', 'Indramayu', '2004-10-10', 'SMPN 6 Tegal'),
('2115453', 'IQBAL BAKHTIAR ZAUUQI', '0050797215', 'e5db7aa9112df195121f6800cb310471', 'L', 'ak', '0895358344085', '', 'Ds.Bojongsana RT.01 RW.01 Kec.Suradadi Kab.Tegal ', 'Tegal', '2005-07-02', 'SMPN 1 Warureja'),
('2115454', 'IRFAN DWI HARYANTO', '0045638888', '166586987ac35e432427fe8b9a52cfa6', 'L', 'ak', '082314313438', '', 'Jl.Sukosrono Gg.5A RT.09 RW.02 Kel.Slerok Kec.Tegal Timur Kota Tegal', 'Tegal', '2004-07-25', 'SMP Muh. 1 Kota Tegal'),
('2115455', 'ISAAC NAZAR SALIM', '0051926266', '7f6cf3d2f04ff0155028d77a12bd911c', 'L', 'ak', '087830963539', '', 'Jl.Sonokeling Pelutan RT.06 RW.02 Ds.Pelutan Kec.Pemalang Kab.Pemalang', 'Pemalang', '0000-00-00', 'SMPN 1 Pemalang'),
('2115456', 'IVAL AKMAL NAHIDAYAT', '0053354727', '06573f7f772ccb90bbc690279db8653b', 'L', 'ak', '087882788887', '', 'Ds.Tegalmlati RT.05 RW.04 Kec.Petarukan Kab.Pemalang', 'Pemalang', '2005-02-08', 'SMP PGRI 5 Petarukan'),
('2115457', 'IWAN GUNADI', '0044597483', '58ee48bf2503a14942b184c887c8e0ad', 'L', 'ak', '085740859603', '', 'Dk.Pepedan RT.02 RW.06 Ds. Pantirejo Kec. Kesesi Kab.Pekalongan', 'Pekalongan', '2004-07-31', 'SMPN 2 Sragi'),
('2115458', 'MEINA DWI ARYANI', '0052857640', 'a62a35e5e32aa486f999d8f4ae44b63d', 'P', 'ak', '0859115653615', '', 'Dk.Bandung RT.01 RW.04 Ds.Kendayakan Kec.Warureja Kab.Tegal', 'Tegal', '2005-05-05', 'MTs NU 01 Warureja'),
('2115459', 'MIFTAKHUL FAHRIZ ALVIANSYAH', '0045371238', 'dac02bda40ce2f0e3dbe173e6351589c', 'L', 'ak', '085713279431', '', 'Jl.Hayam Wuruk RT.03 RW.03 Ds.Dukuhwaru Kec.Dukuhwaru Kab.Tegal', 'Tegal', '2004-12-04', 'SMPN 1 Dukuhwaru'),
('2115460', 'MOH. RISKI ROMADANI', '0051210537', '16a6d49dcd759bedb8027eeacb543601', 'L', 'ak', '082135762455', '', 'Ds.Kepunduhan RT.05 RW.02 Kec.kramat Kab.Tegal ', 'Tegal', '2005-10-15', 'SMPN 2 Talang'),
('2115461', 'MOHAMMAD WAHYUDI ', '0040455083', 'bcbfbc03f6006072576681f3de3e4250', 'L', 'ak', '085721807860', '', 'Ds.Banjaranyar RT.02 RW.03 Kec.Brebes Kab.Brebes', 'Brebes', '2004-07-05', 'SMPN 6 Brebes'),
('2115462', 'MUHAMMAD IHFAL RAMDONI', '0043631771', '09df0a799db632fd5ec380f84529d5b8', 'L', 'ak', '0895321089544', '', 'Ds.Tembok Banjaran RT.05 RW.01Kec.Adiwerna Kab.Tegal', 'Sidodadi Kinali', '0000-00-00', 'SMPN 03 Adiwerna'),
('2115463', 'MUHAMMAD RIZKI AMIRUDIN', '0052347541', 'c13e27ce9cc8dd8268ab06780f79edd4', 'L', 'ak', '085712377648', '', 'Ds.Klampok RT.03 RW.08 Kec.Wanasari Kab.Brebes', 'Brebes', '2005-01-03', 'SMPN 02 Wanasari'),
('2115464', 'MUHAMMAD RONALD DIDA HAKIKI', '0044834596', '23a0e499af7637324f07ddf081242e88', 'L', 'ak', '083804934851', '', 'Jl. M.Toha No.167A RT.02 RW.03 Kel.Kaligangsa Kec.Margadana Kota Tegal', 'Brebes', '2004-12-13', 'MTs Raudhatul Ulum Kota Tegal'),
('2115465', 'NISHA PUTRI WAHYANA', '0054027524', '947e7ff1f5d3b748e5955b98e339471b', 'P', 'ak', '082325613150', '', 'Jl.Petunjungan RT.01 RW.06 Ds.Petunjungan Kec.Bulakamba Kab.Brebes', 'Brebes', '2005-05-28', 'MTsN 1 Brebes'),
('2115466', 'NUR SAHRA MUTIA', '0057019140', '2be4fb991031131c417535169d3437d4', 'P', 'ak', '0895383226578', '', 'Ds.Tonggara RT.17 RW.07 Kec.Kedungbanteng Kab.Tegal', 'Tegal', '2005-12-29', 'Mts Ma\'Hadut Tholabah Lebaksiu'),
('2115467', 'PANDE OLOAN SIDABARIBA', '0043832836', '63329476cbba1bb1807042eda9cfdc23', 'L', 'ak', '081906792449', '', 'Villa De Blandong Ds.Purwoharjo RT.04 RW.08 Kec.Comal Kab.pemalang', 'Pemalang', '2004-03-22', 'SMPN 4 Comal'),
('2115468', 'RAHAD DIKA APRIAN', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ak', '', '', 'Ds. Maribaya Rt 05 Rw 03 Kec. Kramat Kab. Tegal', 'Semarang ', '2004-04-02', 'SMP Al–Musyafafa Kendal'),
('2115469', 'RANGGA DANA PRASTIA', '0038936283', 'b54049051214bdf196928848ae5bab0b', 'L', 'ak', '0895378056909', '', 'Ds.Iser RT.09 RW.02 kec.Petarukan Kab.Pemalang', 'Pemalang', '2003-12-15', 'SMP PGRI 5 Petarukan'),
('2115470', 'RATNA RAMADANI', '0043773807', '792c63cb02fab78dc924e11e6d61e1e6', 'P', 'ak', '081215050608', '', 'Jl.Halmahera No.60 RT.012 RW.010 Kel.Mintaragen Kec.Tegal Timur Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 12 Tegal'),
('2115471', 'RHISMA ANANTA', '0052837701', '3cd2e2ad986918cefb9b26f3254fccb5', 'P', 'ak', '082328913878', '', 'Dk.Pandan Laut No.84 RT.02 RW.01 Ds.Purwahamba Kec.Suradadi Kab.Tegal', 'Tegal', '2005-01-17', 'SMPN 8 Tegal'),
('2115472', 'RIZKI SAPUTRA', '0033611636', '4a9d189091014b4e1ba3820556dc98df', 'L', 'ak', '0895360924587', '', 'Jl.Layang Gg.Etong RT.09 RW.09 Kel.Tegalsari Kec.Tegal Barat Kota Tegal', 'Tegal', '2003-08-25', 'SMPN 3 Tegal'),
('2115473', 'ROFIQ ZAKARIYA', '0046509114', '37fe3900a3cf256a2d5e5e89ae21d054', 'L', 'ak', '085645176120', '', 'Ds.Klampok RT.02 RW.08 Kec.Wanasari Kab.Brebes', 'Brebes', '2004-09-15', 'SMPN 2 Wanasari'),
('2115474', 'TRI WAHYUDI', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ak', '085866676138', '', 'Ds.Pantirejo Kec.Kesesi Kab.Pekalongan', 'Pekalongan', '2004-08-21', 'SMPN 2 Sragi'),
('2115475', 'VERI RESTU AJI SAPUTRO', '0038919692', '0d354e2538fb4545a9fdb363d80e470c', 'L', 'ak', '088233865249', '', 'Ds.Getaskerep RT.15 RW.05 Kec.Talang Kab.Tegal', 'Tegal ', '2003-12-11', 'SMPN 2 Talang'),
('2115476', 'ADI PRASETYO', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '085600854084', NULL, 'Ds.Mejasem Timur RT.08 RW.01 Kec.Kramat Kab.Tegal ', 'Tegal', '2038-09-01', 'SMPN 1 Kramat'),
('2115477', 'AKHMAD BUSTHOMI', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '081904390635', NULL, 'Jl. Raya Barat No. 12  Ds.Lebaksiu Lor Kec. Lebaksiu Kab.Tegal', 'Tegal', '0000-00-00', 'SMPN 1 Lebaksiu'),
('2115478', 'ALFANA IFDZIL HAKIKI', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '085327129460', NULL, 'Ds.Bulakwaru RT.01 RW.01 Kec.Tarub Kab.Tegal ', 'Tegal', '0000-00-00', 'MTs NU 01 Tarub'),
('2115479', 'DANI MASRUHAN', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '', NULL, 'Ds. Sidangheula RT.03 RW.01 Kec. Banjaharjo Kab. Brebes.  ', 'Brebes', '0000-00-00', 'SMPN 03 Banjaharjo'),
('2115480', 'DEDE YUSUF', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '087733164538', NULL, 'Jl.Desa Padasugih RT 01 RW 04  Ds. Padasugih Kec. Brebes  Kab. Brebes', 'Brebes', '0000-00-00', 'SMPN 1 Brebes'),
('2115481', 'DICKY PRASETYADI', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '081215620324', NULL, 'Jl Manggis RT.02 RW.02  Ds.Dampyak Kec.Kramat Kab.Tegal', 'Brebes', '0000-00-00', 'SMP Al Irsyad Tegal'),
('2115482', 'DIDING NUR PRASTIO', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '087830309166', NULL, 'Jl.Sadewa  RT.03 RW.02  Kel. Debong Lor Kec. Tegal Barat  Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 13 Tegal'),
('2115483', 'DIMAS SUGIANTO', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '', NULL, 'Dk.Kalisusu RT.031 RW.014 Ds.Karanganyar  Kec.Kedungbanteng Kab.Tegal', 'Bekasi', '0000-00-00', 'SMPN 2 Pangkah'),
('2115484', 'DIMAS SUKMA  ANGGORO', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '085229407871', NULL, 'Ds.Pakembaran RT.04 RW.01 Kec.Slawi Kab.Tegal ', 'Tegal ', '0000-00-00', 'SMPN 2 Slawi'),
('2115485', 'DIPA SLAVIA JAYA', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '081477071293', NULL, 'Ds.Pacul RT.022 RW.06 Kec.Talang Kab.Tegal ', 'Tegal ', '0000-00-00', 'SMPN 2 Talang'),
('2115486', 'FAQIHIL MUQODDAM', '0050837804', '1e6d56b80dca844b4e2f2c4c45a2b438', 'L', 'ot', '089609966199', NULL, 'Ds.Suradadi RT.02 RW.08 Kec.Suradadi Kab.Tegal ', 'Tegal ', '0000-00-00', 'SMPN 12 Tegal'),
('2115487', 'MOCHAMMAD WIZAM KHAIRULLAH', '0054470192', 'af9592113fda642e1a0d0dea909c6f94', 'L', 'ot', '0895422752782', NULL, 'Ds.Klampok RT.010 RW.005 Kec.Wanasari Kab.Brebes ', 'Brebes ', '0000-00-00', 'SMPN 1 Wanasari'),
('2115488', 'MOH. GIBRAN MATOFANI', '0011226290', 'daf44725aac4e87f19ee44ca50d20c85', 'L', 'ot', '0895358549546', NULL, 'Jl.Dr.Cipto Mangunkusumo RT.08 RW.04 Kel.Kaligangsa Kec.Margadana Kota Tegal', 'Tegal ', '0000-00-00', 'MTs Negeri Kota Tegal'),
('2115489', 'MOH. REZA FAJAR WIBOWO', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '', NULL, '  ', 'Tegal ', '0000-00-00', 'MTs N 3 Tegal'),
('2115490', 'MOHAMAD BAYU ARDIANSYAH', '0052077608', 'c3d471d73de95e8b9295f1c8ad89f570', 'L', 'ot', '083838351359', NULL, 'Ds.Bangun Galih RT.08 RW 02 Kec.Kramat Kab.Tegal ', 'Tegal ', '0000-00-00', 'SMPN 1 Suradadi'),
('2115491', 'MUHAMAD RAHMA DANI', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '088216610628', NULL, 'Dk.Jatilawang RT.01 RW.08 Ds.Jembayat Kec.Margasari Kab.Tegal', 'Tegal ', '0000-00-00', 'SMPN 1 Margasari'),
('2115492', 'MUHAMMAD AMIK FUADI', '0029773938', '8cacca82b69831d3b4d08bb28db17374', 'L', 'ot', '083174505813', NULL, 'Ds.Bojong RT.04 RW.03 Kec.Bojong Kab.Tegal ', 'Tegal ', '0000-00-00', 'MTs Hasyim Ashari Bojong'),
('2115493', 'MUHAMMAD FADLI APANDY', '0048656677', '5a4061bcbc61b224f515a7d09dd743bb', 'L', 'ot', '087869458414', NULL, 'Ds.Sinang Jaya Kec.Kersana Kab.Brebes ', 'Batam ', '2038-11-01', 'MTsN 1 Mesangin'),
('2115494', 'MUHAMMAD KHAHLIL GIBRAN', '0051623943', 'a7e125d48c8e97974ec5687fcd1b48fc', 'L', 'ot', '085952895619', NULL, 'Ds.Sutapranan RT.06 RW.02 Kec.Dukuhturi Kab.Tegal ', 'Tegal ', '0000-00-00', 'SMPN 01 Talang'),
('2115495', 'RIYON SUHANDA', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '085959819254', NULL, 'Ds.Padasugih RT.05 RW.03 Kec.Brebes Kab.Brebes ', 'Brebes ', '2038-12-01', 'SMPN 3 Brebes'),
('2115496', 'WILLY ANSAH SAFUDIN', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ot', '085954739088', NULL, 'Pemalang, Lawangrejo  ', 'Lawang Rejo ', '0000-00-00', 'SMPN 6 Pemalang'),
('2115497', ' AGUS BATARA SIAHAAN', '0053720124', '2702f6d1132be9d0a882def2c4c38b65', 'L', 'mm', '085742193922', NULL, 'Jl.Metro No.48 Kel.Debong Lor Kec.Tegal Barat Kota Tegal ', 'Lawe Loning', '0000-00-00', 'SMP Atmaja Wacana Kota Tegal'),
('2115498', ' ANGGA TIO PRATAMA', '0057585326', '36f33297053a723fccbefc25f91e984b', 'L', 'mm', '081325115479', NULL, 'Dk.Beji Jurang RT.10 RW.06 Ds.Bejiarum Kec.Kertek Kab.Wonosobo', 'Wonosobo', '0000-00-00', 'SMPN 1 Kalikajar Wonosobo'),
('2115499', ' DINAR DAVA INARTO', '0053125443', 'f9e48d50742c8d908e25dd976bd17b4a', 'L', 'mm', '089509051760', NULL, 'Dk. Posongan RT.09 RW.03  Ds.Purwoharjo Kec.Comal Kab.Pemalang', 'Pemalang', '0000-00-00', 'SMPN 1 Comal Pemalang'),
('2115500', ' FAOZAN KEMAL HENDIYANTO', '0063866176', 'b8d6d07569116897d27d575b3dfbc4f5', 'L', 'mm', '088233728229', NULL, 'Ds.Kemanggungan RT.01 RW.01 Kec.Tarub Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 3 Talang '),
('2115501', ' HANIF IFDA ALFANIZAR', '0054098218', 'c7ff845d84c6ecec5e053dab210e0d94', 'L', 'mm', '085640401321', NULL, 'Dk.Pengasinan RT.02 RW.06 Ds.Sukareja Kec.Warureja  Kab.Tegal', 'Tegal', '0000-00-00', 'MTs NU 01 Warureja '),
('2115502', ' KHOLIFUDIN ALSYAH', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'mm', '088215437727', NULL, 'Ds.Dawuhan RT.16 RW.04 Kec.Talang Kab.Tegal ', 'Tegal', '0000-00-00', 'MTs Bustanul Huda Dawuhan'),
('2115503', ' M. FAOZAN ARIF MUNANDAR', '0066561904', '17ded651c7011e7d14bcc3f6c092535d', 'L', 'mm', '087729019282', NULL, 'Ds.Sidaharja RT.14 RW.07 Kec.Sidaharja Kab.Tegal ', 'Tegal', '0000-00-00', 'SMP IT Al Madani Kota Semarang'),
('2115504', ' MUHAMAD IMAM ROSYIDIN', '0055668652', 'ea55579d2181bb85c39d8936c22ab16f', 'L', 'mm', '085714840517', NULL, 'Kp. Al Huda RT.02 RW.02  Ds.Waluya Kec.Cikarang Utara  Kab.Bekasi', 'Bekasi', '0000-00-00', 'MTs Al Ishlah '),
('2115505', ' MISHBAKHUL MUSTHOFA', '0066482705', '771b809ad3f05a2e1f18ad5354c9aa1b', 'L', 'mm', '081477190272', NULL, 'Ds.Getaskerep RT.01 RW.01  Kec.Talang Kab.Tegal ', 'Tegal', '0000-00-00', 'MTs Bustanul Huda Dawuhan'),
('2115506', ' MOH. NUR PRATAMA', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'mm', '082329173025', NULL, 'Jl.Citarum Gg.Buntu No.24 RT.05 RW.09 Kec.Tegal Timur Kota Tegal', 'Tegal ', '2039-07-04', 'SMPN 4 Kota TEGAL '),
('2115507', ' MOHAMAD MAFTUKH BASUNI', '0074600112', '688641260072ad37aec28b707340d49a', 'L', 'mm', '081901094790', NULL, 'Ds.Kemanggungan RT.08 RW.01 Kec.Tarub Kab.Tegal ', 'Tegal', '2039-08-03', 'SMPN 3 Talang '),
('2115508', ' MOHAMMAD RAFFI FAUZAN', '0052988077', 'c241a25a2dc782d339fa6cc144fc1b8c', 'L', 'mm', '087795168078', NULL, 'Jl.Halmahera Kamp.Pasir Agung RT.13 RW.10 Kel.Mintaragen Kec.Tegal Timur Kota Tegal', 'Tegal ', '0000-00-00', 'SMPN 12 Kota Tegal '),
('2115509', ' MUHAMMAD NAFIALI', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'mm', '083191339330', NULL, 'Ds.Langgen RT.14 RW.03  Kec.Talang Kab.Tegal ', 'Tegal', '0000-00-00', 'MTs Bustanul Huda Tegal'),
('2115510', ' NAKHWAH ULFIYAH KOMARUDIN', '', 'd41d8cd98f00b204e9800998ecf8427e', 'P', 'mm', '081215546433', NULL, 'Jl.Merpati Gg.Kasuari No.14 Kel.Randugunting  Kec.Tegal Selatan Kota Tegal', 'Tegal ', '2039-01-06', 'SMPN 7 Kota Tegal '),
('2115511', ' REHAN SAPUTRA', '0066372201', 'f9d6433681ea8ef4eee81991700e2dba', 'L', 'mm', '085773324277', NULL, 'Jl.Pahlawan Rempoa RT.02 RW.03 Kel.Rempoa Kec.Ciputat Timur Kota Tangerang Selatan', 'Jakarta', '0000-00-00', 'SMP Muhammadiyah 17 Ciputat Banten'),
('2115512', ' RESTU INDRA SYAHPUTRA', '0061790366', '0bb36bd36490fbbaa536a8f18d5d2fa0', 'L', 'mm', '089665778547', NULL, 'Jl.Halmahera Gg.Mandiri RT.08 RW.11 Kel.Mintaragen Kec.Tegal Timur Kota Tegal', 'Tegal ', '0000-00-00', 'SMPN 9 Kota Tegal '),
('2115513', ' RIDHO SAPUTRA', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'mm', '0895401703652', NULL, 'Jl.Sawo Barat Blok A No.302 RT.02 RW.09 Kel.Kraton Kec.Tegal Barat Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 6 Kota Tegal '),
('2115514', ' SACHMADANI NURHUDA', '0050710026', '425715c7b3152c2390ababda86be9718', 'L', 'mm', '085742191233', NULL, 'Jl.Karimunjawa II No.43  RT.07 RW.11 Kel.Mintaragen Kec.Tegal Timur Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 9 Kota Tegal '),
('2115515', ' SATRIA MAULANA RAMADAN', '0052106481', '7a3b40351f821a4482a410a221f67b95', 'L', 'mm', '085702283842', NULL, 'Ds.Kepunduhan RT.09 RW.01 Kec.Kramat Kab.Tegal ', 'Tangerang', '0000-00-00', 'MTs Hidayatus  Shibyan Tarub'),
('2115516', ' TEGUH FRASTYA', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'mm', '085725336534', NULL, 'Ds.Setu RT.05 RW.02 Kec.Tarub Kab.Tegal ', 'Tegal', '0000-00-00', 'MTs Bustanul Huda Dawuhan'),
('2115517', ' TITTO HANTORO', '0062814339', '1925504eb68d77a6cde79a0cb6215f2c', 'L', 'mm', '085742193922', NULL, 'Jl.Metro No.48 Kel.Debong Lor Kec.Tegal Barat Kota Tegal ', 'Sukabumi', '0000-00-00', 'SMP Atmaja Wacana Kota Tegal'),
('2115518', ' TOGU ADHITAMA MANIK', '0068457092', '6467629fe5cac772597476c42678c331', 'L', 'mm', '0895421970318', NULL, 'Perumahan Dedy Jaya, Ds.Jagapura RT.06 RW.03 Kec.Kersana Kab.Brebes', 'Brebes', '0000-00-00', 'SMPN 1 Kersana Brebes'),
('2115519', ' WAHYU ALAMSYAH', '0066688164', '6a667561e7edd87efd12968c81d4ec26', 'L', 'mm', '088225148286', NULL, 'Ds.Jatilawang RT.02 RW.01 Kec.Kramat Kab.Tegal ', 'Tegal ', '0000-00-00', 'SMPN 2 Talang '),
('2115520', ' WIJAYANTO', '0058283494', '3324dfac421b402a2b4173f01d533d6f', 'L', 'mm', '083107408997', NULL, 'Dsn.Klapasawit RT.03 RW.05  Ds.Padasugih Kec.Brebes Kab.Brebes', 'Brebes', '0000-00-00', 'SMPN 4 Brebes '),
('2115521', ' ARTHA ARFANDIANSYAH', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'kj', '087771399282', NULL, 'Ds.Suradadi RT.01 RW.14 Kec.Suradadi Kab.Tegal ', 'Tegal', '0000-00-00', 'Mts Al Fatah  Suradadi'),
('2115522', ' ARYA BUDI LAKSANA', '0055521399', '52365805c9f9298815a86937f67250bd', 'L', 'kj', '081904392816', NULL, 'Ds.Bandasari RT.02 RW.01 Kec.Dukuhturi Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 3 Talang '),
('2115523', ' EBI SAPUTRA', '0066354734', '0605cc6b4daff160eece7af16744c855', 'L', 'kj', '081228447046', NULL, 'Ds.Sindangheula RT.02 RW.01 Kec.Banjarharjo Kab.Brebes ', 'Brebes ', '0000-00-00', 'MTs Ma\'arif NU 6 Bandungsari Brebes'),
('2115524', ' FIRMAN SUKMAJID', '0058753815', '143a89b1729c17b4468cbfb62cdae52d', 'L', 'kj', '085641304127', NULL, 'Ds.Sidakaton RT.02 RW.01  Kec.Tanjung Kab.Brebes ', 'Brebes', '0000-00-00', 'SMPN 2 Tanjung Brebes'),
('2115525', ' GILANG AINUR SETIA', '0053915828', '2a10dc915ef6996d794a174c168af034', 'L', 'kj', '088227646744', NULL, 'Jl.Sangir No.37 RT.07 RW.11 Kel.Mintaragen Kec.Tegal Timur Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 12 Kota Tegal '),
('2115526', ' HABIBI RIZKI MAULANA', '0062629997', 'bfaaf2f27379e2631fbd506defd8d658', 'L', 'kj', '087835095292', NULL, 'Ds.Luwunggede RT.03 RW.01 Kec.Tanjung Kab.Brebes ', 'Brebes', '2039-01-02', 'SMPN 01 Kersana Brebes'),
('2115527', ' HANGKA RIZAL NURSIDIK', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'kj', '081328312658', NULL, 'Ds.Randusanga Kulon  RT.07 RW.02 Kec.Brebes  Kab.Brebes', 'Brebes', '2039-05-09', 'MTs Ma\'arif NU 6 Bandungsari Brebes'),
('2115528', ' HANIF AMAR MUTTAQIM', '0065333479', '82d9f63914249a5396c48b2a0d1f66b4', 'L', 'kj', '087723981879', NULL, 'Ds.Wangandawa RT.20 RW.05 Kec.Talang Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 2 Talang '),
('2115529', ' M. HAIDAR HABAIB', '0061577690', '12da7f51b45fd1f1a19a68675d7358b6', 'L', 'kj', '0895185763663', NULL, 'Ds.Songgom Lor RT.04 RW.02 Kec.Songgom Kab.Brebes ', 'Brebes', '0000-00-00', 'SMPN 3 Songgom Brebes'),
('2115530', ' MUH. AKHMAD RAMADHAN', '0047244318', '46eae754ea59310063a46155c71f1702', 'L', 'kj', '083143298764', NULL, 'Ds.Wangandawa RT.21 RW.05 Kec.Talang Kab.Brebes ', 'Tegal', '0000-00-00', 'SMPN 2 Talang '),
('2115531', ' MOHAMAD FEBRIAN', '0061803495', '79f7780296013a53a5284146fb692a9e', 'L', 'kj', '083145246737', NULL, 'Jl.Pramuka RT.013 RW.003  ', 'Brebes', '0000-00-00', 'SMP Muhammadiyah Kluwut Brebes'),
('2115532', ' MOHAMAD MISBAHU DHOLAM', '0052736160', 'bd538c25ee9cc23b29d7478a0c7a56c3', 'L', 'kj', '085600865107', NULL, 'Jl.Teuku Umar Gg.Bahari I No.29 RT.04 RW.06 Kel.Debong Tengah Kec.Tegal Selatan Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 13 Kota Tegal '),
('2115533', ' MOHAMMAD AZHAR PAMUNGKAS', '0052021699', 'f9cb5164be14749351c6b2fe0891a077', 'L', 'kj', '089647677544', NULL, 'Ds. Grinting RT.01 RW.01 Kec.Bulakamba Kab.Brebes ', 'Serang', '0000-00-00', 'SMP Mhammadiyah Kluwut'),
('2115534', ' PANJI PRABOWO', '0068305283', '42c7d5b5ef87c44e6a8d3f0415d9a7b7', 'L', 'kj', '085713243785', NULL, 'Ds.Kedokansayang RT.01 RW.04 Kec.Tarub Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 1 Tarub '),
('2115535', ' RIFKI ABDILA SAPUTRA', '0040455812', '1f5c1f7047b696dafee8324ddb0e07c1', 'L', 'kj', '085866142723', NULL, 'Jl.Dr. Cipto mangunkusumo RT.01 RW.02 Ds.Gandasuli Kec.Brebes Kab.Brebes', 'Brebes', '0000-00-00', 'SMPN 4 Brebes '),
('2115536', ' RIFVAL ANANDA', '0052610994', '74411d2205069e8129c0cdb4f9089bc5', 'L', 'kj', '085742420729', NULL, 'Jl.Bawal Manunggal  Gg.Sengkuyung 2 RT.05 RW.31  Kel.Tegal Sari Kec.Tegal Barat', 'Tegal', '0000-00-00', 'SMPN 13 Kota Tegal '),
('2115537', ' RIVA ZAKI AMINULLOH', '0061373972', 'c164bfec9e9864a0de5979b0c8ee10ad', 'L', 'kj', '087730298118', NULL, 'Ds.Dukuhwringin RT.23 RW.10 Kec.Wanasari Kab.Brebes ', 'Brebes', '0000-00-00', 'MTs Hikmah Kamilah Wanasari'),
('2115538', ' RIZKI DIO HERMANSYAH', '0076050539', 'cc5f005db614105782243cc4d1663b44', 'L', 'kj', '085693110231', NULL, 'Jl.Tangkil RT.04 RW.04  Ds.Mindaka Kec.Tarub Kab.Tegal', 'Tegal ', '0000-00-00', 'MTs Al Kamal Tarub Kab.Tegal'),
('2115539', ' ROBBY UNGGUL PRATAMA', '0062386542', 'e90d369717169b65c202e4407f5b791c', 'L', 'kj', '085879263886', NULL, 'Jl.Kapt. Samadikun RT.07 RW.02 Kel.Pesurungan Lor  Kec.Margadana Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 13 Tegal '),
('2115540', ' AMIN SAFRUDIN', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'kj', '087839405841', NULL, 'Ds.Karanganyar RT.03 RW.02 Kec.Dukuhturi Kab.Tegal ', 'Tegal', '0000-00-00', 'SMP NU 01 Dukuhturi '),
('2115541', ' ANDRA RADIT TIO', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'kj', '082137063658', NULL, 'Dsn.Jurang RT.07 RW.02  Ds.Pesantren Kec.Wonoboyo Kab.Temanggung', 'Temanggung', '0000-00-00', 'SMPN 1 Wonoboyo '),
('2115542', 'ABDURROHMAN', '0077434082', '4caf58aaae2e2f2f5c3f18452b8b060e', 'L', 'ps', '087730066244', NULL, 'Jl.Sunan Gnung Jati 4 RT.05 RW.04 Ds.Limbangan Wetan Kec.Brebes Kab.Brebes', 'Brebes', '0000-00-00', 'MTsN 02 Brebes '),
('2115543', 'ADE TABA CHASANATA OCTAVIAN', '', 'd41d8cd98f00b204e9800998ecf8427e', 'L', 'ps', '083117058093', NULL, 'Jl.Kalibuntu Barat RT.07 RW.02 Kel.Panggung Kec.Tegal Timur Kota Tegal', 'Tegal', '0000-00-00', 'MTs Ma\'arif NU 01  Brebes'),
('2115544', 'AKHMAD KHAERUL ANWAR', '0066382458', '3f53c4d810f0ab62f3d595dafab112d8', 'L', 'ps', '085882052138', NULL, 'Jl.Desa Pulosari RT.04 RW.06 Ds.Pulosari Kec.Brebes Kab.Brebes', 'Brebes', '0000-00-00', 'SMPN 5 Brebes '),
('2115545', 'AKHMAD TORIKHIN', '0072147719', 'f81b2e4d2359df50e37f57991dd25a67', 'L', 'ps', '081542224328', NULL, 'Ds.Sisalam RT.03 RW.01 Kec.Wanasari Kab.Brebes ', 'Brebes', '0000-00-00', 'MTs Wachid Hasyim Wanasari Brebes'),
('2115546', 'AKMAL SAFITROH', '0064140181', '52b045a1c657084ee472b037bce6b4f7', 'L', 'ps', '0882003902653', NULL, 'Ds.Pesantunan RT.03 RW.09 Kec.Wanasari Kab.Brebes ', 'Brebes', '2039-03-07', 'MTs Assalafiyah Luwungragi Brebes'),
('2115547', 'BAGAS WIJAYA', '0069816372', '459db387398f821c698251473d70b4bc', 'L', 'ps', '085713219936', NULL, 'Griya Bahari Sentosa   RT.05 RW.07 Perum Dampyak Ds.Dampyak Kec.Kramat Kab.Tegal', 'Tegal', '2039-01-07', 'SMPN 01 Kramat '),
('2115548', 'DENI HARYANTO', '0063842805', '85076835384d6a3e91d6d294a766e927', 'L', 'ps', '087873251495', NULL, 'Jl.Markisa Barat RT.04 RW.03 Ds.Tambakrejo Kec.Pemalang Kab.Pemalang', 'Pemalang', '0000-00-00', 'SMPN 03 Pemalang '),
('2115549', 'FIKRI RAMADHAN', '0064115712', 'c155d0b12237ad98566ccfc5c5a0deca', 'L', 'ps', '081242274670', NULL, 'Dk.Tangkil  RT.05 RW.04 Ds.Mindaka Kec.Tarub Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 01 Tarub '),
('2115550', 'GHANI ADLI MAULANA', '0077593777', '212af4cdf22816e949e41cfb51b967d3', 'L', 'ps', '085641316462', NULL, 'Ds.Wanasari RT.03 RW.02 Kec.Wanasari Kab.Brebes ', 'Brebes', '0000-00-00', 'SMPN 01 Wanasari Brebes'),
('2115551', 'IRFAN NUR KHOLIL', '0079668968', 'a9f7c0d1761efed2d18ae61dc97f7ff7', 'L', 'ps', '083898195188', NULL, 'Ds.Cikandang RT.03 RW.04 Kec.Cikandang Kab.Brebes ', 'Brebes', '0000-00-00', 'SMPN 01 Kersana Brebes'),
('2115552', 'LAXMITHA NAWANG KINANTI', '0071669766', 'f195f560842b53901a640bda7531a069', 'P', 'ps', '086989370442', NULL, 'Ds.Bongkok RT.03 RW.03 Kec.Kramat Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 02 Talang '),
('2115553', 'M. RISQI', '0071376841', '6554c0f87ef98e392ec79c58b73a22ae', 'L', 'ps', '085229213835', NULL, 'Jl.Halmahera RT.08 RW.11 Kel.Mintaragen Kec.Tegal Timur Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 12 Tegal '),
('2115554', 'MAULANA AFNAN LABIB', '0072735784', 'c5bce7dafdc7e78c0dfbf7de27e27c53', 'L', 'ps', '083843526679', NULL, 'Dk.Babadan Tengah RT.03 RW.02 Ds.Bulaksari Kec.Sragi Kab.Pekalongan', 'Pekalongan ', '0000-00-00', 'SMPN 03 Sragi Pekalongan'),
('2115555', 'MOHAMMAD DAFFA EDYA MEYCA', '0057819126', '8de0e469ea108fa1768f44fde546f288', 'L', 'ps', '082125153168', NULL, 'Ds.Suradadi RT.04 RW.12 Kec.Suradadi Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 12 Tegal '),
('2115556', 'MUHAMAD ADHI SETYADI', '0065633195', 'a0ea274f302136a4ec65bf2764cd2664', 'L', 'ps', '085293377348', NULL, 'Ds.Dawuhan RT.12 RW.03 Kec.Talang Kab.Tegal ', 'Tegal', '0000-00-00', 'MTs Bustanul Huda Talang'),
('2115557', 'REVA RAMADHONA MUALIM', '0072894345', 'f50fbcbfe83b417fe31e3f7bf60ef4a2', 'P', 'ps', '087770479212', NULL, 'Jl.Jambu RT.22 RW.09  Ds.Purwahamba Kec.Purwahamba Kab.Tegal', 'Tegal', '0000-00-00', 'SMPN 01 Suradadi '),
('2115558', 'REZA DWI SAPUTRA', '0066287085', '3445167f2b8637ca7c1a23dad5995a73', 'L', 'ps', '085326598871', NULL, 'Jl.Ciliwung No.40 RT.08 RW.09 Kel.Mintaragen Kec.Tegal Timur Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 04 Tegal '),
('2115559', 'RIRIN SETYANINGRUM', '0071072520', 'e48de544ac4fbaad04738574b483e5ce', 'P', 'ps', '085951752131', NULL, 'Ds.Mejasem Timur RT.01 RW.03 Kec.Kramat Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 01 Kramat '),
('2115560', 'WISNU MURTI', '0073998497', '6fd1a02574d630c513799a0eb8a7b8e5', 'L', 'ps', '088232512455', NULL, 'Ds.Bojongsana RT.01 RW.01 Kec.Suradadi Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 01 Warureja '),
('2115561', 'ZINEDINE ZIDHANE MELLO PUTRA', '0063069068', '266ce4675ffd93fce77bebaff971d8b2', 'L', 'ps', '0882008423615', NULL, 'Ds.Kesuben RT.03 RW.10 Kec.Lebaksiu Kab.Tegal ', 'Tegal', '2039-07-01', 'SMPN 02 Lebaksiu '),
('2115562', 'ALVIN MUFADHOL', '0054645079', '8ec13dff318040e82678d9e252a587d5', 'L', 'ps', '087835136820', NULL, 'Ds.Kertaharja RT.05 RW.02  Kec.Kramat Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 02 Kramat '),
('2115563', 'ANDI HERMAWAN', '0063822907', '1a626f2c3eaf0c4f34dc5e31daa383b5', 'L', 'ps', '085600916065', NULL, 'Ds.Kebon Rowo Pucang RT.02 RW.05 Kec.Karangdadap Kab.Pekalongan ', 'Pekalongan', '0000-00-00', 'SMPN 01 Karangdadap '),
('2115564', 'ANGGER DWI MARGIONO', '0064101480', '78ec9d0f7ca10ef86e0c58e288710640', 'L', 'ps', '081225284887', NULL, 'Jl.Sangir RT.09 RW.11  Kel.Mintaragen Kec.Tegal Timur Kota Tegal', 'Tegal', '2039-04-01', 'SMPN 12 Tegal '),
('2115565', 'AWAN ADITYA FEBRIANSYAH', '0071176989', '1e38bd3d3d824868b1f2d4890a3f15ca', 'L', 'ps', '085866131731', NULL, 'Jl.Kapt.Sudibyo No.5 RT.01 RW.03 Kel.Kemandungan Kec.Tegal Barat Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 13 Tegal '),
('2115566', 'AWAN EKA PRAKASA', '0075331104', '43cc6543a4a18836c8a14c6a2acd3034', 'L', 'ps', '085328988585', NULL, 'Jl.KH.Rais RT.05 RW.03 Ds.Suradadi Kec.Suradadi Kab.Tegal ', 'Tegal', '0000-00-00', 'MTs Al Fatah Suradadi '),
('2115567', 'DHEAS ADRIANO BIGFANS', '0078107225', '25e3517e99ad0dc39c1b863fc9db1f75', 'L', 'ps', '085792174129', NULL, 'Griya Kajen Indah RT.01 RW.12 Gg.Anggrek 3 No.25 Ds.Gandarum Kec.Kajen Kab.Pekalongan', 'Madiun', '2039-10-08', 'SMPN 01 Karanganyar Pekalongan'),
('2115568', 'FAREL HARTIKA', '0081449927', '85efad17806f21e78e4ace61c2335339', 'L', 'ps', '085879263886', NULL, 'Jl. Kapt. Samadikun RT.07 RW.02 Kel.Pesurungan Lor Kec.Margadana  Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 18 Tegal '),
('2115569', 'FERDY ARDY YANTO', '0066231141', '94deeb1737e9193fd4331cb2e334fc68', 'L', 'ps', '087724731297', NULL, 'Ds.Kertayasa RT.05 RW.01 Kec.Kramat Kab.Tegal ', 'Tegal', '0000-00-00', 'SMP Takhassus  Al Qur\'an Tarub'),
('2115570', 'M. IKHSAN ARDIANSYAH', '0072280812', '045311e0e646c0a9538af68609f00c6e', 'L', 'ps', '081346485855', NULL, 'Dk.Tangkil RT.05 RW.04 Ds.Mindaka Kec.Tarub Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 01 Tarub '),
('2115571', 'MUHAMMAD RAFA ZAKI RAKHMAN', '3078231825', '9dda601adb03a9a774dcc5c993deab92', 'L', 'ps', '085641288790', NULL, 'Ds.Kesadikan RT.18 RW.02 Kec.Tarub Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 02 Kramat ');
INSERT INTO `siswa` (`nipd`, `nama`, `nisn`, `password`, `jk`, `jurusan_id`, `no_hp`, `email`, `alamat`, `tempat_lahir`, `tanggal_lahir`, `asal_sekolah`) VALUES
('2115572', 'MUHAMMAD AHLUL FIRDAUS', '0077491227', '438a9fc8ca10c2c15e6092c4178abea0', 'L', 'ps', '081927257849', NULL, 'Jl.Kalimantan No.5 RT.15 RW.11 Kel.Mintaragen Kec.Tegal Timur Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 02 Tegal '),
('2115573', 'MUH. ARFIN SABILI', '0055456456', '121f1c3b91fcde2838cb4576fbfd1034', 'L', 'ps', '088239147680', NULL, 'Ds.Tegalwangi RT.09 RW.03 Kec.Talang Kab.Tegal ', 'Tegal', '0000-00-00', 'SMP NU Al Amin Dukuhturi'),
('2115574', 'MUHAMAD FATKHUL AZIZ', '0073098126', '7e420b0adec8663c68eb10fd4a41a848', 'L', 'ps', '083119201753', NULL, 'Ds.Sutapranan RT.07 RW.02 Kec.Dukuhturi Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 3 Talang '),
('2115575', 'MUHAMMAD FIRLY', '0079579641', '12ce8087fa59c4255aed080007a5c223', 'L', 'ps', '088293684334', NULL, 'Dsn.Cilalung RT.14 RW.07  Ds.Mekarjaya Kec.Purwasari Kab.Karawang', 'Tegal', '2039-09-02', 'SMPN 05 Klari Karawang'),
('2115576', 'NOVAN FAUZAN', '0077392796', '883544d3a47e525b3b1971790ddbbca5', 'L', 'ps', '085643097285', NULL, 'Ds.Wangandawa RT.02 RW.01 Kec.Talang Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 03 Talang '),
('2115577', 'RIYANTO TRIAJI BUDIONO', '0064167435', '00c4d1b4ebb675cb906b94d26ea076dd', 'L', 'ps', '087831183468', NULL, 'Ds.Tambakrejo RT.04 RW.03 Kec.Pemalang Kab.Pemalang ', 'Pemalang', '0000-00-00', 'SMPN 06 Pemalang '),
('2115578', 'SAKI AYU ARIYONO', '0074011638', '1b2ac89d35f71c3ff0a7bbfce60ec91d', 'P', 'ps', '082313668220', NULL, 'DK.Miri RT.01 RW.02 Ds.Tuwel Kec.Bojong Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 01 Bojong '),
('2115579', 'SYAMSUL ARIFIN', '0077515717', '2fd247009f95d44889b2f496d592fdcd', 'L', 'ps', '085867176707', NULL, 'Ds.Bulak Waru RT.01 RW.03 Kec.Tarub Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 02 Tarub '),
('2115580', 'VIVIAN FEBRIYANTI', '0085077088', 'bb21809953e7bec6d96d7dde579f8922', 'P', 'ps', '089502432414', NULL, 'Kp.Pasir Bedeng RT.01 RW.06 Ds.Muara Ciujung Timur Kec.Lebak Kab.Banten', 'Brebes', '0000-00-00', 'MTsN 01 Lebak Banten'),
('2115581', 'ADITYA TRI FARKHAN AL FARIS', '0071702844', 'f317dc5383ed5f702999980d886ae9d0', 'L', 'ak', '081284453138', NULL, 'Dk.Pojok RT.04 RW.03  Ds.Paguyangan Kec.Paguyangan Kab.Brebes', 'Brebes', '0000-00-00', 'SMPN 03 Paguyangan Brebes'),
('2115582', 'AKHMAD VATKHURISKI', '0071808757', '455265ad81d333d38055880024535168', 'L', 'ak', '085293878791', NULL, 'Dsn.Karanganyar RT.47 RW.10 Ds.Asemdoyong Kec.Taman Kab.Pemalang', 'Pemalang', '0000-00-00', 'SMP Al Fadlu '),
('2115583', 'ANGGA OKTA KURNIAWAN', '0072779092', 'b0a1eab566c9979bd61d31f9d03304c8', 'L', 'ak', '088806637341', NULL, 'Jl.Pengayoman RT.03 RW.02 Ds.Babakan Kec.Kramat Kab.Tegal', 'Tegal', '0000-00-00', 'MTs NU 01 Kramat '),
('2115584', 'DAFA AL AGNAN', '0074266559', '4849cc67ab64adfe13e384d0c1666e10', 'L', 'ak', '085700842068', NULL, 'Jl.Dirjo Subroto RT.02 RW.01 Ds.Wangandawa Kec.Talang Kab.Tegal', 'Tegal', '0000-00-00', 'SMPN 15 Tegal '),
('2115585', 'DAFA NUR KHASANI', '0062958328', '999419656b8d243fa37fd2817a44f67a', 'L', 'ak', '083801394180', NULL, 'Ds.Sisalam RT.03 RW.01 Kec.Wanasari Kab.Brebes ', 'Brebes', '0000-00-00', 'SMP AlFusha  Pekalongan'),
('2115586', 'DIDIK FAJAR NUR ALAMSYAH', '0061231603', '3fcad7c982f03d4a6467f45c7d6705e3', 'L', 'ak', '087831565598', NULL, 'Ds.Bulakwaru RT.02 RW.01 Kec.Tarub Kab.Tegal ', 'Tegal', '2039-03-04', 'SMPN 02 Tarub '),
('2115587', 'KRESNA ALIF MUSTOFA', '0077620086', 'c0d2f4be5bd16742bc76cc808158fddf', 'L', 'ak', '089522530035', NULL, 'Ds.Kepandean RT.05 RW.02 Kec.Dukuhturi Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 02 Dukuhturi '),
('2115588', 'M. RIZKY BACHTIAR', '0067278786', '90a822036003875406bbc524599022fc', 'L', 'ak', '087705013213', NULL, 'Ds.Maribaya RT.07 RW.03 Kec.Kramat Kab.Tegal ', 'Tegal', '2039-04-01', 'MTsN Kota Tegal '),
('2115589', 'MUHAMMAD IKHSAN', '0077263449', 'cba8d2436b0539b5a4543e67710b4d35', 'L', 'ak', '081370548837', NULL, 'Jl.Cipto Mangunkusumo No.22 RT.03 RW.04 Kel.Kaligangsa Kec.Margadana Kota Tegal', 'Binjai', '0000-00-00', 'SMPN 15 IT Binjai Sumatera Utara'),
('2115590', 'MOH. ROGO WASKITO', '0087901113', 'e34f16a467ccaa8c4d27d0e77c4de77b', 'L', 'ak', '083149246652', NULL, 'Jl.Bali RT.14 RW.11  Kel.Mintaragen Kec.Tegal Timur  Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 12 Tegal '),
('2115591', 'MUHAMMAD ADE PUTRA JAYA', '0076845206', '6c3673aa77e3fa2cf34862f2d032bf09', 'L', 'ak', '082135595401', NULL, 'Jl.Kesambi RT.05 RW.03 Ds.Kramat Kec.Kramat Kab.Tegal', 'Tegal', '0000-00-00', 'SMPN 01 Kramat '),
('2115592', 'MUHAMMAD JIDDAN AL HABSYI', '0068702195', '73c3b68a902c923c1b3bb030448970e8', 'L', 'ak', '085223460751', NULL, 'Rusunawa CIP Besar Selatan Blok B No.513 Kel.Cipinang Besar Selatan  Kec.Jatinegara Kota Jaktim', 'Jakarta', '0000-00-00', 'MTs NU Prupuk Selatan'),
('2115593', 'MUHAMMAD KHOZI', '0074441729', '2156df4d351cd716940cb8c7ea3a1f26', 'L', 'ak', '089528934082', NULL, 'Ds.Purwahamba RT.02 RW.01 Kec.Suradadi Kab.Tegal ', 'Tegal', '0000-00-00', 'MTsN Kota Tegal '),
('2115594', 'MUHAMMAD REZA ADI NOFIKA', '0068542870', '26bc1da7514dc761286fdcbb977a304b', 'L', 'ak', '08882890956', NULL, 'Ds.Karangjati RT.05 RW.02 Kec.Tarub Kab.Tegal ', 'Tegal', '2039-02-03', 'SMPN 02 Tarub '),
('2115595', 'MUHAMMAD RIZQI SUGIARTO', '0074030186', '9668c06c4974cdaa503b5d44b89d6901', 'L', 'ak', '085228667162', NULL, 'Ds.Pakulaut RT.02 RW.07 Kec.Margasari Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 03 Margasari '),
('2115596', 'MUHAMMAD TAMAM SYACH ', '0058417199', '32cd2b25ef9c935d60e1b5ec73ad46e0', 'L', 'ak', '085102505813', NULL, 'Jl.Hang Tuah Gg.Kiper No.13 RT.02 RW.03 Kel.Tegal Sari Kec.Tegal Barat Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 06 Tegal '),
('2115597', 'NOVAL IZZAR RAMADHAN', '0067114204', '908afcf008eeb2fec7ae0ddb611bc456', 'L', 'ak', '089526267434', NULL, 'Perum Soma Square Blok J No.10  Ds.Purwahamba RT.29 RW.02 Kec.Suradadi Kab.Tegal', 'Tegal', '2039-01-01', 'SMPN 01 Kramat '),
('2115598', 'NUR ARIFIN', '0062816231', 'ba6545629d56d9fbe03db3c69cf5382a', 'L', 'ak', '085640755615', NULL, 'Ds.Suradadi RT.01 RW.08 Kec.Suradadi Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 01 Warureja '),
('2115599', 'RENDI YANUAR', '0074750970', '5c8bdb3dc694cce325051a0c75b22756', 'L', 'ak', '088220045065', NULL, 'Dk.Larangan RT.04 RW.01 Ds.Munjungagung Kec.Kramat Kab.Tegal', 'Tegal', '2039-09-07', 'SMPN 08 Tegal '),
('2115600', 'RUBBEN BUDI ADDAILAMY', '0072069447', 'db6960e26612fc374c5b4db48d27d0a6', 'L', 'ak', '087817322828', NULL, 'Ds.Lawatan RT.07 RW.02  Kec.Dukuhturi Kab.Tegal ', 'Tegal', '0000-00-00', 'SMPN 02 Dukuhturi '),
('2115601', 'TEGAR APRIANTO', '0071596696', '9e54a70316ffa523c9cf0ed0f23c6b6c', 'L', 'ak', '085877354892', NULL, 'Jl.Nakula Gg.13 No.13 RT.04  RW.06 Kel.Slerok Kec.Tegal Timur Kota Tegal', 'Tegal', '0000-00-00', 'SMPN 15 Tegal '),
('2115602', 'YANUAR AFIF PRATAMA', '0052264009', 'b1532f35dde07da9b2f7536b6789762c', 'L', 'ak', '085885758514', NULL, 'Villa Gading Harapan Blok.HT No.1 RT.27 RW.15  Babelan Bekasi', 'Bekasi', '0000-00-00', 'MTs Attaqwa 19  Bekasi Utara'),
('2115603', 'ZACKY AGIL AL HAFIZ', '0054942367', '7ef8b55063d1ead763906803c5f26c00', 'L', 'ak', '081807513133', NULL, 'Jl.Gunung Tangkuban Perahu RT.02 RW.02 Ds.Blubuk  Kec.Dukuhwaru Kab.Brebes', 'Tegal', '0000-00-00', 'SMPN 01 Dukuhwaru '),
('2115604', 'Adriyan', '9876543210', 'e388c1c5df4933fa01f6da9f92595589', 'L', 'kj', NULL, NULL, NULL, NULL, NULL, NULL),
('2115605', 'Fadil', '1324576890', '0264ffe629a401393829f483a8444e6b', 'L', 'kj', NULL, NULL, NULL, NULL, NULL, NULL),
('2115606', 'Kholid', '9078563412', 'a7eb63189beea43dbd96e02ac9e4d3de', 'L', 'ot', NULL, NULL, NULL, NULL, NULL, NULL),
('2115607', 'Teveen', '5647382910', '5d703c921df9518d8b60226f01a82b95', 'L', 'mm', NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Triggers `siswa`
--
DELIMITER $$
CREATE TRIGGER `siswa_before_insert` BEFORE INSERT ON `siswa` FOR EACH ROW BEGIN
   DECLARE vid char(32);
   DECLARE id INT;
   SELECT MD5(NEW.nisn) INTO vid;  
   SELECT MAX(nipd)+1 FROM `siswa` INTO id;
   SET NEW.password = vid;
   SET NEW.nipd = id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `siswa_baru_belum_ploting_kelas`
-- (See below for the actual view)
--
CREATE TABLE `siswa_baru_belum_ploting_kelas` (
`nipd` char(7)
,`nama` varchar(30)
,`jurusan` varchar(25)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `siswa_belum_ploting_kelas`
-- (See below for the actual view)
--
CREATE TABLE `siswa_belum_ploting_kelas` (
`nipd` char(7)
,`nisn` char(10)
,`nama` varchar(30)
,`jurusan` varchar(25)
,`kelas_sebelumnya` varchar(10)
,`tahun` char(9)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `siswa_kelas`
-- (See below for the actual view)
--
CREATE TABLE `siswa_kelas` (
`nipd` char(7)
,`nisn` char(10)
,`nama` varchar(30)
,`jurusan` varchar(25)
,`kelas` varchar(10)
,`tahun` char(9)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `siswa_kelas_tahun_ini`
-- (See below for the actual view)
--
CREATE TABLE `siswa_kelas_tahun_ini` (
`nipd` char(7)
,`nisn` char(10)
,`nama` varchar(30)
,`jurusan` varchar(25)
,`kelas` varchar(10)
,`tahun` char(9)
);

-- --------------------------------------------------------

--
-- Table structure for table `soal`
--

CREATE TABLE `soal` (
  `id` int(11) NOT NULL,
  `soal` varchar(100) NOT NULL,
  `jawaban` varchar(255) NOT NULL,
  `kategori_soal_id` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `soal`
--

INSERT INTO `soal` (`id`, `soal`, `jawaban`, `kategori_soal_id`) VALUES
(1, 'apa itu php', 'bahasa pemrogramman', 'T');

-- --------------------------------------------------------

--
-- Table structure for table `tahun_akademik`
--

CREATE TABLE `tahun_akademik` (
  `id` char(4) NOT NULL,
  `tahun` char(9) NOT NULL,
  `mulai` date NOT NULL,
  `selesai` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tahun_akademik`
--

INSERT INTO `tahun_akademik` (`id`, `tahun`, `mulai`, `selesai`) VALUES
('1920', '2019/2020', '2019-07-01', '2020-06-30'),
('2021', '2020/2021', '2020-07-01', '2021-06-30'),
('2122', '2021/2022', '2021-07-01', '2022-06-30'),
('2223', '2022/2023', '2022-07-01', '2023-06-30'),
('2324', '2023/2024', '2023-07-01', '2024-06-30');

-- --------------------------------------------------------

--
-- Stand-in structure for view `wali_kelas`
-- (See below for the actual view)
--
CREATE TABLE `wali_kelas` (
`tahun` char(9)
,`kelas` varchar(10)
,`jurusan` varchar(25)
,`nip` char(16)
,`nama` varchar(30)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `wali_kelas_bukan_tahun_ini`
-- (See below for the actual view)
--
CREATE TABLE `wali_kelas_bukan_tahun_ini` (
`nip` char(16)
,`nama` varchar(30)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `wali_kelas_tahun_ini`
-- (See below for the actual view)
--
CREATE TABLE `wali_kelas_tahun_ini` (
`tahun` char(9)
,`nip` char(16)
,`nama` varchar(30)
,`kelas` varchar(10)
,`jurusan` varchar(25)
);

-- --------------------------------------------------------

--
-- Structure for view `kelas_belum_ploting_walinya`
--
DROP TABLE IF EXISTS `kelas_belum_ploting_walinya`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `kelas_belum_ploting_walinya`  AS SELECT `kelas`.`id` AS `id`, `kelas`.`kelas` AS `kelas` FROM (`kelas` left join `wali_kelas_tahun_ini` on(`kelas`.`kelas` = `wali_kelas_tahun_ini`.`kelas`)) WHERE `wali_kelas_tahun_ini`.`nama` is nullnull  ;

-- --------------------------------------------------------

--
-- Structure for view `siswa_baru_belum_ploting_kelas`
--
DROP TABLE IF EXISTS `siswa_baru_belum_ploting_kelas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `siswa_baru_belum_ploting_kelas`  AS SELECT `siswa`.`nipd` AS `nipd`, `siswa`.`nama` AS `nama`, `jurusan`.`jurusan` AS `jurusan` FROM ((`siswa` left join `plot_kelas` on(`siswa`.`nipd` = `plot_kelas`.`siswa_nipd`)) join `jurusan` on(`jurusan`.`id` = `siswa`.`jurusan_id`)) WHERE `plot_kelas`.`bagi_kelas_id` is nullnull  ;

-- --------------------------------------------------------

--
-- Structure for view `siswa_belum_ploting_kelas`
--
DROP TABLE IF EXISTS `siswa_belum_ploting_kelas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `siswa_belum_ploting_kelas`  AS SELECT `siswa_kelas`.`nipd` AS `nipd`, `siswa_kelas`.`nisn` AS `nisn`, `siswa_kelas`.`nama` AS `nama`, `siswa_kelas`.`jurusan` AS `jurusan`, `siswa_kelas`.`kelas` AS `kelas_sebelumnya`, `siswa_kelas`.`tahun` AS `tahun` FROM (`siswa_kelas` join `tahun_akademik` on(`tahun_akademik`.`tahun` = `siswa_kelas`.`tahun`)) WHERE `tahun_akademik`.`mulai` <= sysdate() + interval -356 day AND `tahun_akademik`.`selesai` >= sysdate() + interval -356 dayday  ;

-- --------------------------------------------------------

--
-- Structure for view `siswa_kelas`
--
DROP TABLE IF EXISTS `siswa_kelas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `siswa_kelas`  AS SELECT `siswa`.`nipd` AS `nipd`, `siswa`.`nisn` AS `nisn`, `siswa`.`nama` AS `nama`, `jurusan`.`jurusan` AS `jurusan`, `kelas`.`kelas` AS `kelas`, `tahun_akademik`.`tahun` AS `tahun` FROM (((((`siswa` join `jurusan` on(`jurusan`.`id` = `siswa`.`jurusan_id`)) join `plot_kelas` on(`plot_kelas`.`siswa_nipd` = `siswa`.`nipd`)) join `bagi_kelas` on(`bagi_kelas`.`id` = `plot_kelas`.`bagi_kelas_id`)) join `kelas` on(`kelas`.`id` = `bagi_kelas`.`kelas_id`)) join `tahun_akademik` on(`tahun_akademik`.`id` = `bagi_kelas`.`tahun_akademik_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `siswa_kelas_tahun_ini`
--
DROP TABLE IF EXISTS `siswa_kelas_tahun_ini`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `siswa_kelas_tahun_ini`  AS SELECT `siswa_kelas`.`nipd` AS `nipd`, `siswa_kelas`.`nisn` AS `nisn`, `siswa_kelas`.`nama` AS `nama`, `siswa_kelas`.`jurusan` AS `jurusan`, `siswa_kelas`.`kelas` AS `kelas`, `siswa_kelas`.`tahun` AS `tahun` FROM (`siswa_kelas` join `tahun_akademik` on(`tahun_akademik`.`tahun` = `siswa_kelas`.`tahun`)) WHERE `tahun_akademik`.`mulai` <= sysdate() AND `tahun_akademik`.`selesai` >= sysdate()  ;

-- --------------------------------------------------------

--
-- Structure for view `wali_kelas`
--
DROP TABLE IF EXISTS `wali_kelas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wali_kelas`  AS SELECT `tahun_akademik`.`tahun` AS `tahun`, `kelas`.`kelas` AS `kelas`, `jurusan`.`jurusan` AS `jurusan`, `guru`.`nip` AS `nip`, `guru`.`nama` AS `nama` FROM ((((`guru` join `bagi_kelas` on(`guru`.`nip` = `bagi_kelas`.`guru_nip`)) join `tahun_akademik` on(`tahun_akademik`.`id` = `bagi_kelas`.`tahun_akademik_id`)) join `kelas` on(`kelas`.`id` = `bagi_kelas`.`kelas_id`)) join `jurusan` on(`jurusan`.`id` = `kelas`.`jurusan_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `wali_kelas_bukan_tahun_ini`
--
DROP TABLE IF EXISTS `wali_kelas_bukan_tahun_ini`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wali_kelas_bukan_tahun_ini`  AS SELECT `guru`.`nip` AS `nip`, `guru`.`nama` AS `nama` FROM (`guru` left join `wali_kelas_tahun_ini` on(`guru`.`nip` = `wali_kelas_tahun_ini`.`nip`)) WHERE `wali_kelas_tahun_ini`.`kelas` is nullnull  ;

-- --------------------------------------------------------

--
-- Structure for view `wali_kelas_tahun_ini`
--
DROP TABLE IF EXISTS `wali_kelas_tahun_ini`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wali_kelas_tahun_ini`  AS SELECT `wali_kelas`.`tahun` AS `tahun`, `wali_kelas`.`nip` AS `nip`, `wali_kelas`.`nama` AS `nama`, `wali_kelas`.`kelas` AS `kelas`, `wali_kelas`.`jurusan` AS `jurusan` FROM (`wali_kelas` join `tahun_akademik` on(`wali_kelas`.`tahun` = `tahun_akademik`.`tahun`)) WHERE `tahun_akademik`.`mulai` <= sysdate() AND `tahun_akademik`.`selesai` >= sysdate()  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `absensi_guru_fk` (`guru_nip`);

--
-- Indexes for table `bagi_kelas`
--
ALTER TABLE `bagi_kelas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bagi_kelas_guru_fk` (`guru_nip`),
  ADD KEY `bagi_kelas_kelas_fk` (`kelas_id`),
  ADD KEY `bagi_kelas_tahun_akademik_fk` (`tahun_akademik_id`);

--
-- Indexes for table `guru`
--
ALTER TABLE `guru`
  ADD PRIMARY KEY (`nip`),
  ADD KEY `guru_level_fk` (`level_id`);

--
-- Indexes for table `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategori_soal`
--
ALTER TABLE `kategori_soal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kehadiran`
--
ALTER TABLE `kehadiran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kehadiran_keterangan_fk` (`keterangan_id`),
  ADD KEY `kehadiran_pertemuan_fk` (`pertemuan_id`),
  ADD KEY `kehadiran_siswa_fk` (`siswa_nipd`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kelas_jurusan_fk` (`jurusan_id`);

--
-- Indexes for table `keterangan`
--
ALTER TABLE `keterangan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pertemuan`
--
ALTER TABLE `pertemuan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `plot_kelas`
--
ALTER TABLE `plot_kelas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plot_kelas_bagi_siswa_fk` (`bagi_kelas_id`),
  ADD KEY `plot_kelas_siswa_fk` (`siswa_nipd`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`nipd`),
  ADD KEY `siswa_jurusan_fk` (`jurusan_id`);

--
-- Indexes for table `soal`
--
ALTER TABLE `soal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `soal_kategori_soal_fk` (`kategori_soal_id`);

--
-- Indexes for table `tahun_akademik`
--
ALTER TABLE `tahun_akademik`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kehadiran`
--
ALTER TABLE `kehadiran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plot_kelas`
--
ALTER TABLE `plot_kelas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1199;

--
-- AUTO_INCREMENT for table `soal`
--
ALTER TABLE `soal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensi`
--
ALTER TABLE `absensi`
  ADD CONSTRAINT `absensi_ibfk_1` FOREIGN KEY (`guru_nip`) REFERENCES `guru` (`nip`);

--
-- Constraints for table `bagi_kelas`
--
ALTER TABLE `bagi_kelas`
  ADD CONSTRAINT `bagi_kelas_guru_fk` FOREIGN KEY (`guru_nip`) REFERENCES `guru` (`nip`),
  ADD CONSTRAINT `bagi_kelas_kelas_fk` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id`),
  ADD CONSTRAINT `bagi_kelas_tahun_akademik_fk` FOREIGN KEY (`tahun_akademik_id`) REFERENCES `tahun_akademik` (`id`);

--
-- Constraints for table `guru`
--
ALTER TABLE `guru`
  ADD CONSTRAINT `guru_level_fk` FOREIGN KEY (`level_id`) REFERENCES `level` (`id`);

--
-- Constraints for table `kehadiran`
--
ALTER TABLE `kehadiran`
  ADD CONSTRAINT `kehadiran_keterangan_fk` FOREIGN KEY (`keterangan_id`) REFERENCES `keterangan` (`id`),
  ADD CONSTRAINT `kehadiran_pertemuan_fk` FOREIGN KEY (`pertemuan_id`) REFERENCES `pertemuan` (`id`),
  ADD CONSTRAINT `kehadiran_siswa_fk` FOREIGN KEY (`siswa_nipd`) REFERENCES `siswa` (`nipd`);

--
-- Constraints for table `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `kelas_jurusan_fk` FOREIGN KEY (`jurusan_id`) REFERENCES `jurusan` (`id`);

--
-- Constraints for table `plot_kelas`
--
ALTER TABLE `plot_kelas`
  ADD CONSTRAINT `plot_kelas_bagi_kelas_fk` FOREIGN KEY (`bagi_kelas_id`) REFERENCES `bagi_kelas` (`id`),
  ADD CONSTRAINT `plot_kelas_siswa_fk` FOREIGN KEY (`siswa_nipd`) REFERENCES `siswa` (`nipd`);

--
-- Constraints for table `siswa`
--
ALTER TABLE `siswa`
  ADD CONSTRAINT `siswa_jurusan_fk` FOREIGN KEY (`jurusan_id`) REFERENCES `jurusan` (`id`);

--
-- Constraints for table `soal`
--
ALTER TABLE `soal`
  ADD CONSTRAINT `soal_kategori_soal_fk` FOREIGN KEY (`kategori_soal_id`) REFERENCES `kategori_soal` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
