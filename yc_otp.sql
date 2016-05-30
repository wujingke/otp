-- phpMyAdmin SQL Dump
-- version 4.5.4.1
-- http://www.phpmyadmin.net
--
-- Host: 172.16.100.114
-- Generation Time: 2016-05-30 05:16:21
-- 服务器版本： 5.6.30-log
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `otp`
--

-- --------------------------------------------------------

--
-- 表的结构 `yc_otp`
--

CREATE TABLE `yc_otp` (
  `id` int(11) UNSIGNED NOT NULL,
  `no` char(13) NOT NULL,
  `authkey` varchar(100) NOT NULL DEFAULT '',
  `currsucc` int(12) DEFAULT '0',
  `currdft` int(4) DEFAULT '0',
  `upadte_time` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `yc_otp`
--
ALTER TABLE `yc_otp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `no` (`no`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `yc_otp`
--
ALTER TABLE `yc_otp`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
