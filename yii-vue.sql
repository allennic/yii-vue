-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 17, 2017 at 01:50 AM
-- Server version: 5.7.9
-- PHP Version: 7.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shenyi`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_transfer` (IN `fromuser` INT, IN `touser` INT, IN `_money` DECIMAL(10,2))  BEGIN
	DECLARE fromuser_money DECIMAL(10,2) DEFAULT 0;
	DECLARE touser_money DECIMAL(10,2) DEFAULT 0;
	DECLARE error bit DEFAULT false;
	DECLARE CONTINUE HANDLER for SQLEXCEPTION set error =true;
	start TRANSACTION;
		SELECT user_money into fromuser_money from user_balance where user_id=fromuser FOR UPDATE;
		SELECT user_money into touser_money from user_balance where user_id=touser FOR UPDATE;

		IF fromuser_money<_money THEN
			COMMIT;
			SELECT '钱不够' as result;
		ELSE
			set fromuser_money=fromuser_money-_money;
			set touser_money=touser_money+_money;
			update user_balance set user_money=fromuser_money where user_id=fromuser;
			update user_balance set user_money=touser_money where user_id=touser;
		end if;

		IF error=true THEN
			ROLLBACK;
			select '出错了' as result;
		else
			COMMIT;
			select '转账完成' as result;
		end if;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `client_id` int(11) NOT NULL,
  `client_appid` varchar(50) DEFAULT NULL,
  `client_appkey` varchar(50) DEFAULT NULL,
  `client_token` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`client_id`, `client_appid`, `client_appkey`, `client_token`) VALUES
(1, '452345', 'fdgsdf', '7v25OaMPL-DD2MazSCo1w_eatrUhGYtn'),
(2, '342134', 'fdgsd', '');

-- --------------------------------------------------------

--
-- Table structure for table `navbar`
--

