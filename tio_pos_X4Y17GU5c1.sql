-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 30, 2024 at 11:33 AM
-- Server version: 10.6.18-MariaDB-0ubuntu0.22.04.1
-- PHP Version: 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tio_pos_X4Y17GU5c1`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `balance` double NOT NULL,
  `account_number` varchar(255) NOT NULL,
  `total_in` double DEFAULT NULL,
  `total_out` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `account`, `description`, `balance`, `account_number`, `total_in`, `total_out`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'Cash', 'Default account', 614050, '1', 2749600, 2135550, '2021-11-28 05:06:59', '2024-04-26 22:50:03', NULL),
(2, 'Payable', 'td', 0, '2', 0, 0, '2021-11-28 05:07:21', '2024-04-25 13:28:35', NULL),
(3, 'Receivable', 'Default account', 0, '3', 0, 0, '2021-11-28 05:07:36', '2024-03-31 15:55:28', NULL),
(11, 'K pay', NULL, 12000, 'Kp1', 12100, 100, '2024-04-22 18:29:15', '2024-04-26 22:50:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `f_name` varchar(255) NOT NULL,
  `l_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `f_name`, `l_name`, `email`, `phone`, `password`, `remember_token`, `created_at`, `updated_at`, `image`, `company_id`, `role_id`) VALUES
