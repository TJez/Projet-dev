-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 10, 2020 at 05:02 PM
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
  `Latitude_2` float NOT NULL,
  `Longitude_2` float NOT NULL,
  `Zoom_min` int(11) NOT NULL,
  `Icone` text NOT NULL,
  `Type` text NOT NULL,
  `Indice` text NOT NULL,
  `Temps2` int(11) NOT NULL,
  `Indice2` text NOT NULL,
  `Temps3` int(11) NOT NULL,
  `Indice_final` text NOT NULL,
  `Depart` tinyint(1) NOT NULL,
  `Bloque_par` int(11) DEFAULT NULL,
  `Suivant` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `objet`
--

INSERT INTO `objet` (`ID`, `Nom`, `Latitude`, `Longitude`, `Latitude_2`, `Longitude_2`, `Zoom_min`, `Icone`, `Type`, `Indice`, `Temps2`, `Indice2`, `Temps3`, `Indice_final`, `Depart`, `Bloque_par`, `Suivant`) VALUES
(1, 'Porte', 48.8574, 2.2935, 48.8594, 2.2955, 3, '../Images/Porte.jpg\r\n', 'bloque_cadenas', 'Pour la première fois, vous pensez pouvoir monter dans la Tour Eiffel mais une porte avec un code vous bloque le passage. Dessus, voici le mot écrit :\r\n\"Le code est caché dans un coffre qui touche le ciel de la France\"', 2, 'Le code se trouve sur la plus haute montagne de France', 2, 'Le code se trouve sur le Mont-Blanc', 1, 34, '5'),
(2, 'Coffre', 45.8316, 6.8641, 45.8336, 6.8661, 12, '../Images/coffre.png', 'bloque_cle', 'La clé se trouve dans un des lieux touristiques les plus visités en France connu pour ses petits gâteaux.', 2, 'La clé ne sait pas si elle est bretonne ou normande', 2, 'La clé se trouve au Mont-Saint-Michel', 1, 3, '6'),
(3, 'Cle', 45.8471, 1.2573, 45.8491, 1.2603, 10, '../Images/cle.png', 'recuperable', '', 0, '', 0, '', 0, NULL, NULL),
(4, 'Code 1', 45.8336, 6.8641, 45.8356, 6.8661, 13, '../Images/parchemin.jpg\r\n\r\n', 'recuperable_texte', 'Le code est 6536', 0, '', 0, '', 0, NULL, NULL),
(5, 'Porte ouverte', 48.8574, 2.2935, 48.8594, 2.2955, 3, '../Images/Porte_ouverte.jpg', 'fin', 'Félicitation, vous pouvez enfin accéder à la Tour Eiffel !', 0, '', 0, '', 0, NULL, NULL),
(6, 'Coffre ouvert', 45.8316, 6.8641, 45.8336, 6.8661, 12, '../Images/CoffreOuv.png', 'inutile', 'Vous continuez d\'observer le Mont Blanc mais cela ne vous avance guère dans votre quête.', 0, '', 0, '', 0, NULL, '4'),
(7, 'Mont-Saint-Michel', 48.6354, -1.5145, 48.6374, -1.5125, 12, '../Images/passant.png', 'bloque_cle', 'Vous cherchez une clé !\r\nJ\'en ai récupéré une l\'autre jour que j\'ai rangé dans ma voiture mais j\'ai perdu les clé de ma voiture. Il me semble les avoir perdu dans le plus vaste château du Centre-Val-de-Loire.\r\nSi vous les retrouvez, ramenez-les moi et vous pourrez récupérer votre clé.', 2, 'Je me rappelle que c\'est un château construit par François Ier', 2, 'Je me souviens ! J\'ai perdu mes clé au château de Chambord', 1, 11, '12'),
(8, 'Château de Chambord', 47.611, 1.5142, 47.616, 1.5202, 12, '../Images/chateau_chambord.jpg', 'bloque_cadenas', 'Visite interdite aujourd\'hui !\r\nMais vous trouver un petit papier sous le paillasson à l\'entrée :\r\nNote au gardien !\r\nSi vous avez encore oublié le code, rappelez-vous que la première partie du code est en rapport avec le lieu de la mort de Charles VIII et la deuxième partie avec l\'endroit où les voitures roulent pendant 24H.\r\nSi vous vous ne rappelez toujours pas, allez sur place, il y a d\'autres indices', 3, 'Vous continuez de fouillez autour du château et trouvez un autre mémo :\r\nNote au gardien 2 !!\r\nSi vous n\'avez rien compris à la note précédente, vous me désespérez mais la première partie du code se trouve au château d\'Amboise et la deuxième partie se trouve sur le circuit des 24h du Mans ', 3, 'En vous promenant dans l\'immense jardin, vous trouvez une autre note :\r\nNote au gardien 3 !!!!!!\r\nArrêtez de flânez ! Les indications sont clairs, Charles VIII est mort en 1498 et c\'est la voiture 8 qui a gagné les derniers 24h du Mans', 1, 22, '11'),
(9, 'Chateau d\'Amboise', 47.4134, 0.9872, 47.4154, 0.9892, 14, '../Images/feuille.jpeg', 'recuperable_texte', 'Les trois premiers chiffres correspondent aux trois derniers chiffres de l\'année de la mort de Charles VIII', 0, '', 0, '', 1, NULL, NULL),
(10, '24h du Mans', 47.9574, 0.2116, 47.9594, 0.2136, 12, '../Images/mans.jpg', 'recuperable_texte', 'Le dernier chiffre correspond au numéro de la voiture vainqueur de l\'édition 2020', 0, '', 0, '', 1, NULL, NULL),
(11, 'Clé de voiture', 47.611, 1.5142, 47.613, 1.5162, 12, '../Images/cle_voiture.jpg', 'recuperable', '', 0, '', 0, '', 0, NULL, NULL),
(12, 'Voiture perdu', 48.6354, -1.5145, 48.6374, -1.5125, 12, '../Images/passant.png', 'information', 'Merci d\'avoir retrouvé mes clés mais j\'ai oublié de vous précisé que ma voiture n\'est pas ici comme je ne pouvais plus l\'utiliser. Je l\'ai laissé au port de l\'Orient.\r\nPrenez mes clés de voiture et vous pourrez récupérer celle que vous chercher.\r\nPour reconnaitre ma voiture, je vous laisse ces indications.', 0, '', 0, '', 0, NULL, '32,13,14,15'),
(13, 'Lorient', 47.7383, -3.3557, 47.7403, -3.3537, 11, '../Images/gendarme.png\r\n', 'bloque_cle', 'Oui, j\'ai déjà vu cette voiture. Je l\'ai emmené à la fourrière car elle était mal garée.\r\nJe veux bien vous dire à quelle fourrière  elle est mais, pour cela, vous devez me ramener du nougat. Mais attention, je veux le meilleur.', 2, 'Pour vous aider, vous devez aller dans la ville connu pour le nougat', 2, 'Vous avez pas l\'air fûtes fûtes donc apportez moi du nougat de Montélimar ', 0, 15, '16'),
(14, 'Description voiture', 48.6334, -1.5125, 48.6354, -1.5105, 12, '../Images/note.jpg', 'recuperable_texte', 'Ma voiture est un utilitaire Renault noir', 0, '', 0, '', 0, NULL, NULL),
(15, 'Montélimar', 44.5582, 4.7496, 44.5602, 4.7516, 10, '../Images/nougat.jpg', 'recuperable', '', 0, '', 0, '', 0, NULL, NULL),
(16, 'Direction la fourrière', 47.7383, -3.3557, 47.7403, -3.3537, 12, '../Images/gendarme.png', 'information', 'Merci beaucoup, ils sont délicieux. Voilà un petit rebus pour vous indiquer dans quelle ville se trouve la fourrière :\r\nOn dort sur mon premier, mon deuxième permet de former des phrases et mon troisième est le pronom personnel de la première personne du singulier.', 2, 'Arrêtez de me regarder avec ces gros yeux. J\'ai compris que vous n\'avez rien compris, la voiture se trouve à la fourrière de Limoges.', 0, '', 0, NULL, '17,18,19'),
(17, 'Voiture 1', 45.8451, 1.2533, 45.8471, 1.2563, 12, '../Images/voiture1.jpg', 'inutile', 'Vous observez la voiture et vous demandez si ce n\'est pas la votre mais vous vous rappelez que ce n\'est pas la voiture que vous chercher', 0, '', 0, '', 0, NULL, NULL),
(18, 'Voiture 2', 45.8451, 1.2503, 45.8471, 1.2533, 12, '../Images/voiture2.jpg', 'inutile', 'Oui, vous avez avez enfin trouvé la voiture. Puis vous réfléchissez et vous dites qu\'il n\'y a pas le bon logo à l\'avant de la voiture', 0, '', 0, '', 0, NULL, NULL),
(19, 'Voiture 3', 45.8451, 1.2563, 45.8471, 1.2593, 12, '../Images/voiture3.jpg', 'bloque_cle', 'Oui, vous avez trouvé la voiture mais pensez quand même à utiliser la clé pour l\'ouvrir', 0, '', 0, '', 0, 32, '30'),
(20, 'Fourrière fermée', 45.8431, 1.2553, 45.8451, 1.2573, 10, '../Images/gendarme.png', 'bloque_cle', 'Quand vous revenez discrètement vous observez un gendarme qui surveille les alentours. Vous ne pouvez rentrer dans la fourrière mais vous vous rappelez que vous avez un costume de gendarme dans votre maison au pied du volcan le plus connu de France métropolitaine.', 2, 'Votre mémoire commence à vous faire défaut, vous avez du mal à vous rappelez précisément où est votre maison mais vous vous souvenez qu\'elle se trouve dans la chaîne des Puys.', 2, 'Ca y est ! Vous vous êtes rappelés que votre maison se trouve au pied du Puy de Dôme.', 0, 26, '27'),
(21, 'Maison fermée', 45.7648, 2.9631, 45.7668, 2.9651, 12, '../Images/maison.jpg', 'bloque_cadenas', 'Vous arrivez chez vous mais ne pouvez ouvrir la porte. Votre code ne marche plus. Votre femme a encore dû le changer sans vous prévenir. Vous vous rappeler qu\'elle est parti visiter un autre monument : une basilique en haut d\'une colline', 2, 'Vous vous souvenez aussi qu\'elle vous a dit qu\'elle partait à Lyon', 2, 'Vous vous rappelez précisément qu\'elle est parti visiter la basilique Notre Dame de Fourvière', 0, 31, '25'),
(22, 'Code Chambord', 0, 0, 0, 0, 0, '', 'code', '4988', 0, '', 0, '', 0, NULL, NULL),
(23, 'Femme', 45.7623, 4.822, 45.7643, 4.824, 12, '../Images/femmme.jpg', 'information', 'Quand vous lui demander le code de la maison, votre femme s\'énerve en disant qu\'elle vous avait déjà envoyé le code sur votre téléphone (que vous ne regarder jamais). Mais elle vous redonne le code quand même : 2835', 0, '', 0, '', 0, NULL, NULL),
(24, 'Voiture maison', 45.767, 2.9653, 45.769, 2.9673, 12, '../Images/voiture1.jpg', 'inutile', 'Vous poussez un ouf de soulagement en voyant votre voiture ici. Ce n\'était pas elle à la fourrière', 0, '', 0, '', 0, NULL, NULL),
(25, 'Maison ouverte', 45.7648, 2.9631, 45.7668, 2.9651, 12, '../Images/maison.jpg', 'inutile', 'Vous êtes vraiment heureux de voir une si belle maison mais la regarder ne vous aidera pas à accéder à la Tour Eiffel', 0, '', 0, '', 0, NULL, '26'),
(26, 'Déguisement gendarme', 45.7626, 2.9609, 45.7646, 2.9629, 12, '../Images/deguisement.jpg', 'recuperable', '', 0, '', 0, '', 0, NULL, NULL),
(27, 'Fourrière ouverte', 45.8431, 1.2553, 45.8451, 1.2573, 10, '../Images/gendarme.png', 'information', 'Le gendarme vous regarde, vous salue et vous laisse entrer dans la fourrière', 0, '', 0, '', 0, NULL, '28,'),
(28, 'Bonne voiture', 45.8451, 1.2593, 45.8471, 1.2623, 10, '../Images/voiture3.jpg', 'bloque_cle', 'Non loin de la voiture de tout à l\'heure, vous trouver une voiture identique à celle-ci. Allez, essayez de nouveau pour voir si c\'est la bonne.', 0, '', 0, '', 0, 33, '29'),
(29, 'Voiture inutile', 45.8451, 1.2573, 45.8471, 1.2593, 10, '../Images/voiture3.jpg', 'inutile', 'Après tous les problèmes que vous a posé cette voiture, vous hésitez à partir avec mais vous vous rétractez. ', 0, '', 0, '', 0, NULL, '3'),
(30, 'Alarme', 45.8451, 1.2563, 45.8471, 1.2593, 10, '../Images/voiture3.jpg', 'information', 'Vous essayez d\'ouvrir la voiture mais celle-ci reste fermée, vous forcez la poignée et l\'alarme de la voiture s\'allume. Vous vous enfuyez de peur et faites tomber vos clé.\r\nPensez à les rammasser en vous enfuyant', 0, '', 0, '', 0, NULL, '20,21,23,24,33'),
(31, 'téléphone', 43.7643, 4.822, 43.7663, 4.824, 12, '', 'code', '2835', 0, '', 0, '', 0, NULL, NULL),
(32, 'Clé de voiture 2', 48.6334, -1.5145, 48.6354, -1.5125, 12, '../Images/cle_voiture.jpg\r\n', 'recuperable', '', 0, '', 0, '', 0, NULL, NULL),
(33, 'Clé de voiture 3', 45.8431, 1.2573, 45.8451, 1.2593, 10, '../Images/cle_voiture.jpg', 'recuperable', '', 0, '', 0, '', 0, NULL, NULL),
(34, 'Code_coffre', 0, 0, 0, 0, 0, '', 'code', '6536', 0, '', 0, '', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `score`
--

CREATE TABLE `score` (
  `Nom` text NOT NULL,
  `Temps` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `score`
--

INSERT INTO `score` (`Nom`, `Temps`) VALUES
('Thomas', '00:15:25');

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
