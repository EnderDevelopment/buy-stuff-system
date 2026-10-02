CREATE TABLE IF NOT EXISTS buy_stuff_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    label VARCHAR(50) NOT NULL,
    price INT NOT NULL
);

INSERT INTO buy_stuff_items (name, label, price) VALUES
('water', 'Water', 10),
('bread', 'Bread', 20),
('phone', 'Phone', 500);