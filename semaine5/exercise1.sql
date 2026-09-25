USE AgregationDonnes;
GO

DROP TABLE IF EXISTS eleves;

CREATE TABLE eleves_exercise1 (
    id INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    sexe char(1) CHECK(sexe IN ('F','M')),
    programme VARCHAR(100),
    noteExamen1 DECIMAL(5, 2),
    noteExamen2 DECIMAL(5, 2)
   
);

INSERT INTO eleves_exercise1 (id, nom, sexe, programme, noteExamen1, noteExamen2) 
VALUES 
    (1, 'Alice Dupont', 'F', 'Informatique', 66.5, 80.5),
    (2, 'Bob Martin', 'M', 'Génie électrique', 55.0, 73.0),
    (3, 'Claire Lemaire', 'F', 'Multimedia', 86.0, 78.5),
    (4, 'David Durand', 'M', 'Informatique', 92.0, 83.5),
    (5, 'Eva Lambert', 'F', 'Informatique', 68.5, 84.0),
    (6, 'Annie Leroy', 'F', 'Multimedia', 90.0, 87.5),
    (7, 'Valdislav Koval', 'M', 'Informatique', 84.5, 87.0),
    (8, 'Niko Petra', 'F', 'Informatique', 73.0, 71.0);