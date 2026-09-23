CREATE DATABASE PRACTICEWHERE;
USE PRACTICEWHERE;
GO
DROP TABLE IF EXISTS Commande;

CREATE TABLE Commande (
	CommandeID INT,
	Client VARCHAR(100) NOT NULL,
	Produit VARCHAR(100) NOT NULL,
	Qte INT, 
	Prix_U DECIMAL(10, 2),
	CodePromo VARCHAR(20), 
	DateCommande DATE,

	CONSTRAINT pk_CommandeId PRIMARY KEY (CommandeId)
);

INSERT INTO Commande (CommandeID, Client, Produit, Qte, Prix_U, CodePromo, DateCommande) VALUES
(1, 'Alice Bonnet', 'Table Vision 8', 2, 179.99, NULL, '2023-12-22'),
(2, 'Bob Martin', 'Camera GoPro', 1, 300.99, 'CAM10', '2023-12-23'),
(3, 'Alain Dupont', 'Montre connectée', 3, 69.99, 'BOXINGDAY', '2023-12-27'),
(4, 'Diane Caron', 'Montre connectée', 1, 99.99, NULL, '2024-01-04'),
(5, 'Diane Caron', 'Enceinte Bluetooth', 2, 79.99, 'SOUNDOFF', '2024-01-04'),
(6, 'Alain Dupont', 'Casque Bluetooth', 1, 24.99, 'SOUNDOFF', '2024-01-05'),
(7, 'Joanne Leroy', 'Montre connectée', 2, 99.99, NULL, '2024-01-07');

SELECT * FROM Commande;
SELECT * FROM Commande WHERE Prix_U > 100;
SELECT * FROM Commande WHERE Client = 'Diane Caron';
SELECT * FROM Commande WHERE Prix_U <= 80;
SELECT * FROM Commande WHERE Produit LIKE '%Bluetooth%';
SELECT * FROM Commande WHERE Client LIKE 'A%';
SELECT * FROM Commande WHERE Produit LIKE '%connectée';
SELECT * FROM Commande WHERE CodePromo IS NULL;
SELECT * FROM Commande WHERE CodePromo IS NOT NULL;
SELECT * FROM Commande WHERE Client = 'Alain Dupont' AND Prix_U < 50;
SELECT * FROM Commande WHERE Prix_U > 200 AND Qte = 1;
SELECT * FROM Commande WHERE Client IN('Alice Bonnet', 'Bob Martin') AND DateCommande BETWEEN '2023-01-01' AND '2023-12-31';
SELECT * FROM Commande WHERE CodePromo IN('CAM10', 'SOUNDOFF');
SELECT * FROM Commande WHERE Prix_U BETWEEN 70 AND 180;
SELECT * FROM Commande WHERE DateCommande BETWEEN '2024-01-01' AND '2024-01-05';
SELECT * FROM Commande WHERE Produit IN('Montre Connectée', 'Enceinte Bluetooth') AND Qte > 1;
SELECT * FROM Commande WHERE CodePromo IS NOT NULL AND DateCommande BETWEEN '2024-01-01' AND '2024-01-31';
SELECT * FROM Commande WHERE Prix_U > 50 AND Produit != 'Table Vision 8';

-------------------------------------------------------------------------
SELECT CommandeId 'ID Commande', Client 'Nom du Client', Produit 'Article', Qte 'Quantité', Prix_U 'Prix Unitaire', (Prix_U * Qte) 'Total' FROM Commande;
SELECT * FROM Commande ORDER BY CLIENT ASC;
SELECT * FROM Commande ORDER BY Prix_U DESC;
SELECT * FROM Commande 
SELECT * FROM Commande ORDER BY Client, DateCommande ASC;
SELECT TOP 3 * FROM Commande ORDER BY Prix_U;
SELECT TOP 2 * FROM Commande ORDER BY DateCommande DESC;
SELECT * FROM Commande 
SELECT DISTINCT Client FROM Commande;
SELECT TOP 3 Client, DISTINCT Produit, (Prix_U * Qte) 'Total' FROM Commande WHERE ;
