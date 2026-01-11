CREATE DATABASE food_db;
USE food_db;
CREATE TABLE dishes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description  VARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(255) NOT NULL
);
CREATE TABLE COMMANDE (
    id_commande INT AUTO_INCREMENT PRIMARY KEY,
    nom_client VARCHAR(100) NOT NULL,
    prenom_client VARCHAR(100) NOT NULL,
    tel VARCHAR(20) NOT NULL,
    date DATETIME NOT NULL,
    adresse TEXT NOT NULL,
    montant_total DECIMAL(10,2) NOT NULL
);
CREATE TABLE IF NOT EXISTS ContenirDans (
    id_commande INT,
    id_plat INT,
    quantité INT NOT NULL,
    PRIMARY KEY (id_commande, id_plat), 
    FOREIGN KEY (id_commande) REFERENCES COMMANDE(id_commande) ON DELETE CASCADE,
    FOREIGN KEY (id_plat) REFERENCES dishes(id) ON UPDATE CASCADE
)
--insertion des plats
USE food_db;
INSERT INTO dishes (name, description, price, image_url) 
VALUES ('Brochette', 'Bœuf épicé',50.00, 'images/m1.png');
INSERT INTO dishes (name, description, price, image_url) 
VALUES ('Bœuf', 'Bœuf avec prune',55.00, 'images/m2.png');
INSERT INTO dishes (name, description, price, image_url) 
VALUES ('couscous', 'couscous avec boeuf',45.00, 'images/m3.png');
INSERT INTO dishes (name, description, price, image_url) VALUES 
('bastilla', 'bastilla poisson',70.00, 'images/m4.png');
INSERT INTO dishes (name, description, price, image_url) VALUES 
('tagine poisson', 'poisson',65.00, 'images/m5.png');
INSERT INTO dishes (name, description, price, image_url) VALUES 
('lasagna', 'lasagna delicieuse',63.00, 'images/m6.png');