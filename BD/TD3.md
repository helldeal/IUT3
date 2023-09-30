# TD 3 : Relationnel – Objet avec Oracle

Alexandre Clenet - Florian Tran  
Année 3 - Groupe 1-2

## I) Les tables imbriquées

### Exercice 1

1) Traduire le schéma UML en schéma logique Relationnel-Objet
![](https://cdn.discordapp.com/attachments/763665832949579797/1155888818700955698/image.png)

2) Implémenter le schéma logique avec Oracle
```sql
   CREATE OR REPLACE TYPE Tel AS TABLE OF number(10) NULL;
   CREATE TABLE Enseignant (
      ide INTEGER PRIMARY KEY,
      nome VARCHAR(255),
      ltel Tel
   ) NESTED TABLE Tel STORE AS t1
```
3) Insérer dans la table Enseignant les tuples de votre choix permettant de répondre aux questions suivantes.
```sql
   INSERT INTO Enseignant (ide, nome, ltel) VALUES (1, 'Jean', Tel(1234567890));
   INSERT INTO Enseignant (ide, nome, ltel) VALUES (2, 'Marie', Tel(9876543210, 1234567890, 5555555555));
   INSERT INTO Enseignant (ide, nome, ltel) VALUES (3, 'Pauline', Tel());
   INSERT INTO Enseignant (ide, nome, ltel) VALUES (4, 'Thomas', Tel(1111111111, 2222222222));
   INSERT INTO Enseignant (ide, nome, ltel) VALUES (5, 'Sophie', Tel(9999999999));
   INSERT INTO Enseignant (ide, nome, ltel) VALUES (6, 'Nicolas', Tel(7777777777));
```
4) réponder aux questions suivantes :
   
a) Trouver le(s) numéro(s) de téléphone d’un enseignant dont vous renseignez son identité
```sql
SELECT ltel FROM Enseignant WHERE nome = 'Thomas';

--Outpout : S5A08B.TEL(1111111111, 2222222222)
```

b) Trouver le nombre de téléphone possédé par enseignant
```sql
SELECT e.nome, COUNT(*) from Enseignant e,TABLE(e.ltel) GROUP BY e.nome;

--Outpout :
Jean	1
Nicolas	1
Sophie	1
Thomas	2
Marie	3
```

c) Trouver le nombre des enseignants qui possèdent trois numéros de téléphone.
```sql
SELECT COUNT(*) AS nombre_enseignants
FROM Enseignant
WHERE (SELECT COUNT(*) FROM TABLE(ltel)) = 3;

--Outpout : 1
```

d) Trouver les enseignants qui ne possèdent pas de téléphone
```sql
SELECT nome
FROM Enseignant
WHERE (SELECT COUNT(*) FROM TABLE(ltel)) = 0;

--Outpout : Pauline
```


### Exercice 2

1) Traduire le schéma UML en schéma logique Relationnel-Objet
   ![](https://cdn.discordapp.com/attachments/763665832949579797/1155888903077765180/image.png)
2) Implémenter le schéma logique avec Oracle
```sql
CREATE OR REPLACE TYPE Module AS OBJECT (
    idm NUMBER(10),
    nomm VARCHAR2(255)
);
CREATE OR REPLACE TYPE Module_Table AS TABLE OF Module;

DROP TABLE Enseignant;
CREATE TABLE Enseignant (
    ide INTEGER PRIMARY KEY,
    nome VARCHAR2(255),
    ltel Tel,
    modules Module_Table
) NESTED TABLE ltel STORE AS t1 NESTED TABLE modules STORE AS t2;
```

3) Insérer dans la table Enseignant les tuples de votre choix permettant de répondre aux questions suivantes : 
```sql
INSERT INTO Enseignant VALUES (1, 'Martin', Tel(1234567890), Module_Table(Module(1, 'Système')));
INSERT INTO Enseignant VALUES (2, 'Sophie', Tel(9876543210), NULL);
INSERT INTO Enseignant VALUES (3, 'Dupond', Tel(5555555555), NULL);
INSERT INTO Enseignant VALUES (4, 'Antoine', Tel(1111111111), Module_Table(Module(2, 'Base de données')));
```

a) Martin a abandonné la responsabilité du module système. Mettre à jour la table enseignant afin de prendre en compte ce changement.
```sql
UPDATE Enseignant
SET modules = NULL
WHERE nome = 'Martin';
```

b) Sophie et Dupond deux enseignants qui ont pris respectivement la responsabilité du module système et base de données. Ajouter dans la table enseignant les nouvelles responsabilités de ces deux enseignants.
```sql
UPDATE Enseignant
SET modules = Module_Table(Module(1, 'Système'))
WHERE nome = 'Sophie';

UPDATE Enseignant
SET modules = Module_Table(Module(2, 'Base de données'))
WHERE nome = 'Dupond';
```

c) Un changement au niveau des responsabilités des modules. A partir de maintenant Antoine prend la responsabilité du module gestion à la place de base de données. Mettre à jour la table enseignant.
```sql
UPDATE Enseignant
SET modules = Module_Table(Module(3, 'Gestion'))
WHERE nome = 'Antoine';
```

