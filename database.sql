-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 20, 2024 at 12:33 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `istdept`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`email`, `password`) VALUES
('sami@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4'),
('admin@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4');

-- --------------------------------------------------------

--
-- Table structure for table `dates`
--

CREATE TABLE `dates` (
  `rollnumber` int(11) DEFAULT NULL,
  `staff_email` varchar(255) DEFAULT NULL,
  `subject_code` varchar(50) DEFAULT NULL,
  `num_of_hours` int(11) DEFAULT NULL,
  `attendance_status` varchar(5) DEFAULT NULL,
  `doc` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dates`
--

INSERT INTO `dates` (`rollnumber`, `staff_email`, `subject_code`, `num_of_hours`, `attendance_status`, `doc`) VALUES
(2021115018, 'arunamanivannan2003@gmail.com', 'IT5602', 4, 'P', '2024-04-17'),
(2021115050, 'arunamanivannan2003@gmail.com', 'IT5602', 4, 'P', '2024-04-17'),
(2021115085, 'arunamanivannan2003@gmail.com', 'IT5602', 4, 'P', '2024-04-17'),
(2021115117, 'arunamanivannan2003@gmail.com', 'IT5602', 4, 'P', '2024-04-17'),
(2021115125, 'arunamanivannan2003@gmail.com', 'IT5602', 4, 'P', '2024-04-17'),
(2021115315, 'arunamanivannan2003@gmail.com', 'IT5602', 4, 'P', '2024-04-17');

-- --------------------------------------------------------

--
-- Table structure for table `enrolledsubjects`
--

CREATE TABLE `enrolledsubjects` (
  `student_roll_number` int(11) NOT NULL,
  `subjectid` varchar(50) NOT NULL,
  `class_attended` int(11) DEFAULT 0,
  `class_taken` int(11) DEFAULT 0,
  `teacher_email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrolledsubjects`
--

INSERT INTO `enrolledsubjects` (`student_roll_number`, `subjectid`, `class_attended`, `class_taken`, `teacher_email`) VALUES
(2021115018, 'IT5551', 0, 0, 'anandkumar333221@gmail.com'),
(2021115018, 'IT5602', 4, 4, 'arunamanivannan2003@gmail.com'),
(2021115050, 'IT5551', 0, 0, 'anandkumar333221@gmail.com'),
(2021115050, 'IT5602', 4, 4, 'arunamanivannan2003@gmail.com'),
(2021115085, 'IT5551', 0, 0, 'anandkumar333221@gmail.com'),
(2021115085, 'IT5601', 0, 0, 'arunamanivannan2003@gmail.com'),
(2021115085, 'IT5602', 4, 4, 'arunamanivannan2003@gmail.com'),
(2021115117, 'IT5551', 0, 0, 'anandkumar333221@gmail.com'),
(2021115117, 'IT5602', 4, 4, 'arunamanivannan2003@gmail.com'),
(2021115125, 'IT5551', 0, 0, 'anandkumar333221@gmail.com'),
(2021115125, 'IT5602', 4, 4, 'arunamanivannan2003@gmail.com'),
(2021115315, 'IT5551', 0, 0, 'anandkumar333221@gmail.com'),
(2021115315, 'IT5602', 4, 4, 'arunamanivannan2003@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `roll_number` int(11) DEFAULT NULL,
  `event_name` varchar(255) DEFAULT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `role` enum('Participate','Conduct/Manage') DEFAULT NULL,
  `awards` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `roll_number`, `event_name`, `institution`, `date`, `role`, `awards`) VALUES
(1, 111, 'Itrix', 'IST', '0000-00-00', 'Participate', 'First'),
(2, 2021115050, 'Itrix', 'IST', '0000-00-00', 'Participate', 'First');

-- --------------------------------------------------------

--
-- Table structure for table `exams_attended`
--

CREATE TABLE `exams_attended` (
  `id` int(11) NOT NULL,
  `roll_number` int(11) DEFAULT NULL,
  `GATE_score` decimal(10,2) DEFAULT NULL,
  `GRE_score` decimal(10,2) DEFAULT NULL,
  `TOEFL_score` decimal(10,2) DEFAULT NULL,
  `IELTS_score` decimal(10,2) DEFAULT NULL,
  `UPSC_score` decimal(10,2) DEFAULT NULL,
  `NET_score` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gpa`
--

CREATE TABLE `gpa` (
  `rollnumber` int(11) NOT NULL,
  `gpa` float DEFAULT NULL,
  `semester` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gpa`
--

INSERT INTO `gpa` (`rollnumber`, `gpa`, `semester`) VALUES
(111, 8.3, 1),
(111, 7.5, 2),
(111, 9.1, 3),
(111, 6.8, 4),
(111, 8.7, 5),
(111, 7.2, 6),
(2021115050, 8.3, 1),
(2021115050, 7.5, 2),
(2021115050, 9.1, 3),
(2021115050, 6.8, 4),
(2021115050, 8.7, 5),
(2021115050, 7.2, 6);

-- --------------------------------------------------------

--
-- Table structure for table `internship`
--

CREATE TABLE `internship` (
  `id` int(11) NOT NULL,
  `roll_number` int(11) DEFAULT NULL,
  `employer_name` varchar(255) DEFAULT NULL,
  `on_off_campus` enum('On Campus','Off Campus') DEFAULT NULL,
  `ctc` decimal(10,2) DEFAULT NULL,
  `InternshipDuration` varchar(50) DEFAULT NULL,
  `InternshipStartDate` date DEFAULT NULL,
  `InternshipEndDate` date DEFAULT NULL,
  `product_service_based` enum('Product Based','Service Based') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `internship`
--

INSERT INTO `internship` (`id`, `roll_number`, `employer_name`, `on_off_campus`, `ctc`, `InternshipDuration`, `InternshipStartDate`, `InternshipEndDate`, `product_service_based`) VALUES
(2, 111, 'sample', 'On Campus', 2000.00, '2 months', '2024-03-05', '2024-03-06', 'Product Based'),
(3, 2021115050, 'sample', 'On Campus', 2000.00, '2 months', '2024-03-05', '2024-03-06', 'Product Based');

-- --------------------------------------------------------

--
-- Table structure for table `marks`
--

CREATE TABLE `marks` (
  `RollNumber` int(11) NOT NULL,
  `SubjectID` varchar(50) NOT NULL,
  `Semester` int(11) NOT NULL,
  `MarksObtained` int(11) DEFAULT NULL,
  `Grade` varchar(5) DEFAULT NULL,
  `verified_status` tinyint(1) DEFAULT 0,
  `teacherId` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `marks`
--

INSERT INTO `marks` (`RollNumber`, `SubjectID`, `Semester`, `MarksObtained`, `Grade`, `verified_status`, `teacherId`) VALUES
(2021115018, 'BS5161', 1, 0, NULL, 0, NULL),
(2021115018, 'CY5151', 1, 0, NULL, 0, NULL),
(2021115018, 'EE5251', 2, 0, NULL, 0, NULL),
(2021115018, 'EE5261', 2, 0, NULL, 0, NULL),
(2021115018, 'GE5151', 2, 0, NULL, 0, NULL),
(2021115018, 'GE5153', 1, 0, NULL, 0, NULL),
(2021115018, 'GE5161', 1, 0, NULL, 0, NULL),
(2021115018, 'GE5251', 4, 0, NULL, 0, NULL),
(2021115018, 'HS5151', 1, 0, NULL, 0, NULL),
(2021115018, 'HS5251', 2, 0, NULL, 0, NULL),
(2021115018, 'HUXXX1', 3, 0, NULL, 0, NULL),
(2021115018, 'HUXXX2', 4, 0, NULL, 0, NULL),
(2021115018, 'HUXXX3', 5, 0, NULL, 0, NULL),
(2021115018, 'IT5201', 2, 0, NULL, 0, NULL),
(2021115018, 'IT5211', 2, 0, NULL, 0, NULL),
(2021115018, 'IT5301', 3, 0, NULL, 0, NULL),
(2021115018, 'IT5302', 3, 0, NULL, 0, NULL),
(2021115018, 'IT5311', 3, 0, NULL, 0, NULL),
(2021115018, 'IT5312', 3, 0, NULL, 0, NULL),
(2021115018, 'IT5351', 3, 0, NULL, 0, NULL),
(2021115018, 'IT5352', 3, 0, NULL, 0, NULL),
(2021115018, 'IT5401', 4, 0, NULL, 0, NULL),
(2021115018, 'IT5402', 4, 0, NULL, 0, NULL),
(2021115018, 'IT5403', 4, 0, NULL, 0, NULL),
(2021115018, 'IT5411', 4, 0, NULL, 0, NULL),
(2021115018, 'IT5412', 4, 0, NULL, 0, NULL),
(2021115018, 'IT5451', 4, 0, NULL, 0, NULL),
(2021115018, 'IT5501', 5, 0, NULL, 0, NULL),
(2021115018, 'IT5502', 5, 0, NULL, 0, NULL),
(2021115018, 'IT5511', 5, 0, NULL, 0, NULL),
(2021115018, 'IT5512', 5, 0, NULL, 0, NULL),
(2021115018, 'IT5513', 5, 0, NULL, 0, NULL),
(2021115018, 'IT5551', 5, 0, NULL, 0, NULL),
(2021115018, 'IT5601', 6, 0, NULL, 0, NULL),
(2021115018, 'IT5602', 6, 0, NULL, 0, NULL),
(2021115018, 'IT5603', 6, 0, NULL, 0, NULL),
(2021115018, 'IT5611', 6, 0, NULL, 0, NULL),
(2021115018, 'IT5612', 6, 0, NULL, 0, NULL),
(2021115018, 'IT5613', 6, 0, NULL, 0, NULL),
(2021115018, 'IT5701', 7, 0, NULL, 0, NULL),
(2021115018, 'IT5702', 7, 0, NULL, 0, NULL),
(2021115018, 'IT5703', 7, 0, NULL, 0, NULL),
(2021115018, 'IT5711', 7, 0, NULL, 0, NULL),
(2021115018, 'IT5712', 7, 0, NULL, 0, NULL),
(2021115018, 'IT5811', 8, 0, NULL, 0, NULL),
(2021115018, 'ITXXX1', 5, 0, NULL, 0, NULL),
(2021115018, 'ITXXX2', 5, 0, NULL, 0, NULL),
(2021115018, 'ITXXX3', 6, 0, NULL, 0, NULL),
(2021115018, 'ITXXX4', 6, 0, NULL, 0, NULL),
(2021115018, 'ITXXX5', 7, 0, NULL, 0, NULL),
(2021115018, 'ITXXX6', 7, 0, NULL, 0, NULL),
(2021115018, 'ITXXX7', 8, 0, NULL, 0, NULL),
(2021115018, 'MA5158', 1, 0, NULL, 0, NULL),
(2021115018, 'MA5252', 2, 0, NULL, 0, NULL),
(2021115018, 'MA5302', 3, 0, NULL, 0, NULL),
(2021115018, 'OEXXX1', 6, 0, NULL, 0, NULL),
(2021115018, 'OEXXX2', 7, 0, NULL, 0, NULL),
(2021115018, 'PH5151', 1, 0, NULL, 0, NULL),
(2021115042, 'BS5161', 1, 0, NULL, 0, NULL),
(2021115042, 'CY5151', 1, 0, NULL, 0, NULL),
(2021115042, 'EE5251', 2, 0, NULL, 0, NULL),
(2021115042, 'EE5261', 2, 0, NULL, 0, NULL),
(2021115042, 'GE5151', 2, 0, NULL, 0, NULL),
(2021115042, 'GE5153', 1, 0, NULL, 0, NULL),
(2021115042, 'GE5161', 1, 0, NULL, 0, NULL),
(2021115042, 'GE5251', 4, 0, NULL, 0, NULL),
(2021115042, 'HS5151', 1, 0, NULL, 0, NULL),
(2021115042, 'HS5251', 2, 0, NULL, 0, NULL),
(2021115042, 'HUXXX1', 3, 0, NULL, 0, NULL),
(2021115042, 'HUXXX2', 4, 0, NULL, 0, NULL),
(2021115042, 'HUXXX3', 5, 0, NULL, 0, NULL),
(2021115042, 'IT5201', 2, 0, NULL, 0, NULL),
(2021115042, 'IT5211', 2, 0, NULL, 0, NULL),
(2021115042, 'IT5301', 3, 0, NULL, 0, NULL),
(2021115042, 'IT5302', 3, 0, NULL, 0, NULL),
(2021115042, 'IT5311', 3, 0, NULL, 0, NULL),
(2021115042, 'IT5312', 3, 0, NULL, 0, NULL),
(2021115042, 'IT5351', 3, 0, NULL, 0, NULL),
(2021115042, 'IT5352', 3, 0, NULL, 0, NULL),
(2021115042, 'IT5401', 4, 0, NULL, 0, NULL),
(2021115042, 'IT5402', 4, 0, NULL, 0, NULL),
(2021115042, 'IT5403', 4, 0, NULL, 0, NULL),
(2021115042, 'IT5411', 4, 0, NULL, 0, NULL),
(2021115042, 'IT5412', 4, 0, NULL, 0, NULL),
(2021115042, 'IT5451', 4, 0, NULL, 0, NULL),
(2021115042, 'IT5501', 5, 0, NULL, 0, NULL),
(2021115042, 'IT5502', 5, 0, NULL, 0, NULL),
(2021115042, 'IT5511', 5, 0, NULL, 0, NULL),
(2021115042, 'IT5512', 5, 0, NULL, 0, NULL),
(2021115042, 'IT5513', 5, 0, NULL, 0, NULL),
(2021115042, 'IT5551', 5, 0, NULL, 0, NULL),
(2021115042, 'IT5601', 6, 0, NULL, 0, NULL),
(2021115042, 'IT5602', 6, 0, NULL, 0, NULL),
(2021115042, 'IT5603', 6, 0, NULL, 0, NULL),
(2021115042, 'IT5611', 6, 0, NULL, 0, NULL),
(2021115042, 'IT5612', 6, 0, NULL, 0, NULL),
(2021115042, 'IT5613', 6, 0, NULL, 0, NULL),
(2021115042, 'IT5701', 7, 0, NULL, 0, NULL),
(2021115042, 'IT5702', 7, 0, NULL, 0, NULL),
(2021115042, 'IT5703', 7, 0, NULL, 0, NULL),
(2021115042, 'IT5711', 7, 0, NULL, 0, NULL),
(2021115042, 'IT5712', 7, 0, NULL, 0, NULL),
(2021115042, 'IT5811', 8, 0, NULL, 0, NULL),
(2021115042, 'ITXXX1', 5, 0, NULL, 0, NULL),
(2021115042, 'ITXXX2', 5, 0, NULL, 0, NULL),
(2021115042, 'ITXXX3', 6, 0, NULL, 0, NULL),
(2021115042, 'ITXXX4', 6, 0, NULL, 0, NULL),
(2021115042, 'ITXXX5', 7, 0, NULL, 0, NULL),
(2021115042, 'ITXXX6', 7, 0, NULL, 0, NULL),
(2021115042, 'ITXXX7', 8, 0, NULL, 0, NULL),
(2021115042, 'MA5158', 1, 0, NULL, 0, NULL),
(2021115042, 'MA5252', 2, 0, NULL, 0, NULL),
(2021115042, 'MA5302', 3, 0, NULL, 0, NULL),
(2021115042, 'OEXXX1', 6, 0, NULL, 0, NULL),
(2021115042, 'OEXXX2', 7, 0, NULL, 0, NULL),
(2021115042, 'PH5151', 1, 0, NULL, 0, NULL),
(2021115050, 'BS5161', 1, 96, 'O', 0, NULL),
(2021115050, 'CY5151', 1, 90, 'A+', 0, NULL),
(2021115050, 'EE5251', 2, 88, 'A+', 0, NULL),
(2021115050, 'EE5261', 2, 78, 'A', 0, NULL),
(2021115050, 'GE5151', 2, 87, 'A+', 0, NULL),
(2021115050, 'GE5153', 1, 78, 'A', 0, NULL),
(2021115050, 'GE5161', 1, 77, 'A', 0, NULL),
(2021115050, 'GE5251', 4, 90, 'O', 0, NULL),
(2021115050, 'HS5151', 1, 88, 'A+', 0, NULL),
(2021115050, 'HS5251', 2, 99, 'O', 0, NULL),
(2021115050, 'HUXXX1', 3, 87, 'A+', 0, NULL),
(2021115050, 'HUXXX2', 4, 90, 'O', 0, NULL),
(2021115050, 'HUXXX3', 5, 90, 'O', 0, NULL),
(2021115050, 'IT5201', 2, 78, 'A', 0, NULL),
(2021115050, 'IT5211', 2, 97, 'O', 0, NULL),
(2021115050, 'IT5301', 3, 77, 'A', 0, NULL),
(2021115050, 'IT5302', 3, 66, 'B+', 0, NULL),
(2021115050, 'IT5311', 3, 78, 'A', 0, NULL),
(2021115050, 'IT5312', 3, 98, 'A+', 0, NULL),
(2021115050, 'IT5351', 3, 88, 'A+', 0, NULL),
(2021115050, 'IT5352', 3, 99, 'O', 0, NULL),
(2021115050, 'IT5401', 4, 98, 'O', 0, NULL),
(2021115050, 'IT5402', 4, 87, 'A+', 0, NULL),
(2021115050, 'IT5403', 4, 76, 'A', 0, NULL),
(2021115050, 'IT5411', 4, 88, 'A+', 0, NULL),
(2021115050, 'IT5412', 4, 80, 'A+', 0, NULL),
(2021115050, 'IT5451', 4, 70, 'A', 0, NULL),
(2021115050, 'IT5501', 5, 98, 'O', 0, NULL),
(2021115050, 'IT5502', 5, 80, 'A+', 0, NULL),
(2021115050, 'IT5511', 5, 99, 'O', 0, NULL),
(2021115050, 'IT5512', 5, 88, 'A+', 0, NULL),
(2021115050, 'IT5513', 5, 78, 'A', 0, NULL),
(2021115050, 'IT5551', 5, 67, 'B+', 0, NULL),
(2021115050, 'IT5601', 6, 0, NULL, 0, NULL),
(2021115050, 'IT5602', 6, 0, NULL, 0, NULL),
(2021115050, 'IT5603', 6, 0, NULL, 0, NULL),
(2021115050, 'IT5611', 6, 0, NULL, 0, NULL),
(2021115050, 'IT5612', 6, 0, NULL, 0, NULL),
(2021115050, 'IT5613', 6, 0, NULL, 0, NULL),
(2021115050, 'IT5701', 7, 0, NULL, 0, NULL),
(2021115050, 'IT5702', 7, 0, NULL, 0, NULL),
(2021115050, 'IT5703', 7, 0, NULL, 0, NULL),
(2021115050, 'IT5711', 7, 0, NULL, 0, NULL),
(2021115050, 'IT5712', 7, 0, NULL, 0, NULL),
(2021115050, 'IT5811', 8, 0, NULL, 0, NULL),
(2021115050, 'ITXXX1', 5, 76, 'A', 0, NULL),
(2021115050, 'ITXXX2', 5, 77, 'A', 0, NULL),
(2021115050, 'ITXXX3', 6, 0, NULL, 0, NULL),
(2021115050, 'ITXXX4', 6, 0, NULL, 0, NULL),
(2021115050, 'ITXXX5', 7, 0, NULL, 0, NULL),
(2021115050, 'ITXXX6', 7, 0, NULL, 0, NULL),
(2021115050, 'ITXXX7', 8, 0, NULL, 0, NULL),
(2021115050, 'MA5158', 1, 94, 'O', 0, NULL),
(2021115050, 'MA5252', 2, 87, 'A+', 0, NULL),
(2021115050, 'MA5302', 3, 90, 'O', 0, NULL),
(2021115050, 'OEXXX1', 6, 0, NULL, 0, NULL),
(2021115050, 'OEXXX2', 7, 0, NULL, 0, NULL),
(2021115050, 'PH5151', 1, 78, 'A', 0, NULL),
(2021115074, 'BS5161', 1, 0, NULL, 0, NULL),
(2021115074, 'CY5151', 1, 0, NULL, 0, NULL),
(2021115074, 'EE5251', 2, 0, NULL, 0, NULL),
(2021115074, 'EE5261', 2, 0, NULL, 0, NULL),
(2021115074, 'GE5151', 2, 0, NULL, 0, NULL),
(2021115074, 'GE5153', 1, 0, NULL, 0, NULL),
(2021115074, 'GE5161', 1, 0, NULL, 0, NULL),
(2021115074, 'GE5251', 4, 0, NULL, 0, NULL),
(2021115074, 'HS5151', 1, 0, NULL, 0, NULL),
(2021115074, 'HS5251', 2, 0, NULL, 0, NULL),
(2021115074, 'HUXXX1', 3, 0, NULL, 0, NULL),
(2021115074, 'HUXXX2', 4, 0, NULL, 0, NULL),
(2021115074, 'HUXXX3', 5, 0, NULL, 0, NULL),
(2021115074, 'IT5201', 2, 0, NULL, 0, NULL),
(2021115074, 'IT5211', 2, 0, NULL, 0, NULL),
(2021115074, 'IT5301', 3, 0, NULL, 0, NULL),
(2021115074, 'IT5302', 3, 0, NULL, 0, NULL),
(2021115074, 'IT5311', 3, 0, NULL, 0, NULL),
(2021115074, 'IT5312', 3, 0, NULL, 0, NULL),
(2021115074, 'IT5351', 3, 0, NULL, 0, NULL),
(2021115074, 'IT5352', 3, 0, NULL, 0, NULL),
(2021115074, 'IT5401', 4, 0, NULL, 0, NULL),
(2021115074, 'IT5402', 4, 0, NULL, 0, NULL),
(2021115074, 'IT5403', 4, 0, NULL, 0, NULL),
(2021115074, 'IT5411', 4, 0, NULL, 0, NULL),
(2021115074, 'IT5412', 4, 0, NULL, 0, NULL),
(2021115074, 'IT5451', 4, 0, NULL, 0, NULL),
(2021115074, 'IT5501', 5, 0, NULL, 0, NULL),
(2021115074, 'IT5502', 5, 0, NULL, 0, NULL),
(2021115074, 'IT5511', 5, 0, NULL, 0, NULL),
(2021115074, 'IT5512', 5, 0, NULL, 0, NULL),
(2021115074, 'IT5513', 5, 0, NULL, 0, NULL),
(2021115074, 'IT5551', 5, 0, NULL, 0, NULL),
(2021115074, 'IT5601', 6, 0, NULL, 0, NULL),
(2021115074, 'IT5602', 6, 0, NULL, 0, NULL),
(2021115074, 'IT5603', 6, 0, NULL, 0, NULL),
(2021115074, 'IT5611', 6, 0, NULL, 0, NULL),
(2021115074, 'IT5612', 6, 0, NULL, 0, NULL),
(2021115074, 'IT5613', 6, 0, NULL, 0, NULL),
(2021115074, 'IT5701', 7, 0, NULL, 0, NULL),
(2021115074, 'IT5702', 7, 0, NULL, 0, NULL),
(2021115074, 'IT5703', 7, 0, NULL, 0, NULL),
(2021115074, 'IT5711', 7, 0, NULL, 0, NULL),
(2021115074, 'IT5712', 7, 0, NULL, 0, NULL),
(2021115074, 'IT5811', 8, 0, NULL, 0, NULL),
(2021115074, 'ITXXX1', 5, 0, NULL, 0, NULL),
(2021115074, 'ITXXX2', 5, 0, NULL, 0, NULL),
(2021115074, 'ITXXX3', 6, 0, NULL, 0, NULL),
(2021115074, 'ITXXX4', 6, 0, NULL, 0, NULL),
(2021115074, 'ITXXX5', 7, 0, NULL, 0, NULL),
(2021115074, 'ITXXX6', 7, 0, NULL, 0, NULL),
(2021115074, 'ITXXX7', 8, 0, NULL, 0, NULL),
(2021115074, 'MA5158', 1, 0, NULL, 0, NULL),
(2021115074, 'MA5252', 2, 0, NULL, 0, NULL),
(2021115074, 'MA5302', 3, 0, NULL, 0, NULL),
(2021115074, 'OEXXX1', 6, 0, NULL, 0, NULL),
(2021115074, 'OEXXX2', 7, 0, NULL, 0, NULL),
(2021115074, 'PH5151', 1, 0, NULL, 0, NULL),
(2021115076, 'BS5161', 1, 0, NULL, 0, NULL),
(2021115076, 'CY5151', 1, 0, NULL, 0, NULL),
(2021115076, 'EE5251', 2, 0, NULL, 0, NULL),
(2021115076, 'EE5261', 2, 0, NULL, 0, NULL),
(2021115076, 'GE5151', 2, 0, NULL, 0, NULL),
(2021115076, 'GE5153', 1, 0, NULL, 0, NULL),
(2021115076, 'GE5161', 1, 0, NULL, 0, NULL),
(2021115076, 'GE5251', 4, 0, NULL, 0, NULL),
(2021115076, 'HS5151', 1, 0, NULL, 0, NULL),
(2021115076, 'HS5251', 2, 0, NULL, 0, NULL),
(2021115076, 'HUXXX1', 3, 0, NULL, 0, NULL),
(2021115076, 'HUXXX2', 4, 0, NULL, 0, NULL),
(2021115076, 'HUXXX3', 5, 0, NULL, 0, NULL),
(2021115076, 'IT5201', 2, 0, NULL, 0, NULL),
(2021115076, 'IT5211', 2, 0, NULL, 0, NULL),
(2021115076, 'IT5301', 3, 0, NULL, 0, NULL),
(2021115076, 'IT5302', 3, 0, NULL, 0, NULL),
(2021115076, 'IT5311', 3, 0, NULL, 0, NULL),
(2021115076, 'IT5312', 3, 0, NULL, 0, NULL),
(2021115076, 'IT5351', 3, 0, NULL, 0, NULL),
(2021115076, 'IT5352', 3, 0, NULL, 0, NULL),
(2021115076, 'IT5401', 4, 0, NULL, 0, NULL),
(2021115076, 'IT5402', 4, 0, NULL, 0, NULL),
(2021115076, 'IT5403', 4, 0, NULL, 0, NULL),
(2021115076, 'IT5411', 4, 0, NULL, 0, NULL),
(2021115076, 'IT5412', 4, 0, NULL, 0, NULL),
(2021115076, 'IT5451', 4, 0, NULL, 0, NULL),
(2021115076, 'IT5501', 5, 0, NULL, 0, NULL),
(2021115076, 'IT5502', 5, 0, NULL, 0, NULL),
(2021115076, 'IT5511', 5, 0, NULL, 0, NULL),
(2021115076, 'IT5512', 5, 0, NULL, 0, NULL),
(2021115076, 'IT5513', 5, 0, NULL, 0, NULL),
(2021115076, 'IT5551', 5, 0, NULL, 0, NULL),
(2021115076, 'IT5601', 6, 0, NULL, 0, NULL),
(2021115076, 'IT5602', 6, 0, NULL, 0, NULL),
(2021115076, 'IT5603', 6, 0, NULL, 0, NULL),
(2021115076, 'IT5611', 6, 0, NULL, 0, NULL),
(2021115076, 'IT5612', 6, 0, NULL, 0, NULL),
(2021115076, 'IT5613', 6, 0, NULL, 0, NULL),
(2021115076, 'IT5701', 7, 0, NULL, 0, NULL),
(2021115076, 'IT5702', 7, 0, NULL, 0, NULL),
(2021115076, 'IT5703', 7, 0, NULL, 0, NULL),
(2021115076, 'IT5711', 7, 0, NULL, 0, NULL),
(2021115076, 'IT5712', 7, 0, NULL, 0, NULL),
(2021115076, 'IT5811', 8, 0, NULL, 0, NULL),
(2021115076, 'ITXXX1', 5, 0, NULL, 0, NULL),
(2021115076, 'ITXXX2', 5, 0, NULL, 0, NULL),
(2021115076, 'ITXXX3', 6, 0, NULL, 0, NULL),
(2021115076, 'ITXXX4', 6, 0, NULL, 0, NULL),
(2021115076, 'ITXXX5', 7, 0, NULL, 0, NULL),
(2021115076, 'ITXXX6', 7, 0, NULL, 0, NULL),
(2021115076, 'ITXXX7', 8, 0, NULL, 0, NULL),
(2021115076, 'MA5158', 1, 0, NULL, 0, NULL),
(2021115076, 'MA5252', 2, 0, NULL, 0, NULL),
(2021115076, 'MA5302', 3, 0, NULL, 0, NULL),
(2021115076, 'OEXXX1', 6, 0, NULL, 0, NULL),
(2021115076, 'OEXXX2', 7, 0, NULL, 0, NULL),
(2021115076, 'PH5151', 1, 0, NULL, 0, NULL),
(2021115085, 'BS5161', 1, 0, NULL, 0, NULL),
(2021115085, 'CY5151', 1, 0, NULL, 0, NULL),
(2021115085, 'EE5251', 2, 0, NULL, 0, NULL),
(2021115085, 'EE5261', 2, 0, NULL, 0, NULL),
(2021115085, 'GE5151', 2, 0, NULL, 0, NULL),
(2021115085, 'GE5153', 1, 0, NULL, 0, NULL),
(2021115085, 'GE5161', 1, 0, NULL, 0, NULL),
(2021115085, 'GE5251', 4, 0, NULL, 0, NULL),
(2021115085, 'HS5151', 1, 0, NULL, 0, NULL),
(2021115085, 'HS5251', 2, 0, NULL, 0, NULL),
(2021115085, 'HUXXX1', 3, 0, NULL, 0, NULL),
(2021115085, 'HUXXX2', 4, 0, NULL, 0, NULL),
(2021115085, 'HUXXX3', 5, 0, NULL, 0, NULL),
(2021115085, 'IT5201', 2, 0, NULL, 0, NULL),
(2021115085, 'IT5211', 2, 0, NULL, 0, NULL),
(2021115085, 'IT5301', 3, 0, NULL, 0, NULL),
(2021115085, 'IT5302', 3, 0, NULL, 0, NULL),
(2021115085, 'IT5311', 3, 0, NULL, 0, NULL),
(2021115085, 'IT5312', 3, 0, NULL, 0, NULL),
(2021115085, 'IT5351', 3, 0, NULL, 0, NULL),
(2021115085, 'IT5352', 3, 0, NULL, 0, NULL),
(2021115085, 'IT5401', 4, 0, NULL, 0, NULL),
(2021115085, 'IT5402', 4, 0, NULL, 0, NULL),
(2021115085, 'IT5403', 4, 0, NULL, 0, NULL),
(2021115085, 'IT5411', 4, 0, NULL, 0, NULL),
(2021115085, 'IT5412', 4, 0, NULL, 0, NULL),
(2021115085, 'IT5451', 4, 0, NULL, 0, NULL),
(2021115085, 'IT5501', 5, 0, NULL, 0, NULL),
(2021115085, 'IT5502', 5, 0, NULL, 0, NULL),
(2021115085, 'IT5511', 5, 0, NULL, 0, NULL),
(2021115085, 'IT5512', 5, 0, NULL, 0, NULL),
(2021115085, 'IT5513', 5, 0, NULL, 0, NULL),
(2021115085, 'IT5551', 5, 0, NULL, 0, NULL),
(2021115085, 'IT5601', 6, 0, NULL, 0, NULL),
(2021115085, 'IT5602', 6, 0, NULL, 0, NULL),
(2021115085, 'IT5603', 6, 0, NULL, 0, NULL),
(2021115085, 'IT5611', 6, 0, NULL, 0, NULL),
(2021115085, 'IT5612', 6, 0, NULL, 0, NULL),
(2021115085, 'IT5613', 6, 0, NULL, 0, NULL),
(2021115085, 'IT5701', 7, 0, NULL, 0, NULL),
(2021115085, 'IT5702', 7, 0, NULL, 0, NULL),
(2021115085, 'IT5703', 7, 0, NULL, 0, NULL),
(2021115085, 'IT5711', 7, 0, NULL, 0, NULL),
(2021115085, 'IT5712', 7, 0, NULL, 0, NULL),
(2021115085, 'IT5811', 8, 0, NULL, 0, NULL),
(2021115085, 'ITXXX1', 5, 0, NULL, 0, NULL),
(2021115085, 'ITXXX2', 5, 0, NULL, 0, NULL),
(2021115085, 'ITXXX3', 6, 0, NULL, 0, NULL),
(2021115085, 'ITXXX4', 6, 0, NULL, 0, NULL),
(2021115085, 'ITXXX5', 7, 0, NULL, 0, NULL),
(2021115085, 'ITXXX6', 7, 0, NULL, 0, NULL),
(2021115085, 'ITXXX7', 8, 0, NULL, 0, NULL),
(2021115085, 'MA5158', 1, 0, NULL, 0, NULL),
(2021115085, 'MA5252', 2, 0, NULL, 0, NULL),
(2021115085, 'MA5302', 3, 0, NULL, 0, NULL),
(2021115085, 'OEXXX1', 6, 0, NULL, 0, NULL),
(2021115085, 'OEXXX2', 7, 0, NULL, 0, NULL),
(2021115085, 'PH5151', 1, 0, NULL, 0, NULL),
(2021115117, 'BS5161', 1, 0, NULL, 0, NULL),
(2021115117, 'CY5151', 1, 0, NULL, 0, NULL),
(2021115117, 'EE5251', 2, 0, NULL, 0, NULL),
(2021115117, 'EE5261', 2, 0, NULL, 0, NULL),
(2021115117, 'GE5151', 2, 0, NULL, 0, NULL),
(2021115117, 'GE5153', 1, 0, NULL, 0, NULL),
(2021115117, 'GE5161', 1, 0, NULL, 0, NULL),
(2021115117, 'GE5251', 4, 0, NULL, 0, NULL),
(2021115117, 'HS5151', 1, 0, NULL, 0, NULL),
(2021115117, 'HS5251', 2, 0, NULL, 0, NULL),
(2021115117, 'HUXXX1', 3, 0, NULL, 0, NULL),
(2021115117, 'HUXXX2', 4, 0, NULL, 0, NULL),
(2021115117, 'HUXXX3', 5, 0, NULL, 0, NULL),
(2021115117, 'IT5201', 2, 0, NULL, 0, NULL),
(2021115117, 'IT5211', 2, 0, NULL, 0, NULL),
(2021115117, 'IT5301', 3, 0, NULL, 0, NULL),
(2021115117, 'IT5302', 3, 0, NULL, 0, NULL),
(2021115117, 'IT5311', 3, 0, NULL, 0, NULL),
(2021115117, 'IT5312', 3, 0, NULL, 0, NULL),
(2021115117, 'IT5351', 3, 0, NULL, 0, NULL),
(2021115117, 'IT5352', 3, 0, NULL, 0, NULL),
(2021115117, 'IT5401', 4, 0, NULL, 0, NULL),
(2021115117, 'IT5402', 4, 0, NULL, 0, NULL),
(2021115117, 'IT5403', 4, 0, NULL, 0, NULL),
(2021115117, 'IT5411', 4, 0, NULL, 0, NULL),
(2021115117, 'IT5412', 4, 0, NULL, 0, NULL),
(2021115117, 'IT5451', 4, 0, NULL, 0, NULL),
(2021115117, 'IT5501', 5, 0, NULL, 0, NULL),
(2021115117, 'IT5502', 5, 0, NULL, 0, NULL),
(2021115117, 'IT5511', 5, 0, NULL, 0, NULL),
(2021115117, 'IT5512', 5, 0, NULL, 0, NULL),
(2021115117, 'IT5513', 5, 0, NULL, 0, NULL),
(2021115117, 'IT5551', 5, 0, NULL, 0, NULL),
(2021115117, 'IT5601', 6, 0, NULL, 0, NULL),
(2021115117, 'IT5602', 6, 0, NULL, 0, NULL),
(2021115117, 'IT5603', 6, 0, NULL, 0, NULL),
(2021115117, 'IT5611', 6, 0, NULL, 0, NULL),
(2021115117, 'IT5612', 6, 0, NULL, 0, NULL),
(2021115117, 'IT5613', 6, 0, NULL, 0, NULL),
(2021115117, 'IT5701', 7, 0, NULL, 0, NULL),
(2021115117, 'IT5702', 7, 0, NULL, 0, NULL),
(2021115117, 'IT5703', 7, 0, NULL, 0, NULL),
(2021115117, 'IT5711', 7, 0, NULL, 0, NULL),
(2021115117, 'IT5712', 7, 0, NULL, 0, NULL),
(2021115117, 'IT5811', 8, 0, NULL, 0, NULL),
(2021115117, 'ITXXX1', 5, 0, NULL, 0, NULL),
(2021115117, 'ITXXX2', 5, 0, NULL, 0, NULL),
(2021115117, 'ITXXX3', 6, 0, NULL, 0, NULL),
(2021115117, 'ITXXX4', 6, 0, NULL, 0, NULL),
(2021115117, 'ITXXX5', 7, 0, NULL, 0, NULL),
(2021115117, 'ITXXX6', 7, 0, NULL, 0, NULL),
(2021115117, 'ITXXX7', 8, 0, NULL, 0, NULL),
(2021115117, 'MA5158', 1, 0, NULL, 0, NULL),
(2021115117, 'MA5252', 2, 0, NULL, 0, NULL),
(2021115117, 'MA5302', 3, 0, NULL, 0, NULL),
(2021115117, 'OEXXX1', 6, 0, NULL, 0, NULL),
(2021115117, 'OEXXX2', 7, 0, NULL, 0, NULL),
(2021115117, 'PH5151', 1, 0, NULL, 0, NULL),
(2021115125, 'BS5161', 1, 0, NULL, 0, NULL),
(2021115125, 'CY5151', 1, 0, NULL, 0, NULL),
(2021115125, 'EE5251', 2, 0, NULL, 0, NULL),
(2021115125, 'EE5261', 2, 0, NULL, 0, NULL),
(2021115125, 'GE5151', 2, 0, NULL, 0, NULL),
(2021115125, 'GE5153', 1, 0, NULL, 0, NULL),
(2021115125, 'GE5161', 1, 0, NULL, 0, NULL),
(2021115125, 'GE5251', 4, 0, NULL, 0, NULL),
(2021115125, 'HS5151', 1, 0, NULL, 0, NULL),
(2021115125, 'HS5251', 2, 0, NULL, 0, NULL),
(2021115125, 'HUXXX1', 3, 0, NULL, 0, NULL),
(2021115125, 'HUXXX2', 4, 0, NULL, 0, NULL),
(2021115125, 'HUXXX3', 5, 0, NULL, 0, NULL),
(2021115125, 'IT5201', 2, 0, NULL, 0, NULL),
(2021115125, 'IT5211', 2, 0, NULL, 0, NULL),
(2021115125, 'IT5301', 3, 0, NULL, 0, NULL),
(2021115125, 'IT5302', 3, 0, NULL, 0, NULL),
(2021115125, 'IT5311', 3, 0, NULL, 0, NULL),
(2021115125, 'IT5312', 3, 0, NULL, 0, NULL),
(2021115125, 'IT5351', 3, 0, NULL, 0, NULL),
(2021115125, 'IT5352', 3, 0, NULL, 0, NULL),
(2021115125, 'IT5401', 4, 0, NULL, 0, NULL),
(2021115125, 'IT5402', 4, 0, NULL, 0, NULL),
(2021115125, 'IT5403', 4, 0, NULL, 0, NULL),
(2021115125, 'IT5411', 4, 0, NULL, 0, NULL),
(2021115125, 'IT5412', 4, 0, NULL, 0, NULL),
(2021115125, 'IT5451', 4, 0, NULL, 0, NULL),
(2021115125, 'IT5501', 5, 0, NULL, 0, NULL),
(2021115125, 'IT5502', 5, 0, NULL, 0, NULL),
(2021115125, 'IT5511', 5, 0, NULL, 0, NULL),
(2021115125, 'IT5512', 5, 0, NULL, 0, NULL),
(2021115125, 'IT5513', 5, 0, NULL, 0, NULL),
(2021115125, 'IT5551', 5, 0, NULL, 0, NULL),
(2021115125, 'IT5601', 6, 0, NULL, 0, NULL),
(2021115125, 'IT5602', 6, 0, NULL, 0, NULL),
(2021115125, 'IT5603', 6, 0, NULL, 0, NULL),
(2021115125, 'IT5611', 6, 0, NULL, 0, NULL),
(2021115125, 'IT5612', 6, 0, NULL, 0, NULL),
(2021115125, 'IT5613', 6, 0, NULL, 0, NULL),
(2021115125, 'IT5701', 7, 0, NULL, 0, NULL),
(2021115125, 'IT5702', 7, 0, NULL, 0, NULL),
(2021115125, 'IT5703', 7, 0, NULL, 0, NULL),
(2021115125, 'IT5711', 7, 0, NULL, 0, NULL),
(2021115125, 'IT5712', 7, 0, NULL, 0, NULL),
(2021115125, 'IT5811', 8, 0, NULL, 0, NULL),
(2021115125, 'ITXXX1', 5, 0, NULL, 0, NULL),
(2021115125, 'ITXXX2', 5, 0, NULL, 0, NULL),
(2021115125, 'ITXXX3', 6, 0, NULL, 0, NULL),
(2021115125, 'ITXXX4', 6, 0, NULL, 0, NULL),
(2021115125, 'ITXXX5', 7, 0, NULL, 0, NULL),
(2021115125, 'ITXXX6', 7, 0, NULL, 0, NULL),
(2021115125, 'ITXXX7', 8, 0, NULL, 0, NULL),
(2021115125, 'MA5158', 1, 0, NULL, 0, NULL),
(2021115125, 'MA5252', 2, 0, NULL, 0, NULL),
(2021115125, 'MA5302', 3, 0, NULL, 0, NULL),
(2021115125, 'OEXXX1', 6, 0, NULL, 0, NULL),
(2021115125, 'OEXXX2', 7, 0, NULL, 0, NULL),
(2021115125, 'PH5151', 1, 0, NULL, 0, NULL),
(2021115315, 'BS5161', 1, 0, NULL, 0, NULL),
(2021115315, 'CY5151', 1, 0, NULL, 0, NULL),
(2021115315, 'EE5251', 2, 0, NULL, 0, NULL),
(2021115315, 'EE5261', 2, 0, NULL, 0, NULL),
(2021115315, 'GE5151', 2, 0, NULL, 0, NULL),
(2021115315, 'GE5153', 1, 0, NULL, 0, NULL),
(2021115315, 'GE5161', 1, 0, NULL, 0, NULL),
(2021115315, 'GE5251', 4, 0, NULL, 0, NULL),
(2021115315, 'HS5151', 1, 0, NULL, 0, NULL),
(2021115315, 'HS5251', 2, 0, NULL, 0, NULL),
(2021115315, 'HUXXX1', 3, 0, NULL, 0, NULL),
(2021115315, 'HUXXX2', 4, 0, NULL, 0, NULL),
(2021115315, 'HUXXX3', 5, 0, NULL, 0, NULL),
(2021115315, 'IT5201', 2, 0, NULL, 0, NULL),
(2021115315, 'IT5211', 2, 0, NULL, 0, NULL),
(2021115315, 'IT5301', 3, 0, NULL, 0, NULL),
(2021115315, 'IT5302', 3, 0, NULL, 0, NULL),
(2021115315, 'IT5311', 3, 0, NULL, 0, NULL),
(2021115315, 'IT5312', 3, 0, NULL, 0, NULL),
(2021115315, 'IT5351', 3, 0, NULL, 0, NULL),
(2021115315, 'IT5352', 3, 0, NULL, 0, NULL),
(2021115315, 'IT5401', 4, 0, NULL, 0, NULL),
(2021115315, 'IT5402', 4, 0, NULL, 0, NULL),
(2021115315, 'IT5403', 4, 0, NULL, 0, NULL),
(2021115315, 'IT5411', 4, 0, NULL, 0, NULL),
(2021115315, 'IT5412', 4, 0, NULL, 0, NULL),
(2021115315, 'IT5451', 4, 0, NULL, 0, NULL),
(2021115315, 'IT5501', 5, 0, NULL, 0, NULL),
(2021115315, 'IT5502', 5, 0, NULL, 0, NULL),
(2021115315, 'IT5511', 5, 0, NULL, 0, NULL),
(2021115315, 'IT5512', 5, 0, NULL, 0, NULL),
(2021115315, 'IT5513', 5, 0, NULL, 0, NULL),
(2021115315, 'IT5551', 5, 0, NULL, 0, NULL),
(2021115315, 'IT5601', 6, 0, NULL, 0, NULL),
(2021115315, 'IT5602', 6, 0, NULL, 0, NULL),
(2021115315, 'IT5603', 6, 0, NULL, 0, NULL),
(2021115315, 'IT5611', 6, 0, NULL, 0, NULL),
(2021115315, 'IT5612', 6, 0, NULL, 0, NULL),
(2021115315, 'IT5613', 6, 0, NULL, 0, NULL),
(2021115315, 'IT5701', 7, 0, NULL, 0, NULL),
(2021115315, 'IT5702', 7, 0, NULL, 0, NULL),
(2021115315, 'IT5703', 7, 0, NULL, 0, NULL),
(2021115315, 'IT5711', 7, 0, NULL, 0, NULL),
(2021115315, 'IT5712', 7, 0, NULL, 0, NULL),
(2021115315, 'IT5811', 8, 0, NULL, 0, NULL),
(2021115315, 'ITXXX1', 5, 0, NULL, 0, NULL),
(2021115315, 'ITXXX2', 5, 0, NULL, 0, NULL),
(2021115315, 'ITXXX3', 6, 0, NULL, 0, NULL),
(2021115315, 'ITXXX4', 6, 0, NULL, 0, NULL),
(2021115315, 'ITXXX5', 7, 0, NULL, 0, NULL),
(2021115315, 'ITXXX6', 7, 0, NULL, 0, NULL),
(2021115315, 'ITXXX7', 8, 0, NULL, 0, NULL),
(2021115315, 'MA5158', 1, 0, NULL, 0, NULL),
(2021115315, 'MA5252', 2, 0, NULL, 0, NULL),
(2021115315, 'MA5302', 3, 0, NULL, 0, NULL),
(2021115315, 'OEXXX1', 6, 0, NULL, 0, NULL),
(2021115315, 'OEXXX2', 7, 0, NULL, 0, NULL),
(2021115315, 'PH5151', 1, 0, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `paper_published`
--

CREATE TABLE `paper_published` (
  `id` int(11) NOT NULL,
  `roll_number` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `journal` varchar(255) DEFAULT NULL,
  `date_year` date DEFAULT NULL,
  `DOI_link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `paper_published`
--

INSERT INTO `paper_published` (`id`, `roll_number`, `title`, `journal`, `date_year`, `DOI_link`) VALUES
(1, 111, 'CTG Fetal Risk Classification', 'IEEE', '0000-00-00', 'ieee.com'),
(3, 2021115050, 'CTG Fetal Risk Classification', 'IEEE', '0000-00-00', 'ieee.com');

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `id` int(11) NOT NULL,
  `roll_number` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `guide` varchar(255) DEFAULT NULL,
  `project_desc` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`id`, `roll_number`, `title`, `guide`, `project_desc`) VALUES
(1, 111, 'SRP-Project', 'ABC', 'Socially Relavent Project'),
(3, 2021115050, 'SRP-Project', 'ABC', 'Socially Relavent Project');

-- --------------------------------------------------------

--
-- Table structure for table `scholarship`
--

CREATE TABLE `scholarship` (
  `id` int(11) NOT NULL,
  `roll_number` int(11) DEFAULT NULL,
  `ScholarshipProvider` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `scholarship`
--

INSERT INTO `scholarship` (`id`, `roll_number`, `ScholarshipProvider`, `amount`) VALUES
(1, 111, 'Aram', 50000.00),
(5, 111, 'LMES', 10000.00),
(6, 2021115050, 'Aram', 50000.00),
(7, 2021115050, 'LMES', 10000.00);

-- --------------------------------------------------------

--
-- Table structure for table `sem`
--

CREATE TABLE `sem` (
  `subject_code` varchar(50) NOT NULL,
  `sem_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sem`
--

INSERT INTO `sem` (`subject_code`, `sem_number`) VALUES
('IT5014', 6),
('IT5402', 3);

-- --------------------------------------------------------

--
-- Table structure for table `sports`
--

CREATE TABLE `sports` (
  `id` int(11) NOT NULL,
  `roll_number` int(11) DEFAULT NULL,
  `event_name` varchar(255) DEFAULT NULL,
  `award` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sports`
--

INSERT INTO `sports` (`id`, `roll_number`, `event_name`, `award`) VALUES
(4, 111, 'abc', 'sample'),
(5, 2021115050, 'abc', 'sample');

-- --------------------------------------------------------

--
-- Table structure for table `studentdetails`
--

CREATE TABLE `studentdetails` (
  `RollNumber` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `Residenttype` enum('Hosteller','Dayscholar') DEFAULT NULL,
  `Address` varchar(500) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Sex` enum('Male','Female') DEFAULT NULL,
  `Blood_Group` varchar(10) DEFAULT NULL,
  `FatherName` varchar(50) DEFAULT NULL,
  `Fathermobile` varchar(20) DEFAULT NULL,
  `Mothername` varchar(50) DEFAULT NULL,
  `Mothermobile` varchar(20) DEFAULT NULL,
  `Fatheroccupation` varchar(50) DEFAULT NULL,
  `Motheroccupation` varchar(50) DEFAULT NULL,
  `StudentImage` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentdetails`
--

INSERT INTO `studentdetails` (`RollNumber`, `Name`, `DateOfBirth`, `Residenttype`, `Address`, `Phone`, `Sex`, `Blood_Group`, `FatherName`, `Fathermobile`, `Mothername`, `Mothermobile`, `Fatheroccupation`, `Motheroccupation`, `StudentImage`) VALUES
(202, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(222, NULL, '2024-03-04', NULL, 'Vaagai Hostels,CEG', '12345678', 'Male', 'o', 'afd', NULL, 'dsfs', NULL, 'afd', 'adf', NULL),
(333, NULL, '2024-03-13', NULL, 'Vaagai Hostels,CEG', '123', 'Male', 'O+', 'Father', NULL, 'Mother Name', NULL, 'Father Occupation', 'Mother Occupation', NULL),
(4444, 'Karthikeyan M S', '2003-09-16', 'Hosteller', '9-E, Type-1 Qtrs, Block-19, Neyveli-3', '9345534207', 'Male', 'O+', 'Maharajan K', '9442058375', 'Sumathi M', '9487332765', 'Retired NLC Employee', 'HouseWife', 'image_1713202330826.png'),
(2021115018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2021115042, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2021115050, 'Karthikeyan M S', '2003-09-16', 'Hosteller', '9-E,Type-1 qtrs, Block-19, Neyveli - 607803', '9345534207', 'Male', 'O+', 'Maharajan K', '9442058375', 'Sumathi M', '9487332765', 'Retired NLC Employee', 'Housewife', 'image_1713412580544.jpg'),
(2021115074, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2021115076, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2021115085, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2021115117, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2021115125, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2021115315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `rollnumber` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `year_of_joining` int(11) NOT NULL,
  `facultyadvisorid` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`rollnumber`, `username`, `password`, `email`, `year_of_joining`, `facultyadvisorid`) VALUES
(111, '111', '111', 'temp@gmail.com', 2021, 'T001'),
(202, '202', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '202@gmail.com', 2021, NULL),
(222, '222', '222', 'temp2@gmail.com', 2021, 'T001'),
(333, '333', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '333@gmail.com', 2021, ''),
(4444, '444', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '444@gmail.com', 2021, ''),
(2021115018, 'aruna', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'arunamanivannan2003@gmail.com', 2021, NULL),
(2021115042, 'Navas', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'ibrahimnavas2003@gmail.com', 2021, NULL),
(2021115050, 'Karthikeyan', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'msk@gmail.com', 2021, NULL),
(2021115074, '2021115074', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'prabhavathi@gmail.com', 2021, NULL),
(2021115076, 'Praveen', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'praveenanand333@gmail.com', 2021, NULL),
(2021115085, 'Ratish', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'rathuratish4589@gmail.com', 2021, NULL),
(2021115117, 'Thirumurugan', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'thirumurugankumaresan@gmail.com', 2021, NULL),
(2021115125, 'Yuvaraj', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'yuvaraj@gmail.com', 2021, NULL),
(2021115315, 'Gopi', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'gopiramesh1972@gmail.com', 2021, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `student_academic_details`
--

CREATE TABLE `student_academic_details` (
  `RollNumber` int(11) NOT NULL,
  `CurrentSemester` int(11) DEFAULT NULL,
  `TenthMarks` float(5,2) DEFAULT NULL,
  `HigherSecondaryMarks` float(5,2) DEFAULT NULL,
  `Cutoff` float(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_academic_details`
--

INSERT INTO `student_academic_details` (`RollNumber`, `CurrentSemester`, `TenthMarks`, `HigherSecondaryMarks`, `Cutoff`) VALUES
(202, NULL, NULL, NULL, NULL),
(2021115018, NULL, NULL, NULL, NULL),
(2021115042, NULL, NULL, NULL, NULL),
(2021115050, 6, 32.00, 34.00, 198.00),
(2021115074, NULL, NULL, NULL, NULL),
(2021115076, NULL, NULL, NULL, NULL),
(2021115085, NULL, NULL, NULL, NULL),
(2021115117, NULL, NULL, NULL, NULL),
(2021115125, NULL, NULL, NULL, NULL),
(2021115315, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `SubjectID` varchar(50) NOT NULL,
  `SubjectName` varchar(100) DEFAULT NULL,
  `Type` enum('core','prof-elective','humanities-elective','optional','open-elective') NOT NULL,
  `Semester` int(11) DEFAULT NULL,
  `credits` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`SubjectID`, `SubjectName`, `Type`, `Semester`, `credits`) VALUES
('BS5161', 'Basic Sciences Laboratory', 'core', 1, 2),
('CY5151', 'Engineering Chemistry', 'core', 1, 3),
('EE5251', 'Basics of Electrical and Electronics Engineering', 'core', 2, 3),
('EE5261', 'Electrical and Electronics Engineering Laboratory', 'core', 2, 2),
('GE5151', 'Engineering Graphics', 'core', 2, 3),
('GE5153', 'Problem Solving and Python Programming', 'core', 1, 3),
('GE5161', 'Problem Solving and Python Programming Laboratory', 'core', 1, 2),
('GE5251', 'Environmental Sciences', 'core', 4, 3),
('HS5151', 'Technical English', 'core', 1, 4),
('HS5251', 'Professional Communication', 'core', 2, 4),
('HUXXX1', 'Humanities Elective I', 'humanities-elective', 3, 3),
('HUXXX2', 'Humanities Elective II', 'humanities-elective', 4, 3),
('HUXXX3', 'Humanities Elective I', 'humanities-elective', 5, 3),
('IT5201', 'Information Technology Essentials', 'core', 2, 3),
('IT5211', 'Information Technology Essentials Laboratory', 'core', 2, 2),
('IT5301', 'Digital Logic and Design', 'core', 3, 3),
('IT5302', 'Software Engineering', 'core', 3, 3),
('IT5311', 'Programming and Data Structures Laboratory', 'core', 3, 2),
('IT5312', 'Database Management Systems Laboratory', 'core', 3, 2),
('IT5351', 'Database Management Systems', 'core', 3, 3),
('IT5352', 'Programming and Data Structures', 'core', 3, 3),
('IT5401', 'Object Oriented Programming and Advanced Data Structures', 'core', 4, 3),
('IT5402', 'Design and Analysis of Algorithms', 'core', 4, 3),
('IT5403', 'Operating Systems', 'core', 4, 3),
('IT5411', 'Operating Systems Laboratory', 'core', 4, 2),
('IT5412', 'Advanced Data Structures Laboratory', 'core', 4, 2),
('IT5451', 'Computer Architecture', 'core', 4, 3),
('IT5501', 'Web Technologies', 'core', 5, 3),
('IT5502', 'Compiler Engineering', 'core', 5, 3),
('IT5511', 'Computer Networks Laboratory', 'core', 5, 2),
('IT5512', 'Web Technologies Laboratory', 'core', 5, 2),
('IT5513', 'Summer Internship /Summer Project', 'core', 5, 2),
('IT5551', 'Computer Networks', 'core', 5, 3),
('IT5601', 'Embedded Systems and Internet of Things', 'core', 6, 3),
('IT5602', 'Data Science and Analytics', 'core', 6, 3),
('IT5603', 'Embedded Systems', 'core', 6, 3),
('IT5611', 'Embedded Systems and Internet of Things Laboratory', 'core', 6, 2),
('IT5612', 'Data Analytics and Cloud Computing Laboratory', 'core', 6, 2),
('IT5613', 'Socially Relevant Project Laboratory', 'core', 6, 1),
('IT5701', 'Artificial Intelligence', 'core', 7, 3),
('IT5702', 'Mobile Computing', 'core', 7, 3),
('IT5703', 'Cryptography and Security', 'core', 7, 3),
('IT5711', 'Mobile and Security Laboratory', 'core', 7, 2),
('IT5712', 'Project I', 'core', 7, 2),
('IT5811', 'Project II', 'core', 8, 8),
('ITXXX1', 'Professional Elective I', 'prof-elective', 5, 3),
('ITXXX2', 'Professional Elective II', 'prof-elective', 5, 3),
('ITXXX3', 'Professional Elective III', 'prof-elective', 6, 3),
('ITXXX4', 'Professional Elective IV', 'prof-elective', 6, 3),
('ITXXX5', 'Professional Elective V', 'prof-elective', 7, 3),
('ITXXX6', 'Professional Elective VI', 'prof-elective', 7, 3),
('ITXXX7', 'Professional Elective VII', 'prof-elective', 8, 3),
('MA5158', 'Engineering Mathematics I', 'core', 1, 4),
('MA5252', 'Engineering Mathematics II', 'core', 2, 4),
('MA5302', 'Discrete Mathematics', 'core', 3, 4),
('OEXXX1', 'Open Elective I', 'open-elective', 6, 3),
('OEXXX2', 'Open Elective II', 'open-elective', 7, 3),
('PH5151', 'Engineering Physics', 'core', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `teacherId` varchar(100) NOT NULL,
  `teacher_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`teacherId`, `teacher_name`, `password`, `email`) VALUES
('T001', 'staff1', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'arunamanivannan2003@gmail.com'),
('T002', 's1', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 's1@gmail.com'),
('T004', 'Anand', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'anandkumar333221@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `teachersubjects`
--

CREATE TABLE `teachersubjects` (
  `TeacherID` varchar(50) NOT NULL,
  `SubjectID` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachersubjects`
--

INSERT INTO `teachersubjects` (`TeacherID`, `SubjectID`) VALUES
('T001', 'EC5693'),
('T002', 'IT5014'),
('T003', 'IT5020'),
('T004', 'IT5601'),
('T005', 'IT5602'),
('T006', 'IT5603'),
('T007', 'IT5611'),
('T008', 'IT5612'),
('T009', 'IT5613');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `enrolledsubjects`
--
ALTER TABLE `enrolledsubjects`
  ADD PRIMARY KEY (`student_roll_number`,`subjectid`),
  ADD KEY `subjectid` (`subjectid`),
  ADD KEY `teacher_email` (`teacher_email`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `roll_number` (`roll_number`);

--
-- Indexes for table `exams_attended`
--
ALTER TABLE `exams_attended`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roll_number` (`roll_number`);

--
-- Indexes for table `gpa`
--
ALTER TABLE `gpa`
  ADD PRIMARY KEY (`rollnumber`,`semester`);

--
-- Indexes for table `internship`
--
ALTER TABLE `internship`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `roll_number` (`roll_number`);

--
-- Indexes for table `marks`
--
ALTER TABLE `marks`
  ADD PRIMARY KEY (`RollNumber`,`SubjectID`,`Semester`),
  ADD KEY `SubjectID` (`SubjectID`);

--
-- Indexes for table `paper_published`
--
ALTER TABLE `paper_published`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `roll_number` (`roll_number`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `roll_number` (`roll_number`);

--
-- Indexes for table `scholarship`
--
ALTER TABLE `scholarship`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `roll_number` (`roll_number`);

--
-- Indexes for table `sem`
--
ALTER TABLE `sem`
  ADD PRIMARY KEY (`subject_code`);

--
-- Indexes for table `sports`
--
ALTER TABLE `sports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `roll_number` (`roll_number`);

--
-- Indexes for table `studentdetails`
--
ALTER TABLE `studentdetails`
  ADD PRIMARY KEY (`RollNumber`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`rollnumber`);

--
-- Indexes for table `student_academic_details`
--
ALTER TABLE `student_academic_details`
  ADD PRIMARY KEY (`RollNumber`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`SubjectID`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teacherId`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `teachersubjects`
--
ALTER TABLE `teachersubjects`
  ADD PRIMARY KEY (`TeacherID`,`SubjectID`),
  ADD KEY `SubjectID` (`SubjectID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `exams_attended`
--
ALTER TABLE `exams_attended`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internship`
--
ALTER TABLE `internship`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `paper_published`
--
ALTER TABLE `paper_published`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `scholarship`
--
ALTER TABLE `scholarship`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `sports`
--
ALTER TABLE `sports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `enrolledsubjects`
--
ALTER TABLE `enrolledsubjects`
  ADD CONSTRAINT `enrolledsubjects_ibfk_1` FOREIGN KEY (`subjectid`) REFERENCES `subjects` (`SubjectID`),
  ADD CONSTRAINT `enrolledsubjects_ibfk_2` FOREIGN KEY (`teacher_email`) REFERENCES `teachers` (`email`),
  ADD CONSTRAINT `fk_student_roll_number` FOREIGN KEY (`student_roll_number`) REFERENCES `students` (`rollnumber`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
