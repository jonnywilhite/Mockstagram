--
-- File generated with SQLiteStudio v3.0.6 on Sun Nov 1 17:03:57 2015
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Classes
CREATE TABLE Classes (class TEXT, type TEXT, country TEXT, numGuns INT, bore INT, displacement INT);
INSERT INTO Classes (class, type, country, numGuns, bore, displacement) VALUES ('Revenge', 'bb', 'Gt. Britain', 8, 15, 29000);
INSERT INTO Classes (class, type, country, numGuns, bore, displacement) VALUES ('Kongo', 'bc', 'Japan', 8, 14, 32000);
INSERT INTO Classes (class, type, country, numGuns, bore, displacement) VALUES ('Iowa', 'bb', 'USA', 9, 16, 46000);
INSERT INTO Classes (class, type, country, numGuns, bore, displacement) VALUES ('Renown', 'bc', 'Gr. Britain', 10, 12, 35000);
INSERT INTO Classes (class, type, country, numGuns, bore, displacement) VALUES ('Tennessee', 'bb', 'USA', 12, 14, 41000);
INSERT INTO Classes (class, type, country, numGuns, bore, displacement) VALUES ('Yamato', 'bb', 'Japan', 10, 13, 33000);
INSERT INTO Classes (class, type, country, numGuns, bore, displacement) VALUES ('North Carolina', 'bc', 'USA', 10, 12, 30000);

-- Table: Outcomes
CREATE TABLE Outcomes (ship TEXT, battle TEXT, result TEXT);
INSERT INTO Outcomes (ship, battle, result) VALUES ('Tennessee', 'Surigao Strait', 'ok');
INSERT INTO Outcomes (ship, battle, result) VALUES ('Washington', 'Guadalcanal', 'ok');
INSERT INTO Outcomes (ship, battle, result) VALUES ('West Virginia', 'Surigao Strait', 'ok');
INSERT INTO Outcomes (ship, battle, result) VALUES ('Yamashiro', 'Surigao Strait', 'sunk');
INSERT INTO Outcomes (ship, battle, result) VALUES ('South Dakota', 'Guadalcanal', 'damaged');
INSERT INTO Outcomes (ship, battle, result) VALUES ('Scharnhorst', 'North Cape', 'sunk');
INSERT INTO Outcomes (ship, battle, result) VALUES ('Rodney', 'Denmark Strait', 'ok');
INSERT INTO Outcomes (ship, battle, result) VALUES ('Prince of Wales', 'Denmark Strait', 'damaged');
INSERT INTO Outcomes (ship, battle, result) VALUES ('Kirishima', 'Guadalcanal', 'sunk');
INSERT INTO Outcomes (ship, battle, result) VALUES ('King George V', 'Denmark Strait', 'ok');
INSERT INTO Outcomes (ship, battle, result) VALUES ('Hood', 'Denmark Strait', 'sunk');
INSERT INTO Outcomes (ship, battle, result) VALUES ('Fuso', 'Surigao Strait', 'sunk');
INSERT INTO Outcomes (ship, battle, result) VALUES ('Duke of York', 'North Cape', 'ok');
INSERT INTO Outcomes (ship, battle, result) VALUES ('California', 'Surigao Strait', 'ok');
INSERT INTO Outcomes (ship, battle, result) VALUES ('Arizona', 'Pearl Harbor', 'sunk');
INSERT INTO Outcomes (ship, battle, result) VALUES ('Bismarck', 'Denmark Strait', 'sunk');

-- Table: Ships
CREATE TABLE Ships (name TEXT, class TEXT, launched INT);
INSERT INTO Ships (name, class, launched) VALUES ('California', 'Tennessee', 1921);
INSERT INTO Ships (name, class, launched) VALUES ('Haruna', 'Kongo', 1915);
INSERT INTO Ships (name, class, launched) VALUES ('Hiei', 'Kongo', 1914);
INSERT INTO Ships (name, class, launched) VALUES ('Iowa', 'Iowa', 1943);
INSERT INTO Ships (name, class, launched) VALUES ('Kongo', 'Kongo', 1913);
INSERT INTO Ships (name, class, launched) VALUES ('Missouri', 'Iowa', 1944);
INSERT INTO Ships (name, class, launched) VALUES ('Musashi', 'Yamato', 1942);
INSERT INTO Ships (name, class, launched) VALUES ('New Jersey', 'Iowa', 1943);
INSERT INTO Ships (name, class, launched) VALUES ('North Carolina', 'North Carolina', 1941);
INSERT INTO Ships (name, class, launched) VALUES ('Ramillies', 'Revenge', 1917);
INSERT INTO Ships (name, class, launched) VALUES ('Renown', 'Renown', 1916);
INSERT INTO Ships (name, class, launched) VALUES ('Resolution', 'Revenge', 1916);
INSERT INTO Ships (name, class, launched) VALUES ('Revenge', 'Revenge', 1916);
INSERT INTO Ships (name, class, launched) VALUES ('Royal Oak', 'Revenge', 1916);
INSERT INTO Ships (name, class, launched) VALUES ('Royal Sovereign', 'Revenge', 1916);
INSERT INTO Ships (name, class, launched) VALUES ('Tennessee', 'Tennessee', 1920);
INSERT INTO Ships (name, class, launched) VALUES ('Washington', 'North Carolina', 1941);
INSERT INTO Ships (name, class, launched) VALUES ('Wisconsin', 'Iowa', 1944);
INSERT INTO Ships (name, class, launched) VALUES ('Yamato', 'Yamato', 1941);
INSERT INTO Ships (name, class, launched) VALUES ('Repulse', 'Renown', 1916);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
