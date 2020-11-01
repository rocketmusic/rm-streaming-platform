-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 01, 2020 at 11:54 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spotify`
--

-- --------------------------------------------------------

--
-- Table structure for table `albums`
--

CREATE TABLE `albums` (
  `id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `artist` int(11) NOT NULL,
  `genre` int(11) NOT NULL,
  `artworkPath` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `albums`
--

INSERT INTO `albums` (`id`, `title`, `artist`, `genre`, `artworkPath`) VALUES
(1, 'Hope for the Holiday', 1, 1, 'assets/images/artwork/hope_for_the_holidays.jpg'),
(2, 'Claire De Lune', 2, 2, 'assets/images/artwork/claire_de_lune.jpg'),
(3, 'Classical Piano Relaxation', 3, 3, 'assets/images/artwork/classical_piano_meditation.jpg'),
(4, 'Happy Holy Days', 4, 4, 'assets/images/artwork/happy_holy_days.jpg'),
(5, 'Emmanuel', 5, 1, 'assets/images/artwork/emmanuel.jpg'),
(6, 'Deeper Still', 6, 5, 'assets/images/artwork/deeper_still.jpg'),
(7, 'Christmas', 1, 6, 'assets/images/artwork/christmas.jpg'),
(8, 'Silent Night', 7, 1, 'assets/images/artwork/silent_night.jpg'),
(9, 'Running Tracks', 8, 7, 'assets/images/artwork/running_track.jpg'),
(10, 'Chegou de Manso SINGLE', 9, 8, 'assets\\images\\artwork\\chegou_de_manso.jpg'),
(11, 'Scorpion', 10, 9, 'assets\\images\\artwork\\scorpion_drake.jpg'),
(12, 'Barões da Pisadinha - Ao vivo', 11, 10, 'assets\\images\\artwork\\baroes_da_pisadinha.jpg'),
(13, 'Jonas Esticado', 12, 10, 'assets\\images\\artwork\\jonas_esticado.jpg'),
(14, 'Leo Gomes', 13, 10, 'assets\\images\\artwork\\leo_gomes.jpg'),
(15, 'Ariana Grande', 14, 4, 'assets\\images\\artwork\\sweetener.jpg'),
(16, 'No bad vibes today', 15, 4, 'assets\\images\\artwork\\broderick.jpg'),
(17, 'Bright and early', 16, 9, 'assets\\images\\artwork\\locs.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`id`, `name`) VALUES
(1, 'Mark Smelby'),
(2, 'Nicholas York'),
(3, 'Classical Meditation'),
(4, '11 Acorn Lane'),
(5, 'Fielder Church'),
(6, 'Kimberly & Roberto Reviera'),
(7, 'Kristen Chambers'),
(8, 'Caius Lear'),
(9, 'Lagum'),
(10, 'Drake'),
(11, 'Barões da Pisadinha'),
(12, 'Jonas Esticado'),
(13, 'Leo Gomes'),
(14, 'Ariana Grande'),
(15, 'Broderick Jones'),
(16, 'LOCS');

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`id`, `name`) VALUES
(1, 'Holiday'),
(2, 'Hymn'),
(3, 'Classical'),
(4, 'Pop'),
(5, 'Gospel'),
(6, 'Country'),
(7, 'R&B'),
(8, 'MPB'),
(9, 'Rap'),
(10, 'Forró');

-- --------------------------------------------------------

--
-- Table structure for table `playlists`
--

CREATE TABLE `playlists` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `dateCreated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `playlists`
--

INSERT INTO `playlists` (`id`, `name`, `owner`, `dateCreated`) VALUES
(1, 'Playlist do Leo', 'leo123', '2020-10-31 00:00:00'),
(2, 'Musicas para churrasco', 'Admin', '2020-10-31 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `playlistsongs`
--

CREATE TABLE `playlistsongs` (
  `id` int(11) NOT NULL,
  `songId` int(11) NOT NULL,
  `playlistId` int(11) NOT NULL,
  `playlistOrder` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `playlistsongs`
--

INSERT INTO `playlistsongs` (`id`, `songId`, `playlistId`, `playlistOrder`) VALUES
(1, 2, 1, 0),
(2, 11, 1, 1),
(3, 21, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `songs`
--

CREATE TABLE `songs` (
  `id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `artist` int(11) NOT NULL,
  `album` int(11) NOT NULL,
  `genre` int(11) NOT NULL,
  `duration` varchar(8) NOT NULL,
  `path` varchar(500) NOT NULL,
  `albumOrder` int(11) NOT NULL,
  `plays` int(11) NOT NULL,
  `Likes` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `songs`
--

