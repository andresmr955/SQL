CREATE DATABASE SOUSREQUETES;
USE SOUSREQUETES;

CREATE TABLE Employes(
	id INT PRIMARY KEY,
	nom NVARCHAR(50),
	prenom NVARCHAR(50),
	salaire DECIMAL(10,2),
	departement NVARCHAR(50),
	ville NVARCHAR(50)
)

CREATE TABLE Produits(
	id INT PRIMARY KEY,
	nom_du_produit NVARCHAR(50),
	prix DECIMAL (10, 2),
	categorie NVARCHAR(50),
	quantite INT
)

INSERT INTO Employes VALUES 
(1, 'Dupont', 'Marie', 3500.00, 'Informatique', 'Montréal'),
(2, 'Martin', 'Pierre', 2800.00, 'Marketing', 'Québec'),
(3, 'Bernard', 'Sophie', 4200.00, 'Informatique', 'Montréal'),
(4, 'Dubois', 'Luc', 2500.00, 'Ventes', 'Sherbrooke'),
(5, 'Lambert', 'Julie', 3800.00, 'Informatique', 'Québec'),
(6, 'Moreau', 'Thomas', 2600.00, 'Marketing', 'Montréal'),
(7, 'Laurent', 'Emma', 3000.00, 'Ventes', 'Québec'),
(8, 'Simon', 'Paul', 4500.00, 'Direction', 'Montréal');

INSERT INTO Produits VALUES 
(101, 'Ordinateur Portable', 899.99, 'Électronique', 15),
(102, 'Souris Sans Fil', 25.50, 'Accessoires', 50),
(103, 'Clavier Mécanique', 75.00, 'Accessoires', 30),
(104, 'Écran 24 pouces', 199.99, 'Électronique', 20),
(105, 'Casque Audio', 120.00, 'Audio', 25),
(106, 'Webcam HD', 65.00, 'Accessoires', 18),
(107, 'Tablette', 350.00, 'Électronique', 12),
(108, 'Enceinte Bluetooth', 80.00, 'Audio', 40);

SELECT * FROM Employes;
SELECT * FROM Produits;



-- EXERCICE 1 : Sous-requête simple dans WHERE
-- Trouvez tous les employés qui gagnent plus que le salaire moyen
-- Votre requête ici :
SELECT * FROM Employes;

DECLARE @moyenSalaire DECIMAL(10,2)
SET @moyenSalaire = (SELECT AVG(salaire) FROM Employes);
SELECT @moyenSalaire  salaireMoyen

SELECT * FROM Employes WHERE salaire > @moyenSalaire;

-- EXERCICE 2 : Sous-requête avec IN
-- Trouvez tous les employés qui travaillent dans le même département que 'Dupont'
-- Votre requête ici :

SELECT * FROM Employes;
DECLARE @dupontDepartement NVARCHAR(50)
SET @dupontDepartement = (SELECT departement FROM Employes WHERE nom = 'Dupont');
SELECT * FROM Employes WHERE departement = @dupontDepartement AND nom != 'Dupont';


-- EXERCICE 3 : Sous-requête avec NOT IN
-- Trouvez les produits dont le prix est différent de tous les prix de la catégorie 'Audio'
-- Votre requête ici :

DECLARE @prix_in_audio TABLE(prix DECIMAL(10,2));
INSERT INTO @prix_in_audio SELECT prix FROM Produits WHERE categorie = 'Audio';
SELECT * FROM Produits WHERE prix NOT IN(SELECT prix FROM @prix_in_audio);
SELECT * FROM Produits WHERE prix NOT IN(SELECT prix FROM Produits WHERE categorie = 'Audio');

-- EXERCICE 4 : Sous-requête avec ANY
-- Trouvez les employés qui gagnent plus qu'au moins un employé du département 'Ventes'
-- Votre requête ici :
--RS-1//
DECLARE @employes_vents_salaire TABLE(prix DECIMAL(10, 2));
INSERT INTO @employes_vents_salaire SELECT salaire FROM Employes WHERE departement = 'ventes';
SELECT * FROM Employes WHERE salaire  = ANY(SELECT * FROM @employes_vents_salaire);
--RS-2//
SELECT * FROM Employes WHERE salaire = ANY(SELECT salaire FROM Employes WHERE departement = 'ventes'); 
SELECT salaire FROM Employes WHERE departement = 'ventes'


-- EXERCICE 5 : Sous-requête avec ALL
-- Trouvez les produits dont le prix est supérieur à TOUS les prix des produits 'Accessoires'
-- Votre requête ici :
 SELECT * FROM Produits
 --RS-1//

DECLARE @prix_accesoires TABLE(
prix DECIMAL(10, 2))

INSERT INTO @prix_accesoires SELECT prix FROM Produits WHERE categorie = 'Accessoires';
SELECT * FROM Produits WHERE prix > ALL(SELECT prix FROM @prix_accesoires)
--RS-2//

SELECT * FROM Produits WHERE prix > ALL (SELECT prix FROM Produits WHERE categorie = 'Accessoires');

-- EXERCICE 6 : Sous-requête avec EXISTS
-- Trouvez les villes où il existe au moins un employé gagnant plus de 3500
-- Votre requête ici :
SELECT * FROM Employes;
SELECT salaire FROM Employes WHERE salaire > 3500
SELECT DISTINCT ville FROM Employes C1 Where EXISTS(SELECT 1 FROM Employes C2 WHERE C2.salaire >3500 AND C2.ville = C1.ville)
SELECT  * FROM Employes C1 Where EXISTS(SELECT 1 FROM Employes C2 WHERE C2.salaire >3500)

-- EXERCICE 7 : Sous-requête avec NOT EXISTS
-- Trouvez les catégories de produits pour lesquelles il n'existe aucun produit avec un stock inférieur à 20
-- Votre requête ici :
SELECT * FROM Produits WHERE quantite < 20;

SELECT DISTINCT categorie FROM Produits P1 WHERE NOT EXISTS(SELECT 1 FROM Produits P2 WHERE P1.categorie = P2.categorie AND quantite < 20)


-- EXERCICE 8 : UNION
-- Créez une seule liste (une colonne Nom) qui contient :
-- - les noms des employés de Montréal
-- - les noms des produits de la catégorie 'Électronique'
-- Rappel : les deux SELECT d'un UNION doivent avoir le même nombre de colonnes
-- Votre requête ici :
SELECT nom as Nom FROM Employes WHERE ville = 'Montréal' UNION SELECT nom_du_produit FROM Produits WHERE categorie = 'Électronique'


-- EXERCICE 9 : Sous-requête dans SELECT
-- Affichez chaque employé avec son salaire et l'écart par rapport au salaire maximum
-- Votre requête ici :
select MAX(salaire) from Employes
SELECT  nom, salaire, (select MAX(salaire) from Employes) - salaire as ecart FROM Employes 



-- EXERCICE 10 : Combinaison complexe
-- Trouvez les employés qui gagnent plus que la moyenne ET qui travaillent 
-- dans une ville où il existe des employés du département 'Informatique'
-- Votre requête ici :

SELECT * FROM Employes
SELECT * FROM Employes WHERE salaire > (SELECT AVG(salaire) FROM Employes) AND ville IN (SELECT ville FROM Employes WHERE departement = 'Informatique')