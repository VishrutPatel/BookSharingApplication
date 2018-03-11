-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 11, 2018 at 11:07 PM
-- Server version: 5.7.19
-- PHP Version: 5.6.31

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
DROP PROCEDURE IF EXISTS `addBookForLending`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addBookForLending` (IN `inptemail` VARCHAR(50), IN `inpttitle` VARCHAR(30), IN `inptauthor` VARCHAR(100), IN `inptgenre` VARCHAR(100), IN `inptstartdatetime` DATETIME, IN `inptenddatetime` DATETIME, IN `inptmod` VARCHAR(3))  insert into book 
(email,title,author,genre,start_Date_Time,end_Date_Time,methodOfDelivery)values(inptemail,inpttitle,inptauthor,inptgenre,inptstartdatetime,inptenddatetime,inptmod)$$

DROP PROCEDURE IF EXISTS `addBorrowRequest`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addBorrowRequest` (IN `inptborroweremail` VARCHAR(50), IN `inptbookid` INT(6))  insert into borrowrequest 
(borrower_email,book_Id)
values (inptborroweremail,inptbookid)$$

DROP PROCEDURE IF EXISTS `addReviewForTransaction`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addReviewForTransaction` (IN `inptbookid` INT(6))  NO SQL
insert into reviews(transaction_id) SELECT id from transaction where book_Id = inptbookid$$

DROP PROCEDURE IF EXISTS `addSignUpInformation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addSignUpInformation` (IN `inptfirstname` VARCHAR(30), IN `inptlastname` VARCHAR(30), IN `inptaddr1` VARCHAR(100), IN `inptaddr2` VARCHAR(100), IN `inptcity` VARCHAR(100), IN `inptstate` VARCHAR(2), IN `inptzipcode` VARCHAR(5), IN `inptemail` VARCHAR(50), IN `inptreg_date` TIMESTAMP, IN `inptsec_code` INT(5), IN `inptverification_status` BOOLEAN, IN `inptpassword` VARCHAR(30))  insert into user (firstname, lastname, addr1, addr2, city, state, zipcode, email,reg_date, sec_code, verification_status,password) values 
(inptfirstname, inptlastname, inptaddr1, inptaddr2, inptcity,inptstate, inptzipcode, inptemail, inptreg_date, inptsec_code, inptverification_status, inptpassword)$$

DROP PROCEDURE IF EXISTS `addTransaction`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addTransaction` (IN `lenderemail` VARCHAR(50), IN `inptbookid` INT(6), IN `borroweremail` VARCHAR(50))  insert into transaction VALUES (lenderemail, inptbookid, borroweremail)$$

DROP PROCEDURE IF EXISTS `deleteBorrowRequest`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBorrowRequest` (IN `bookID` INT(6))  DELETE FROM borrowrequest where book_Id=bookID$$

DROP PROCEDURE IF EXISTS `getCountOfBooks`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCountOfBooks` (OUT `count` INT)  SELECT count(*) INTO count FROM BOOK$$

DROP PROCEDURE IF EXISTS `getCountOfBorrowRequests`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCountOfBorrowRequests` (OUT `count` INT(6))  SELECT count(*) INTO count FROM borrowrequest$$

DROP PROCEDURE IF EXISTS `getNotificationCount`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getNotificationCount` (IN `inptemail` VARCHAR(50), OUT `count` INT(6))  NO SQL
SELECT count(*) into count
      FROM borrower b, borrowrequest br, book bk
      WHERE b.email = br.borrower_email AND bk.id = br.book_Id AND bk.email = inptemail$$

DROP PROCEDURE IF EXISTS `getSecCode`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSecCode` (IN `inptemail` VARCHAR(50), OUT `securitycode` INT(5))  SELECT sec_code INTO securitycode FROM user where email=inptemail$$

DROP PROCEDURE IF EXISTS `getUserName`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserName` (IN `userName` VARCHAR(50), OUT `userFirstName` VARCHAR(50))  BEGIN
      
      SELECT firstName INTO userFirstName
      FROM user u
      WHERE u.email = userName;
      
END$$

