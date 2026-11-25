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
SELECT DISTINCT Ville FROM Clients ORDER BY Ville;
-- Question 7
SELECT TOP 5 * FROM Commandes ORDER BY DateCommande DESC;
-- Question 8
SELECT * FROM Livres WHERE LOWER(Titre) LIKE '%vie%';
-- Question 9
SELECT UPPER(Nom) AS NOM, LOWER(Prenom) as prenom FROM Auteurs;
-- Question 10
SELECT Nom, Prenom, DATEDIFF(year, DateNaissance, GETDATE())AS Age FROM Clients;
-- Question 11
SELECT AVG(prix) AS 'Prix moyenne' FROM Livres
-- Question 12
SELECT MAX(Prix) PrixPlusCher, MIN(Prix) PrixMoinsCher FROM Livres
-- Question 13
SELECT 
(	Select NomCategorie
	FROM Categories C1 
	WHERE C1.CategorieID = L1.CategorieID ) AS [NomCategorie], 
CategorieID, 
COUNT(*) AS 'Nombre de livres' 
FROM Livres  L1 
GROUP BY CategorieID 
ORDER BY 'Nombre de livres' DESC
-- Question 14
SELECT  CategorieID, 
CAST(ROUND(AVG(Prix), 2) AS DECIMAL(10,2)) as PrixMoyenneCategorieID 
FROM Livres 
GROUP BY CategorieID 
ORDER BY PrixMoyenneCategorieID DESC;
-- Question 15
SELECT ClientID, COUNT(ClientID) AS NombreCommandes FROM Commandes GROUP BY ClientID ORDER BY NombreCommandes DESC;
-- Question 16
SELECT TOP 3 CategorieID, SUM(Stock) AS TotalStock FROM Livres GROUP BY CategorieID ORDER BY TotalStock DESC
-- Question 17
SELECT CategorieID, COUNT(CategorieID) AS [Nombre Livres] FROM Livres GROUP BY CategorieID HAVING COUNT(CategorieID) > 2;
-- Question 18
SELECT AuteurID, COUNT(AuteurID) AS NbLivres FROM Livres WHERE DatePublication >= '01-01-2020' GROUP BY AuteurID HAVING COUNT(AuteurID) >= 3
-- Question 19
SELECT * FROM Livres WHERE Prix > (SELECT AVG(Prix) FROM Livres)
-- Question 20
SELECT Titre, Prix FROM Livres L1 WHERE Prix > (SELECT AVG(Prix) FROM Livres L2 WHERE L1.CategorieID = L2.CategorieID )
-- Question 21
SELECT Nom FROM Clients C1 WHERE EXISTS( SELECT 1 FROM Commandes C2 WHERE C1.ClientID = C2.ClientID)
-- Question 22
SELECT nom FROM Clients C1 WHERE NOT EXISTS( SELECT 1 FROM Commandes C2 WHERE C1.ClientID = C2.ClientID)


-- Question 23
--23.	Trouvez tous les livres dont le prix est supérieur au prix de TOUS les livres de la catégorie "Jeunesse" (CategorieID = 5).
SELECT * FROM Livres WHERE Prix > ALL(SELECT Prix FROM Livres WHERE CategorieID = 5);
-- Question 24
SELECT Titre, Prix, 
	CAST( 
		ROUND( 
			Prix - (SELECT AVG(Prix) FROM Livres) , 
			2
			) AS DECIMAL(10,2)
		) AS EcartMoyenne 
FROM Livres
-- Question 25
SELECT Titre AS 'Description', Prix Montant FROM Livres 
UNION
SELECT 'Commnade #'+ CAST(CommandeID  AS VARCHAR) AS 'Description', MontantTotal Montant FROM Commandes ORDER BY Montant DESC
