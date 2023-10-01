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


INSERT INTO Enseignant VALUES (
    4,
    'Alex',
    Tel(4566515458),
    Module_Table(Module(3, 'Base de données')),
    Ordinateur_Table(Ordinateur(103, 'Windows')),
    Intervention_Table(Intervention(5, 1, 20))
);

SELECT e.ltel
FROM Enseignant e,
Table(e.intervention) i,
Table(e.modules) m,
Etablissement et
WHERE i.etablissement = et.num AND m.nomm = 'Base de données' AND et.ville = 'Paris';

SELECT e.etablissement, COUNT(DISTINCT e.nome) AS nombre_enseignants
FROM (
    SELECT et.ville AS etablissement, e.nome
    FROM Enseignant e,
    TABLE(e.intervention) i,
    Etablissement et
    WHERE i.etablissement = et.num
) e
GROUP BY e.etablissement;

SELECT e.nome, et.ville, i.duree
FROM Enseignant e,Etablissement et,
Table(e.intervention) i
where et.num = i.etablissement;



--PART II

DROP TYPE Enseignant;
DROP TYPE Module;

//CREATE OR REPLACE TYPE Tel AS TABLE OF number(10) NULL;

/*CREATE OR REPLACE TYPE Module AS OBJECT (
    idm NUMBER(10),
    nomm VARCHAR2(255)
);*/

/*create or replace TYPE Enseignant AS OBJECT(
    ide NUMBER(10),
    nome VARCHAR2(255),
    ltel Tel,
    refmodule REF Module
);*/

drop table tModule;
CREATE TABLE tModule OF Module (
    idm PRIMARY KEY,
    nomm NOT NULL
);

drop table tTel;
CREATE TABLE tTel OF Tel;

drop table tEnseignant;
CREATE TABLE tEnseignant OF Enseignant(
    ide PRIMARY KEY,
    nome NOT NULL,
    refmodule SCOPE IS tModule
)NESTED TABLE ltel STORE AS tTel;

INSERT INTO tModule VALUES (1, 'Base de données');
INSERT INTO tModule VALUES (2, 'Système');
INSERT INTO tEnseignant VALUES (101, 'Martin', Tel(1234567890), (SELECT REF(m) FROM tModule m WHERE m.idm = 1));
INSERT INTO tEnseignant VALUES (102, 'Alice', Tel(9876543210), (SELECT REF(m) FROM tModule m WHERE m.idm = 2));

SELECT e.refmodule.nomm
FROM tEnseignant e
WHERE e.nome = 'Martin';

SELECT e.nome
FROM tEnseignant e
WHERE e.refmodule.nomm = 'Base de données';

SELECT e.refmodule.nomm, COUNT(e.ide) AS nombre_intervenants
FROM tEnseignant e
GROUP BY e.refmodule.nomm;

SELECT e.ltel
FROM tEnseignant e
WHERE e.refmodule.nomm = 'Système';

SELECT * FROM tModule;
SELECT * FROM tEnseignant;

DROP TYPE Personne;
DROP TYPE Adresse;

-- Creating the types
/*CREATE OR REPLACE TYPE Adresse AS OBJECT (
    no   NUMBER(10),
    rue VARCHAR2(255),
    ville VARCHAR2(255),
    MEMBER FUNCTION displayad RETURN varchar2,
    MEMBER FUNCTION getno RETURN number,
    MEMBER FUNCTION compareto(ad IN Adresse) RETURN number
);

CREATE OR REPLACE TYPE BODY Adresse AS
    MEMBER FUNCTION displayad RETURN varchar2 IS
    BEGIN
        RETURN no || ' ' || rue || ', ' || ville;
    END displayad;

    MEMBER FUNCTION getno RETURN number IS
    BEGIN
        RETURN no;
    END getno;

    MEMBER FUNCTION compareto(ad IN Adresse) RETURN number IS
    BEGIN
        IF no = ad.no AND rue = ad.rue AND ville = ad.ville THEN
            RETURN 0;
        ELSIF no > ad.no OR (no = ad.no AND rue > ad.rue) OR (no = ad.no AND rue = ad.rue AND ville > ad.ville) THEN
            RETURN 1;
        ELSE
            RETURN -1;
        END IF;
    END compareto;
END;

CREATE OR REPLACE TYPE Personne AS OBJECT(
    idp NUMBER(10),
    nomp VARCHAR2(255),
    age  NUMBER(10),
    refAdresse REF Adresse,
    MEMBER FUNCTION displayp RETURN varchar2,
    MEMBER FUNCTION getage RETURN number,
    MEMBER FUNCTION setage(a IN NUMBER) RETURN number
);

CREATE OR REPLACE TYPE BODY Personne AS
    MEMBER FUNCTION displayp RETURN varchar2 IS
    BEGIN
        RETURN idp || ': ' || nomp || ', ' || age || ' years old, Address: ' || refAdresse.displayad();
    END displayp;

    MEMBER FUNCTION getage RETURN number IS
    BEGIN
        RETURN age;
    END getage;

    MEMBER FUNCTION setage(a IN OUT NUMBER) RETURN number IS
    BEGIN
        age := a;
        RETURN age;
    END setage;
END;
*/
-- Creating tables
DROP TABLE tAdresse;
CREATE TABLE tAdresse OF Adresse (
    PRIMARY KEY(no,rue,ville)
);

