create database Events_system;
use Events_system; 
CREATE TABLE `Events` (
    `event_id` INT AUTO_INCREMENT PRIMARY KEY,
    `event_name` VARCHAR(255) NOT NULL,
    `event_date` DATE NOT NULL,
    `location` VARCHAR(255) NOT NULL,
    `total_tickets` INT NOT NULL,
    `available_tickets` INT NOT NULL
);


CREATE TABLE `Customers` (
    `customer_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) UNIQUE NOT NULL,
    `phone` VARCHAR(15)
);


CREATE TABLE `Tickets` (
    `ticket_id` INT AUTO_INCREMENT PRIMARY KEY,
    `event_id` INT,
    `price` DECIMAL(10, 2) NOT NULL,
    `status` ENUM('available', 'reserved', 'sold') DEFAULT 'available',
    FOREIGN KEY (`event_id`) REFERENCES `Events`(`event_id`)
);

CREATE TABLE `Reservations` (
    `reservation_id` INT AUTO_INCREMENT PRIMARY KEY,
    `ticket_id` INT,
    `customer_id` INT,
    `reservation_date` DATE NOT NULL,
    FOREIGN KEY (`ticket_id`) REFERENCES `Tickets`(`ticket_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `Customers`(`customer_id`)
);


CREATE TABLE `Sales` (
    `sale_id` INT AUTO_INCREMENT PRIMARY KEY,
    `ticket_id` INT,
    `customer_id` INT,
    `sale_date` DATE NOT NULL,
    `sale_amount` DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (`ticket_id`) REFERENCES `Tickets`(`ticket_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `Customers`(`customer_id`)
);
