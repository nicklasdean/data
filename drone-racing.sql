DROP DATABASE drone_racing IF EXISTS
CREATE DATABASE drone_racing

CREATE TABLE pilots (
    pilot_id INT PRIMARY KEY,
    callsign VARCHAR(50) UNIQUE NOT NULL,
    real_name VARCHAR(100),
    country VARCHAR(50),
    pro_license_number VARCHAR(20) UNIQUE,
    career_start_date DATE,
    ranking_points INT DEFAULT 0
);

CREATE TABLE drones (
    drone_id INT PRIMARY KEY,
    pilot_id INT,
    nickname VARCHAR(50),
    frame_model VARCHAR(50),
    weight_grams INT,
    motor_kv INT,
    battery_capacity INT,
    certification_status VARCHAR(20),
    FOREIGN KEY (pilot_id) REFERENCES pilots(pilot_id)
);

CREATE TABLE tracks (
    track_id INT PRIMARY KEY,
    track_name VARCHAR(100),
    location VARCHAR(100),
    difficulty_rating INT CHECK (difficulty_rating BETWEEN 1 AND 10),
    length_meters INT,
    gates_count INT,
    indoor BOOLEAN,
    altitude_meters INT
);

CREATE TABLE race_events (
    event_id INT PRIMARY KEY,
    track_id INT,
    event_date DATE,
    weather_conditions VARCHAR(50),
    prize_pool DECIMAL(10,2),
    broadcast_partner VARCHAR(100),
    FOREIGN KEY (track_id) REFERENCES tracks(track_id)
);

CREATE TABLE race_heats (
    heat_id INT PRIMARY KEY,
    event_id INT,
    heat_number INT,
    start_time TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES race_events(event_id)
);

CREATE TABLE heat_results (
    heat_id INT,
    pilot_id INT,
    drone_id INT,
    finish_position INT,
    lap_time_seconds DECIMAL(6,3),
    disqualified BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (heat_id, pilot_id),
    FOREIGN KEY (heat_id) REFERENCES race_heats(heat_id),
    FOREIGN KEY (pilot_id) REFERENCES pilots(pilot_id),
    FOREIGN KEY (drone_id) REFERENCES drones(drone_id)
);

-- Populate pilots table
INSERT INTO pilots (pilot_id, callsign, real_name, country, pro_license_number, career_start_date, ranking_points) VALUES 
(1, 'PhoenixFPV', 'Takeshi Yamamoto', 'Japan', 'PRO-2024-0123', '2020-03-15', 2850),
(2, 'VortexQueen', 'Marina Petrova', 'Russia', 'PRO-2024-0124', '2019-06-22', 3100),
(3, 'ThunderBolt', 'Raj Kapoor', 'India', 'PRO-2024-0125', '2021-01-10', 2200),
(4, 'NightHawk', 'Chen Wei', 'China', 'PRO-2024-0126', '2018-09-30', 3300),
(5, 'DesertStorm', 'Ahmed Hassan', 'UAE', 'PRO-2024-0127', '2022-02-15', 1950),
(6, 'CyberWitch', 'Emma Torres', 'Spain', 'PRO-2024-0128', '2019-11-05', 2750),
(7, 'SpeedDemon', 'Lucas Silva', 'Brazil', 'PRO-2024-0129', '2020-07-20', 2600),
(8, 'ArcticFox', 'Erik Larsson', 'Sweden', 'PRO-2024-0130', '2021-04-01', 2400),
(9, 'WindRunner', 'Sarah O''Connor', 'Ireland', 'PRO-2024-0131', '2019-08-12', 2900),
(10, 'DragonZero', 'Park Min-jun', 'South Korea', 'PRO-2024-0132', '2020-05-15', 2700);

