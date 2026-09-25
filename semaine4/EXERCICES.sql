-- Table de référence (même que précédemment)
DROP TABLE IF EXISTS Commande;
go
CREATE TABLE Commande (
    CommandeID INT PRIMARY KEY,
    Client VARCHAR(100) NOT NULL,
    Produit VARCHAR(100) NOT NULL,
    Qte INT,
    Prix_U DECIMAL(10, 2),
    CodePromo VARCHAR(20),
    DateCommande DATE
);

INSERT INTO Commande VALUES
(1, 'Alice Bonnet', 'Table Vision 8', 2, 179.99, NULL, '2023-12-22'),
(2, 'Bob Martin', 'Camera GoPro', 1, 300.99, 'CAM10', '2023-12-23'),
(3, 'Alain Dupont', 'Montre connectée', 3, 69.99, 'BOXINGDAY', '2023-12-27'),
(4, 'Diane Caron', 'Montre connectée', 1, 99.99, NULL, '2024-01-04'),
(5, 'Diane Caron', 'Enceinte Bluetooth', 2, 79.99, 'SOUNDOFF', '2024-01-04'),
(6, 'Alain Dupont', 'Casque Bluetooth', 1, 24.99, 'SOUNDOFF', '2024-01-05'),
(7, 'Joanne Leroy', 'Montre connectée', 2, 99.99, NULL, '2024-01-07');



SELECT * FROM Commande;

--Q1: Alias et calculs:
--Affichez toutes les commandes avec les colonnes renommées en français : "ID Commande", "Nom du client", "Article", "Quantité", "Prix unitaire", "Total"
--Le "Total" doit être calculé -->  SELECT ... (Prix_U * Qte)Tri simple:
SELECT 
	CommandeID 'ID Commande',
    Client 'Nom du Client',
    Produit 'Article',
    Qte 'Quantité',
    Prix_U 'Prix unitaire',
    (Prix_U * Qte) 'Total'
FROM Commande;


--Q2: Tri simple:
--Affichez toutes les commandes triées par client (ordre alphabétique)
SELECT * FROM Commande ORDER BY Client;
--Affichez les commandes triées par prix unitaire décroissantTri multiple:
SELECT * FROM Commande ORDER BY Client, Prix_U DESC;
--Q3: Tri multiple:
--Triez les commandes par client, puis par date de commande (la plus récente en premier)
SELECT * FROM Commande ORDER BY Client ASC, DateCommande DESC;
-- TOP: Affichez les 3 commandes les plus chères (par prix unitaire)
SELECT TOP 3 * FROM Commande ORDER BY Prix_U Desc;
--Q4: TOP:
--Affichez les 2 dernières commandes passées
SELECT TOP 2 * FROM Commande ORDER BY DateCommande DESC;
-- DISTINCT: Listez tous les clients distincts (sans doublons)
SELECT DISTINCT Client FROM Commande;
--Q5: DISTINCT:
--Listez tous les produits distincts triés alphabétiquementCombinaisons: 
SELECT DISTINCT Produit FROM Commande ORDER BY Produit ASC;
--Affichez les 3 meilleurs clients par total d'achat (Prix_U * Qte), avec alias français
SELECT TOP 3 client AS 'Nom Client' FROM Commande ORDER BY (Prix_U * Qte);
--Q6: Combinaisons:
--Listez les produits distincts commandés en 2024, triés par nom
SELECT DISTINCT Produit FROM Commande WHERE DateCommande Between '2024/01/01' AND '2024/12/31' ORDER BY Produit

--Exercise 2
SELECT * 
FROM Commande;
-- 1. Sélectionner tous les noms distincts des clients qui ont passé une commande. On ne doit pas avoir de doublons dans la liste.
SELECT DISTINCT Client 
FROM Commande;

-- 2. Afficher toutes les informations des commandes pour le produit nommé "Montre connectée". Trier les résultats par la date de 
-- commande, de la plus récente à la plus ancienne.
SELECT * 
FROM Commande
WHERE Produit LIKE '%Montre connectée%'
ORDER BY DateCommande DESC;
-- 3. Trouver toutes les commandes où la quantité est supérieure à 1. On doit afficher le nom du client, le nom du produit, et la quantité.
SELECT  Client 'Nom du client',
		Produit 'Nom du produit',
		Qte 'Quantité'
FROM Commande
WHERE Qte > 1

-- 4. Afficher le nom de chaque produit commandé avec son prix unitaire, mais uniquement pour les commandes passées en 2023. On inclut 
-- uniquement les produits dont le prix unitaire est supérieur à 50 $. On limite le résultat aux 2 premiers produits ayant les prix les plus élevés.

SELECT TOP 2 WITH TIES Client, Produit, Prix_U
FROM Commande
WHERE DateCommande BETWEEN '2023-01-01' AND '2023-12-31' AND Prix_U > 50
ORDER BY Prix_U DESC;

-- 5. Afficher toutes les informations des commandes passées entre 2023-12-27 et 2024-01-05 qui ont été achetées avec un code promo. On doit trier 
-- le résultat par nom et par quantité.

SELECT * 
FROM Commande
SELECT *
FROM Commande
WHERE DateCommande BETWEEN  '2023-12-27' AND '2024-01-05' AND CodePromo IS NOT NULL
ORDER BY Client, Qte