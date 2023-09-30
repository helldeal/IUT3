// I) Les tables imbriquées
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

INSERT INTO Enseignant VALUES (1, 'Martin', Tel(1234567890), Module_Table(Module(1, 'Syst�me')));
INSERT INTO Enseignant VALUES (2, 'Sophie', Tel(9876543210), NULL);
INSERT INTO Enseignant VALUES (3, 'Dupond', Tel(5555555555), NULL);
INSERT INTO Enseignant VALUES (4, 'Antoine', Tel(1111111111), Module_Table(Module(2, 'Base de donn�es')));

SELECT * FROM Enseignant;

UPDATE Enseignant
SET modules = NULL
WHERE nome = 'Martin';
-- Output: La responsabilit� du module syst�me pour Martin a �t� abandonn�e.


-- Supposons que Sophie a pris la responsabilit� du module syst�me et Dupond du module base de donn�es
UPDATE Enseignant
SET modules = Module_Table(Module(1, 'Syst�me'))
WHERE nome = 'Sophie';

UPDATE Enseignant
SET modules = Module_Table(Module(2, 'Base de donn�es'))
WHERE nome = 'Dupond';
-- Output: Les responsabilit�s des modules ont �t� mises � jour pour Sophie et Dupond.

UPDATE Enseignant
SET modules = Module_Table(Module(3, 'Gestion'))
WHERE nome = 'Antoine';
-- Output: La responsabilit� du module gestion pour Antoine a �t� mise � jour.


SELECT modules
FROM Enseignant
WHERE nome = 'Martin' AND modules IS NOT NULL;
-- Output: Martin n'est responsable d'aucun module apr�s la mise � jour.

SELECT ltel
FROM Enseignant
WHERE nome = 'Martin';
-- Output: Les num�ros de t�l�phone de Martin.

SELECT e.ltel
FROM Enseignant e
WHERE EXISTS (
    SELECT *
    FROM TABLE(e.modules) m
    WHERE m.nomm = 'Syst�me'
);
-- Output: Les num�ros de t�l�phone du responsable du module syst�me.


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

-- Cr�er une nouvelle table Enseignant avec une colonne de type Ordinateur
CREATE TABLE Enseignant (
    ide INTEGER PRIMARY KEY,
    nome VARCHAR2(255),
    ltel Tel,
    modules Module_Table,
    ordinateur Ordinateur_Table
) NESTED TABLE ltel STORE AS t1 NESTED TABLE modules STORE AS t2 NESTED TABLE ordinateur STORE AS t3;

SELECT * from Enseignant;

INSERT INTO Enseignant VALUES (1, 'Martin', Tel(1234567890), Module_Table(Module(1, 'Syst�me')), Ordinateur_Table(Ordinateur(101, 'Windows')));
INSERT INTO Enseignant VALUES (2, 'Sophie', Tel(9876543210), Module_Table(Module(2, 'Base de donn�es')), Ordinateur_Table(Ordinateur(102, 'Linux')));
INSERT INTO Enseignant VALUES (3, 'Dupond', Tel(5555555555), Module_Table(Module(3, 'R�seaux')), Ordinateur_Table(Ordinateur(103, 'Windows')));


SELECT e.nome, e.ordinateur.se AS systeme_exploitation, e.ltel
FROM Enseignant e
WHERE e.nome = 'Martin';
-- Output : nome      | systeme_exploitation | ltel
--           --------- | -------------------- | ----------
--           Martin    | Windows              | 1234567890



SELECT e.nome, e.modules.nomm
FROM Enseignant e
WHERE e.ordinateur.se = 'Windows' AND e.modules IS NOT NULL;
-- Output : nome      | nomm
--           --------- | ---------
--           Martin    | Syst�me
--           Dupond    | R�seaux



SELECT COUNT(*) AS nombre_enseignants_windows
FROM Enseignant e
WHERE EXISTS (
    SELECT 1
    FROM TABLE(e.ordinateur) o
    WHERE o.se = 'Windows'
);
-- Output : nombre_enseignants_windows
--           -------------------------
--           2

SELECT * FROM Enseignant;
-- Output : ide | nome    | ltel          | modules                     | ordinateur
--           --- | ------- | ------------- | --------------------------- | -----------------------
--            1  | Martin  | 1234567890    | Module_Table(Module(1, 'Syst�me')) | Ordinateur_Table(Ordinateur(101, 'Windows'))
--            2  | Sophie  | 9876543210    | Module_Table(Module(2, 'Base de donn�es')) | Ordinateur_Table(Ordinateur(102, 'Linux'))
--            3  | Dupond  | 5555555555    | Module_Table(Module(3, 'R�seaux')) | Ordinateur_Table(Ordinateur(103, 'Windows'))
-- Add other rows as needed







