-- Nom de l’étudiant : Andres David Caicedo Marquez
-- Cours : 420-2C5 GROUPe\ 01
-- Session : Automne 2026
-- TP2 - REQUETÊS SQL

-- Question 1
SELECT Titre 'Titre du livre', Prix 'Prix CAD', Stock 'Quantité en inventaire' FROM Livres; 
-- Question 2
SELECT Prenom + ' ' + Nom AS 'Nom Complet' FROM Auteurs;
-- Question 3
SELECT * FROM Livres ORDER BY Prix DESC;
-- Question 4
SELECT * FROM Clients ORDER BY Ville ASC, Nom ASC;
-- Question 5
SELECT TOP 10 * FROM Livres ORDER BY Prix DESC;
-- Question 6
-- ?? SELECT Ville FROM Clients GROUP BY Ville;
SELECT DISTINCT Ville FROM Clients ORDER BY Ville;
-- Question 7
SELECT TOP 5 * FROM Commandes ORDER BY DateCommande DESC;
-- Question 8
SELECT * FROM Livres WHERE LOWER(Titre) LIKE '%vie%';
-- Question 9
SELECT UPPER(Nom), LOWER(Prenom) FROM Auteurs;
-- Question 10
SELECT * FROM Clients;
-- ??
SELECT Nom, Prenom, DATEDIFF(year, DateNaissance, GETDATE())AS Age FROM Clients;
SELECT Nom, Prenom, YEAR(GETDATE()) - YEAR(DateNaissance) AS Age FROM Clients;
-- Question 11
SELECT AVG(prix) AS 'Prix moyenne' FROM Livres
-- Question 12
-- ??
DECLARE @Le_livre_le_plus_cher AS TABLE( prix MONEY);
DECLARE @Le_livre_le_moins_cher AS TABLE( prix MONEY);

INSERT INTO @Le_livre_le_plus_cher SELECT TOP 1 Prix FROM Livres ORDER BY Prix DESC
INSERT INTO @Le_livre_le_moins_cher SELECT TOP 1 Prix FROM Livres ORDER BY Prix ASC

SELECT (SELECT prix FROM @Le_livre_le_plus_cher  ) AS 'LPC', (SELECT Prix FROM @Le_livre_le_moins_cher ) AS 'LMC';

----max
SELECT (
SELECT TOP 1 Prix FROM Livres ORDER BY Prix DESC) AS LPC,
(SELECT TOP 1 Prix FROM Livres ORDER BY Prix ASC) AS LMC

-- Question 13
-- ??
SELECT * FROM Livres ORDER BY CategorieID
SELECT CategorieID, COUNT(CategorieID) AS 'Nombre de livres' FROM Livres GROUP BY CategorieID ORDER BY 'Nombre de livres'
-- Question 14
SELECT Prix, CategorieID FROM Livres ORDER BY CategorieID

SELECT CategorieID, CAST(ROUND(AVG(Prix), 2) AS DECIMAL(10,2)) as PrixMoyenneCategorieID FROM Livres GROUP BY CategorieID ORDER BY PrixMoyenneCategorieID DESC;
-- Question 15

SELECT ClientID, COUNT(ClientID) AS NombreCommandes FROM Commandes GROUP BY ClientID ORDER BY NombreCommandes DESC;


-- Question 16
SELECT TOP 3 CategorieID, SUM(Stock) AS TotalStock FROM Livres GROUP BY CategorieID ORDER BY TotalStock DESC
-- Question 17
SELECT * FROM Livres;
SELECT CategorieID, COUNT(CategorieID) AS [Nombre Livres] FROM Livres GROUP BY CategorieID HAVING COUNT(CategorieID) > 2;

-- Question 18

SELECT AuteurID, COUNT(AuteurID) AS NbLivres FROM Livres WHERE DatePublication >= '01-01-2020' GROUP BY AuteurID HAVING  COUNT(AuteurID) >= 3

-- Question 19
SELECT AVG(Prix) FROM Livres;
DECLARE @MOYENNPRIX DECIMAL(10, 2);
SET @MOYENNPRIX = (SELECT AVG(Prix) FROM Livres);
SELECT @MOYENNPRIX

SELECT * FROM Livres WHERE Prix > @MOYENNPRIX
SELECT * FROM Livres WHERE Prix > (SELECT AVG(Prix) FROM Livres)

-- Question 20
SELECT * FROM Livres order by CategorieID
SELECT CategorieID, AVG(Prix) FROM Livres GROUP BY CategorieID 
SELECT Titre, Prix FROM Livres L1 WHERE Prix > (SELECT AVG(Prix) FROM Livres L2 WHERE L1.CategorieID = L2.CategorieID )
-- Question 21
--21.	Affichez les noms des clients qui ont passé au moins une commande.
select * from commandes
SELECT Nom FROM Clients WHERE ClientID IN(SELECT clientID FROM Commandes GROUP BY ClientID HAVING COUNT(ClientID) >= 1)
SELECT clientID, COUNT(ClientID) AS NbCommandes FROM Commandes GROUP BY ClientID HAVING COUNT(ClientID) >= 1
SELECT nom FROM Clients C1 WHERE EXISTS( SELECT 1 FROM Commandes C2 WHERE C1.ClientID = C2.ClientID)

-- Question 22
--22.	À l'aide de NOT EXISTS, 
-- affichez le nom et le prénom des clients qui n'ont jamais passé de commande
select * from commandes order by ClientID
select * from clients
SELECT nom FROM Clients C1 WHERE NOT EXISTS( SELECT 1 FROM Commandes C2 WHERE C1.ClientID = C2.ClientID)
-- Question 23
--23.	Trouvez tous les livres dont le prix est supérieur au prix de TOUS les livres de la catégorie "Jeunesse" (CategorieID = 5).
SELECT * FROM Livres;
SELECT * FROM Categories;
SELECT Prix FROM Livres WHERE CategorieID = 5
SELECT * FROM Livres WHERE Prix > ALL(SELECT Prix FROM Livres WHERE CategorieID = 5);
-- Question 24
SELECT Titre, Prix, 
		abs(
			CAST( 
			ROUND( 
				Prix - (SELECT AVG(Prix) FROM Livres) , 
				2
				) AS DECIMAL(10,2)
			) AS EcartMoyenne 
		)

		------???
FROM Livres
-- Question 25
SELECT * FROM Commandes

SELECT Titre AS 'Description', Prix Montant FROM Livres 
UNION
SELECT 'Commnade #'+ CAST(CommandeID  AS VARCHAR) AS 'Description', MontantTotal Montant FROM Commandes ORDER BY Montant DESC
