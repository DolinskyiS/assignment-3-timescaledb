
-- ALL THE TABLES

CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(100) NOT NULL
);

CREATE TABLE Room (
    room_id SERIAL PRIMARY KEY,
    room_type VARCHAR(20) NOT NULL,
    capacity INT NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE Package (
    package_id SERIAL PRIMARY KEY,
    room_id INT NOT NULL,
    skipass_type VARCHAR(100) NOT NULL,
    package_name VARCHAR(20) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

CREATE TABLE Reservation (
    reservation_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    package_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    reservation_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (package_id) REFERENCES Package(package_id)
);

CREATE TABLE SkiResort (
    resort_id SERIAL PRIMARY KEY,
    resort_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    difficulty VARCHAR(100) NOT NULL,
    size INT NOT NULL
);

CREATE TABLE SkiPass (
    skipass_id SERIAL PRIMARY KEY,
    reservation_id INT NOT NULL,
    resort_id INT NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id),
    FOREIGN KEY (resort_id) REFERENCES SkiResort(resort_id)
);

CREATE TABLE Telemetry (
    telemetry_id SERIAL,
    skipass_id INT NOT NULL,
    resort_id INT NOT NULL,
    time_scanned TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (telemetry_id, time_scanned),
    FOREIGN KEY (skipass_id) REFERENCES SkiPass(skipass_id),
    FOREIGN KEY (resort_id) REFERENCES SkiResort(resort_id)
);

-- HYPERTABLE CREATION

SELECT create_hypertable('Telemetry', 'time_scanned');

-- ALL tHE INSERTS

INSERT INTO Customer (customer_id, first_name, last_name, email, phone, address) VALUES
(4, 'Jessica', 'Nguyen', 'scarson@ross.com', '001-495-380-4928', '52102 George Harbor, Lake Kellytown, RI 85749'),
(5, 'William', 'Carroll', 'mark84@hotmail.com', '(021)430-3208x4579', '899 Baldwin Via, East Josephstad, AL 31923'),
(6, 'Terrence', 'Baker', 'lisaturner@harris-griffith.com', '+1-157-603-0588', '46306 Keith Ferry, North Brendanstad, OK 85251'),
(7, 'Alex', 'Reyes', 'melissa26@hotmail.com', '001-041-421-4410x677', '33048 Johnson Avenue Apt. 373, Pittmanstad, DC 22818'),
(8, 'Yolanda', 'Miller', 'waltonkatie@yahoo.com', '3491888692', '0837 Lauren Junction, South Charlesberg, WV 30276'),
(9, 'Mark', 'Ray', 'nicolegonzalez@yahoo.com', '783.806.6737x27173', '576 Murray Mountain, North Nathanview, NJ 09735'),
(10, 'Ashley', 'Cooper', 'xmartinez@king.com', '(743)452-9979', '7610 Walker Lane Suite 120, Mcdonaldberg, MS 05974'),
(11, 'Jamie', 'Williams', 'joanwilliams@newman.com', '393.280.2610x283', '66175 Katrina River Apt. 791, New Victoria, RI 81389'),
(12, 'Allison', 'Turner', 'amy13@hotmail.com', '835-118-9310', '58790 Strong Overpass Apt. 184, Carolshire, IA 21770'),
(13, 'Charles', 'Richardson', 'megan31@harrington.com', '001-480-667-1994', '8155 Melissa Rest, Port Joanna, OK 65840');

INSERT INTO Room (room_id, room_type, capacity, description) VALUES
(1, 'Suite', 1, 'Important trial any participant thus. Also expect join out do.'),
(2, 'Double', 4, 'Push purpose claim bank usually spring. Commercial make scene.'),
(3, 'Single', 5, 'Enter onto character discover keep candidate. Over mention risk.'),
(4, 'Double', 5, 'Economy ago move especially. Out head pick push.'),
(5, 'Double', 1, 'Each general size through voice you show. Seat picture mission.'),
(6, 'Single', 2, 'Local this notice but. Defense bed state seem enjoy everyone.'),
(7, 'Suite', 5, 'Source win quickly really. Determine store street easy senior.'),
(8, 'Suite', 4, 'State little game station fill card like. Black knowledge you.'),
(9, 'Single', 4, 'Product magazine fill. Your discover seat blood through.'),
(10, 'Single', 3, 'Exist station dark usually hit. Require road they court.');

INSERT INTO Package (package_id, room_id, skipass_type, package_name, price) VALUES
(1, 6, 'Standard', 'Package 1', 490.20),
(2, 6, 'Family', 'Package 2', 105.96),
(3, 5, 'Premium', 'Package 3', 304.30),
(4, 10, 'Premium', 'Package 4', 385.44),
(5, 2, 'Family', 'Package 5', 351.85),
(6, 9, 'Family', 'Package 6', 280.18),
(7, 7, 'Family', 'Package 7', 230.35),
(8, 5, 'Family', 'Package 8', 423.13),
(9, 7, 'Family', 'Package 9', 136.98),
(10, 2, 'Premium', 'Package 10', 402.98);

INSERT INTO Reservation (reservation_id, customer_id, package_id, start_date, end_date, reservation_date, total_price) VALUES
(21, 11, 8, '2024-08-23', '2024-08-30', '2024-08-19', 331.08),
(22, 7, 2, '2024-06-01', '2024-06-03', '2024-05-06', 434.95),
(23, 13, 8, '2024-09-21', '2024-09-23', '2024-08-24', 391.26),
(24, 12, 5, '2025-03-24', '2025-03-31', '2025-03-15', 568.85),
(25, 10, 8, '2024-10-26', '2024-11-01', '2024-10-23', 316.87),
(26, 12, 3, '2025-02-25', '2025-02-26', '2025-02-19', 716.82),
(27, 6, 2, '2024-09-21', '2024-09-25', '2024-09-05', 881.55),
(28, 7, 6, '2024-12-31', '2025-01-04', '2024-12-20', 616.42),
(29, 6, 1, '2025-03-29', '2025-04-01', '2025-03-19', 504.53),
(30, 4, 2, '2024-05-20', '2024-05-26', '2024-05-02', 258.88);

INSERT INTO skiresort (resort_id, resort_name, location, difficulty, size) VALUES
(1, 'Robinstad Resort', 'New Kenneth', 'Hard', 53),
(2, 'Port Victoriaberg Resort', 'East Elizabethland', 'Easy', 180),
(3, 'West Randallfort Resort', 'Williamshaven', 'Medium', 197),
(4, 'Chandlerview Resort', 'North Brianshire', 'Easy', 150),
(5, 'Carmenland Resort', 'Valeriestad', 'Easy', 71),
(6, 'Marytown Resort', 'Stevenland', 'Hard', 133),
(7, 'South Matthew Resort', 'Michaelberg', 'Hard', 173),
(8, 'Port William Resort', 'Shahfort', 'Easy', 180),
(9, 'Port Andrew Resort', 'Josemouth', 'Hard', 156),
(10, 'Bennettstad Resort', 'Annchester', 'Easy', 56);

INSERT INTO skipass (skipass_id, reservation_id, resort_id, valid_from, valid_to) VALUES
(11, 21, 1, '2024-06-11', '2024-06-16'),
(12, 22, 2, '2024-12-24', '2024-12-27'),
(13, 23, 3, '2024-09-25', '2024-09-28'),
(14, 24, 4, '2025-03-05', '2025-03-09'),
(15, 25, 5, '2024-12-26', '2024-12-30'),
(16, 26, 6, '2025-01-02', '2025-01-06'),
(17, 27, 7, '2025-01-12', '2025-01-17'),
(18, 28, 8, '2025-01-26', '2025-01-29'),
(19, 29, 9, '2024-07-01', '2024-07-06'),
(20, 30, 10, '2024-06-25', '2024-06-26');
