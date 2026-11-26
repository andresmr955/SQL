CREATE DATABASE Ventes;
GO
USE Ventes
GO
-- Suppression des tables si elles existent déjà
DROP TABLE IF EXISTS Vente;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Produit;

-- Création de la table Client
CREATE TABLE Client (
    clientID INT PRIMARY KEY,
    nomClient VARCHAR(100) NOT NULL,
    ville VARCHAR(100),
    typeClient VARCHAR(50) -- 'Particulier' ou 'Entreprise'
);

-- Création de la table Produit
CREATE TABLE Produit (
    produitID INT PRIMARY KEY,
    nomProduit VARCHAR(100) NOT NULL,
    categorie VARCHAR(50),
    prix DECIMAL(10,2)
);

-- Création de la table Vente
CREATE TABLE Vente (
    venteID INT PRIMARY KEY,
    clientID INT,
    produitID INT,
    quantite INT,
    dateVente DATE,
    FOREIGN KEY (clientID) REFERENCES Client(clientID),
    FOREIGN KEY (produitID) REFERENCES Produit(produitID)
);

-- Insertion de données dans Client
INSERT INTO Client (clientID, nomClient, ville, typeClient) VALUES 
(1, 'Entreprise ABC', 'Montreal', 'Entreprise'),
(2, 'Jean Tremblay', 'Quebec', 'Particulier'),
(3, 'Marie Gagnon', 'Montreal', 'Particulier'),
(4, 'TechCorp', 'Laval', 'Entreprise'),
(5, 'Sophie Roy', 'Sherbrooke', 'Particulier'),
(6, 'GlobalInc', 'Toronto', 'Entreprise'),   -- Client sans achat
(7, 'Café Lumière', 'Montreal', 'Entreprise'); -- Client de Montreal sans achat

-- Insertion de données dans Produit
INSERT INTO Produit (produitID, nomProduit, categorie, prix) VALUES 
(1, 'Ordinateur portable', 'Informatique', 1200.00),
(2, 'Souris', 'Informatique', 25.00),
(3, 'Bureau', 'Mobilier', 450.00),
(4, 'Chaise', 'Mobilier', 180.00),
(5, 'Écran', 'Informatique', 350.00),
(6, 'Lampe', 'Mobilier', 75.00),
(7, 'Clavier', 'Informatique', 80.00); -- Produit jamais vendu

-- Insertion de données dans Vente
-- Notez : les clients 6 et 7 n'ont aucune vente, le produit 7 n'est jamais vendu,
-- et la vente 13 n'est associée à aucun client (clientID NULL).
INSERT INTO Vente (venteID, clientID, produitID, quantite, dateVente) VALUES 
(1, 1, 1, 5, '2024-01-15'),
(2, 1, 2, 10, '2024-01-15'),
(3, 2, 3, 1, '2024-02-20'),
(4, 3, 1, 1, '2024-02-25'),
(5, 3, 5, 2, '2024-02-25'),
(6, 4, 1, 3, '2024-03-10'),
(7, 4, 2, 5, '2024-03-10'),
(8, 4, 5, 3, '2024-03-10'),
(9, 5, 4, 2, '2024-03-15'),
(10, 2, 6, 1, '2024-04-01'),
(11, 1, 3, 2, '2024-04-05'),
(12, 5, 2, 3, '2024-04-10'),
(13, NULL, 4, 1, '2024-04-12'); -- Vente au comptoir, sans client associé

-- Données ajoutées : le client 7 (Café Lumière, Montreal) n'a aucun achat, et 
-- la vente 13 n'est associée à aucun client (clientID NULL).

-- 1. Détail des achats
-- Afficher le nom du client, le nom du produit et la quantité de chaque vente, 
-- triés par nom de client puis par produit.

SELECT C.nomClient, P.nomProduit, V.quantite
FROM Vente V
INNER JOIN Produit P
	ON V.produitID = P.produitID
INNER JOIN Client C
	ON V.clientID = C.clientID
ORDER BY C.nomClient, P.nomProduit
-- 2. Clients de Montreal
-- Afficher tous les clients de Montreal avec les produits qu'ils ont achetés, y 
-- compris ceux qui n'ont rien acheté.
SELECT C.nomClient, P.nomProduit, V.quantite
FROM Client C
LEFT JOIN Vente V
	ON C.clientID = V.clientID --AND C.ville = 'Montreal'
LEFT JOIN Produit P
	ON V.produitID = P.produitID
WHERE C.ville = 'Montreal'

-- 3. Achats de mars 2024 : ON ou WHERE ?
-- Afficher tous les clients avec leurs achats de mars 2024. 
-- Les clients qui n'ont rien acheté en mars doivent apparaître avec NULL. 
-- Placez ensuite la condition sur la date dans le WHERE plutôt que dans le ON : 
-- combien de lignes obtenez-vous ? Expliquez.



