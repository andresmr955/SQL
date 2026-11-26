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
-- Question 5 
-- Question 6 
-- Question 7 
-- Question 8 

