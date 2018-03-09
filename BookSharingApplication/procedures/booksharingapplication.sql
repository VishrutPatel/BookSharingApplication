-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 18, 2018 at 11:09 PM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 5.6.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `booksharingapplication`
--

DELIMITER $$
--
-- Procedures
--


CREATE DEFINER=`root`@`localhost` PROCEDURE `addBookForLending` (IN `inptemail` VARCHAR(50), IN `inpttitle` VARCHAR(30), IN `inptgenre` VARCHAR(100), IN `inptauthor` VARCHAR(100), IN `inptstartdatetime` DATETIME, IN `inptenddatetime` DATETIME, OUT `check` INT)  MODIFIES SQL DATA
insert into book 
      (email,title,author,genre,start_Date_Time,end_Date_Time)
      values 
      (inptemail,inpttitle,inptauthor,inptgenre,inptstartdatetime,inptenddatetime)$$
      
CREATE DEFINER=`root`@`localhost` PROCEDURE `addBorrowRequest` (IN `inptborroweremail` VARCHAR(50), IN `inptbookid` VARCHAR(30), IN `inptstartdatetime` DATETIME, IN `inptenddatetime` DATETIME, OUT `check` INT)  MODIFIES SQL DATA
insert into borrowrequest 
      (book_Id,borrower_email,start_Date_Time,end_Date_Time)
      values 
      (inptborroweremail,inptbookid,inptstartdatetime,inptenddatetime)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addSignUpInformation` (IN `inptfirstname` VARCHAR(30), IN `inptlastname` VARCHAR(30), IN `inptaddr1` VARCHAR(100), IN `inptaddr2` VARCHAR(100), IN `inptcity` VARCHAR(100), IN `inptstate` VARCHAR(2), IN `inptzipcode` VARCHAR(5), IN `inptemail` VARCHAR(50), IN `inptreg_date` TIMESTAMP, IN `inptsec_code` INT(5), IN `inptverification_status` BOOLEAN, IN `inptpassword` VARCHAR(30))  READS SQL DATA
insert into user (firstname, lastname, addr1, addr2, city, state, zipcode, email, reg_date, sec_code, verification_status,password) values (inptfirstname, inptlastname, inptaddr1, inptaddr2, inptcity, inptstate, inptzipcode, inptemail, inptreg_date, inptsec_code, inptverification_status, inptpassword)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `displayBookSearchResult` (IN `inptstartdate` DATETIME, IN `inptenddate` DATETIME, OUT `email` VARCHAR(50), OUT `title` VARCHAR(50), OUT `author` VARCHAR(50), OUT `genre` VARCHAR(50), OUT `start_Date_Time` DATETIME, OUT `end_Date_Time` DATETIME)  READS SQL DATA
select *
      from book
      where inptbookname = title AND inptstartdate >= start_Date_Time AND inptenddate <= end_Date_Time$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `forgotPassword` (IN `inptemail` VARCHAR(50), IN `inptnewpass` VARCHAR(30))  MODIFIES SQL DATA
UPDATE user SET password = inptnewpass WHERE email = inptemail$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `retrieveBorrowRequests` (IN `inptemail` VARCHAR(50), OUT `otptborroweremail` VARCHAR(50), OUT `otptratings` FLOAT(3,2))  READS SQL DATA
SELECT b.email,b.ratings
      FROM borrower b, borrowrequest br, book bk
      WHERE b.email = br.borroweremail AND bk.id = br.book_Id AND bk.email = inptemail$$
      
CREATE DEFINER=`root`@`localhost` PROCEDURE `signUpValidated` (IN `inptemail` VARCHAR(50))  MODIFIES SQL DATA
UPDATE user SET verification_status = 1 WHERE email = inptemail$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validatedOrNot` (IN `inptemail` VARCHAR(50), OUT `trueorFalse` BOOLEAN)  READS SQL DATA
select verification_status into trueorFalse
      from User
      where inptemail = email$$
      
CREATE DEFINER=`root`@`localhost` PROCEDURE `validateLogin` (IN `inptemail` VARCHAR(50), IN `inptpass` VARCHAR(30), OUT `validate` INT)  READS SQL DATA
BEGIN
      
      SELECT count(*) INTO validate
      FROM user u
      WHERE u.email = inptemail
      AND
      u.password = inptpass;
      
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validateSignUp` (IN `inptemail` VARCHAR(50), OUT `validate` INT)  READS SQL DATA
SELECT count(*) INTO validate
FROM user u
WHERE u.email = inptemail$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `id` int(6) UNSIGNED NOT NULL,
  `email` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `author` varchar(50) NOT NULL,
  `genre` varchar(50) NOT NULL,
  `start_Date_Time` datetime NOT NULL,
  `end_Date_Time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `borrower`
--

CREATE TABLE `borrower` (
  `id` int(6) UNSIGNED NOT NULL,
  `email` varchar(50) NOT NULL,
  `ratings` float(3,2) DEFAULT NULL,
  `no_of_reviews` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `borrowrequest`
--

CREATE TABLE `borrowrequest` (
  `id` int(6) UNSIGNED NOT NULL,
  `borrower_email` varchar(50) NOT NULL,
  `start_Date_Time` datetime NOT NULL,
  `end_Date_Time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lender`
--

CREATE TABLE `lender` (
  `id` int(6) UNSIGNED NOT NULL,
  `email` varchar(50) NOT NULL,
  `ratings` float(3,2) DEFAULT NULL,
  `no_of_reviews` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `addr1` varchar(100) NOT NULL,
  `addr2` varchar(100) DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zipcode` varchar(5) NOT NULL,
  `email` varchar(50) NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sec_code` int(5) DEFAULT NULL,
  `verification_status` tinyint(1) DEFAULT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `borrower`
--
ALTER TABLE `borrower`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `borrowrequest`
--
ALTER TABLE `borrowrequest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `borrower_email` (`borrower_email`);

--
-- Indexes for table `lender`
--
ALTER TABLE `lender`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `borrower`
--
ALTER TABLE `borrower`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `borrowrequest`
--
ALTER TABLE `borrowrequest`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lender`
--
ALTER TABLE `lender`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book`
--
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`email`) REFERENCES `user` (`email`);

--
-- Constraints for table `borrower`
--
ALTER TABLE `borrower`
  ADD CONSTRAINT `borrower_ibfk_1` FOREIGN KEY (`email`) REFERENCES `user` (`email`);

--
-- Constraints for table `borrowrequest`
--
ALTER TABLE `borrowrequest`
  ADD CONSTRAINT `borrowrequest_ibfk_1` FOREIGN KEY (`borrower_email`) REFERENCES `user` (`email`);

--
-- Constraints for table `lender`
--
ALTER TABLE `lender`
  ADD CONSTRAINT `lender_ibfk_1` FOREIGN KEY (`email`) REFERENCES `user` (`email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
