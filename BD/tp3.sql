// I) Les tables imbriquÃ©es
//Exercice 1

//CREATE OR REPLACE TYPE Tel AS TABLE OF number(10) NULL;

CREATE TABLE Enseignant (
    ide INTEGER PRIMARY KEY,
    nome VARCHAR(255),
    ltel Tel
) NESTED TABLE ltel STORE AS t1;


INSERT INTO Enseignant (ide, nome, ltel) VALUES (1, 'Jean', Tel(1234567890));
INSERT INTO Enseignant (ide, nome, ltel) VALUES (2, 'Marie', Tel(9876543210, 1234567890, 5555555555));
INSERT INTO Enseignant (ide, nome, ltel) VALUES (3, 'Pauline', Tel());
INSERT INTO Enseignant (ide, nome, ltel) VALUES (4, 'Thomas', Tel(1111111111, 2222222222));
INSERT INTO Enseignant (ide, nome, ltel) VALUES (5, 'Sophie', Tel(9999999999));
INSERT INTO Enseignant (ide, nome, ltel) VALUES (6, 'Nicolas', Tel(7777777777));

SELECT * FROM Enseignant;

SELECT ltel FROM Enseignant WHERE nome = 'Thomas';

SELECT e.nome, COUNT(*) from Enseignant e,TABLE(e.ltel) GROUP BY e.nome;

SELECT COUNT(*) AS nombre_enseignants
FROM Enseignant
WHERE (SELECT COUNT(*) FROM TABLE(ltel)) = 3;

SELECT nome
FROM Enseignant
WHERE (SELECT COUNT(*) FROM TABLE(ltel)) = 0;


// Exercice 2

/*CREATE OR REPLACE TYPE Module AS OBJECT (
    idm NUMBER(10),
    nomm VARCHAR2(255)
);*/

//CREATE OR REPLACE TYPE Module_Table AS TABLE OF Module;

DROP TABLE Enseignant;

CREATE TABLE Enseignant (
    ide INTEGER PRIMARY KEY,
    nome VARCHAR2(255),
    ltel Tel,
    modules Module_Table
) NESTED TABLE ltel STORE AS t1 NESTED TABLE modules STORE AS t2;

INSERT INTO Enseignant VALUES (1, 'Martin', Tel(1234567890), Module_Table(Module(1, 'Système')));
INSERT INTO Enseignant VALUES (2, 'Sophie', Tel(9876543210), NULL);
INSERT INTO Enseignant VALUES (3, 'Dupond', Tel(5555555555), NULL);
INSERT INTO Enseignant VALUES (4, 'Antoine', Tel(1111111111), Module_Table(Module(2, 'Base de données')));

SELECT * FROM Enseignant;

UPDATE Enseignant
SET modules = NULL
WHERE nome = 'Martin';
-- Output: La responsabilité du module système pour Martin a été abandonnée.


-- Supposons que Sophie a pris la responsabilité du module système et Dupond du module base de données
UPDATE Enseignant
SET modules = Module_Table(Module(1, 'Système'))
WHERE nome = 'Sophie';

UPDATE Enseignant
SET modules = Module_Table(Module(2, 'Base de données'))
WHERE nome = 'Dupond';
-- Output: Les responsabilités des modules ont été mises à jour pour Sophie et Dupond.

UPDATE Enseignant
SET modules = Module_Table(Module(3, 'Gestion'))
WHERE nome = 'Antoine';
-- Output: La responsabilité du module gestion pour Antoine a été mise à jour.


SELECT modules
FROM Enseignant
WHERE nome = 'Martin' AND modules IS NOT NULL;
-- Output: Martin n'est responsable d'aucun module après la mise à jour.

SELECT ltel
FROM Enseignant
WHERE nome = 'Martin';
-- Output: Les numéros de téléphone de Martin.

SELECT e.ltel
FROM Enseignant e
WHERE EXISTS (
    SELECT *
    FROM TABLE(e.modules) m
    WHERE m.nomm = 'Système'
);
-- Output: Les numéros de téléphone du responsable du module système.


SELECT nome
FROM Enseignant
WHERE (SELECT COUNT(*) FROM TABLE(modules)) = 1;
-- Output: Les enseignants responsables d'un seul module.


/*CREATE OR REPLACE TYPE Ordinateur AS OBJECT (
    ido NUMBER(10),
    se VARCHAR2(255)
);*/
//CREATE OR REPLACE TYPE Ordinateur_Table AS TABLE OF Ordinateur;


DROP TABLE Enseignant;

