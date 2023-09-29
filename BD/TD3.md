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
b) Trouver le nombre de téléphone possédé par enseignant
c) Trouver le nombre des enseignants qui possèdent trois numéros de téléphone.
d) Trouver les enseignants qui ne possèdent pas de téléphone


### Exercice 2

1) Traduire le schéma UML en schéma logique Relationnel-Objet
   ![](https://cdn.discordapp.com/attachments/763665832949579797/1155888903077765180/image.png)
2) Implémenter le schéma logique avec Oracle
3) Insérer dans la table Enseignant les tuples de votre choix permettant de répondre aux questions
suivantes :
a) Martin a abandonné la responsabilité du module système. Mettre à jour la table enseignant afin
de prendre en compte ce changement.
b) Sophie et Dupond deux enseignants qui ont pris respectivement la responsabilité du module
système et base de données. Ajouter dans la table enseignant les nouvelles responsabilités de ces
deux enseignants.
c) Un changement au niveau des responsabilités des modules. A partir de maintenant Antoine prend
la responsabilité du module gestion à la place de base de données. Mettre à jour la table enseignant.
d) réponder aux questions suivantes
d1) Pour Martin trouver les noms des modules dont il est responsable
d2) Trouver les numéros de téléphone de Martin
d3) Trouver les numéros de téléphone du responsable du module système
d4) Trouver les enseignants responsables d’un seul module


### Exercice 3

1) Traduire le schéma UML en schéma logique Relationnel-Objet
   ![](https://cdn.discordapp.com/attachments/763665832949579797/1155888948200079420/image.png)
2) Implémenter le schéma logique avec Oracle
3) Insérer plusieurs tuples dans la table enseignant.
4) réponder aux questions suivantes :
a) Trouver le se de Martin et son numéro de téléphone
b) Afficher les responsables des modules utilisant windows comme système d’exploitation.
c) Afficher le nombre d’enseignants utilisant le système windows
d) Afficher les n-uplets de la table Enseignant


### Exercice 4

1) Compléter le schéma UML de l’exercice précédent en tenant compte des nouvelles règles
   ![](https://cdn.discordapp.com/attachments/763665832949579797/1155890588277800970/image.png)
2) Traduire le schéma UML en schéma logique Relationnel-Objet.
3) Implémentez le schéma logique avec Oracle. Il faut penser à ajouter les contraîntes d’intégrité
(clés primaires et étrangères) suite à l’introduction de la table établissement.
1) Insérer des tuples dans les tables selon votre choix de manière à répondre aux questions
suivantes. Vérifier toutes les contraintes d’intégrités
1) réponder aux questions suivantes :
a) Trouver les systèmes d'exploitation (se) utilisés par des enseignants qui travaillent plus de 25h
par semaine.
b) Afficher les numéros de téléphones de l'enseignant responsable du module bd et travaillant dans
un établissement situé à Paris.
c) Trouver le nombre d’enseignants qui intervient dans chaque établissement
d) Afficher les enqeignant enseignant et pour chacun les établissements dans lesquels il inervient
ainsi que la durée