(1, 'Pyae Sone', 'Phyoe', 'admin123@gmail.com', 'admin123@gmail.com', '$2y$10$yI8NSzQU6CrcNZzWDdrDGeI9lVL1hHySU8w4bF0BUAC.AldwKGH3.', NULL, '2024-02-20 16:45:58', '2024-08-21 20:30:42', '2024-04-04-660e74215fac7.png', NULL, 1),
(2, 'Phyoe Thaw Tar Oo', 'Lin', 'phyothawtar048@gmail.com', '+959442274599', '$2y$10$5uUhrMkhpy4LUG5zYq4bReLsvRxH23KkPIxSPsY4LKtBxW4PyAP.i', NULL, '2024-02-28 19:05:41', '2024-04-25 17:00:42', 'def.png', NULL, 2),
(3, 'Ko Khun Min', 'Set Wai', 'khunminsetwai@gmail.com', '+959251098193', '$2y$10$Rb0GtIWBKdzO0vhG5lYZLOy/lPaYM0247rJuOMg/K.E7cpYLVQXTy', NULL, '2024-02-28 19:51:24', '2024-04-25 16:09:37', '2024-02-28-65df335472cb6.png', NULL, 3),
(4, 'Ko', 'Thurein', 'tiothurein0@gail.com', '09224456766', '$2y$10$saKSW0mPjji0YI1g0iqdLuNHbKT8gxyXCmQLXwuDG7qx3OQaxQmuS', NULL, '2024-04-19 08:30:12', '2024-04-25 16:12:10', '2024-04-19-6621d02be6908.png', NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `admin_roles`
--

CREATE TABLE `admin_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(30) NOT NULL,
  `modules` longtext DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_roles`
--

INSERT INTO `admin_roles` (`id`, `name`, `modules`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Master Admin', NULL, 1, '2024-02-20 16:45:58', '2024-02-20 16:45:58'),
(2, 'Sale', '[\"pos_section\",\"product_section\",\"customer_section\",\"brand_section\",\"unit_section\",\"stock_section\",\"coupon_section\"]', 1, '2024-02-28 19:03:47', '2024-04-25 18:53:23'),
(3, 'General Manager', '[\"account\",\"dashboard_section\",\"pos_section\",\"product_section\",\"employee_section\",\"employee_role_section\",\"customer_section\",\"supplier_section\",\"setting_section\",\"category_section\",\"brand_section\",\"unit_section\",\"account_section\",\"stock_section\",\"coupon_section\"]', 1, '2024-02-28 19:04:00', '2024-02-28 19:04:00');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `image`, `created_at`, `updated_at`, `company_id`) VALUES
(3, 'Testing Company Limited', '2023-10-25-65389205947d0.png', '2023-10-25 03:56:53', '2024-02-28 16:43:38', NULL),
(4, 'RFYF (Raw For Your feed )', '2024-02-28-65df079ba6a63.png', '2024-02-28 16:44:51', '2024-02-28 16:44:51', NULL),
(5, 'DingFong', '2024-04-28-662dd79aeb922.png', '2024-02-28 16:46:28', '2024-04-28 11:29:06', NULL),
(6, 'Tio', '2024-04-25-662a26ef1b796.png', '2024-04-25 16:18:31', '2024-04-25 16:18:31', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `business_settings`
--

CREATE TABLE `business_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `business_settings`
--

INSERT INTO `business_settings` (`id`, `key`, `value`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'shop_logo', '2024-04-22-6626700e762b9.png', NULL, NULL, NULL),
(2, 'pagination_limit', '15', NULL, NULL, NULL),
(3, 'currency', 'MMK', NULL, NULL, NULL),
(4, 'shop_name', 'Tio Coffee', NULL, NULL, NULL),
(5, 'shop_address', 'Mandalay', NULL, NULL, NULL),
(6, 'shop_phone', '09442274599', NULL, NULL, NULL),
(7, 'shop_email', 'tiocoffeeofice@gmail.com', NULL, NULL, NULL),
(8, 'footer_text', '@Copyrights by Tio Tech', NULL, NULL, NULL),
(9, 'country', 'MM', NULL, NULL, NULL),
(10, 'stock_limit', '999', NULL, NULL, NULL),
(11, 'time_zone', 'Asia/Rangoon', NULL, NULL, NULL),
(12, 'vat_reg_no', '0000', NULL, NULL, NULL),
(13, 'fav_icon', '2024-03-23-65fe530c8e2fd.png', NULL, NULL, NULL),
(14, 'currency_symbol', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `parent_id`, `position`, `status`, `image`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'Coffee', 0, 0, 1, 'def.png', '2024-04-25 16:18:46', '2024-04-25 16:18:46', NULL),
(3, 'Bevrages', 0, 0, 1, 'def.png', '2024-04-25 16:20:35', '2024-04-25 16:20:35', NULL),
(4, 'Coffee', 3, 1, 1, 'def.png', '2024-04-25 16:20:47', '2024-04-25 16:20:47', NULL),
(5, 'Tea', 3, 1, 1, 'def.png', '2024-04-25 16:57:44', '2024-04-25 16:57:44', NULL),
(6, 'Milkshake', 3, 1, 1, 'def.png', '2024-04-25 17:39:11', '2024-04-25 17:39:11', NULL),
(7, 'Soda', 3, 1, 1, 'def.png', '2024-04-25 19:38:52', '2024-04-25 19:38:52', NULL),
(8, 'Juice', 3, 1, 1, 'def.png', '2024-04-25 19:53:40', '2024-04-25 19:53:40', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `sub_domain_prefix` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `coupon_type` varchar(255) NOT NULL DEFAULT 'default',
  `user_limit` int(11) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `min_purchase` decimal(8,2) NOT NULL DEFAULT 0.00,
  `max_discount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `discount_type` varchar(15) NOT NULL DEFAULT 'percentage',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `country` varchar(255) DEFAULT NULL,
  `currency_code` varchar(255) DEFAULT NULL,
  `currency_symbol` varchar(255) DEFAULT NULL,
  `exchange_rate` decimal(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `country`, `currency_code`, `currency_symbol`, `exchange_rate`, `created_at`, `updated_at`) VALUES
(1, 'US Dollar', 'USD', '$', 1.00, NULL, NULL),
(2, 'Canadian Dollar', 'CAD', 'CA$', 1.00, NULL, NULL),
(3, 'Euro', 'EUR', '€', 1.00, NULL, NULL),
(4, 'United Arab Emirates Dirham', 'AED', 'د.إ.‏', 1.00, NULL, NULL),
(5, 'Afghan Afghani', 'AFN', '؋', 1.00, NULL, NULL),
(6, 'Albanian Lek', 'ALL', 'L', 1.00, NULL, NULL),
(7, 'Armenian Dram', 'AMD', '֏', 1.00, NULL, NULL),
(8, 'Argentine Peso', 'ARS', '$', 1.00, NULL, NULL),
(9, 'Australian Dollar', 'AUD', '$', 1.00, NULL, NULL),
(10, 'Azerbaijani Manat', 'AZN', '₼', 1.00, NULL, NULL),
(11, 'Bosnia-Herzegovina Convertible Mark', 'BAM', 'KM', 1.00, NULL, NULL),
(12, 'Bangladeshi Taka', 'BDT', '৳', 1.00, NULL, NULL),
(13, 'Bulgarian Lev', 'BGN', 'лв.', 1.00, NULL, NULL),
(14, 'Bahraini Dinar', 'BHD', 'د.ب.‏', 1.00, NULL, NULL),
(15, 'Burundian Franc', 'BIF', 'FBu', 1.00, NULL, NULL),
(16, 'Brunei Dollar', 'BND', 'B$', 1.00, NULL, NULL),
(17, 'Bolivian Boliviano', 'BOB', 'Bs', 1.00, NULL, NULL),
(18, 'Brazilian Real', 'BRL', 'R$', 1.00, NULL, NULL),
(19, 'Botswanan Pula', 'BWP', 'P', 1.00, NULL, NULL),
(20, 'Belarusian Ruble', 'BYN', 'Br', 1.00, NULL, NULL),
(21, 'Belize Dollar', 'BZD', '$', 1.00, NULL, NULL),
(22, 'Congolese Franc', 'CDF', 'FC', 1.00, NULL, NULL),
(23, 'Swiss Franc', 'CHF', 'CHf', 1.00, NULL, NULL),
(24, 'Chilean Peso', 'CLP', '$', 1.00, NULL, NULL),
(25, 'Chinese Yuan', 'CNY', '¥', 1.00, NULL, NULL),
(26, 'Colombian Peso', 'COP', '$', 1.00, NULL, NULL),
(27, 'Costa Rican Colón', 'CRC', '₡', 1.00, NULL, NULL),
(28, 'Cape Verdean Escudo', 'CVE', '$', 1.00, NULL, NULL),
(29, 'Czech Republic Koruna', 'CZK', 'Kč', 1.00, NULL, NULL),
(30, 'Djiboutian Franc', 'DJF', 'Fdj', 1.00, NULL, NULL),
(31, 'Danish Krone', 'DKK', 'Kr.', 1.00, NULL, NULL),
(32, 'Dominican Peso', 'DOP', 'RD$', 1.00, NULL, NULL),
(33, 'Algerian Dinar', 'DZD', 'د.ج.‏', 1.00, NULL, NULL),
(34, 'Estonian Kroon', 'EEK', 'kr', 1.00, NULL, NULL),
(35, 'Egyptian Pound', 'EGP', 'E£‏', 1.00, NULL, NULL),
(36, 'Eritrean Nakfa', 'ERN', 'Nfk', 1.00, NULL, NULL),
(37, 'Ethiopian Birr', 'ETB', 'Br', 1.00, NULL, NULL),
(38, 'British Pound Sterling', 'GBP', '£', 1.00, NULL, NULL),
(39, 'Georgian Lari', 'GEL', 'GEL', 1.00, NULL, NULL),
(40, 'Ghanaian Cedi', 'GHS', 'GH¢', 1.00, NULL, NULL),
(41, 'Guinean Franc', 'GNF', 'FG', 1.00, NULL, NULL),
(42, 'Guatemalan Quetzal', 'GTQ', 'Q', 1.00, NULL, NULL),
(43, 'Hong Kong Dollar', 'HKD', 'HK$', 1.00, NULL, NULL),
(44, 'Honduran Lempira', 'HNL', 'L', 1.00, NULL, NULL),
(45, 'Croatian Kuna', 'HRK', 'kn', 1.00, NULL, NULL),
(46, 'Hungarian Forint', 'HUF', 'Ft', 1.00, NULL, NULL),
(47, 'Indonesian Rupiah', 'IDR', 'Rp', 1.00, NULL, NULL),
(48, 'Israeli New Sheqel', 'ILS', '₪', 1.00, NULL, NULL),
(49, 'Indian Rupee', 'INR', '₹', 1.00, NULL, NULL),
(50, 'Iraqi Dinar', 'IQD', 'ع.د', 1.00, NULL, NULL),
(51, 'Iranian Rial', 'IRR', '﷼', 1.00, NULL, NULL),
(52, 'Icelandic Króna', 'ISK', 'kr', 1.00, NULL, NULL),
(53, 'Jamaican Dollar', 'JMD', '$', 1.00, NULL, NULL),
(54, 'Jordanian Dinar', 'JOD', 'د.ا‏', 1.00, NULL, NULL),
(55, 'Japanese Yen', 'JPY', '¥', 1.00, NULL, NULL),
(56, 'Kenyan Shilling', 'KES', 'Ksh', 1.00, NULL, NULL),
(57, 'Cambodian Riel', 'KHR', '៛', 1.00, NULL, NULL),
(58, 'Comorian Franc', 'KMF', 'FC', 1.00, NULL, NULL),
(59, 'South Korean Won', 'KRW', 'CF', 1.00, NULL, NULL),
(60, 'Kuwaiti Dinar', 'KWD', 'د.ك.‏', 1.00, NULL, NULL),
(61, 'Kazakhstani Tenge', 'KZT', '₸.', 1.00, NULL, NULL),
(62, 'Lebanese Pound', 'LBP', 'ل.ل.‏', 1.00, NULL, NULL),
(63, 'Sri Lankan Rupee', 'LKR', 'Rs', 1.00, NULL, NULL),
(64, 'Lithuanian Litas', 'LTL', 'Lt', 1.00, NULL, NULL),
(65, 'Latvian Lats', 'LVL', 'Ls', 1.00, NULL, NULL),
(66, 'Libyan Dinar', 'LYD', 'د.ل.‏', 1.00, NULL, NULL),
(67, 'Moroccan Dirham', 'MAD', 'د.م.‏', 1.00, NULL, NULL),
(68, 'Moldovan Leu', 'MDL', 'L', 1.00, NULL, NULL),
(69, 'Malagasy Ariary', 'MGA', 'Ar', 1.00, NULL, NULL),
(70, 'Macedonian Denar', 'MKD', 'Ден', 1.00, NULL, NULL),
(71, 'Myanma Kyat', 'MMK', 'K', 1.00, NULL, NULL),
(72, 'Macanese Pataca', 'MOP', 'MOP$', 1.00, NULL, NULL),
(73, 'Mauritian Rupee', 'MUR', 'Rs', 1.00, NULL, NULL),
(74, 'Mexican Peso', 'MXN', '$', 1.00, NULL, NULL),
(75, 'Malaysian Ringgit', 'MYR', 'RM', 1.00, NULL, NULL),
(76, 'Mozambican Metical', 'MZN', 'MT', 1.00, NULL, NULL),
(77, 'Namibian Dollar', 'NAD', 'N$', 1.00, NULL, NULL),
(78, 'Nigerian Naira', 'NGN', '₦', 1.00, NULL, NULL),
(79, 'Nicaraguan Córdoba', 'NIO', 'C$', 1.00, NULL, NULL),
(80, 'Norwegian Krone', 'NOK', 'kr', 1.00, NULL, NULL),
(81, 'Nepalese Rupee', 'NPR', 'Re.', 1.00, NULL, NULL),
(82, 'New Zealand Dollar', 'NZD', '$', 1.00, NULL, NULL),
(83, 'Omani Rial', 'OMR', 'ر.ع.‏', 1.00, NULL, NULL),
(84, 'Panamanian Balboa', 'PAB', 'B/.', 1.00, NULL, NULL),
(85, 'Peruvian Nuevo Sol', 'PEN', 'S/', 1.00, NULL, NULL),
(86, 'Philippine Peso', 'PHP', '₱', 1.00, NULL, NULL),
(87, 'Pakistani Rupee', 'PKR', 'Rs', 1.00, NULL, NULL),
(88, 'Polish Zloty', 'PLN', 'zł', 1.00, NULL, NULL),
(89, 'Paraguayan Guarani', 'PYG', '₲', 1.00, NULL, NULL),
(90, 'Qatari Rial', 'QAR', 'ر.ق.‏', 1.00, NULL, NULL),
(91, 'Romanian Leu', 'RON', 'lei', 1.00, NULL, NULL),
(92, 'Serbian Dinar', 'RSD', 'din.', 1.00, NULL, NULL),
(93, 'Russian Ruble', 'RUB', '₽.', 1.00, NULL, NULL),
(94, 'Rwandan Franc', 'RWF', 'FRw', 1.00, NULL, NULL),
(95, 'Saudi Riyal', 'SAR', 'ر.س.‏', 1.00, NULL, NULL),
(96, 'Sudanese Pound', 'SDG', 'ج.س.', 1.00, NULL, NULL),
(97, 'Swedish Krona', 'SEK', 'kr', 1.00, NULL, NULL),
(98, 'Singapore Dollar', 'SGD', '$', 1.00, NULL, NULL),
(99, 'Somali Shilling', 'SOS', 'Sh.so.', 1.00, NULL, NULL),
(100, 'Syrian Pound', 'SYP', 'LS‏', 1.00, NULL, NULL),
(101, 'Thai Baht', 'THB', '฿', 1.00, NULL, NULL),
(102, 'Tunisian Dinar', 'TND', 'د.ت‏', 1.00, NULL, NULL),
(103, 'Tongan Paʻanga', 'TOP', 'T$', 1.00, NULL, NULL),
(104, 'Turkish Lira', 'TRY', '₺', 1.00, NULL, NULL),
(105, 'Trinidad and Tobago Dollar', 'TTD', '$', 1.00, NULL, NULL),
(106, 'New Taiwan Dollar', 'TWD', 'NT$', 1.00, NULL, NULL),
(107, 'Tanzanian Shilling', 'TZS', 'TSh', 1.00, NULL, NULL),
(108, 'Ukrainian Hryvnia', 'UAH', '₴', 1.00, NULL, NULL),
(109, 'Ugandan Shilling', 'UGX', 'USh', 1.00, NULL, NULL),
(110, 'Uruguayan Peso', 'UYU', '$', 1.00, NULL, NULL),
(111, 'Uzbekistan Som', 'UZS', 'so\'m', 1.00, NULL, NULL),
(112, 'Venezuelan Bolívar', 'VEF', 'Bs.F.', 1.00, NULL, NULL),
(113, 'Vietnamese Dong', 'VND', '₫', 1.00, NULL, NULL),
(114, 'CFA Franc BEAC', 'XAF', 'FCFA', 1.00, NULL, NULL),
(115, 'CFA Franc BCEAO', 'XOF', 'CFA', 1.00, NULL, NULL),
(116, 'Yemeni Rial', 'YER', '﷼‏', 1.00, NULL, NULL),
(117, 'South African Rand', 'ZAR', 'R', 1.00, NULL, NULL),
(118, 'Zambian Kwacha', 'ZMK', 'ZK', 1.00, NULL, NULL),
(119, 'Zimbabwean Dollar', 'ZWL', 'Z$', 1.00, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `mobile` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `is_customer` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `mobile`, `email`, `image`, `state`, `city`, `zip_code`, `address`, `balance`, `created_at`, `updated_at`, `company_id`, `is_customer`) VALUES
(0, 'walking customer', '1', NULL, 'def.png', NULL, NULL, NULL, NULL, 0, '2024-04-25 13:47:32', '0000-00-00 00:00:00', NULL, 0),
(2, 'Ko Tin Lin Soe', '+959456678955', 'tinlinsoe@gmail.com', 'def.png', NULL, NULL, NULL, NULL, 0, '2024-04-25 16:22:36', '2024-04-25 16:22:36', NULL, 0),
(3, 'Ko Hein Min Htet', '+9592399998', NULL, 'def.png', NULL, NULL, NULL, NULL, 0, '2024-04-25 20:40:26', '2024-04-25 20:40:26', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `edit_transaction_news`
--

CREATE TABLE `edit_transaction_news` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_new_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `admin_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `edit_transaction_new_details`
--

CREATE TABLE `edit_transaction_new_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `edit_transaction_new_id` int(11) NOT NULL,
  `product_new_id` int(11) NOT NULL,
  `old_quantity` int(11) NOT NULL,
  `new_quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `edit_transfer_records`
--

CREATE TABLE `edit_transfer_records` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transfer_record_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `admin_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `edit_transfer_record_details`
--

CREATE TABLE `edit_transfer_record_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `edit_transfer_record_id` int(11) NOT NULL,
  `product_new_id` int(11) NOT NULL,
  `old_quantity` int(11) NOT NULL,
  `new_quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2021_11_02_095022_create_business_settings_table', 1),
(6, '2021_11_02_114801_create_admins_table', 1),
(7, '2021_11_03_044923_create_categories_table', 1),
(8, '2021_11_03_090927_create_brands_table', 1),
(9, '2021_11_03_101237_create_products_table', 1),
(10, '2021_11_06_025604_create_currencies_table', 1),
(11, '2021_11_06_031804_create_orders_table', 1),
(12, '2021_11_06_084528_create_order_details_table', 1),
(13, '2021_11_08_094042_create_customers_table', 1),
(15, '2021_11_11_051704_create_coupons_table', 1),
(16, '2021_11_13_100539_create_units_table', 1),
(17, '2021_11_17_034203_create_accounts_table', 1),
(20, '2021_11_17_083502_create_transections_table', 2),
(21, '2021_11_09_064445_create_suppliers_table', 3),
(22, '2021_06_17_054551_create_soft_credentials_table', 4),
(23, '2021_12_01_141901_add_phone_col_admin', 4),
(24, '2021_12_02_092539_add_image_to_admin_tables', 4),
(25, '2016_06_01_000001_create_oauth_auth_codes_table', 5),
(26, '2016_06_01_000002_create_oauth_access_tokens_table', 5),
(27, '2016_06_01_000003_create_oauth_refresh_tokens_table', 5),
(28, '2016_06_01_000004_create_oauth_clients_table', 5),
(29, '2016_06_01_000005_create_oauth_personal_access_clients_table', 5),
(30, '2022_02_06_115834_create_companies_table', 5),
(31, '2022_02_06_121739_add_company_id_col_admin', 5),
(32, '2022_02_06_150041_add_company_id_category', 5),
(33, '2022_02_06_151731_add_company_id_brand', 5),
(34, '2022_02_06_152243_add_company_id_accounts', 5),
(35, '2022_02_06_152301_add_company_id_coupon', 5),
(36, '2022_02_06_152323_add_company_id_users', 5),
(37, '2022_02_06_152357_add_company_id_orders', 5),
(38, '2022_02_06_152412_add_company_id_order_details', 5),
(39, '2022_02_06_152429_add_company_id_products', 5),
(40, '2022_02_06_152453_add_company_id_suppliers', 5),
(41, '2022_02_06_152515_add_company_id_transactions', 5),
(42, '2022_02_06_152943_add_company_id_units', 5),
(43, '2022_02_06_154752_add_company_id_customers', 5),
(44, '2022_02_06_160446_add_company_id_business_settings', 5),
(45, '2022_06_19_194943_rename_columns_to_coupons_table', 5),
(46, '2024_01_24_175057_create_admin_roles_table', 6),
(47, '2024_01_24_183027_add_to_col_admin_table', 6),
(48, '2014_10_12_100000_create_password_reset_tokens_table', 7),
(49, '2024_04_23_144041_is_purchase_record', 7),
(50, '2024_06_12_093445_is_customer', 8),
(51, '2024_06_14_140829_car_driver_name', 8),
(52, '2024_06_14_142016_car_id', 8),
(53, '2024_06_14_142050_is_paid_for_car_fee', 8),
(54, '2024_06_17_183851_absolute', 8),
(55, '2024_06_17_183906_lost', 8),
(56, '2024_06_17_183923_gain', 8),
(57, '2024_07_04_124021_create_product_news_table', 8),
(58, '2024_07_04_222459_create_shops_table', 8),
(59, '2024_07_05_105851_create_tanks_table', 8),
(60, '2024_07_06_103454_create_product_shop_table', 8),
(61, '2024_07_06_103502_create_product_tank_table', 8),
(62, '2024_07_06_163137_create_transaction_news_table', 8),
(63, '2024_07_06_163328_add_transaction_id_to_product_shop_table', 9),
(64, '2024_07_06_163507_add_transaction_id_to_product_shop_table', 10),
(65, '2024_07_15_113417_add_absolute_to_product_new_shop_table', 10),
(66, '2024_07_15_113906_add_absolute_to_product_new_tank_table', 10),
(67, '2024_07_18_205300_create_transfer_records_table', 10),
(68, '2024_07_18_211831_create_transfer_record_product_new_table', 10),
(69, '2024_08_23_111213_add_is_final_to_transferrecords_table', 11),
(70, '2024_08_23_111847_add_status_to_transfer_records_table', 12),
(71, '2024_08_23_112342_add_is_extra_to_transfer_record_product_new_table', 13),
(72, '2024_08_24_195100_add_is_po_to_transaction_news_table', 14),
(73, '2024_08_24_200331_add_extra_description_to_transfer_records_table', 14),
(74, '2024_10_19_113725_create_edit_transaction_news_table', 15),
(75, '2024_10_20_021646_create_table_edit_transfer_records', 15),
(76, '2024_10_21_103550_add_user_id_to_edit_transfer_records_table', 15),
(77, '2024_10_21_103824_add_user_id_to_edit_transaction_news_table', 15),
(78, '2024_10_21_173223_add_created_by_and_confirmed_by_to_transfer_records_table', 15),
(79, '2024_10_21_173523_add_created_by_to_transaction_news_table', 15),
(80, '2024_10_21_220642_create_edit_transaction_new_details_table', 15),
(81, '2024_10_21_220700_create_edit_transfer_record_details_table', 15);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('0a4ac3bf39517e1965b9468203e3e5d20ba0a56afe87a2e7c0eaec259899e4835face1bf1c2fb7ff', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-28 11:04:52', '2024-08-28 11:04:52', '2025-08-28 11:04:52'),
('107584a2db1f3a9f9f726d7ad7f10b5fe1a9125e5ddfb82e59de7645dc667322dc715274434e5498', 3, 1, 'LaravelPassportClient', '[]', 0, '2024-02-28 19:53:12', '2024-02-28 19:53:12', '2025-02-28 19:53:12'),
('1c2fc17c7a83b6e13a6c2806ac99ee6b5e4d0b1df41e664e45fd73c0f42a4c1a046ec5c5d2e89c1b', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-26 21:13:49', '2024-08-26 21:13:49', '2025-08-26 21:13:49'),
('2b8b73855884c2eb98ff68f7ff258e3ef465ce4d22ec0b7f083abacd05e4a2c45769f56cdcac817a', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-02-28 19:48:37', '2024-02-28 19:48:37', '2025-02-28 19:48:37'),
('2cdd176d7154ceb19412af20103e20696b8af47d5973a0fef650e99920d019443184648bcf98aaa1', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-26 19:56:39', '2024-08-26 19:56:39', '2025-08-26 19:56:39'),
('35e5d1979953aca7f0d06920b7832821cce55c773517329202ed2ffc6495d7d9b36229a9f2d9ae03', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-26 19:09:35', '2024-08-26 19:09:35', '2025-08-26 19:09:35'),
('42b95b1b11a684965f5d2b890be2c681cc05605e039e48630ee76de456125524890960c7faf992b5', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-02-24 14:17:22', '2024-02-24 14:17:22', '2025-02-24 14:17:22'),
('445d5339b9de191484a178b9cbc34bc337c21bed2d585dbfe84abd4ad47f02bba90970de1e9210c8', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-21 20:33:57', '2024-08-21 20:33:57', '2025-08-21 20:33:57'),
('471b71340760bf75b3aef50c40bbf4e874dc6f325e15c5d1fab24ee94249f53b9cf29934d1fd75e4', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-26 16:27:28', '2024-08-26 16:27:28', '2025-08-26 16:27:28'),
('47f7a80b605a2b322c368cd80c1c7dd79b61a709307903f981db8072e076d562faaaaa79cb9d2962', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-28 09:59:37', '2024-08-28 09:59:37', '2025-08-28 09:59:37'),
('55aea171b6eb8307e5163fe61a5804b21d425e3e55b52c6f9e8b7f7aec382bbb5be945725f24cb63', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-02-24 14:17:20', '2024-02-24 14:17:20', '2025-02-24 14:17:20'),
('586881f114fb20021d1cbface6e0a7c1f83966a5f2d06a9326055783982b9e16166a78140c471c71', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-02-24 14:13:26', '2024-02-24 14:13:26', '2025-02-24 14:13:26'),
('6bfb0e919d3550f449987646cafb9fd1ebff68c666023093b71c16b26316a3234f98660edfeb44b7', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-25 21:58:16', '2024-08-25 21:58:16', '2025-08-25 21:58:16'),
('80c96725da918904b18294c881239fbc1046ba524db701f1bc484dc53ca43fcbaf60d35f469fb82c', 2, 1, 'LaravelPassportClient', '[]', 0, '2024-02-28 19:07:30', '2024-02-28 19:07:30', '2025-02-28 19:07:30'),
('8bf34036929f20b9df81dae9d6d0cfb2733390595919e9a09a38cd05a5d3604c2b3269eecbbe1994', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-26 21:57:28', '2024-08-26 21:57:28', '2025-08-26 21:57:28'),
('91cd1788064baef26a15557e75736b96d26040779b94d29f14c4b7929db2240f8154c4f1fb8c4430', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-02-28 20:12:10', '2024-02-28 20:12:10', '2025-02-28 20:12:10'),
('983f51bb76c04afb84f1a399e07bf34290bcc0d06c05fb91708d741a2d4c47b30c85d792a4909c90', 2, 1, 'LaravelPassportClient', '[]', 0, '2024-02-28 19:06:21', '2024-02-28 19:06:21', '2025-02-28 19:06:21'),
('9ac1010cd3c5c6fa12e70da71448534d9dbf63e5c5d179c8cb426f4e4496d12f950ea74b52cd5da7', 1, 3, 'LaravelPassportClient', '[]', 0, '2024-11-29 14:33:32', '2024-11-29 14:33:32', '2025-11-29 14:33:32'),
('9d86dd0e5bd3b81c2e4dd3bdcbdf65dd3b23e45a491ac6da6ccd3851217258ad8f907a5bfce6f330', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-26 16:27:34', '2024-08-26 16:27:34', '2025-08-26 16:27:34'),
('abba1c14471288759bcad2bb55e3907e8ee5a3ed745d0526f5419fb6919f763f1b14d498e0828a46', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-25 22:42:27', '2024-08-25 22:42:27', '2025-08-25 22:42:27'),
('b2477a2114987021d7996532df2e347e0a5933ab178ff770af30ef0c8c786739426a75910ebf4732', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-02-24 14:13:09', '2024-02-24 14:13:09', '2025-02-24 14:13:09'),
('b3d866b18b6471f966e4988333e34e697e2955b829496cec90bc0ff6706f14e1b8ff08e33a1b7375', 3, 1, 'LaravelPassportClient', '[]', 0, '2024-02-28 19:57:37', '2024-02-28 19:57:37', '2025-02-28 19:57:37'),
('dd289f7c9eaa5b915d661ac8046668146eabbc1ebbf9a7ab619335414f0746e8e8bc603668a674ec', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-02-28 19:59:38', '2024-02-28 19:59:38', '2025-02-28 19:59:38'),
('ddf07f567166024a399be0f28a7177854412a3986b771b436cfb2f4daa03592d229d4b3a7f777675', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-23 11:05:34', '2024-08-23 11:05:34', '2025-08-23 11:05:34'),
('ea7cc831fdb0129d63600dc2b5e61206f3e44b9a3856cea568442023a723d6fb0b4b897b519827a7', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-26 16:42:56', '2024-08-26 16:42:56', '2025-08-26 16:42:56'),
('eb9c9b780c429b7b62204acb53d858d1464db3043ebac574d325cb010745057e6807551ad0fed878', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-08-26 21:26:00', '2024-08-26 21:26:00', '2025-08-26 21:26:00'),
('ee512d2d0a7213828dfedb4cb99905603f9432d7e81ddbb9e23e32eb2f49996f9bfc9b12b69592f4', 1, 1, 'LaravelPassportClient', '[]', 0, '2024-02-24 14:20:38', '2024-02-24 14:20:38', '2025-02-24 14:20:38');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `secret` varchar(100) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `redirect` text NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', '$2y$10$Htk01zDU0oqll.c/1Yn3Ne1k4AacFMa8o6lE.vYkbMYlZpnOBg9rS', NULL, 'http://localhost', 1, 0, 0, '2022-07-27 12:47:21', '2022-07-27 12:47:21'),
(2, NULL, 'Laravel Password Grant Client', '$2y$10$1KPNKD2A/51U5knvzM1Oe.b2BJaYwQ8/cC8e9tlHjGnFziiW.Ayk2', 'users', 'http://localhost', 0, 1, 0, '2022-07-27 12:47:21', '2022-07-27 12:47:21'),
(3, NULL, '6pos-1708448813 Personal Access Client', '7K82hTpq6Bi0U3RW97O8DTJbg4WbRcaDmGdbPQVQ', NULL, 'http://localhost', 1, 0, 0, '2024-11-29 14:33:27', '2024-11-29 14:33:27'),
(4, NULL, '6pos-1708448813 Password Grant Client', 'BEu4P6LhACrfLs5pvFyHcdiwSoDUYJgIqKb0sNGq', 'users', 'http://localhost', 0, 1, 0, '2024-11-29 14:33:27', '2024-11-29 14:33:27');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2022-07-27 12:47:21', '2022-07-27 12:47:21'),
(2, 3, '2024-11-29 14:33:27', '2024-11-29 14:33:27');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) NOT NULL,
  `access_token_id` varchar(100) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_amount` double NOT NULL DEFAULT 0,
  `total_tax` double NOT NULL,
  `collected_cash` double DEFAULT NULL,
  `extra_discount` double DEFAULT NULL,
  `coupon_code` varchar(255) DEFAULT NULL,
  `coupon_discount_amount` double NOT NULL DEFAULT 0,
  `coupon_discount_title` varchar(255) DEFAULT NULL,
  `payment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `transaction_reference` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `is_purchase_record` tinyint(1) NOT NULL,
  `car_driver_name` varchar(255) NOT NULL,
  `car_id` varchar(255) NOT NULL,
  `is_paid_for_car_fee` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_amount`, `total_tax`, `collected_cash`, `extra_discount`, `coupon_code`, `coupon_discount_amount`, `coupon_discount_title`, `payment_id`, `transaction_reference`, `created_at`, `updated_at`, `company_id`, `is_purchase_record`, `car_driver_name`, `car_id`, `is_paid_for_car_fee`) VALUES
(100001, 0, 5000, 0, 5000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 16:22:46', '2024-04-25 16:22:46', NULL, 0, '', '', 0),
(100002, 0, 6000, 0, 10000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 18:48:12', '2024-04-25 18:48:12', NULL, 0, '', '', 0),
(100003, 2, 2000, 0, 2000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 19:27:54', '2024-04-25 19:27:54', NULL, 0, '', '', 0),
(100004, 2, 5000, 0, 5000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 20:32:31', '2024-04-25 20:32:31', NULL, 0, '', '', 0),
(100005, 2, 4000, 0, 5000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 20:33:04', '2024-04-25 20:33:04', NULL, 0, '', '', 0),
(100006, 3, 3500, 0, 4000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 20:40:58', '2024-04-25 20:40:58', NULL, 0, '', '', 0),
(100007, 3, 17500, 0, 17500, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 20:55:56', '2024-04-25 20:55:56', NULL, 0, '', '', 0),
(100008, 3, 2500, 0, 2500, NULL, NULL, 0, NULL, 11, '2500', '2024-04-25 20:58:26', '2024-04-25 20:58:26', NULL, 0, '', '', 0),
(100009, 3, 9500, 0, 9500, NULL, NULL, 0, NULL, 11, '8/4/24', '2024-04-25 21:02:06', '2024-04-25 21:02:06', NULL, 0, '', '', 0),
(100010, 3, 17500, 0, 20000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 21:06:40', '2024-04-25 21:06:40', NULL, 0, '', '', 0),
(100011, 3, 2000, 0, 2000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 21:08:28', '2024-04-25 21:08:28', NULL, 0, '', '', 0),
(100012, 3, 23000, 0, 24000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 21:12:23', '2024-04-25 21:12:23', NULL, 0, '', '', 0),
(100013, 3, 13500, 0, 15000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 21:14:05', '2024-04-25 21:14:05', NULL, 0, '', '', 0),
(100014, 3, 13000, 0, 13000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 21:15:42', '2024-04-25 21:15:42', NULL, 0, '', '', 0),
(100015, 3, 2500, 0, 2500, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 21:17:21', '2024-04-25 21:17:21', NULL, 0, '', '', 0),
(100016, 3, 15500, 0, 16000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 21:18:13', '2024-04-25 21:18:13', NULL, 0, '', '', 0),
(100017, 3, 18000, 0, 18000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 21:20:04', '2024-04-25 21:20:04', NULL, 0, '', '', 0),
(100018, 3, 10500, 0, 11000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 21:21:49', '2024-04-25 21:21:49', NULL, 0, '', '', 0),
(100019, 3, 33000, 0, 33000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 21:24:19', '2024-04-25 21:24:19', NULL, 0, '', '', 0),
(100020, 3, 40500, 0, 41000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 21:26:45', '2024-04-25 21:26:45', NULL, 0, '', '', 0),
(100021, 3, 12500, 0, 13000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 21:28:47', '2024-04-25 21:28:47', NULL, 0, '', '', 0),
(100022, 3, 5000, 0, 5000, NULL, NULL, 0, NULL, 1, NULL, '2024-04-25 21:30:15', '2024-04-25 21:30:15', NULL, 0, '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `price` double NOT NULL DEFAULT 0,
  `product_details` text DEFAULT NULL,
  `discount_on_product` double DEFAULT NULL,
  `discount_type` varchar(20) NOT NULL DEFAULT 'amount',
  `quantity` int(11) NOT NULL DEFAULT 1,
  `tax_amount` double NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `product_id`, `order_id`, `price`, `product_details`, `discount_on_product`, `discount_type`, `quantity`, `tax_amount`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 1, 100001, 2500, '{\"id\":1,\"name\":\"Americano\",\"product_code\":\"94486\",\"unit_type\":3,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"def.png\",\"order_count\":1,\"supplier_id\":1,\"created_at\":\"2024-04-25T09:51:45.000000Z\",\"updated_at\":\"2024-04-25T09:52:46.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/public\\/assets\\/admin\\/img\\/160x160\\/img2.jpg\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 16:22:46', '2024-04-25 16:22:46', NULL),
(2, 6, 100002, 3000, '{\"id\":6,\"name\":\"Bubble Tea\",\"product_code\":\"91453\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a37809439d.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:59:12.000000Z\",\"updated_at\":\"2024-04-25T12:18:12.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a37809439d.png\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 18:48:12', '2024-04-25 18:48:12', NULL),
(3, 2, 100003, 2000, '{\"id\":2,\"name\":\"Tio Signature Coffee\",\"product_code\":\"91314\",\"unit_type\":4,\"unit_value\":2000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a32e7de934.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:39:35.000000Z\",\"updated_at\":\"2024-04-25T12:57:54.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a32e7de934.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 19:27:54', '2024-04-25 19:27:54', NULL),
(4, 13, 100004, 2500, '{\"id\":13,\"name\":\"Kiwi Milkshake\",\"product_code\":\"36621\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a3c3147f0b.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:19:13.000000Z\",\"updated_at\":\"2024-04-25T14:02:31.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3c3147f0b.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 20:32:31', '2024-04-25 20:32:31', NULL),
(5, 17, 100004, 2500, '{\"id\":17,\"name\":\"Passion Soda\",\"product_code\":\"30282\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a56a4c4a25.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:12:04.000000Z\",\"updated_at\":\"2024-04-25T14:02:31.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a56a4c4a25.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 20:32:31', '2024-04-25 20:32:31', NULL),
(6, 24, 100005, 2000, '{\"id\":24,\"name\":\"Kiwi Juice\",\"product_code\":\"59138\",\"unit_type\":4,\"unit_value\":2000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"8\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a5b6fcc614.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:32:31.000000Z\",\"updated_at\":\"2024-04-25T14:03:04.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5b6fcc614.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 20:33:04', '2024-04-25 20:33:04', NULL),
(7, 22, 100005, 2000, '{\"id\":22,\"name\":\"Passion Juice\",\"product_code\":\"37003\",\"unit_type\":4,\"unit_value\":2000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"8\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a59cf99ef4.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:25:35.000000Z\",\"updated_at\":\"2024-04-25T14:03:04.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a59cf99ef4.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 20:33:04', '2024-04-25 20:33:04', NULL),
(8, 7, 100006, 3500, '{\"id\":7,\"name\":\"Thai Tea\",\"product_code\":\"53803\",\"unit_type\":4,\"unit_value\":3500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a383e95809.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:02:22.000000Z\",\"updated_at\":\"2024-04-25T14:10:58.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a383e95809.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 20:40:58', '2024-04-25 20:40:58', NULL),
(9, 19, 100007, 2500, '{\"id\":19,\"name\":\"Kiwi Soda\",\"product_code\":\"40604\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a5825e60a1.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:18:29.000000Z\",\"updated_at\":\"2024-04-25T14:25:56.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5825e60a1.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 20:55:56', '2024-04-25 20:55:56', NULL),
(10, 17, 100007, 2500, '{\"id\":17,\"name\":\"Passion Soda\",\"product_code\":\"30282\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a56a4c4a25.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:12:04.000000Z\",\"updated_at\":\"2024-04-25T14:25:56.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a56a4c4a25.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 20:55:56', '2024-04-25 20:55:56', NULL),
(11, 15, 100007, 2500, '{\"id\":15,\"name\":\"Blueberry Milkshake\",\"product_code\":\"14794\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a3d799d798.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:24:41.000000Z\",\"updated_at\":\"2024-04-25T14:25:56.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3d799d798.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 20:55:56', '2024-04-25 20:55:56', NULL),
(12, 4, 100007, 2500, '{\"id\":4,\"name\":\"Iced Coffee\",\"product_code\":\"89837\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a35c344d22.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:51:47.000000Z\",\"updated_at\":\"2024-04-25T14:25:56.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a35c344d22.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 20:55:56', '2024-04-25 20:55:56', NULL),
(13, 21, 100007, 2500, '{\"id\":21,\"name\":\"Blueberry Soda\",\"product_code\":\"95070\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a594482fc3.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:23:16.000000Z\",\"updated_at\":\"2024-04-25T14:25:56.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a594482fc3.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 20:55:56', '2024-04-25 20:55:56', NULL),
(14, 20, 100007, 2500, '{\"id\":20,\"name\":\"Raspberry Soda\",\"product_code\":\"69600\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a58dc36deb.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:21:32.000000Z\",\"updated_at\":\"2024-04-25T14:25:56.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a58dc36deb.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 20:55:56', '2024-04-25 20:55:56', NULL),
(15, 18, 100007, 2500, '{\"id\":18,\"name\":\"Peach Soda\",\"product_code\":\"20128\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a5769c8c57.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:15:21.000000Z\",\"updated_at\":\"2024-04-25T14:25:56.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5769c8c57.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 20:55:56', '2024-04-25 20:55:56', NULL),
(16, 15, 100008, 2500, '{\"id\":15,\"name\":\"Blueberry Milkshake\",\"product_code\":\"14794\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a3d799d798.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:24:41.000000Z\",\"updated_at\":\"2024-04-25T14:28:26.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3d799d798.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 20:58:26', '2024-04-25 20:58:26', NULL),
(17, 15, 100009, 2500, '{\"id\":15,\"name\":\"Blueberry Milkshake\",\"product_code\":\"14794\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a3d799d798.png\",\"order_count\":3,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:24:41.000000Z\",\"updated_at\":\"2024-04-25T14:32:06.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3d799d798.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:02:06', '2024-04-25 21:02:06', NULL),
(18, 10, 100009, 3000, '{\"id\":10,\"name\":\"Peach Green Tea\",\"product_code\":\"14407\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a39ae71c6e.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:08:30.000000Z\",\"updated_at\":\"2024-04-25T14:32:06.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a39ae71c6e.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:02:06', '2024-04-25 21:02:06', NULL),
(19, 24, 100009, 2000, '{\"id\":24,\"name\":\"Kiwi Juice\",\"product_code\":\"59138\",\"unit_type\":4,\"unit_value\":2000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"8\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a5b6fcc614.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:32:31.000000Z\",\"updated_at\":\"2024-04-25T14:32:06.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5b6fcc614.png\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 21:02:06', '2024-04-25 21:02:06', NULL),
(20, 10, 100010, 3000, '{\"id\":10,\"name\":\"Peach Green Tea\",\"product_code\":\"14407\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a39ae71c6e.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:08:30.000000Z\",\"updated_at\":\"2024-04-25T14:36:40.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a39ae71c6e.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:06:40', '2024-04-25 21:06:40', NULL),
(21, 9, 100010, 3000, '{\"id\":9,\"name\":\"Passion Green Tea\",\"product_code\":\"59616\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a3936df305.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:06:30.000000Z\",\"updated_at\":\"2024-04-25T14:36:40.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3936df305.png\"}', 0, 'discount_on_product', 3, 0, '2024-04-25 21:06:40', '2024-04-25 21:06:40', NULL),
(22, 6, 100010, 3000, '{\"id\":6,\"name\":\"Bubble Tea\",\"product_code\":\"91453\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a37809439d.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:59:12.000000Z\",\"updated_at\":\"2024-04-25T14:36:40.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a37809439d.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:06:40', '2024-04-25 21:06:40', NULL),
(23, 1, 100010, 2500, '{\"id\":1,\"name\":\"Iced Americano\",\"product_code\":\"94486\",\"unit_type\":3,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a2a0fc5033.png\",\"order_count\":2,\"supplier_id\":1,\"created_at\":\"2024-04-25T09:51:45.000000Z\",\"updated_at\":\"2024-04-25T14:36:40.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a2a0fc5033.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:06:40', '2024-04-25 21:06:40', NULL),
(24, 2, 100011, 2000, '{\"id\":2,\"name\":\"Tio Signature Coffee\",\"product_code\":\"91314\",\"unit_type\":4,\"unit_value\":2000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a32e7de934.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:39:35.000000Z\",\"updated_at\":\"2024-04-25T14:38:28.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a32e7de934.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:08:28', '2024-04-25 21:08:28', NULL),
(25, 6, 100012, 3000, '{\"id\":6,\"name\":\"Bubble Tea\",\"product_code\":\"91453\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":95,\"image\":\"2024-04-25-662a37809439d.png\",\"order_count\":3,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:59:12.000000Z\",\"updated_at\":\"2024-04-25T14:42:23.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a37809439d.png\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 21:12:23', '2024-04-25 21:12:23', NULL),
(26, 2, 100012, 2000, '{\"id\":2,\"name\":\"Tio Signature Coffee\",\"product_code\":\"91314\",\"unit_type\":4,\"unit_value\":2000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a32e7de934.png\",\"order_count\":3,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:39:35.000000Z\",\"updated_at\":\"2024-04-25T14:42:23.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a32e7de934.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:12:23', '2024-04-25 21:12:23', NULL),
(27, 24, 100012, 2000, '{\"id\":24,\"name\":\"Kiwi Juice\",\"product_code\":\"59138\",\"unit_type\":4,\"unit_value\":2000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"8\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":95,\"image\":\"2024-04-25-662a5b6fcc614.png\",\"order_count\":3,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:32:31.000000Z\",\"updated_at\":\"2024-04-25T14:42:23.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5b6fcc614.png\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 21:12:23', '2024-04-25 21:12:23', NULL),
(28, 9, 100012, 3000, '{\"id\":9,\"name\":\"Passion Green Tea\",\"product_code\":\"59616\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":95,\"image\":\"2024-04-25-662a3936df305.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:06:30.000000Z\",\"updated_at\":\"2024-04-25T14:42:23.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3936df305.png\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 21:12:23', '2024-04-25 21:12:23', NULL),
(29, 13, 100012, 2500, '{\"id\":13,\"name\":\"Kiwi Milkshake\",\"product_code\":\"36621\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a3c3147f0b.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:19:13.000000Z\",\"updated_at\":\"2024-04-25T14:42:23.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3c3147f0b.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:12:23', '2024-04-25 21:12:23', NULL),
(30, 11, 100012, 2500, '{\"id\":11,\"name\":\"Raspberry Milkshake\",\"product_code\":\"58239\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a3a9cceffa.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:12:28.000000Z\",\"updated_at\":\"2024-04-25T14:42:23.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3a9cceffa.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:12:23', '2024-04-25 21:12:23', NULL),
(31, 4, 100013, 2500, '{\"id\":4,\"name\":\"Iced Coffee\",\"product_code\":\"89837\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a35c344d22.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:51:47.000000Z\",\"updated_at\":\"2024-04-25T14:44:05.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a35c344d22.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:14:05', '2024-04-25 21:14:05', NULL),
(32, 18, 100013, 2500, '{\"id\":18,\"name\":\"Peach Soda\",\"product_code\":\"20128\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":96,\"image\":\"2024-04-25-662a5769c8c57.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:15:21.000000Z\",\"updated_at\":\"2024-04-25T14:44:05.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5769c8c57.png\"}', 0, 'discount_on_product', 3, 0, '2024-04-25 21:14:05', '2024-04-25 21:14:05', NULL),
(33, 7, 100013, 3500, '{\"id\":7,\"name\":\"Thai Tea\",\"product_code\":\"53803\",\"unit_type\":4,\"unit_value\":3500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a383e95809.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:02:22.000000Z\",\"updated_at\":\"2024-04-25T14:44:05.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a383e95809.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:14:05', '2024-04-25 21:14:05', NULL),
(34, 1, 100014, 2500, '{\"id\":1,\"name\":\"Iced Americano\",\"product_code\":\"94486\",\"unit_type\":3,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":96,\"image\":\"2024-04-25-662a2a0fc5033.png\",\"order_count\":3,\"supplier_id\":1,\"created_at\":\"2024-04-25T09:51:45.000000Z\",\"updated_at\":\"2024-04-25T14:45:42.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a2a0fc5033.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:15:42', '2024-04-25 21:15:42', NULL),
(35, 6, 100014, 3000, '{\"id\":6,\"name\":\"Bubble Tea\",\"product_code\":\"91453\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":94,\"image\":\"2024-04-25-662a37809439d.png\",\"order_count\":4,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:59:12.000000Z\",\"updated_at\":\"2024-04-25T14:45:42.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a37809439d.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:15:42', '2024-04-25 21:15:42', NULL),
(36, 4, 100014, 2500, '{\"id\":4,\"name\":\"Iced Coffee\",\"product_code\":\"89837\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a35c344d22.png\",\"order_count\":3,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:51:47.000000Z\",\"updated_at\":\"2024-04-25T14:45:42.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a35c344d22.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:15:42', '2024-04-25 21:15:42', NULL),
(37, 13, 100014, 2500, '{\"id\":13,\"name\":\"Kiwi Milkshake\",\"product_code\":\"36621\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a3c3147f0b.png\",\"order_count\":3,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:19:13.000000Z\",\"updated_at\":\"2024-04-25T14:45:42.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3c3147f0b.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:15:42', '2024-04-25 21:15:42', NULL),
(38, 11, 100014, 2500, '{\"id\":11,\"name\":\"Raspberry Milkshake\",\"product_code\":\"58239\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a3a9cceffa.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:12:28.000000Z\",\"updated_at\":\"2024-04-25T14:45:42.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3a9cceffa.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:15:42', '2024-04-25 21:15:42', NULL),
(39, 14, 100015, 2500, '{\"id\":14,\"name\":\"Peach Milkshake\",\"product_code\":\"61871\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a3cc9a69cf.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:21:45.000000Z\",\"updated_at\":\"2024-04-25T14:47:21.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3cc9a69cf.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:17:21', '2024-04-25 21:17:21', NULL),
(40, 6, 100016, 3000, '{\"id\":6,\"name\":\"Bubble Tea\",\"product_code\":\"91453\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":93,\"image\":\"2024-04-25-662a37809439d.png\",\"order_count\":5,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:59:12.000000Z\",\"updated_at\":\"2024-04-25T14:48:13.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a37809439d.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:18:13', '2024-04-25 21:18:13', NULL),
(41, 20, 100016, 2500, '{\"id\":20,\"name\":\"Raspberry Soda\",\"product_code\":\"69600\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a58dc36deb.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:21:32.000000Z\",\"updated_at\":\"2024-04-25T14:48:13.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a58dc36deb.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:18:13', '2024-04-25 21:18:13', NULL),
(42, 21, 100016, 2500, '{\"id\":21,\"name\":\"Blueberry Soda\",\"product_code\":\"95070\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a594482fc3.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:23:16.000000Z\",\"updated_at\":\"2024-04-25T14:48:13.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a594482fc3.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:18:13', '2024-04-25 21:18:13', NULL),
(43, 19, 100016, 2500, '{\"id\":19,\"name\":\"Kiwi Soda\",\"product_code\":\"40604\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a5825e60a1.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:18:29.000000Z\",\"updated_at\":\"2024-04-25T14:48:13.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5825e60a1.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:18:13', '2024-04-25 21:18:13', NULL),
(44, 18, 100016, 2500, '{\"id\":18,\"name\":\"Peach Soda\",\"product_code\":\"20128\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":94,\"image\":\"2024-04-25-662a5769c8c57.png\",\"order_count\":3,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:15:21.000000Z\",\"updated_at\":\"2024-04-25T14:48:13.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5769c8c57.png\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 21:18:13', '2024-04-25 21:18:13', NULL),
(45, 20, 100017, 2500, '{\"id\":20,\"name\":\"Raspberry Soda\",\"product_code\":\"69600\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a58dc36deb.png\",\"order_count\":3,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:21:32.000000Z\",\"updated_at\":\"2024-04-25T14:50:04.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a58dc36deb.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:20:04', '2024-04-25 21:20:04', NULL),
(46, 13, 100017, 2500, '{\"id\":13,\"name\":\"Kiwi Milkshake\",\"product_code\":\"36621\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":96,\"image\":\"2024-04-25-662a3c3147f0b.png\",\"order_count\":4,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:19:13.000000Z\",\"updated_at\":\"2024-04-25T14:50:04.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3c3147f0b.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:20:04', '2024-04-25 21:20:04', NULL),
(47, 4, 100017, 2500, '{\"id\":4,\"name\":\"Iced Coffee\",\"product_code\":\"89837\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":96,\"image\":\"2024-04-25-662a35c344d22.png\",\"order_count\":4,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:51:47.000000Z\",\"updated_at\":\"2024-04-25T14:50:04.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a35c344d22.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:20:04', '2024-04-25 21:20:04', NULL),
(48, 6, 100017, 3000, '{\"id\":6,\"name\":\"Bubble Tea\",\"product_code\":\"91453\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":91,\"image\":\"2024-04-25-662a37809439d.png\",\"order_count\":6,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:59:12.000000Z\",\"updated_at\":\"2024-04-25T14:50:04.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a37809439d.png\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 21:20:04', '2024-04-25 21:20:04', NULL),
(49, 12, 100017, 2500, '{\"id\":12,\"name\":\"Passion Milkshake\",\"product_code\":\"20328\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a3b5d1fd3f.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:15:41.000000Z\",\"updated_at\":\"2024-04-25T14:50:04.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3b5d1fd3f.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:20:04', '2024-04-25 21:20:04', NULL),
(50, 2, 100017, 2000, '{\"id\":2,\"name\":\"Tio Signature Coffee\",\"product_code\":\"91314\",\"unit_type\":4,\"unit_value\":2000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":96,\"image\":\"2024-04-25-662a32e7de934.png\",\"order_count\":4,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:39:35.000000Z\",\"updated_at\":\"2024-04-25T14:50:04.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a32e7de934.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:20:04', '2024-04-25 21:20:04', NULL),
(51, 4, 100018, 2500, '{\"id\":4,\"name\":\"Iced Coffee\",\"product_code\":\"89837\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":94,\"image\":\"2024-04-25-662a35c344d22.png\",\"order_count\":5,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:51:47.000000Z\",\"updated_at\":\"2024-04-25T14:51:49.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a35c344d22.png\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 21:21:49', '2024-04-25 21:21:49', NULL),
(52, 6, 100018, 3000, '{\"id\":6,\"name\":\"Bubble Tea\",\"product_code\":\"91453\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":90,\"image\":\"2024-04-25-662a37809439d.png\",\"order_count\":7,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:59:12.000000Z\",\"updated_at\":\"2024-04-25T14:51:49.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a37809439d.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:21:49', '2024-04-25 21:21:49', NULL),
(53, 19, 100018, 2500, '{\"id\":19,\"name\":\"Kiwi Soda\",\"product_code\":\"40604\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a5825e60a1.png\",\"order_count\":3,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:18:29.000000Z\",\"updated_at\":\"2024-04-25T14:51:49.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5825e60a1.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:21:49', '2024-04-25 21:21:49', NULL),
(54, 6, 100019, 3000, '{\"id\":6,\"name\":\"Bubble Tea\",\"product_code\":\"91453\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":85,\"image\":\"2024-04-25-662a37809439d.png\",\"order_count\":8,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:59:12.000000Z\",\"updated_at\":\"2024-04-25T14:54:19.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a37809439d.png\"}', 0, 'discount_on_product', 5, 0, '2024-04-25 21:24:19', '2024-04-25 21:24:19', NULL),
(55, 1, 100019, 2500, '{\"id\":1,\"name\":\"Iced Americano\",\"product_code\":\"94486\",\"unit_type\":3,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":95,\"image\":\"2024-04-25-662a2a0fc5033.png\",\"order_count\":4,\"supplier_id\":1,\"created_at\":\"2024-04-25T09:51:45.000000Z\",\"updated_at\":\"2024-04-25T14:54:19.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a2a0fc5033.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:24:19', '2024-04-25 21:24:19', NULL),
(56, 19, 100019, 2500, '{\"id\":19,\"name\":\"Kiwi Soda\",\"product_code\":\"40604\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":96,\"image\":\"2024-04-25-662a5825e60a1.png\",\"order_count\":4,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:18:29.000000Z\",\"updated_at\":\"2024-04-25T14:54:19.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5825e60a1.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:24:19', '2024-04-25 21:24:19', NULL),
(57, 20, 100019, 2500, '{\"id\":20,\"name\":\"Raspberry Soda\",\"product_code\":\"69600\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":96,\"image\":\"2024-04-25-662a58dc36deb.png\",\"order_count\":4,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:21:32.000000Z\",\"updated_at\":\"2024-04-25T14:54:19.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a58dc36deb.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:24:19', '2024-04-25 21:24:19', NULL),
(58, 2, 100019, 2000, '{\"id\":2,\"name\":\"Tio Signature Coffee\",\"product_code\":\"91314\",\"unit_type\":4,\"unit_value\":2000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":95,\"image\":\"2024-04-25-662a32e7de934.png\",\"order_count\":5,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:39:35.000000Z\",\"updated_at\":\"2024-04-25T14:54:19.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a32e7de934.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:24:19', '2024-04-25 21:24:19', NULL),
(59, 7, 100019, 3500, '{\"id\":7,\"name\":\"Thai Tea\",\"product_code\":\"53803\",\"unit_type\":4,\"unit_value\":3500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a383e95809.png\",\"order_count\":3,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:02:22.000000Z\",\"updated_at\":\"2024-04-25T14:54:19.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a383e95809.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:24:19', '2024-04-25 21:24:19', NULL),
(60, 23, 100019, 2000, '{\"id\":23,\"name\":\"Peach Juice\",\"product_code\":\"13095\",\"unit_type\":4,\"unit_value\":2000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"8\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":99,\"image\":\"2024-04-25-662a5a81245f8.png\",\"order_count\":1,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:28:33.000000Z\",\"updated_at\":\"2024-04-25T14:54:19.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5a81245f8.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:24:19', '2024-04-25 21:24:19', NULL),
(61, 9, 100019, 3000, '{\"id\":9,\"name\":\"Passion Green Tea\",\"product_code\":\"59616\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":94,\"image\":\"2024-04-25-662a3936df305.png\",\"order_count\":3,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:06:30.000000Z\",\"updated_at\":\"2024-04-25T14:54:19.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3936df305.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:24:19', '2024-04-25 21:24:19', NULL),
(62, 14, 100020, 2500, '{\"id\":14,\"name\":\"Peach Milkshake\",\"product_code\":\"61871\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a3cc9a69cf.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:21:45.000000Z\",\"updated_at\":\"2024-04-25T14:56:45.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3cc9a69cf.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:26:45', '2024-04-25 21:26:45', NULL),
(63, 9, 100020, 3000, '{\"id\":9,\"name\":\"Passion Green Tea\",\"product_code\":\"59616\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":89,\"image\":\"2024-04-25-662a3936df305.png\",\"order_count\":4,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:06:30.000000Z\",\"updated_at\":\"2024-04-25T14:56:45.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3936df305.png\"}', 0, 'discount_on_product', 5, 0, '2024-04-25 21:26:45', '2024-04-25 21:26:45', NULL),
(64, 23, 100020, 2000, '{\"id\":23,\"name\":\"Peach Juice\",\"product_code\":\"13095\",\"unit_type\":4,\"unit_value\":2000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"8\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a5a81245f8.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:28:33.000000Z\",\"updated_at\":\"2024-04-25T14:56:45.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5a81245f8.png\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 21:26:45', '2024-04-25 21:26:45', NULL);
INSERT INTO `order_details` (`id`, `product_id`, `order_id`, `price`, `product_details`, `discount_on_product`, `discount_type`, `quantity`, `tax_amount`, `created_at`, `updated_at`, `company_id`) VALUES
(65, 19, 100020, 2500, '{\"id\":19,\"name\":\"Kiwi Soda\",\"product_code\":\"40604\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":94,\"image\":\"2024-04-25-662a5825e60a1.png\",\"order_count\":5,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:18:29.000000Z\",\"updated_at\":\"2024-04-25T14:56:45.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5825e60a1.png\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 21:26:45', '2024-04-25 21:26:45', NULL),
(66, 20, 100020, 2500, '{\"id\":20,\"name\":\"Raspberry Soda\",\"product_code\":\"69600\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":94,\"image\":\"2024-04-25-662a58dc36deb.png\",\"order_count\":5,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:21:32.000000Z\",\"updated_at\":\"2024-04-25T14:56:45.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a58dc36deb.png\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 21:26:45', '2024-04-25 21:26:45', NULL),
(67, 18, 100020, 2500, '{\"id\":18,\"name\":\"Peach Soda\",\"product_code\":\"20128\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":92,\"image\":\"2024-04-25-662a5769c8c57.png\",\"order_count\":4,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:15:21.000000Z\",\"updated_at\":\"2024-04-25T14:56:45.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5769c8c57.png\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 21:26:45', '2024-04-25 21:26:45', NULL),
(68, 2, 100020, 2000, '{\"id\":2,\"name\":\"Tio Signature Coffee\",\"product_code\":\"91314\",\"unit_type\":4,\"unit_value\":2000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":93,\"image\":\"2024-04-25-662a32e7de934.png\",\"order_count\":6,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:39:35.000000Z\",\"updated_at\":\"2024-04-25T14:56:45.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a32e7de934.png\"}', 0, 'discount_on_product', 2, 0, '2024-04-25 21:26:45', '2024-04-25 21:26:45', NULL),
(69, 13, 100021, 2500, '{\"id\":13,\"name\":\"Kiwi Milkshake\",\"product_code\":\"36621\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":95,\"image\":\"2024-04-25-662a3c3147f0b.png\",\"order_count\":5,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:19:13.000000Z\",\"updated_at\":\"2024-04-25T14:58:47.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3c3147f0b.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:28:47', '2024-04-25 21:28:47', NULL),
(70, 14, 100021, 2500, '{\"id\":14,\"name\":\"Peach Milkshake\",\"product_code\":\"61871\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a3cc9a69cf.png\",\"order_count\":3,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:21:45.000000Z\",\"updated_at\":\"2024-04-25T14:58:47.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3cc9a69cf.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:28:47', '2024-04-25 21:28:47', NULL),
(71, 2, 100021, 2000, '{\"id\":2,\"name\":\"Tio Signature Coffee\",\"product_code\":\"91314\",\"unit_type\":4,\"unit_value\":2000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":92,\"image\":\"2024-04-25-662a32e7de934.png\",\"order_count\":7,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:39:35.000000Z\",\"updated_at\":\"2024-04-25T14:58:47.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a32e7de934.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:28:47', '2024-04-25 21:28:47', NULL),
(72, 10, 100021, 3000, '{\"id\":10,\"name\":\"Peach Green Tea\",\"product_code\":\"14407\",\"unit_type\":4,\"unit_value\":3000,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"5\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":3000,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":97,\"image\":\"2024-04-25-662a39ae71c6e.png\",\"order_count\":3,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:08:30.000000Z\",\"updated_at\":\"2024-04-25T14:58:47.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a39ae71c6e.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:28:47', '2024-04-25 21:28:47', NULL),
(73, 12, 100021, 2500, '{\"id\":12,\"name\":\"Passion Milkshake\",\"product_code\":\"20328\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"6\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":98,\"image\":\"2024-04-25-662a3b5d1fd3f.png\",\"order_count\":2,\"supplier_id\":null,\"created_at\":\"2024-04-25T11:15:41.000000Z\",\"updated_at\":\"2024-04-25T14:58:47.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a3b5d1fd3f.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:28:47', '2024-04-25 21:28:47', NULL),
(74, 4, 100022, 2500, '{\"id\":4,\"name\":\"Iced Coffee\",\"product_code\":\"89837\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"4\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":93,\"image\":\"2024-04-25-662a35c344d22.png\",\"order_count\":6,\"supplier_id\":null,\"created_at\":\"2024-04-25T10:51:47.000000Z\",\"updated_at\":\"2024-04-25T15:00:15.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a35c344d22.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:30:15', '2024-04-25 21:30:15', NULL),
(75, 18, 100022, 2500, '{\"id\":18,\"name\":\"Peach Soda\",\"product_code\":\"20128\",\"unit_type\":4,\"unit_value\":2500,\"brand\":\"6\",\"category_ids\":\"[{\\\"id\\\":\\\"3\\\",\\\"position\\\":1},{\\\"id\\\":\\\"7\\\",\\\"position\\\":2}]\",\"purchase_price\":0,\"selling_price\":2500,\"discount_type\":\"percent\",\"discount\":0,\"tax\":0,\"quantity\":91,\"image\":\"2024-04-25-662a5769c8c57.png\",\"order_count\":5,\"supplier_id\":null,\"created_at\":\"2024-04-25T13:15:21.000000Z\",\"updated_at\":\"2024-04-25T15:00:15.000000Z\",\"company_id\":null,\"image_fullpath\":\"https:\\/\\/chelpanyoung123.click\\/storage\\/app\\/public\\/product\\/2024-04-25-662a5769c8c57.png\"}', 0, 'discount_on_product', 1, 0, '2024-04-25 21:30:15', '2024-04-25 21:30:15', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `unit_type` int(10) UNSIGNED DEFAULT NULL,
  `unit_value` double(8,2) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `category_ids` varchar(255) DEFAULT NULL,
  `purchase_price` double DEFAULT NULL,
  `selling_price` double DEFAULT NULL,
  `discount_type` varchar(255) DEFAULT NULL,
  `discount` double(8,2) DEFAULT NULL,
  `tax` double(8,2) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `order_count` int(10) UNSIGNED DEFAULT NULL,
  `supplier_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `absolute` int(11) NOT NULL,
  `lost` int(11) NOT NULL,
  `gain` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `product_code`, `unit_type`, `unit_value`, `brand`, `category_ids`, `purchase_price`, `selling_price`, `discount_type`, `discount`, `tax`, `quantity`, `image`, `order_count`, `supplier_id`, `created_at`, `updated_at`, `company_id`, `absolute`, `lost`, `gain`) VALUES
(1, 'Iced Americano', '94486', 3, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"4\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 95, '2024-04-25-662a2a0fc5033.png', 4, 1, '2024-04-25 16:21:45', '2024-04-25 21:24:19', NULL, 0, 0, 0),
(2, 'Tio Signature Coffee', '91314', 4, 2000.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"4\",\"position\":2}]', 0, 2000, 'percent', 0.00, 0.00, 92, '2024-04-25-662a32e7de934.png', 7, NULL, '2024-04-25 17:09:35', '2024-04-25 21:28:47', NULL, 0, 0, 0),
(3, 'Iced Latte', '78989', 4, 3500.00, '6', '[{\"id\":\"3\",\"position\":1}]', 0, 3500, 'percent', 0.00, 0.00, 100, '2024-04-25-662a34f96d456.png', 0, NULL, '2024-04-25 17:18:25', '2024-04-25 17:18:25', NULL, 0, 0, 0),
(4, 'Iced Coffee', '89837', 4, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"4\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 93, '2024-04-25-662a35c344d22.png', 6, NULL, '2024-04-25 17:21:47', '2024-04-25 21:30:15', NULL, 0, 0, 0),
(5, 'Iced Black Coffee', '31800', 4, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"4\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 100, '2024-04-25-662a36eeacdad.png', 0, NULL, '2024-04-25 17:26:46', '2024-04-25 17:26:46', NULL, 0, 0, 0),
(6, 'Bubble Tea', '91453', 4, 3000.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"5\",\"position\":2}]', 0, 3000, 'percent', 0.00, 0.00, 85, '2024-04-25-662a37809439d.png', 8, NULL, '2024-04-25 17:29:12', '2024-04-25 21:24:19', NULL, 0, 0, 0),
(7, 'Thai Tea', '53803', 4, 3500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"5\",\"position\":2}]', 0, 3500, 'percent', 0.00, 0.00, 97, '2024-04-25-662a383e95809.png', 3, NULL, '2024-04-25 17:32:22', '2024-04-25 21:24:19', NULL, 0, 0, 0),
(8, 'Bubble Green Tea', '70138', 4, 3500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"5\",\"position\":2}]', 0, 3500, 'percent', 0.00, 0.00, 100, '2024-04-25-662a38b455ff7.png', 0, NULL, '2024-04-25 17:34:20', '2024-04-25 17:34:20', NULL, 0, 0, 0),
(9, 'Passion Green Tea', '59616', 4, 3000.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"5\",\"position\":2}]', 0, 3000, 'percent', 0.00, 0.00, 89, '2024-04-25-662a3936df305.png', 4, NULL, '2024-04-25 17:36:30', '2024-04-25 21:26:45', NULL, 0, 0, 0),
(10, 'Peach Green Tea', '14407', 4, 3000.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"5\",\"position\":2}]', 0, 3000, 'percent', 0.00, 0.00, 97, '2024-04-25-662a39ae71c6e.png', 3, NULL, '2024-04-25 17:38:30', '2024-04-25 21:28:47', NULL, 0, 0, 0),
(11, 'Raspberry Milkshake', '58239', 4, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"6\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 98, '2024-04-25-662a3a9cceffa.png', 2, NULL, '2024-04-25 17:42:28', '2024-04-25 21:15:42', NULL, 0, 0, 0),
(12, 'Passion Milkshake', '20328', 4, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"6\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 98, '2024-04-25-662a3b5d1fd3f.png', 2, NULL, '2024-04-25 17:45:41', '2024-04-25 21:28:47', NULL, 0, 0, 0),
(13, 'Kiwi Milkshake', '36621', 4, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"6\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 95, '2024-04-25-662a3c3147f0b.png', 5, NULL, '2024-04-25 17:49:13', '2024-04-25 21:28:47', NULL, 0, 0, 0),
(14, 'Peach Milkshake', '61871', 4, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"6\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 97, '2024-04-25-662a3cc9a69cf.png', 3, NULL, '2024-04-25 17:51:45', '2024-04-25 21:28:47', NULL, 0, 0, 0),
(15, 'Blueberry Milkshake', '14794', 4, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"6\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 97, '2024-04-25-662a3d799d798.png', 3, NULL, '2024-04-25 17:54:41', '2024-04-25 21:02:06', NULL, 0, 0, 0),
(16, 'Taro Milkshae', '85796', 4, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"6\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 100, '2024-04-25-662a3e0a8d2e1.png', 0, NULL, '2024-04-25 17:57:06', '2024-04-25 17:57:06', NULL, 0, 0, 0),
(17, 'Passion Soda', '30282', 4, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"7\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 98, '2024-04-25-662a56a4c4a25.png', 2, NULL, '2024-04-25 19:42:04', '2024-04-25 20:55:56', NULL, 0, 0, 0),
(18, 'Peach Soda', '20128', 4, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"7\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 91, '2024-04-25-662a5769c8c57.png', 5, NULL, '2024-04-25 19:45:21', '2024-04-25 21:30:15', NULL, 0, 0, 0),
(19, 'Kiwi Soda', '40604', 4, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"7\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 94, '2024-04-25-662a5825e60a1.png', 5, NULL, '2024-04-25 19:48:29', '2024-04-25 21:26:45', NULL, 0, 0, 0),
(20, 'Raspberry Soda', '69600', 4, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"7\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 94, '2024-04-25-662a58dc36deb.png', 5, NULL, '2024-04-25 19:51:32', '2024-04-25 21:26:45', NULL, 0, 0, 0),
(21, 'Blueberry Soda', '95070', 4, 2500.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"7\",\"position\":2}]', 0, 2500, 'percent', 0.00, 0.00, 98, '2024-04-25-662a594482fc3.png', 2, NULL, '2024-04-25 19:53:16', '2024-04-25 21:18:13', NULL, 0, 0, 0),
(22, 'Passion Juice', '37003', 4, 2000.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"8\",\"position\":2}]', 0, 2000, 'percent', 0.00, 0.00, 99, '2024-04-25-662a59cf99ef4.png', 1, NULL, '2024-04-25 19:55:35', '2024-04-25 20:33:04', NULL, 0, 0, 0),
(23, 'Peach Juice', '13095', 4, 2000.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"8\",\"position\":2}]', 0, 2000, 'percent', 0.00, 0.00, 97, '2024-04-25-662a5a81245f8.png', 2, NULL, '2024-04-25 19:58:33', '2024-04-25 21:26:45', NULL, 0, 0, 0),
(24, 'Kiwi Juice', '59138', 4, 2000.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"8\",\"position\":2}]', 0, 2000, 'percent', 0.00, 0.00, 95, '2024-04-25-662a5b6fcc614.png', 3, NULL, '2024-04-25 20:02:31', '2024-04-25 21:12:23', NULL, 0, 0, 0),
(25, 'Raspberry Juice', '26882', 4, 2000.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"8\",\"position\":2}]', 0, 2000, 'percent', 0.00, 0.00, 100, '2024-04-25-662a5bd914c2a.png', 0, NULL, '2024-04-25 20:04:17', '2024-04-25 20:04:17', NULL, 0, 0, 0),
(26, 'Blueberry Juice', '92405', 4, 2000.00, '6', '[{\"id\":\"3\",\"position\":1},{\"id\":\"8\",\"position\":2}]', 0, 2000, 'percent', 0.00, 0.00, 100, '2024-04-25-662a5cbac2d14.png', 0, NULL, '2024-04-25 20:08:02', '2024-04-25 20:08:02', NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `product_news`
--

CREATE TABLE `product_news` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_news`
--

INSERT INTO `product_news` (`id`, `name`, `quantity`, `image`, `created_at`, `updated_at`) VALUES
(4, '92 အောက်တိန်း', 0, '2024-08-26-66cc8a6cc68fc.png', '2024-08-26 20:30:12', '2024-08-26 20:30:12'),
(5, '95 အောက်တိန်း', 0, '2024-08-26-66cc8a838b667.png', '2024-08-26 20:30:35', '2024-08-26 20:30:35'),
(6, 'ဒီဇယ်', 0, '2024-08-26-66cc8a90a5d64.png', '2024-08-26 20:30:48', '2024-08-26 20:30:48'),
(7, 'ပရီမီယံဒီဇယ်', 0, '2024-08-26-66cc8a9fbd299.png', '2024-08-26 20:31:03', '2024-08-26 20:31:03');

-- --------------------------------------------------------

--
-- Table structure for table `product_new_shop`
--

CREATE TABLE `product_new_shop` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_new_id` bigint(20) UNSIGNED NOT NULL,
  `shop_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `transaction_id` bigint(20) UNSIGNED DEFAULT NULL,
  `transaction_new_id` bigint(20) UNSIGNED DEFAULT NULL,
  `absolute` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_new_tank`
--

CREATE TABLE `product_new_tank` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_new_id` bigint(20) UNSIGNED NOT NULL,
  `tank_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `transaction_id` bigint(20) UNSIGNED DEFAULT NULL,
  `transaction_new_id` bigint(20) UNSIGNED DEFAULT NULL,
  `absolute` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE `shops` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`id`, `name`, `phonenumber`, `image`, `description`, `created_at`, `updated_at`) VALUES
(1, 'ရွှေလမင်း', '09254463588', '2024-08-26-66cc84dc42ce9.png', '', '2024-08-26 20:06:28', '2024-08-26 20:06:28'),
(2, 'ဝါဝါဝင်း', '09-552256233', NULL, '', '2024-08-28 11:33:56', '2024-08-28 11:33:56'),
(3, 'ပန်းသီး', '', NULL, '', '2024-08-28 11:34:15', '2024-08-28 11:34:15'),
(4, 'အောင်အော', '09-665523565', NULL, '', '2024-08-28 11:34:36', '2024-08-28 11:35:12'),
(5, 'နိုင်ဟိန်းထက်', '09452865322', NULL, '', '2024-08-28 11:35:38', '2024-08-28 11:35:38'),
(6, 'စန္ဒာထွန်း', '09-445526322', NULL, '', '2024-08-28 11:36:45', '2024-08-28 11:36:45');

-- --------------------------------------------------------

--
-- Table structure for table `soft_credentials`
--

CREATE TABLE `soft_credentials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) DEFAULT NULL,
  `value` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `mobile` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `due_amount` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `mobile`, `email`, `image`, `state`, `city`, `zip_code`, `address`, `due_amount`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'Genius Coffee', '+959970200702', 'genius@gmail.com', '2024-04-25-662a05eb4501a.png', 'Mandalay', 'Mandalay', '05011', '110*109 , 78 street', NULL, '2024-04-25 13:57:39', '2024-04-25 13:57:39', NULL),
(2, 'AEON', '09442274599', 'aeon2@gmail.com', 'def.png', 'MDY', 'Mandalay', '05011', '42 street , between 60 * 61', NULL, '2024-04-25 18:34:24', '2024-04-25 18:34:24', NULL),
(3, 'Thit Sat Wood', '09442223233', 'thitsat2@gmail.com', 'def.png', 'mdy', 'Mandalay', '05011', '42 street , between 60 * 61', NULL, '2024-04-25 18:36:14', '2024-04-25 18:36:14', NULL),
(4, 'Kyine Tone', '+959223456743', 'kyinetone@gmail.om', 'def.png', 'mdy', 'Mandalay', '05011', '42 street , between 60 * 61', NULL, '2024-04-25 18:37:07', '2024-04-25 18:37:07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tanks`
--

CREATE TABLE `tanks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_quantity` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_car` tinyint(1) NOT NULL,
  `car_series` varchar(255) DEFAULT NULL,
  `car_type` varchar(255) DEFAULT NULL,
  `driver_name` varchar(255) DEFAULT NULL,
  `driver_phone_number` varchar(255) DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tanks`
--

INSERT INTO `tanks` (`id`, `name`, `total_quantity`, `image`, `description`, `is_car`, `car_series`, `car_type`, `driver_name`, `driver_phone_number`, `is_paid`, `created_at`, `updated_at`) VALUES
(20, 'ကလေးတင်', 0, 'def.png', '', 0, NULL, NULL, NULL, NULL, NULL, '2024-08-25 22:37:43', '2024-08-25 22:37:43'),
(21, 'စစ်ကိုင်းအရောင်း', 0, 'def.png', '', 0, NULL, NULL, NULL, NULL, NULL, '2024-08-25 22:37:58', '2024-08-25 22:37:58'),
(24, 'Nissan Diesel 2', 0, '2024-08-26-66cc85af521a7.png', '', 1, '2TLR-7427', '4K-7965', 'ကိုမျိုး', '09402585322', NULL, '2024-08-26 20:09:59', '2024-08-28 10:06:41'),
(25, 'Nissan Diesel 1', 0, '2024-08-26-66cc865a056ca.png', '', 1, '2TLR-1301', '1L-4566', 'ပြည့်ဖြိုးအောင်', '09950847247', NULL, '2024-08-26 20:12:50', '2024-08-28 10:06:31'),
(30, 'ကန် ၁', 0, 'def.png', '', 0, NULL, NULL, NULL, NULL, NULL, '2024-08-26 20:19:35', '2024-08-28 12:01:19'),
(33, 'Nissan Diesel 3', 0, '2024-08-28-66ce9ed4afe67.png', '', 1, '2TLR-9561', '3l-1947', 'ဇော်မင်းအောင်', '09402656365', NULL, '2024-08-28 10:21:48', '2024-08-28 10:21:48'),
(35, 'Nissan Diesel 4', 0, '2024-08-28-66ceb2a96f478.png', '', 1, '2TLR-6857', '3L-1947', 'ကျော်ဆန်း', '09402622100', NULL, '2024-08-28 11:45:47', '2024-08-28 11:46:25'),
(43, 'အခြားကား IsuZu Diesel', 0, '2024-11-29-674976021a2f9.png', '', 1, '2TLR-4210', '6N-9346', 'ဇော်ဇော်ထွန်း', '09441554191', NULL, '2024-08-28 12:18:51', '2024-11-29 14:36:26');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_news`
--

CREATE TABLE `transaction_news` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT 'PO',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `isPo` varchar(255) NOT NULL DEFAULT '',
  `start_date` varchar(255) DEFAULT NULL,
  `end_date` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transections`
--

CREATE TABLE `transections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tran_type` varchar(255) DEFAULT NULL,
  `account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `debit` tinyint(1) DEFAULT NULL,
  `credit` tinyint(1) DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `customer_id` int(10) UNSIGNED DEFAULT NULL,
  `supplier_id` int(10) UNSIGNED DEFAULT NULL,
  `order_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transections`
--

INSERT INTO `transections` (`id`, `tran_type`, `account_id`, `amount`, `description`, `debit`, `credit`, `balance`, `date`, `customer_id`, `supplier_id`, `order_id`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'Income', 1, 5000, 'POS order', 0, 1, 5000, '2024-04-25', 0, NULL, 100001, '2024-04-25 16:22:46', '2024-04-25 16:22:46', NULL),
(2, 'Income', 1, 6000, 'POS order', 0, 1, 11000, '2024-04-25', 0, NULL, 100002, '2024-04-25 18:48:12', '2024-04-25 18:48:12', NULL),
(3, 'Income', 1, 3852000, 'WPT Investment', 0, 1, 1511000, '2024-04-01', NULL, NULL, NULL, '2024-04-25 18:58:18', '2024-04-25 18:58:18', NULL),
(4, 'Income', 1, 1000000, 'KhunMinSetWai Investment', 0, 1, 2511000, '2024-03-15', NULL, NULL, NULL, '2024-04-25 18:59:45', '2024-04-25 18:59:45', NULL),
(5, 'Expense', 1, 2040000, 'Rental Apartment', 1, 0, 471000, '2024-03-05', NULL, NULL, NULL, '2024-04-25 19:00:10', '2024-04-25 19:00:10', NULL),
(6, 'Income', 1, 2000, 'POS order', 0, 1, 473000, '2024-04-25', 2, NULL, 100003, '2024-04-25 19:27:54', '2024-04-25 19:27:54', NULL),
(7, 'Income', 1, 5000, 'POS order', 0, 1, 478000, '2024-04-25', 2, NULL, 100004, '2024-04-25 20:32:31', '2024-04-25 20:32:31', NULL),
(8, 'Income', 1, 4000, 'POS order', 0, 1, 482000, '2024-04-25', 2, NULL, 100005, '2024-04-25 20:33:04', '2024-04-25 20:33:04', NULL),
(9, 'Expense', 1, 1000, 'Ice', 1, 0, 481000, '2024-04-25', NULL, NULL, NULL, '2024-04-25 20:34:47', '2024-04-25 20:34:47', NULL),
(10, 'Expense', 1, 3000, 'Gas', 1, 0, 478000, '2024-04-25', NULL, NULL, NULL, '2024-04-25 20:35:22', '2024-04-25 20:35:22', NULL),
(11, 'Income', 1, 3500, 'POS order', 0, 1, 481500, '2024-04-25', 3, NULL, 100006, '2024-04-25 20:40:58', '2024-04-25 20:40:58', NULL),
(12, 'Expense', 1, 1000, 'Water', 1, 0, 480500, '2024-04-25', NULL, NULL, NULL, '2024-04-25 20:43:38', '2024-04-25 20:43:38', NULL),
(13, 'Income', 1, 17500, 'POS order', 0, 1, 498000, '2024-04-25', 3, NULL, 100007, '2024-04-25 20:55:56', '2024-04-25 20:55:56', NULL),
(14, 'Expense', 1, 7700, 'Ice,Water , book', 1, 0, 490300, '2024-03-06', NULL, NULL, NULL, '2024-04-25 20:57:21', '2024-04-25 20:57:21', NULL),
(15, 'Income', 11, 2500, 'POS order', 0, 1, 2500, '2024-04-25', 3, NULL, 100008, '2024-04-25 20:58:26', '2024-04-25 20:58:26', NULL),
(16, 'Expense', 1, 17000, 'Plastic Water Tank', 1, 0, 473300, '2024-03-07', NULL, NULL, NULL, '2024-04-25 21:00:32', '2024-04-25 21:00:32', NULL),
(17, 'Income', 11, 9500, 'POS order', 0, 1, 12000, '2024-04-25', 3, NULL, 100009, '2024-04-25 21:02:06', '2024-04-25 21:02:06', NULL),
(18, 'Expense', 1, 12000, 'Bottle Cleaner Brush , Tower , Water , Ice.', 1, 0, 461300, '2024-03-08', NULL, NULL, NULL, '2024-04-25 21:03:38', '2024-04-25 21:03:38', NULL),
(19, 'Expense', 1, 500, 'ice', 1, 0, 460800, '2024-03-09', NULL, NULL, NULL, '2024-04-25 21:05:27', '2024-04-25 21:05:27', NULL),
(20, 'Income', 1, 17500, 'POS order', 0, 1, 478300, '2024-04-25', 3, NULL, 100010, '2024-04-25 21:06:40', '2024-04-25 21:06:40', NULL),
(21, 'Expense', 1, 1000, 'Iced', 1, 0, 477300, '2024-04-10', NULL, NULL, NULL, '2024-04-25 21:07:56', '2024-04-25 21:07:56', NULL),
(22, 'Income', 1, 2000, 'POS order', 0, 1, 479300, '2024-04-25', 3, NULL, 100011, '2024-04-25 21:08:28', '2024-04-25 21:08:28', NULL),
(23, 'Expense', 1, 1500, 'ice', 1, 0, 477800, '2024-04-11', NULL, NULL, NULL, '2024-04-25 21:08:52', '2024-04-25 21:08:52', NULL),
(24, 'Expense', 1, 3000, 'ice', 1, 0, 474800, '2024-04-12', NULL, NULL, NULL, '2024-04-25 21:09:49', '2024-04-25 21:09:49', NULL),
(25, 'Income', 1, 23000, 'POS order', 0, 1, 497800, '2024-04-25', 3, NULL, 100012, '2024-04-25 21:12:23', '2024-04-25 21:12:23', NULL),
(26, 'Expense', 1, 2500, 'ice', 1, 0, 495300, '2024-04-13', NULL, NULL, NULL, '2024-04-25 21:12:58', '2024-04-25 21:12:58', NULL),
(27, 'Income', 1, 13500, 'POS order', 0, 1, 508800, '2024-04-25', 3, NULL, 100013, '2024-04-25 21:14:05', '2024-04-25 21:14:05', NULL),
(28, 'Expense', 1, 2500, 'ice,water', 1, 0, 506300, '2024-04-14', NULL, NULL, NULL, '2024-04-25 21:14:49', '2024-04-25 21:14:49', NULL),
(29, 'Income', 1, 13000, 'POS order', 0, 1, 519300, '2024-04-25', 3, NULL, 100014, '2024-04-25 21:15:42', '2024-04-25 21:15:42', NULL),
(30, 'Expense', 1, 3000, 'ice,water', 1, 0, 516300, '2024-04-14', NULL, NULL, NULL, '2024-04-25 21:16:32', '2024-04-25 21:16:32', NULL),
(31, 'Expense', 1, 2500, 'ice', 1, 0, 513800, '2024-04-15', NULL, NULL, NULL, '2024-04-25 21:16:59', '2024-04-25 21:16:59', NULL),
(32, 'Income', 1, 2500, 'POS order', 0, 1, 516300, '2024-04-25', 3, NULL, 100015, '2024-04-25 21:17:21', '2024-04-25 21:17:21', NULL),
(33, 'Income', 1, 15500, 'POS order', 0, 1, 531800, '2024-04-25', 3, NULL, 100016, '2024-04-25 21:18:13', '2024-04-25 21:18:13', NULL),
(34, 'Expense', 1, 1000, 'water', 1, 0, 530800, '2024-04-16', NULL, NULL, NULL, '2024-04-25 21:18:37', '2024-04-25 21:18:37', NULL),
(35, 'Income', 1, 18000, 'POS order', 0, 1, 548800, '2024-04-25', 3, NULL, 100017, '2024-04-25 21:20:04', '2024-04-25 21:20:04', NULL),
(36, 'Income', 1, 10500, 'POS order', 0, 1, 559300, '2024-04-25', 3, NULL, 100018, '2024-04-25 21:21:49', '2024-04-25 21:21:49', NULL),
(37, 'Expense', 1, 8000, 'ice,gas', 1, 0, 551300, '2024-04-20', NULL, NULL, NULL, '2024-04-25 21:22:18', '2024-04-25 21:22:18', NULL),
(38, 'Income', 1, 33000, 'POS order', 0, 1, 584300, '2024-04-25', 3, NULL, 100019, '2024-04-25 21:24:19', '2024-04-25 21:24:19', NULL),
(39, 'Expense', 1, 2500, 'ice', 1, 0, 581800, '2024-04-21', NULL, NULL, NULL, '2024-04-25 21:24:50', '2024-04-25 21:24:50', NULL),
(40, 'Income', 1, 40500, 'POS order', 0, 1, 622300, '2024-04-25', 3, NULL, 100020, '2024-04-25 21:26:45', '2024-04-25 21:26:45', NULL),
(41, 'Expense', 1, 9750, 'ice,market,', 1, 0, 612550, '2024-04-22', NULL, NULL, NULL, '2024-04-25 21:27:19', '2024-04-25 21:27:19', NULL),
(42, 'Expense', 1, 5500, 'ice,water', 1, 0, 607050, '2024-04-23', NULL, NULL, NULL, '2024-04-25 21:28:15', '2024-04-25 21:28:15', NULL),
(43, 'Income', 1, 12500, 'POS order', 0, 1, 619550, '2024-04-25', 3, NULL, 100021, '2024-04-25 21:28:47', '2024-04-25 21:28:47', NULL),
(44, 'Expense', 1, 500, 'ice', 1, 0, 619050, '2024-04-24', NULL, NULL, NULL, '2024-04-25 21:29:50', '2024-04-25 21:29:50', NULL),
(45, 'Income', 1, 5000, 'POS order', 0, 1, 624050, '2024-04-25', 3, NULL, 100022, '2024-04-25 21:30:15', '2024-04-25 21:30:15', NULL),
(46, 'Expense', 1, 5000, 'ice', 1, 0, 619050, '2024-04-24', NULL, NULL, NULL, '2024-04-25 21:30:32', '2024-04-25 21:30:32', NULL),
(47, 'Expense', 1, 5000, 'gas,ice,water', 1, 0, 614050, '2024-04-25', NULL, NULL, NULL, '2024-04-25 21:31:08', '2024-04-25 21:31:08', NULL),
(48, 'Transfer', 11, 100, 'Investment', 1, 0, 11900, '2024-04-26', NULL, NULL, NULL, '2024-04-26 22:49:35', '2024-04-26 22:49:35', NULL),
(49, 'Transfer', 1, 100, 'Investment', 0, 1, 614150, '2024-04-26', NULL, NULL, NULL, '2024-04-26 22:49:35', '2024-04-26 22:49:35', NULL),
(50, 'Transfer', 1, 100, 'Investment', 1, 0, 614050, '2024-04-26', NULL, NULL, NULL, '2024-04-26 22:50:03', '2024-04-26 22:50:03', NULL),
(51, 'Transfer', 11, 100, 'Investment', 0, 1, 12000, '2024-04-26', NULL, NULL, NULL, '2024-04-26 22:50:03', '2024-04-26 22:50:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transfer_records`
--

CREATE TABLE `transfer_records` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `from_type` int(11) NOT NULL,
  `to_type` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `isFinal` int(11) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `extra_description` varchar(255) NOT NULL DEFAULT 'aa',
  `created_by` int(11) NOT NULL,
  `confirmed_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transfer_record_product_new`
--

CREATE TABLE `transfer_record_product_new` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_new_id` bigint(20) UNSIGNED NOT NULL,
  `transfer_record_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `isExtra` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unit_type` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_type`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'kg', '2021-11-28 05:34:53', '2021-11-28 05:34:53', NULL),
(2, 'Ltr', '2021-11-28 05:35:05', '2021-11-28 05:35:05', NULL),
(3, 'Pc', '2021-11-28 05:35:14', '2021-11-28 05:35:14', NULL),
(4, 'Cup', '2024-04-25 17:00:32', '2024-04-25 17:00:32', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_roles`
--
ALTER TABLE `admin_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `business_settings`
--
ALTER TABLE `business_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `edit_transaction_news`
--
ALTER TABLE `edit_transaction_news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `edit_transaction_news_transaction_new_id_foreign` (`transaction_new_id`);

--
-- Indexes for table `edit_transaction_new_details`
--
ALTER TABLE `edit_transaction_new_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `edit_transfer_records`
--
ALTER TABLE `edit_transfer_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `edit_transfer_records_transfer_record_id_foreign` (`transfer_record_id`);

--
-- Indexes for table `edit_transfer_record_details`
--
ALTER TABLE `edit_transfer_record_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_news`
--
ALTER TABLE `product_news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_new_shop`
--
ALTER TABLE `product_new_shop`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_new_shop_product_new_id_foreign` (`product_new_id`),
  ADD KEY `product_new_shop_shop_id_foreign` (`shop_id`),
  ADD KEY `product_new_shop_transaction_new_id_foreign` (`transaction_new_id`);

--
-- Indexes for table `product_new_tank`
--
ALTER TABLE `product_new_tank`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_new_tank_product_new_id_foreign` (`product_new_id`),
  ADD KEY `product_new_tank_tank_id_foreign` (`tank_id`),
  ADD KEY `product_new_tank_transaction_new_id_foreign` (`transaction_new_id`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `soft_credentials`
--
ALTER TABLE `soft_credentials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tanks`
--
ALTER TABLE `tanks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_news`
--
ALTER TABLE `transaction_news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transections`
--
ALTER TABLE `transections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfer_records`
--
ALTER TABLE `transfer_records`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfer_record_product_new`
--
ALTER TABLE `transfer_record_product_new`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transfer_record_product_new_product_new_id_foreign` (`product_new_id`),
  ADD KEY `transfer_record_product_new_transfer_record_id_foreign` (`transfer_record_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `admin_roles`
--
ALTER TABLE `admin_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `business_settings`
--
ALTER TABLE `business_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `edit_transaction_news`
--
ALTER TABLE `edit_transaction_news`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `edit_transaction_new_details`
--
ALTER TABLE `edit_transaction_new_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `edit_transfer_records`
--
ALTER TABLE `edit_transfer_records`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `edit_transfer_record_details`
--
ALTER TABLE `edit_transfer_record_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100023;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `product_news`
--
ALTER TABLE `product_news`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `product_new_shop`
--
ALTER TABLE `product_new_shop`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `product_new_tank`
--
ALTER TABLE `product_new_tank`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `soft_credentials`
--
ALTER TABLE `soft_credentials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tanks`
--
ALTER TABLE `tanks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `transaction_news`
--
ALTER TABLE `transaction_news`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `transections`
--
ALTER TABLE `transections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `transfer_records`
--
ALTER TABLE `transfer_records`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `transfer_record_product_new`
--
ALTER TABLE `transfer_record_product_new`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `edit_transaction_news`
--
ALTER TABLE `edit_transaction_news`
  ADD CONSTRAINT `edit_transaction_news_transaction_new_id_foreign` FOREIGN KEY (`transaction_new_id`) REFERENCES `transaction_news` (`id`);

--
-- Constraints for table `edit_transfer_records`
--
ALTER TABLE `edit_transfer_records`
  ADD CONSTRAINT `edit_transfer_records_transfer_record_id_foreign` FOREIGN KEY (`transfer_record_id`) REFERENCES `transfer_records` (`id`);

--
-- Constraints for table `product_new_shop`
--
ALTER TABLE `product_new_shop`
  ADD CONSTRAINT `product_new_shop_product_new_id_foreign` FOREIGN KEY (`product_new_id`) REFERENCES `product_news` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_new_shop_shop_id_foreign` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_new_shop_transaction_new_id_foreign` FOREIGN KEY (`transaction_new_id`) REFERENCES `transaction_news` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_new_tank`
--
ALTER TABLE `product_new_tank`
  ADD CONSTRAINT `product_new_tank_product_new_id_foreign` FOREIGN KEY (`product_new_id`) REFERENCES `product_news` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_new_tank_tank_id_foreign` FOREIGN KEY (`tank_id`) REFERENCES `tanks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_new_tank_transaction_new_id_foreign` FOREIGN KEY (`transaction_new_id`) REFERENCES `transaction_news` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transfer_record_product_new`
--
ALTER TABLE `transfer_record_product_new`
  ADD CONSTRAINT `transfer_record_product_new_product_new_id_foreign` FOREIGN KEY (`product_new_id`) REFERENCES `product_news` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transfer_record_product_new_transfer_record_id_foreign` FOREIGN KEY (`transfer_record_id`) REFERENCES `transfer_records` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