SELECT C.nomClient, V.dateVente, v.quantite
FROM Client C
LEFT JOIN Vente V
	ON C.clientID = V.clientID AND V.dateVente BETWEEN '2024-03-01' AND '2024-04-01'
WHERE V.dateVente BETWEEN '2024-03-01' AND '2024-04-01'

-- 4. Montant total par client (GROUP BY)
-- Pour chaque client ayant acheté, afficher le montant total dépensé (quantité × prix), 
-- du plus grand au plus petit.

SELECT C.nomClient, SUM(V.quantite * P.prix) AS TotalDepense
FROM Client C
INNER JOIN Vente V
	ON C.clientID = V.clientID
INNER JOIN Produit P
	ON V.produitID = P.produitID
GROUP BY  C.nomClient
ORDER BY TotalDepense DESC

SELECT * FROM Client 
SELECT * FROM Vente 
SELECT * FROM Produit 

-- 5. Comparer les jointures
-- Joindre Client (à gauche) et Vente (à droite) avec INNER JOIN, LEFT JOIN, RIGHT JOIN 
-- puis FULL JOIN. Pour chacune, donnez le nombre de lignes et identifiez les lignes qui 
-- expliquent l'écart avec INNER JOIN. Pourquoi la clé étrangère accepte-t-elle la vente 13 ?

SELECT 'LJ C -> V' AS Titulo;

SELECT C.*, V.*
FROM Client C
LEFT JOIN Vente V
	ON C.clientID = V.clientID
SELECT 'LJ V -> C' AS Titulo;
SELECT  V.*, C.*
FROM Vente V
LEFT JOIN Client C 
	ON V.clientID = C.clientID 

SELECT 'LI C -> V' AS Titulo;

SELECT C.*, V.*
FROM Client C
INNER JOIN Vente V
	ON C.clientID = V.clientID
SELECT 'IJ V -> C' AS Titulo;
SELECT  V.*, C.*
FROM Vente V
INNER JOIN Client C 
	ON V.clientID = C.clientID 
SELECT 'RI C -> V' AS Titulo;
SELECT C.*, V.*
FROM Client C
RIGHT JOIN Vente V
	ON C.clientID = V.clientID
SELECT 'RI V -> C' AS Titulo;
SELECT  V.*, C.*
FROM Vente V
RIGHT JOIN Client C 
	ON V.clientID = C.clientID 


-- 6. Toutes les combinaisons client-produit
-- a) Générer toutes les combinaisons possibles client-produit. Combien de lignes obtenez-vous et pourquoi ? 49 parce que 7 * 7 = 49
-- b) En partant de ces combinaisons, lister les produits que TechCorp n'a jamais achetés.

SELECT *
FROM Client
CROSS JOIN Produit

SELECT P.nomProduit, venteID
FROM Client C
CROSS JOIN Produit P
LEFT JOIN Vente V
	ON c.clientID = V.clientID AND V.produitID = P.produitID
WHERE C.nomClient = 'TechCorp' AND V.venteID IS NULL


SELECT C.nomClient, P.nomProduit, V.venteID
FROM Client C
CROSS JOIN Produit P
LEFT JOIN Vente V
    ON C.clientID = V.clientID
    AND V.produitID = P.produitID
WHERE C.nomClient = 'TechCorp';

SELECT P.nomProduit, V.venteID
FROM Client C
INNER JOIN Vente V
    ON C.clientID = V.clientID
INNER JOIN Produit P
    ON V.produitID = P.produitID
WHERE C.nomClient = 'TechCorp';

-- 7. UNION et UNION ALL
-- Écrire une requête qui liste les noms des clients ayant acheté un produit 'Informatique', puis une autre pour 'Mobilier'. 
-- Combinez-les avec UNION, puis avec UNION ALL, et expliquez la différence du nombre de lignes. 
-- (À exécuter dans SSMS : l'émulateur ALIVEcode ne gère pas UNION.)
SELECT 'UNION' AS Titulo;

SELECT C.nomClient 
FROM Client C
INNER JOIN Vente V
	ON C.clientID = V.clientId
INNER JOIN Produit p
	ON V.produitID = P.produitID
WHERE P.categorie = 'Informatique'
UNION
SELECT C.nomClient
FROM Client C
INNER JOIN Vente V
	ON C.clientID = V.clientId
INNER JOIN Produit p
	ON V.produitID = P.produitID
WHERE P.categorie = 'Mobilier'

SELECT 'UNION ALL' AS Titulo;

SELECT C.nomClient 
FROM Client C
INNER JOIN Vente V
	ON C.clientID = V.clientId
INNER JOIN Produit p
	ON V.produitID = P.produitID
WHERE P.categorie = 'Informatique'
UNION ALL
SELECT C.nomClient
FROM Client C
INNER JOIN Vente V
	ON C.clientID = V.clientId
INNER JOIN Produit p
	ON V.produitID = P.produitID
WHERE P.categorie = 'Mobilier'