DROP PROCEDURE IF EXISTS `getUsers`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUsers` (OUT `numOfUsers` INT(5))  SELECT COUNT(*) INTO numOfUsers FROM user$$

DROP PROCEDURE IF EXISTS `retrieveBorrowRequests`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `retrieveBorrowRequests` (IN `inptemail` VARCHAR(50), OUT `abcd` JSON)  SELECT borrowrequest.book_Id,borrower.email ,borrower.ratings ,book.title FROM borrower , borrowrequest, book WHERE borrower.email = borrowrequest.borrower_email AND book.id = borrowrequest.book_Id AND book.email = inptemail ORDER BY borrowrequest.book_Id$$

DROP PROCEDURE IF EXISTS `RetriveBookLendingInformation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `RetriveBookLendingInformation` (IN `inid` INT(6), OUT `email` VARCHAR(50), OUT `title` VARCHAR(50), OUT `author` VARCHAR(50), OUT `genre` VARCHAR(50), OUT `start_Date_Time` DATETIME, OUT `end_Date_Time` DATETIME, OUT `ratings` FLOAT(3,2), OUT `firstname` VARCHAR(30), OUT `lastname` VARCHAR(30))  select b.id,b.email, b.title, b.author, b.genre, b.start_Date_Time, b.end_Date_Time, l.ratings, u.firstname, u.lastname
from book b, lender l, user u
where inid = b.id AND b.email = l.email AND l.email = u.email$$

DROP PROCEDURE IF EXISTS `signUpValidated`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `signUpValidated` (IN `inptemail` VARCHAR(50))  UPDATE user SET verification_status = 1 WHERE email = inptemail$$

DROP PROCEDURE IF EXISTS `updateBookStatus`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateBookStatus` (IN `inptbookid` INT(6))  UPDATE book 
      set book_status = 0
      where id = inptbookid$$

DROP PROCEDURE IF EXISTS `validateLogin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `validateLogin` (IN `inptemail` VARCHAR(50), IN `inptpass` VARCHAR(30), OUT `validate` INT)  BEGIN
      
      SELECT count(*) INTO validate
      FROM user u
      WHERE u.email = inptemail
      AND
      u.password = inptpass;
      
END$$

DROP PROCEDURE IF EXISTS `validateSignUp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `validateSignUp` (IN `inptemail` VARCHAR(50), OUT `validate` INT)  BEGIN
      
      SELECT count(*) INTO validate
      FROM user u
      WHERE u.email = inptemail;
      
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
CREATE TABLE IF NOT EXISTS `book` (
  `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `author` varchar(50) NOT NULL,
  `genre` varchar(50) NOT NULL,
  `start_Date_Time` datetime NOT NULL,
  `end_Date_Time` datetime NOT NULL,
  `methodOfDelivery` varchar(3) NOT NULL,
  `book_status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`id`, `email`, `title`, `author`, `genre`, `start_Date_Time`, `end_Date_Time`, `methodOfDelivery`, `book_status`) VALUES
(2, 'pjmandle@ncsu.edu', 'Introducation to Algorithms', 'Thomas H Cormen', 'Technical', '2018-02-25 23:00:00', '2018-02-28 00:00:00', 'MCP', 1),
(3, 'pjmandle@ncsu.edu', 'The Murder of Roger Ackroyd', 'Agatha Cristie', 'Murder Mystery', '2018-03-05 00:00:00', '2018-03-09 00:00:00', 'HD', 1),
(4, 'pjmandle@ncsu.edu', 'Three Men in a Boat', 'Jerome K. Jerome', 'Comedy', '2018-03-03 00:00:00', '2018-02-08 00:00:00', 'PK', 1),
(6, 'pjmandle@ncsu.edu', 'Romeo and Juliet', 'William Shakespeare', 'Romance', '2018-03-05 00:00:00', '2018-03-14 00:00:00', 'MCP', 1),
(7, 'pjmandle@ncsu.edu', 'Spark', ' S.L. Scott', 'Music', '2018-03-14 00:00:00', '2018-03-23 00:00:00', 'HD', 0),
(8, 'pjmandle@ncsu.edu', 'Educated: A Memoir', 'Tara Westover', 'Biography', '2018-03-22 00:00:00', '2018-03-31 00:00:00', 'HD', 0),
(15, 'pjmandle@ncsu.edu', 'Contact', 'Carl Sagam', 'Space Sci-fy', '2018-03-10 00:00:00', '2018-03-15 00:00:00', 'PK', 1),
(20, 'pjmandle@ncsu.edu', 'The Martian', 'Andy Weir', 'Fiction', '2018-03-15 00:00:00', '2018-03-20 00:00:00', 'HD', 1),
(19, 'pjmandle@ncsu.edu', 'Half Girlfriend', 'Chetan Bhagat', 'Romance', '2018-03-10 00:00:00', '2018-03-15 00:00:00', 'PK', 1),
(21, 'pjmandle@ncsu.edu', 'Still Me', 'Jojo Moyes', 'Fiction', '2018-03-17 00:00:00', '2018-03-20 00:00:00', 'PK', 1),
(22, 'pjmandle@ncsu.edu', 'The Notebook', 'Nicholas Spark', 'Romantic', '2018-03-18 00:00:00', '2018-03-25 00:00:00', 'PK', 1);

-- --------------------------------------------------------

--
-- Table structure for table `borrower`
--

DROP TABLE IF EXISTS `borrower`;
CREATE TABLE IF NOT EXISTS `borrower` (
  `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `ratings` float(3,2) DEFAULT NULL,
  `no_of_reviews` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `borrower`
