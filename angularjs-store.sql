USE `angularjsstore`;

DROP TABLE IF EXISTS `productimages`;

CREATE TABLE `productimages` (
	`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	`path` varchar(255) NOT NULL DEFAULT '',
	`product_id` int(11) unsigned NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `productimages` WRITE;

INSERT INTO `productimages` (`id`, `path`, `product_id`)
VALUES
	(1,'img/gem-02.gif',1),
	(2,'img/gem-05.gif',1),
	(3,'img/gem-09.gif',1),
	(4,'img/gem-01.gif',2),
	(5,'img/gem-03.gif',2),
	(6,'img/gem-04.gif',2),
	(7,'img/gem-06.gif',3),
	(8,'img/gem-07.gif',3),
	(9,'img/gem-08.gif',3);

UNLOCK TABLES;

DROP TABLE IF EXISTS `productreviews`;

CREATE TABLE `productreviews` (
	`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	`stars` tinyint(11) NOT NULL DEFAULT '0',
	`body` text NOT NULL,
	`author` varchar(255) NOT NULL DEFAULT '',
	`product_id` int(11) unsigned NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `productreviews` WRITE;

INSERT INTO `productreviews` (`id`, `stars`, `body`, `author`, `product_id`)
VALUES
	(1,5,'I love this gem!','joe@example.org',1),
	(2,1,'This gem sucks.','tim@example.org',1),
	(3,3,'I think this gem was just OK, could honestly use more \'shine\', IMO.','JimmyDean@example.org',2),
	(4,4,'Any gem with 12 \'faces\' is for me!','gemsRock@example.org',2),
	(5,1,'This gem is WAY too expensive for its \'rarity\' value.','turtleguyy@example.org',3),
	(6,1,'BBW: High \'shine\' != High Quality.','LouisW407@example.org',3),
	(7,1,'Don\'t waste your rubles!','nat@example.org',3);

UNLOCK TABLES;

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
	`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL DEFAULT '',
	`description` text NOT NULL,
	`shine` int(11) NOT NULL DEFAULT '0',
	`price` double NOT NULL,
	`rarity` int(11) NOT NULL DEFAULT '0',
	`color` varchar(7) NOT NULL DEFAULT '',
	`faces` int(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `products` WRITE;

INSERT INTO `products` (`id`, `name`, `description`, `shine`, `price`, `rarity`, `color`, `faces`)
VALUES
	(1,'Azurite','Some gems have hidden qualities beyond their luster, beyond their \'shine\'... Azurite is one of those gems.',8,110.5,7,'#CCC',14),
	(2,'Bloodstone','Origin of the Bloodstone is unknown, hence its low value. It has a very high \'shine\' and 12 sides, however.',9,22.9,6,'#EEE',12),
	(3,'Zircon','Zircon is our most coveted and sought after gem. You will pay much to be the proud owner of this gorgeous and high \'shine\' gem.',70,1100,2,'#000',6);

UNLOCK TABLES;
