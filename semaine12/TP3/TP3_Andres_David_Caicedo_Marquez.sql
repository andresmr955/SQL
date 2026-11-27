-- Nom de l'étudiant : Andres David Caicedo Marquez
-- Cours : 420-2C5 Groupe 01
-- Session : Automne 2026 
-- TP3 - Jointures, Vues et Modificati

--SECTION A
-- Question 1 
INSERT INTO Cours VALUES (11, 'Cardio Boxing', 'Michel Pelletier', 'Mardi 20h00',20, 'Studio B', 'Cardio')

-- Question 2 

INSERT INTO Participations VALUES (19, 11, 11, '2024-06-04', 'Oui'),
		(20, 12, 10, '2024-06-06', 'Non'),
		(21, 7, 3, '2024-06-06', 'Non')

-- Question 3
UPDATE Cours
SET Capacite = Capacite + 5 
WHERE Salle = 'Studio A'

-- Question 4 
UPDATE Inscriptions
SET StatutPaiement = 'Payé'
WHERE StatutPaiement = 'En attente'

-- Question 5 
UPDATE Membres 
SET Statut = 'Inactif'
WHERE NOT EXISTS (SELECT 1 FROM Inscriptions I WHERE Membres.MembreID = I.MembreID)

-- Question 6 
--LAGUNA
ALTER TABLE INSCRIPTIONS ADD NbRenouvellements INT DEFAULT 0;

-- Question 7
--LAGUNA
ALTER TABLE Participations ADD CONSTRAINT CK_Participations_Present CHECK(Present IN ('Oui' , 'Non'))

-- Question 8 
DELETE FROM Participations
WHERE Present = 'Non'

-- SECTION B JOINTURES
-- Question 9
SELECT M.Nom +  ' '+  M.prenom NomComplet,  M.Ville, A.TypeAbonnement, I.DateDebut
FROM Membres M
INNER JOIN Inscriptions I
	ON M.MembreID = I.MembreID
INNER JOIN Abonnements A
	ON A.AbonnementID = I.AbonnementID
ORDER BY NomComplet, I.DateDebut
-- Question 10 
SELECT M.Nom,  M.prenom, C.NomCours, P.DateParticipation
FROM Cours C
INNER JOIN Participations P
	ON C.CoursID = P.CoursID 
INNER JOIN Membres M
	ON P.MembreId = M.MembreID
ORDER BY M.Nom, P.DateParticipation


-- Question 11 
--LAGUNA
SELECT 
	A.TypeAbonnement, 
	COUNT(I.InscriptionID) AS NombreInscriptions, 
	(
		SELECT SUM(A2.Prix)
		FROM Inscriptions I2
		INNER JOIN Abonnements A2
			ON I2.AbonnementID = A2.AbonnementID
		WHERE A2.AbonnementID = A.AbonnementID
	) AS RevenuTotal
FROM Abonnements A
LEFT JOIN Inscriptions I
	ON A.AbonnementID = I.AbonnementID
GROUP BY A.TypeAbonnement, A.AbonnementID
ORDER BY RevenuTotal DESC


-- Question 12 

SELECT A.TypeAbonnement, A.Prix, I.Montant
FROM Abonnements A
LEFT JOIN Inscriptions I
	ON A.AbonnementID = I.AbonnementID

SELECT A.TypeAbonnement, A.Prix, I.Montant
FROM Abonnements A
LEFT JOIN Inscriptions I
	ON A.AbonnementID = I.AbonnementID AND I.StatutPaiement = 'Payé'
ORDER BY  A.TypeAbonnement
-- Question 13

SELECT M.Nom, M.Prenom, M.DateInscription
FROM Membres M
LEFT JOIN Inscriptions I
	ON M.MembreID = I.MembreID 
WHERE I.InscriptionId IS NULL
ORDER BY M.Nom

-- Question 14
SELECT M.Nom, M.Prenom, A.TypeAbonnement, A.DureeJours, A.Prix, I.Montant, (A.Prix - I.Montant) AS Rabais
FROM Membres M
INNER JOIN Inscriptions I
	ON M.MembreID = I.MembreID
INNER JOIN Abonnements A
	ON I.AbonnementID = A.AbonnementID
ORDER BY Rabais DESC