create database Event_systems;
use Event_systems; 
CREATE TABLE Events (
    event_id  INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    event_date DATE NOT NULL,
    location VARCHAR(255) NOT NULL,
    total_tickets INT NOT NULL,
    available_tickets INT NOT NULL
);
Insert Into Events(event_name,event_date,location,total_tickets,available_tickets)values
("Music Concert","2024-12-25","convention centre",500,500),
("Art Exhibition","2024-12-30","Gallery Hall",200,200),
("Conference","2025-01-02","Palette Conference Space",300,300);

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(15)
);
Insert Into Customers(name,email,phone)values
("sam","sam123@gmail.com","9875634210"),
("sujan","sujan345@gmail.com","9768154365"),
("Rajesh","rajesh2007@gmail.com","8765432190");

CREATE TABLE Tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    price INT NOT NULL,
    status ENUM('available', 'reserved', 'sold') DEFAULT 'available',
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);
Insert Into Tickets(event_id,price,status)values
(1,50,"Available"),
(1,50,"Available"),
(2,100,"Available"),
(2,100,"Available"),
(3,500,"Available");

CREATE TABLE Reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT,
    customer_id INT,
    reservation_date DATE NOT NULL,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
Insert Into Reservations(ticket_id,customer_id,reservation_date)Values
(1,1,"2024-12-25"),
(3,2,"2025-01-02");

CREATE TABLE Sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT,
    customer_id INT,
    sale_date DATE NOT NULL,
    sale_amount INT NOT NULL,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
Insert into Sales(ticket_id,customer_id,sale_date,sale_amount)Values
(2,1,"2024-12-30",50),
(4,2,"2025-01-05",100);

Select*from events;
Select*from customers;
Select*from tickects;
Select*from reservations;
Select*from sales;

Select event_name,available_tickets
from events
where event_id= 1;

SELECT e.event_name,s.sale_amount AS total_sales
FROM sales s
JOIN tickets t on s.ticket_id= t.ticket_id
JOIN events e on t.event_id= e.event_id
GROUP BY  e.event_id;

SELECT e.event_name, e.event_date
FROM Events e
WHERE e.total_tickets = e.available_tickets;

CREATE PROCEDURE GetCustomerTicketHistory(IN customer_id INT)
DELIMITER &&
BEGIN
    SELECT e.event_name, t.price, s.sale_date
    FROM Sales s
    JOIN Tickets t ON s.ticket_id = t.ticket_id
    JOIN Events e ON t.event_id = e.event_id
    WHERE s.customer_id = customer_id
    ORDER BY s.sale_date DESC;
    DELIMITER ;
END &&
 DELIMITER ;

SELECT c.name, s.sale_amount AS total_spent
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;

SELECT ucase(name) FROM customers;
SELECT lcase(name) FROM customers;
