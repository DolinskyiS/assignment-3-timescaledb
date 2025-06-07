
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

SELECT create_hypertable('Telemetry', 'time_scanned');