-- Créer une nouvelle table Enseignant avec une colonne de type Ordinateur
CREATE TABLE Enseignant (
    ide INTEGER PRIMARY KEY,
    nome VARCHAR2(255),
    ltel Tel,
    modules Module_Table,
    ordinateur Ordinateur_Table
) NESTED TABLE ltel STORE AS t1 NESTED TABLE modules STORE AS t2 NESTED TABLE ordinateur STORE AS t3;

SELECT * from Enseignant;

INSERT INTO Enseignant VALUES (1, 'Martin', Tel(1234567890), Module_Table(Module(1, 'Système')), Ordinateur_Table(Ordinateur(101, 'Windows')));
INSERT INTO Enseignant VALUES (2, 'Sophie', Tel(9876543210), Module_Table(Module(2, 'Base de données')), Ordinateur_Table(Ordinateur(102, 'Linux')));
INSERT INTO Enseignant VALUES (3, 'Dupond', Tel(5555555555), Module_Table(Module(3, 'Réseaux')), Ordinateur_Table(Ordinateur(103, 'Windows')));

SELECT e.nome, o.se AS systeme_exploitation, e.ltel
FROM Enseignant e,
     TABLE(e.ordinateur) o , TABLE(e.ltel) tel
WHERE e.nome = 'Martin';

SELECT e.nome
FROM Enseignant e
WHERE EXISTS (
    SELECT *
    FROM TABLE(e.ordinateur) o
    WHERE o.se = 'Windows'
) AND e.modules IS NOT NULL;

SELECT COUNT(*) AS nombre_enseignants_windows
FROM Enseignant e
WHERE EXISTS (
    SELECT 1
    FROM TABLE(e.ordinateur) o
    WHERE o.se = 'Windows'
);

SELECT * FROM Enseignant;



drop table Etablissement;
CREATE TABLE Etablissement (
    num INTEGER PRIMARY KEY,
    ville VARCHAR2(255) NOT NULL
);

drop type Intervention;
drop type Intervention_Table
/*CREATE OR REPLACE TYPE Intervention AS OBJECT (
    idi INTEGER,
    etablissement INTEGER,
    duree NUMBER(10)
);*/
//CREATE OR REPLACE TYPE Intervention_Table AS TABLE OF Intervention;


DROP TABLE Enseignant;
CREATE TABLE Enseignant (
    ide INTEGER PRIMARY KEY,
    nome VARCHAR2(255),
    ltel Tel,
    modules Module_Table,
    ordinateur Ordinateur_Table,
    intervention Intervention_Table
) NESTED TABLE ltel STORE AS t1 NESTED TABLE modules STORE AS t2 NESTED TABLE ordinateur STORE AS t3 NESTED TABLE intervention STORE AS t4;

-- Insérer des tuples dans la table Etablissement
INSERT INTO Etablissement VALUES (1, 'Paris');
INSERT INTO Etablissement VALUES (2, 'Lyon');

-- Insérer des tuples dans la table Enseignant
INSERT INTO Enseignant VALUES (
    1,
    'Martin',
    Tel(1234567890),
    Module_Table(Module(1, 'Système')),
    Ordinateur_Table(Ordinateur(101, 'Windows')),
    Intervention_Table(Intervention(1, 1, 20))
);

INSERT INTO Enseignant VALUES (
    2,
    'Sophie',
    Tel(9876543210),
    Module_Table(Module(2, 'Base de données')),
    Ordinateur_Table(Ordinateur(102, 'Linux')),
    Intervention_Table(Intervention(2, 2, 25))
);

INSERT INTO Enseignant VALUES (
    3,
    'Dupond',
    Tel(5555555555),
    Module_Table(Module(3, 'Réseaux')),
    Ordinateur_Table(Ordinateur(103, 'Windows')),
    Intervention_Table(Intervention(3, 1, 30), Intervention(4, 2, 15))
);

SELECT * FROM Enseignant;
SELECT * FROM Etablissement;

SELECT e.nome, o.se
FROM Enseignant e,
Table(e.ordinateur) o,
Table(e.intervention) i
WHERE i.duree > 25;

SELECT e.ltel
FROM Enseignant e,
Table(e.intervention) i,
Table(e.modules) m,
Etablissement et
WHERE i.etablissement = et.num AND m.nomm = 'Base de données' AND et.ville = 'Paris';

SELECT et.num AS numero_etablissement, COUNT(DISTINCT e.nome) AS nombre_enseignants
FROM Enseignant e,
Table(e.intervention) i,
Table(i.etablissement) et
GROUP BY et.num;

SELECT e.nome, et.ville, i.duree
FROM Enseignant e,Etablissement et,
Table(e.intervention) i
where et.num = i.etablissement;

