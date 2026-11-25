--DROP TABLE IF EXISTS Ventes;
--DROP TABLE IF EXISTS Regions;
--GO

USE SOUSREQUETES02

CREATE TABLE Ventes (
    id INT PRIMARY KEY,
    vendeur VARCHAR(50),
    region VARCHAR(50),
    produit VARCHAR(50),
    montant DECIMAL(10,2),
    date_vente DATE
);

CREATE TABLE Regions (
    nom_region VARCHAR(50) PRIMARY KEY,
    directeur VARCHAR(100),
    objectif DECIMAL(10,2)
);

INSERT INTO Ventes VALUES
(1,  'Tremblay',  'Montréal',  'Portable', 1200.00, '2026-01-15'),
(2,  'Tremblay',  'Montréal',  'Souris',     40.00, '2026-01-20'),
(3,  'Gagnon',    'Montréal',  'Écran',     350.00, '2026-02-03'),
(4,  'Gagnon',    'Montréal',  'Portable', 1100.00, '2026-02-10'),
(5,  'Roy',       'Laval',     'Clavier',    80.00, '2026-01-12'),
(6,  'Roy',       'Laval',     'Portable', 1300.00, '2026-03-05'),
(7,  'Côté',      'Laval',     'Écran',     400.00, '2026-02-18'),
(8,  'Bouchard',  'Québec',    'Tablette',  600.00, '2026-01-25'),
(9,  'Bouchard',  'Québec',    'Souris',     35.00, '2026-03-01'),
(10, 'Lavoie',    'Québec',    'Portable', 1250.00, '2026-03-12'),
(11, 'Fortin',    'Gatineau',  'Écran',     380.00, '2026-02-22'),
(12, 'Fortin',    'Gatineau',  'Clavier',    75.00, '2026-03-15'),
(13, 'Morin',     'Longueuil', 'Tablette',  550.00, '2026-02-05'),
(14, 'Morin',     'Longueuil', 'Portable', 1150.00, '2026-03-20'),
(15, 'Pelletier', NULL,        'Souris',     45.00, '2026-03-25'),
(16, 'Pelletier', NULL,        'Clavier',    90.00, '2026-03-28');

INSERT INTO Regions VALUES
('Montréal',   'Julie Lefebvre', 3000.00),
('Laval',      'Marc Girard',    1500.00),
('Québec',     'Nathalie Caron', 2500.00),
('Gatineau',   'Éric Ouellet',    400.00),
('Sherbrooke', 'Sylvie Poirier', 1500.00);




--Q1 : Sous-requête corrélée dans WHERE
--Trouvez les ventes dont le montant est supérieur au montant moyen des ventes de leur propre région.
SELECT * FROM Ventes
SELECT * FROM Ventes WHERE region = 'Montréal';
SELECT AVG(montant) FROM Ventes WHERE region = 'Montréal';


SELECT * FROM Ventes V1 WHERE montant > (SELECT AVG(montant)FROM Ventes V2 WHERE V1.region = V2.region);

--Q2 : Maximum par groupe
--Pour chaque vendeur, affichez sa plus grosse vente (id, vendeur, produit, montant).
SELECT * FROM Ventes
SELECT MAX(montant) FROM Ventes WHERE nom_vendeur = 'Tremblay'
SELECT id, nom_vendeur, nom_produit, montant FROM Ventes V1 WHERE V1.Montant = (SELECT MAX(montant) FROM Ventes V2 WHERE V1.nom_vendeur = V2.nom_vendeur);

--Q3 : Le piège de NOT IN
--a) Avec NOT IN, trouvez les régions de la table Regions où aucune vente n'a été faite.
SELECT * FROM Regions
SELECT nom_region FROM Regions WHERE nom_region IN (SELECT region FROM Ventes)
SELECT nom_region FROM Regions WHERE nom_region NOT IN (SELECT region FROM Ventes)

--b) Le résultat est-il celui que vous attendiez ? Expliquez-le.

-- Non, le resultat n'est pas celui que j'attandais parce que si j'utilis IN il me montre toutes les regions où les ventes sont faits
-- Par contre, quand j'ajout not in, il ne montre rien dû que dans la table ventes il y a nulls

--c) Corrigez la requête de deux façons : avec NOT EXISTS, puis en gardant NOT IN.

SELECT nom_region FROM Regions R WHERE NOT EXISTS(SELECT region FROM Ventes V WHERE R.nom_region = V.region)
--Erreur: SELECT nom_region FROM Regions R WHERE EXISTS(SELECT region FROM Ventes V WHERE R.nom_region NOT IN(V.region))
SELECT region FROM Ventes WHERE  region is not null
SELECT nom_region FROM Regions WHERE nom_region NOT IN(SELECT region FROM Ventes WHERE region IS NOT NULL)
--Q4 : Sous-requête corrélée dans SELECT
--Affichez chaque vente (id, vendeur, region, montant) avec l'objectif de sa région. Pourquoi certaines lignes ont-elles un objectif NULL ?

--Q5 : Sous-requête corrélée avec SUM
--Trouvez les régions dont le total des ventes dépasse l'objectif. Affichez le nom de la région, son objectif et son total des ventes.


--Q6 : NOT EXISTS et NULL, dans l'autre sens
--a) Avec NOT EXISTS, trouvez les ventes (id, vendeur, region) faites dans une région qui n'existe pas dans la table Regions.

--b) Le résultat contient des lignes inattendues. Lesquelles, et pourquoi ?

--c) Corrigez la requête.
