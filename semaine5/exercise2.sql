USE AgregationDonnes;
GO

DROP TABLE IF EXISTS Ventes;
CREATE TABLE Ventes (
    id INT PRIMARY KEY,
    date_vente DATETIME NOT NULL,
    produit VARCHAR(50) NOT NULL,
    categorie VARCHAR(30) NOT NULL,
    quantite INT NOT NULL,
    prix_unitaire DECIMAL(6,2) NOT NULL,
    rabais DECIMAL(6,2) NULL,
    mode_paiement VARCHAR(10) NOT NULL
);
INSERT INTO Ventes VALUES
(1,  '2026-09-21 07:45', 'Café',    'Boisson',   1, 2.25, NULL, 'Carte'),
(2,  '2026-09-21 07:52', 'Muffin',  'Collation', 2, 3.00, NULL, 'Comptant'),
(3,  '2026-09-21 08:10', 'Café',    'Boisson',   3, 2.25, 0.50, 'Carte'),
(4,  '2026-09-21 11:35', 'Pizza',   'Repas',     1, 6.50, NULL, 'Carte'),
(5,  '2026-09-21 11:40', 'Wrap',    'Repas',     2, 7.25, 1.00, 'Carte'),
(6,  '2026-09-21 11:58', 'Jus',     'Boisson',   1, 2.75, NULL, 'Comptant'),
(7,  '2026-09-21 12:05', 'Pizza',   'Repas',     3, 6.50, NULL, 'Carte'),
(8,  '2026-09-21 12:20', 'Biscuit', 'Collation', 4, 1.50, NULL, 'Comptant'),
(9,  '2026-09-21 15:30', 'Café',    'Boisson',   1, 2.25, NULL, 'Carte'),
(10, '2026-09-22 07:50', 'Café',    'Boisson',   2, 2.25, NULL, 'Carte'),
(11, '2026-09-22 08:05', 'Muffin',  'Collation', 1, 3.00, 0.50, 'Carte'),
(12, '2026-09-22 11:45', 'Wrap',    'Repas',     1, 7.25, NULL, 'Comptant'),
(13, '2026-09-22 12:00', 'Pizza',   'Repas',     2, 6.50, 1.00, 'Carte'),
(14, '2026-09-22 12:10', 'Jus',     'Boisson',   2, 2.75, NULL, 'Carte'),
(15, '2026-09-22 12:15', 'Soupe',   'Repas',     1, 4.50, NULL, 'Comptant'),
(16, '2026-09-22 15:40', 'Biscuit', 'Collation', 3, 1.50, NULL, 'Carte');



--Partie C : WHERE, GROUP BY et HAVING ensemble
-- Dans la catégorie Repas seulement, affichez les produits 
-- dont la quantité totale vendue est d'au moins 3.

SELECT categorie, produit, sum(quantite) AS 'Quantite'
FROM ventes
WHERE categorie = 'repas'
GROUP BY categorie, produit
HAVING SUM(quantite) >= 3

--Partie D : Déboguer
--Chaque requête produit une erreur. Expliquez pourquoi, puis corrigez-la.
-- 1 .
--La clause GROUP BY devrait contenir categorie et produit car ces 2 colonnes apparaissent dnas la clause select
SELECT categorie, produit, SUM(quantite) 
FROM Ventes 
GROUP BY categorie, produit;


SELECT * FROM Ventes;
SELECT DATEPART(hour, date_vente) AS heure, COUNT(*) 
FROM Ventes 
GROUP BY DATEPART(hour, date_vente)