CREATE TABLE `navbar` (
  `nav_id` int(4) NOT NULL,
  `nav_text` varchar(200) DEFAULT NULL,
  `vav_url` varchar(200) DEFAULT NULL,
  `nav_order` int(4) DEFAULT NULL,
  `nav_pid` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `navbar`
--

INSERT INTO `navbar` (`nav_id`, `nav_text`, `vav_url`, `nav_order`, `nav_pid`) VALUES
(1, '首页', '/', 1, 0),
(2, '健身', '/fitness', 1, 0),
(3, '饮食', '/diet', 1, 0),
(6, '私人订制', '/pt', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `news_id` int(20) NOT NULL,
  `news_title` varchar(50) DEFAULT NULL,
  `news_classid` int(20) DEFAULT NULL,
  `user_id` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`news_id`, `news_title`, `news_classid`, `user_id`) VALUES
(1, 'fasdfsa', 1, 2),
(2, 'sdfsadf', 2, 1),
(3, 'weqr', 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `news_class`
--

CREATE TABLE `news_class` (
  `class_id` int(20) NOT NULL,
  `class_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `news_class`
--

INSERT INTO `news_class` (`class_id`, `class_name`) VALUES
(1, '头条'),
(2, '经济新闻');

-- --------------------------------------------------------

--
-- Table structure for table `sys_clients`
--

CREATE TABLE `sys_clients` (
  `client_id` int(20) NOT NULL,
  `client_appid` varchar(50) NOT NULL,
  `client_appkey` varchar(50) NOT NULL,
  `client_domain` varchar(50) DEFAULT NULL,
  `client_regtime` datetime DEFAULT NULL,
  `client_tokentime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sys_clients`
--

INSERT INTO `sys_clients` (`client_id`, `client_appid`, `client_appkey`, `client_domain`, `client_regtime`, `client_tokentime`) VALUES
(20170222, '201702221341', 'dsafqwersadfasdfsdf', 'localhost', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_name` varchar(50) DEFAULT NULL,
  `user_pass` varchar(200) DEFAULT NULL,
  `user_id` int(20) NOT NULL,
  `user_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_name`, `user_pass`, `user_id`, `user_date`) VALUES
('shenyi', '323423', 1, NULL),
('zhangsan', '567546', 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_balance`
--

CREATE TABLE `user_balance` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_money` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_balance`
--

INSERT INTO `user_balance` (`id`, `user_id`, `user_money`) VALUES
(1, 22, '700.00'),
(2, 33, '340.00');

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE `videos` (
  `v_id` int(11) NOT NULL,
  `v_title` varchar(50) DEFAULT NULL COMMENT '分类(连navbar)',
  `v_class` int(11) DEFAULT NULL COMMENT '简介',
  `v_intr` text,
  `v_userid` int(11) DEFAULT '0' COMMENT '0代表超级管理员传',
  `v_addtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  `v_playlist` int(11) DEFAULT '0' COMMENT '所属播单',
  `v_lastmod` timestamp NULL DEFAULT NULL,
  `v_pic` varchar(200) DEFAULT NULL,
  `v_money` int(11) DEFAULT NULL,
  `v_videokey` varchar(200) DEFAULT NULL,
  `v_tags` varchar(200) DEFAULT NULL,
  `v_mod` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `videos_img`
--

CREATE TABLE `videos_img` (
  `img_id` int(11) NOT NULL,
  `img_name` varchar(30) NOT NULL,
  `img_url` varchar(200) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `img_uptime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isuploaded` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `videos_img`
--

INSERT INTO `videos_img` (`img_id`, `img_name`, `img_url`, `user_id`, `img_uptime`, `isuploaded`) VALUES
(24, '201702210819050.jpg', 'http://ojtrrp22t.bkt.clouddn.com/201702210819050.jpg', 0, '2017-02-21 12:19:05', b'0'),
(25, '201702210822020.jpg', 'http://ojtrrp22t.bkt.clouddn.com/201702210822020.jpg', 0, '2017-02-21 12:22:02', b'1'),
(26, '201702210826220.jpg', 'http://ojtrrp22t.bkt.clouddn.com/201702210826220.jpg', 0, '2017-02-21 12:26:22', b'1'),
(36, '201703160317260.jpg', 'http://omuud2oh3.bkt.clouddn.com/201703160317260.jpg', 0, '2017-03-16 03:17:26', b'0');

-- --------------------------------------------------------

--
-- Table structure for table `videos_img1`
--

CREATE TABLE `videos_img1` (
  `img_id` int(11) NOT NULL,
  `img_name` varchar(30) DEFAULT NULL,
  `img_url` varchar(200) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `img_uptime` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `videos_img1`
--

INSERT INTO `videos_img1` (`img_id`, `img_name`, `img_url`, `user_id`, `img_uptime`) VALUES
(1, '201703150331430.png', 'http://omuud2oh3.bkt.clouddn.com/201703150331430.png', NULL, NULL),
(2, '201703150332200.png', 'http://omuud2oh3.bkt.clouddn.com/201703150332200.png', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `navbar`
--
ALTER TABLE `navbar`
  ADD PRIMARY KEY (`nav_id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`news_id`);

--
-- Indexes for table `news_class`
--
ALTER TABLE `news_class`
  ADD PRIMARY KEY (`class_id`);

--
-- Indexes for table `sys_clients`
--
ALTER TABLE `sys_clients`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_balance`
--
ALTER TABLE `user_balance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`v_id`);

--
-- Indexes for table `videos_img`
--
ALTER TABLE `videos_img`
  ADD PRIMARY KEY (`img_id`);

--
-- Indexes for table `videos_img1`
--
ALTER TABLE `videos_img1`
  ADD PRIMARY KEY (`img_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `user_balance`
--
ALTER TABLE `user_balance`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `v_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `videos_img`
--
ALTER TABLE `videos_img`
  MODIFY `img_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `videos_img1`
--
ALTER TABLE `videos_img1`
  MODIFY `img_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
