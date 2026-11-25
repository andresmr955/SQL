--DROP TABLE IF EXISTS Ventes;
--DROP TABLE IF EXISTS Regions;
--GO
CREATE DATABASE SOUSREQUETES02
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


--Q2 : Maximum par groupe
--Pour chaque vendeur, affichez sa plus grosse vente (id, vendeur, produit, montant).
select * from ventes v1 WHERE montant = (select max(montant) from ventes v2 where v1.vendeur = v2.vendeur

--Q3 : Le piège de NOT IN
--a) Avec NOT IN, trouvez les régions de la table Regions où aucune vente n'a été faite.

select *
from Regions 
where nom_region not in(select distinct region from ventes)
select * from regions
select distinct region from ventes

select distinct region from ventes WHERE region IS NOT NULL
SELECT * FROM Regions Where nom_region not in(select distinct region from ventes WHERE region IS NOT NULL)
select * from regions R WHERE NOT EXISTS(SELECT DISTINCT region FROM Ventes V WHERE R.nom_region = V.region)
select * from regions R WHERE NOT EXISTS(SELECT region FROM Ventes V WHERE R.nom_region = V.region)

SELECT region FROM Ventes V1 WHERE EXISTS(SELECT nom_region FROM Regions R WHERE V1.region = R.nom_region)
SELECT region FROM Ventes V1 WHERE EXISTS(SELECT nom_region FROM Regions R WHERE V1.region != R.nom_region)
SELECT region FROM Ventes V1 WHERE EXISTS(SELECT nom_region FROM Regions R WHERE V1.region NOT IN (R.nom_region))
select * from regions R WHERE EXISTS(SELECT region FROM Ventes V WHERE R.nom_region = V.region)

--b) Le résultat est-il celui que vous attendiez ? Expliquez-le.
--c) Corrigez la requête de deux façons : avec NOT EXISTS, puis en gardant NOT IN.


--Q4 : Sous-requête corrélée dans SELECT
--Affichez chaque vente (id, vendeur, region, montant) avec l'objectif de sa région.
SELECT objectif FROM Regions WHERE nom_region = 'Montréal'
SELECT objectif FROM Regions R WHERE V.region = R.nom_region
SELECT * FROM Regions
SELECT id, vendeur, region, montant, (SELECT objectif FROM Regions R WHERE V.region = R.nom_region) AS Objectif FROM Ventes V
-- Pourquoi certaines lignes ont-elles un objectif NULL ?
-- Parce que la region de la table ventes n'existe dans la table Regions

--Q5 : Sous-requête corrélée avec SUM
--Trouvez les régions dont le total des ventes dépasse l'objectif. Affichez le nom de la région, son objectif et son total des ventes.
SELECT objectif FROM Regions R WHERE nom_region = 'Laval'
SELECT region, montant FROM Ventes V WHERE  'Laval' = V.region
SELECT SUM(montant) FROM Ventes V WHERE  'Laval' = V.region

SELECT nom_region FROM Regions R WHERE Objectif < (SELECT SUM(montant) FROM Ventes V WHERE  R.nom_region = V.region )
--Q6 : NOT EXISTS et NULL, dans l'autre sens
--a) Avec NOT EXISTS, trouvez les ventes (id, vendeur, region) faites dans une région qui n'existe pas dans la table Regions.
SELECT id, vendeur, region FROM Ventes WHERE region NOT IN(SELECT nom_region FROM Regions)
SELECT id, vendeur, region FROM Ventes WHERE region NOT IN(SELECT nom_region FROM Regions) OR region IS NULL

-- j'ai fait celle-ci
SELECT id, vendeur, region FROM Ventes V1 WHERE NOT EXISTS(SELECT 1 FROM Regions R1 WHERE V1.region = R1.nom_region)

--Cette est mauvaise
SELECT id, vendeur, region FROM Ventes V1 WHERE V1.region IS NULL AND EXISTS(SELECT 1 FROM Regions R1 WHERE R1.nom_region IS NOT NULL)

-- Cette est fait par AI
SELECT id, vendeur, region
FROM Ventes V1
WHERE V1.region IS NULL
   OR NOT EXISTS (
       SELECT 1
       FROM Regions R1
       WHERE V1.region = R1.nom_region
   );


-- NE FONCTIONNE PAS
SELECT id, vendeur, region FROM Ventes V1 WHERE NOT EXISTS(SELECT 1 FROM Regions R1 WHERE V1.region = R1.nom_region AND V1.nom_region IS NULL) 

--b) Le résultat contient des lignes inattendues. Lesquelles, et pourquoi ?

--c) Corrigez la requête.