d) réponder aux questions suivantes

d1) Pour Martin trouver les noms des modules dont il est responsable
```sql
SELECT modules
FROM Enseignant
WHERE nome = 'Martin' AND modules IS NOT NULL;

-- Output : Martin n'est responsable d'aucun module après la mise à jour.
```

d2) Trouver les numéros de téléphone de Martin
```sql
SELECT ltel
FROM Enseignant
WHERE nome = 'Martin';

--Outpout : S5A08B.TEL(1234567890)
```

d3) Trouver les numéros de téléphone du responsable du module système
```sql
SELECT e.ltel
FROM Enseignant e
WHERE EXISTS (
    SELECT *
    FROM TABLE(e.modules) m
    WHERE m.nomm = 'Système'
);

--Outpout : S5A08B.TEL(9876543210)
```

d4) Trouver les enseignants responsables d’un seul module
```sql
SELECT nome
FROM Enseignant
WHERE (SELECT COUNT(*) FROM TABLE(modules)) = 1;

--Outpout :
Sophie
Dupond
Antoine
```


### Exercice 3

1) Traduire le schéma UML en schéma logique Relationnel-Objet
   ![](https://cdn.discordapp.com/attachments/763665832949579797/1155888948200079420/image.png)
2) Implémenter le schéma logique avec Oracle
```sql
CREATE OR REPLACE TYPE Ordinateur AS OBJECT (
    ido NUMBER(10),
    se VARCHAR2(255)
);
CREATE OR REPLACE TYPE Ordinateur_Table AS TABLE OF Ordinateur;

DROP TABLE Enseignant;
CREATE TABLE Enseignant (
    ide INTEGER PRIMARY KEY,
    nome VARCHAR2(255),
    ltel Tel,
    modules Module_Table,
    ordinateur Ordinateur_Table
) NESTED TABLE ltel STORE AS t1 NESTED TABLE modules STORE AS t2 NESTED TABLE ordinateur STORE AS t3;
```
3) Insérer plusieurs tuples dans la table enseignant.
```sql
INSERT INTO Enseignant VALUES (1, 'Martin', Tel(1234567890), Module_Table(Module(1, 'Système')), Ordinateur_Table(Ordinateur(101, 'Windows')));
INSERT INTO Enseignant VALUES (2, 'Sophie', Tel(9876543210), Module_Table(Module(2, 'Base de données')), Ordinateur_Table(Ordinateur(102, 'Linux')));
INSERT INTO Enseignant VALUES (3, 'Dupond', Tel(5555555555), Module_Table(Module(3, 'Réseaux')), Ordinateur_Table(Ordinateur(103, 'Windows')));
```
4) réponder aux questions suivantes :
a) Trouver le se de Martin et son numéro de téléphone
```sql

--Outpout :
```
b) Afficher les responsables des modules utilisant windows comme système d’exploitation.
```sql

--Outpout :
```
c) Afficher le nombre d’enseignants utilisant le système windows
```sql
SELECT COUNT(*) AS nombre_enseignants_windows
FROM Enseignant e
WHERE EXISTS (
    SELECT 1
    FROM TABLE(e.ordinateur) o
    WHERE o.se = 'Windows'
);

--Outpout : 2
```
d) Afficher les n-uplets de la table Enseignant
```sql
SELECT * FROM Enseignant;

-- Output :
Martin  | 1234567890    | Module_Table(Module(1, 'Système')) | Ordinateur_Table(Ordinateur(101, 'Windows'))
Sophie  | 9876543210    | Module_Table(Module(2, 'Base de données')) | Ordinateur_Table(Ordinateur(102, 'Linux'))
Dupond  | 5555555555    | Module_Table(Module(3, 'Réseaux')) | Ordinateur_Table(Ordinateur(103, 'Windows'))
```

### Exercice 4

1) Compléter le schéma UML de l’exercice précédent en tenant compte des nouvelles règles
2) Traduire le schéma UML en schéma logique Relationnel-Objet.
   ![](https://cdn.discordapp.com/attachments/763665832949579797/1155890588277800970/image.png)
3) Implémentez le schéma logique avec Oracle. Il faut penser à ajouter les contraîntes d’intégrité (clés primaires et étrangères) suite à l’introduction de la table établissement.
```sql

```
4) Insérer des tuples dans les tables selon votre choix de manière à répondre aux questions
suivantes. Vérifier toutes les contraintes d’intégrités
```sql

--Outpout :
```
5) réponder aux questions suivantes : 
 
a) Trouver les systèmes d'exploitation (se) utilisés par des enseignants qui travaillent plus de 25h par semaine.
```sql

--Outpout :
```

b) Afficher les numéros de téléphones de l'enseignant responsable du module bd et travaillant dans un établissement situé à Paris.
```sql

--Outpout :
```

c) Trouver le nombre d’enseignants qui intervient dans chaque établissement
```sql

--Outpout :
```

d) Afficher les enqeignant enseignant et pour chacun les établissements dans lesquels il inervient ainsi que la durée
```sql

--Outpout :
```