DROP TABLE tPersonne;
CREATE TABLE tPersonne OF Personne(
    idp PRIMARY KEY,
    nomp NOT NULL,
    age NOT NULL,
    refAdresse SCOPE IS tAdresse
);



DECLARE
    myAddress Adresse := Adresse(123, 'Rue de la Paix', 'Paris');
    myPersonne Personne := Personne(1, 'John Doe', 25, myAddress);
BEGIN
    DBMS_OUTPUT.PUT_LINE(myPersonne.displayp);
END;
/

DECLARE
    -- Creating an instance of Personne
    dupont Personne := Personne(1, 'Dupont', 23, NULL);
BEGIN
    -- Displaying the initial state
    DBMS_OUTPUT.PUT_LINE('Before: ' || dupont.displayp);
    
    -- Updating the age
    dupont.setage(34);
    
    -- Displaying the updated state
    DBMS_OUTPUT.PUT_LINE('After: ' || dupont.displayp);
END;
/

DECLARE
    address1 Adresse := Adresse(101, 'Rue A', 'Ville A');
    address2 Adresse := Adresse(102, 'Rue B', 'Ville B');
    personne1 Personne := Personne(1, 'John Doe', 25, address1);
    personne2 Personne := Personne(2, 'Jane Doe', 30, address2);
BEGIN
    INSERT INTO tAdresse VALUES address1;
    INSERT INTO tAdresse VALUES address2;
    INSERT INTO tPersonne VALUES personne1;
    INSERT INTO tPersonne VALUES personne2;
    COMMIT;
END;
/



INSERT INTO tAdresse VALUES (10, 'Rue de la Paix', 'Paris');
INSERT INTO tAdresse VALUES (62, 'Rue du Faubourg Saint-Honoré', 'Paris');
INSERT INTO tAdresse VALUES (3, 'Avenue des Champs-Élysées', 'Paris');

INSERT INTO tPersonne VALUES (1, 'Jean Dupont', 28, (SELECT REF(a) FROM tAdresse a WHERE a.no = 10));
INSERT INTO tPersonne VALUES (2, 'Marie Leclerc', 35, (SELECT REF(a) FROM tAdresse a WHERE a.no = 62));
INSERT INTO tPersonne VALUES (3, 'Pierre Lambert', 40, (SELECT REF(a) FROM tAdresse a WHERE a.no = 3));

-- Afficher la ville de la personne n° 1
SELECT p.refadresse.ville AS ville
FROM tPersonne p
WHERE p.idp = 1;

SELECT a.ville AS ville_version_2
FROM tPersonne p
JOIN tAdresse a ON p.refAdresse IS NOT NULL AND p.refAdresse = REF(a)
WHERE p.idp = 1;

DECLARE
    v_address VARCHAR2(255);
BEGIN
    SELECT p.refAdresse.displayad()
    INTO v_address
    FROM tPersonne p
    WHERE p.nomp = 'Pierre Lambert' AND ROWNUM = 1;

    DBMS_OUTPUT.PUT_LINE('Pierre Lambert habite ' || v_address);
END;
/

INSERT INTO tPersonne VALUES (4, 'Martin', 35, NULL);
INSERT INTO tAdresse VALUES (3, 'Rue Garenne', 'Nantes');

UPDATE tPersonne p
SET p.refAdresse = (SELECT REF(a) FROM tAdresse a WHERE a.no = 3 AND a.rue = 'Rue Garenne')
WHERE p.idp = 4;

SELECT p.refadresse.displayad() AS Adresse_de_Martin
FROM tPersonne p
WHERE p.nomp = 'Martin';