--

INSERT INTO `borrower` (`id`, `email`, `ratings`, `no_of_reviews`) VALUES
(1, 'pjmandle@ncsu.edu', 4.20, 14),
(2, 'vnpatel@ncsu.edu', 5.00, 14);

-- --------------------------------------------------------

--
-- Table structure for table `borrowrequest`
--

DROP TABLE IF EXISTS `borrowrequest`;
CREATE TABLE IF NOT EXISTS `borrowrequest` (
  `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `book_Id` int(6) NOT NULL,
  `borrower_email` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `borrower_email` (`borrower_email`),
  KEY `book_Id` (`book_Id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lender`
--

DROP TABLE IF EXISTS `lender`;
CREATE TABLE IF NOT EXISTS `lender` (
  `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `ratings` float(3,2) DEFAULT NULL,
  `no_of_reviews` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lender`
--

INSERT INTO `lender` (`id`, `email`, `ratings`, `no_of_reviews`) VALUES
(1, 'pjmandle@ncsu.edu', 4.00, 12);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `transaction_id` int(6) NOT NULL,
  `borrow_book_condition_review` int(1) DEFAULT NULL,
  `borrow_review_text` varchar(100) DEFAULT NULL,
  `borrow_exp_review` int(1) DEFAULT NULL,
  `borrow_exp_text` varchar(100) DEFAULT NULL,
  `lender_review_approve` tinyint(1) DEFAULT '0',
  `return_book_review` int(1) DEFAULT NULL,
  `return_review_text` varchar(100) DEFAULT NULL,
  `return_exp_review` int(1) DEFAULT NULL,
  `return_exp_text` varchar(100) DEFAULT NULL,
  `borrower_review_approve` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_id` (`transaction_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `transaction_id`, `borrow_book_condition_review`, `borrow_review_text`, `borrow_exp_review`, `borrow_exp_text`, `lender_review_approve`, `return_book_review`, `return_review_text`, `return_exp_review`, `return_exp_text`, `borrower_review_approve`) VALUES
(1, 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0),
(2, 7, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE IF NOT EXISTS `transaction` (
  `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `lender_email` varchar(50) NOT NULL,
  `borrower_email` varchar(50) NOT NULL,
  `book_Id` int(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lender_email` (`lender_email`),
  KEY `borrower_email` (`borrower_email`),
  KEY `book_Id` (`book_Id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `lender_email`, `borrower_email`, `book_Id`) VALUES
(1, 'pjmandle@ncsu.edu', 'vnpatel@ncsu.edu', 7),
(2, 'pjmandle@ncsu.edu', 'pjmandle@ncsu.edu', 15),
(6, 'pjmandle@ncsu.edu', 'pjmandle@ncsu.edu', 8),
(7, 'pjmandle@ncsu.edu', 'pjmandle@ncsu.edu', 7);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `addr1` varchar(100) NOT NULL,
  `addr2` varchar(100) DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zipcode` varchar(5) NOT NULL,
  `email` varchar(50) NOT NULL,
  `reg_date` timestamp NULL DEFAULT NULL,
  `sec_code` int(5) DEFAULT NULL,
  `verification_status` tinyint(1) DEFAULT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`firstname`, `lastname`, `addr1`, `addr2`, `city`, `state`, `zipcode`, `email`, `reg_date`, `sec_code`, `verification_status`, `password`) VALUES
('Priyance', 'Mandlewala', '3530, Ivy Commons Dr', 'Avent Ferry Road', 'Raleigh', 'NC', '27606', 'pjmandle@ncsu.edu', '2018-02-20 05:00:00', NULL, NULL, '12345'),
('Vishrut', 'Patel', '2518, Avent Ferry Road', 'Apt no 205', 'Raleigh', 'NC', '27606', 'vnpatel@ncsu.edu', '2018-03-11 03:21:52', 67181, 1, '12345');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