INSERT INTO `songs` (`id`, `title`, `artist`, `album`, `genre`, `duration`, `path`, `albumOrder`, `plays`, `Likes`) VALUES
(1, 'Angels We Have Heard on High', 1, 1, 1, '3:08', 'assets/music/angels_we_have_heard_on_high.mp3', 1, 57, 0),
(2, 'Ave Maria', 2, 2, 2, '2:02', 'assets/music/ave_maria.mp3', 1, 55, 0),
(3, 'Cannon in D', 3, 3, 3, '7:44', 'assets/music/canon_in_d.mp3', 1, 64, 0),
(4, 'Deck the Halls', 4, 4, 4, '2:16', 'assets/music/deck_the_halls.mp3', 1, 44, 0),
(5, 'Do You Hear What I Hear', 5, 5, 1, '3:49', 'assets/music/do_you_hear_what_i_hear.mp3', 1, 65, 0),
(6, 'Hark the Herald Angels Sing', 5, 5, 1, '4:40', 'assets/music/hark_the_herald_angels_sing.mp3', 2, 66, 0),
(7, 'How Great is Our God', 6, 6, 5, '5:08', 'assets/music/bensound-funnysong.mp3', 1, 30, 0),
(8, 'It Came Upon a Midnight Clear', 5, 5, 1, '4:13', 'assets/music/it_came_upon_a_midnight_clear.mp3', 3, 63, 0),
(9, 'Mary Did You Know', 1, 7, 6, '3:40', 'assets/music/mary_did_you_know.mp3', 1, 29, 0),
(10, 'Silent Night', 7, 8, 1, '4:12', 'assets/music/silent_night.mp3', 1, 56, 0),
(11, 'Unbreak My Heart', 8, 9, 7, '4:22', 'assets/music/unbreak_my_ heart.mp3', 1, 44, 0),
(12, 'Chegou de Manso', 9, 10, 8, '2:57', 'assets\\music\\chegou_de_manso.mp3', 1, 126, 0),
(13, 'God\'s Plan', 10, 11, 9, '5:57', 'assets\\music\\gods_plan.mp3', 1, 214, 0),
(14, 'Survival', 10, 11, 9, '2:16', 'assets\\music\\survival.mp3', 2, 178, 2),
(15, 'Nonstop', 10, 11, 9, '5:16', 'assets\\music\\non_stop.mp3', 3, 342, 0),
(16, 'Ta rocheda', 11, 12, 10, '3:32', 'assets\\music\\ta_rocheda.mp3', 1, 509, 0),
(17, 'Investe em mim', 12, 13, 10, '3:20', 'assets\\music\\investe_em_mim.mp3', 1, 500, 0),
(18, 'Casa de Praia', 11, 12, 10, '2:26', 'assets\\music\\casa_de_Praia_Ao_Vivo.mp3', 2, 510, 0),
(19, 'Cabeça Voando', 11, 12, 10, '3:05', 'assets\\music\\cabeca_Voando.mp3', 3, 503, 0),
(20, 'Recairei', 11, 12, 10, '2:46', 'assets\\music\\recairei.mp3', 4, 502, 0),
(21, 'O pai ta ON', 13, 14, 10, '3:43', 'assets\\music\\o_pai_ta_on.mp3', 1, 34, 2),
(22, 'Não valorizou, perdeu', 13, 14, 10, '2:26', 'assets\\music\\nao_valorizou_perdeu.mp3', 2, 33, 1),
(23, '34+35', 14, 15, 4, '2:54', 'assets\\music\\3435.mp3', 1, 502, 0),
(24, 'Motive', 14, 15, 4, '2:49', 'assets\\music\\motive.mp3', 2, 504, 0),
(25, 'Positions', 14, 15, 4, '2:51', 'assets\\music\\positions.mp3', 3, 500, 0),
(26, 'Dont Leave Me Hanging', 15, 16, 4, '3:38', 'assets\\music\\Dont_Leave_Me_Hanging.mp3', 1, 5, 0),
(27, 'I heard', 15, 16, 4, '2:27', 'assets\\musicic\\heard.mp3', 2, 4, 0),
(28, '', 16, 17, 9, '03:02', 'assets\\music\\bright_and_early.mp3', 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(25) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(32) NOT NULL,
  `signUpDate` datetime NOT NULL,
  `profilePic` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `firstName`, `lastName`, `email`, `password`, `signUpDate`, `profilePic`) VALUES
(1, 'reece-kenney', 'Reece', 'Kenney', 'Reece@gmail.com', '5f4dcc3b5aa765d61d8327deb882cf99', '2017-06-28 00:00:00', 'assets/images/profile-pics/head_emerald.png'),
(2, 'donkey-kong', 'Donkey', 'Kong', 'Dk@yahoo.com', '7c6a180b36896a0a8c02787eeafb0e4c', '2017-06-28 00:00:00', 'assets/images/profile-pics/head_emerald.png'),
(3, 'leo123', 'Leo', 'Leo', 'Leonardo.abreu@globo.com', '657b298b04e033810343842f993c9817', '2020-10-31 00:00:00', 'assets/images/profile-pics/head_emerald.png'),
(4, 'Admin', 'Admin', '00', 'Admin@gmail.com', 'e3afed0047b08059d0fada10f400c1e5', '2020-10-31 00:00:00', 'assets/images/profile-pics/head_emerald.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `albums`
--
ALTER TABLE `albums`
  ADD PRIMARY KEY (`id`),
  ADD KEY `genre` (`genre`),
  ADD KEY `artist` (`artist`);

--
-- Indexes for table `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `playlists`
--
ALTER TABLE `playlists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `playlistsongs`
--
ALTER TABLE `playlistsongs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `album` (`album`),
  ADD KEY `genre` (`genre`),
  ADD KEY `artist` (`artist`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `albums`
--
ALTER TABLE `albums`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `playlists`
--
ALTER TABLE `playlists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `playlistsongs`
--
ALTER TABLE `playlistsongs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `songs`
--
ALTER TABLE `songs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `albums`
--
ALTER TABLE `albums`
  ADD CONSTRAINT `albums_ibfk_1` FOREIGN KEY (`genre`) REFERENCES `genres` (`id`),
  ADD CONSTRAINT `albums_ibfk_2` FOREIGN KEY (`artist`) REFERENCES `artists` (`id`);

--
-- Constraints for table `songs`
--
ALTER TABLE `songs`
  ADD CONSTRAINT `songs_ibfk_1` FOREIGN KEY (`album`) REFERENCES `albums` (`id`),
  ADD CONSTRAINT `songs_ibfk_2` FOREIGN KEY (`genre`) REFERENCES `genres` (`id`),
  ADD CONSTRAINT `songs_ibfk_3` FOREIGN KEY (`artist`) REFERENCES `artists` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