-- Populate drones table
INSERT INTO drones (drone_id, pilot_id, nickname, frame_model, weight_grams, motor_kv, battery_capacity, certification_status) VALUES
(1, 1, 'RedDragon', 'SkystormX', 250, 2400, 1300, 'Race Certified'),
(2, 2, 'Banshee', 'SpeedDemon Pro', 235, 2600, 1500, 'Race Certified'),
(3, 3, 'StormChaser', 'LightningFrame', 242, 2500, 1400, 'Race Certified'),
(4, 4, 'ShadowBlade', 'NinjaX Pro', 248, 2450, 1350, 'Race Certified'),
(5, 5, 'DuneRacer', 'SandstormFPV', 238, 2550, 1450, 'Race Certified'),
(6, 6, 'HexBlade', 'WarlockFrame', 245, 2480, 1380, 'Race Certified'),
(7, 7, 'ThunderBolt', 'VortexPro', 240, 2520, 1420, 'Race Certified'),
(8, 8, 'IceBreaker', 'FrostBite', 237, 2580, 1460, 'Race Certified'),
(9, 9, 'Cyclone', 'TempestX', 243, 2490, 1390, 'Race Certified'),
(10, 10, 'FireBird', 'PhoenixPro', 246, 2470, 1370, 'Race Certified');

-- Populate tracks table
INSERT INTO tracks (track_id, track_name, location, difficulty_rating, length_meters, gates_count, indoor, altitude_meters) VALUES
(1, 'Neon Canyon', 'Tokyo Dome', 9, 800, 12, true, 0),
(2, 'Mountain Mayhem', 'Swiss Alps', 10, 1200, 15, false, 2100),
(3, 'Desert Storm', 'Dubai Arena', 8, 1000, 10, true, 50),
(4, 'Urban Jungle', 'Singapore Stadium', 7, 750, 14, true, 5),
(5, 'Arctic Circuit', 'Helsinki Arena', 9, 950, 13, true, 20),
(6, 'Canyon Run', 'Arizona Desert', 8, 1100, 11, false, 800),
(7, 'Rainforest Rush', 'Amazon Arena', 9, 850, 15, false, 400),
(8, 'Cyber City', 'Seoul Stadium', 10, 900, 16, true, 30),
(9, 'Beach Blast', 'Gold Coast', 7, 780, 12, false, 5),
(10, 'Alpine Edge', 'Chamonix', 9, 1050, 14, false, 1800);

-- Populate race_events table
INSERT INTO race_events (event_id, track_id, event_date, weather_conditions, prize_pool, broadcast_partner) VALUES
(1, 1, '2024-03-15', 'Clear', 50000.00, 'DroneSports TV'),
(2, 2, '2024-03-22', 'Light Snow', 75000.00, 'ESports Global'),
(3, 3, '2024-04-01', 'Clear', 60000.00, 'AerialSports Network'),
(4, 4, '2024-04-15', 'Light Rain', 55000.00, 'DroneSports TV'),
(5, 5, '2024-04-29', 'Clear', 65000.00, 'Nordic Sports'),
(6, 6, '2024-05-10', 'Windy', 70000.00, 'Desert Racing Network'),
(7, 7, '2024-05-24', 'Humid', 58000.00, 'Amazon Prime'),
(8, 8, '2024-06-07', 'Clear', 80000.00, 'KSports'),
(9, 9, '2024-06-21', 'Partly Cloudy', 52000.00, 'Pacific Sports'),
(10, 10, '2024-07-05', 'Clear', 72000.00, 'EuroSports');

-- Populate race_heats table
INSERT INTO race_heats (heat_id, event_id, heat_number, start_time) VALUES
(1, 1, 1, '2024-03-15 10:00:00'),
(2, 1, 2, '2024-03-15 10:30:00'),
(3, 1, 3, '2024-03-15 11:00:00'),
(4, 2, 1, '2024-03-22 09:00:00'),
(5, 2, 2, '2024-03-22 09:30:00'),
(6, 3, 1, '2024-04-01 14:00:00'),
(7, 3, 2, '2024-04-01 14:30:00'),
(8, 4, 1, '2024-04-15 15:00:00'),
(9, 4, 2, '2024-04-15 15:30:00'),
(10, 5, 1, '2024-04-29 13:00:00');

-- Populate heat_results table
INSERT INTO heat_results (heat_id, pilot_id, drone_id, finish_position, lap_time_seconds, disqualified) VALUES
(1, 1, 1, 1, 45.321, false),
(1, 2, 2, 2, 46.123, false),
(1, 3, 3, 3, 46.892, false),
(2, 4, 4, 1, 44.987, false),
(2, 5, 5, 2, 45.654, false),
(2, 6, 6, 3, 46.321, false),
(3, 7, 7, 1, 45.123, false),
(3, 8, 8, 2, 45.789, false),
(3, 9, 9, 3, 46.432, false),
(3, 10, 10, 4, 47.123, true);
