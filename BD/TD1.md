# TD1 Optimisation algébrique et physique de requêtes dans Oracle

Alexandre Clenet

## Exercice 1 On considère la requête SQL suivante formulée sur les tables Employe et Travail :
(Q1) : select nomempl from employe e, travail t where t.duree > 35 and e.nuempl = t.nuempl;

(a) Espace Mémoire  A1 = 5  A2 = 5

(b) Nombre d’Opérations  A1 = 100*500+500+5 = 50505  A2 = 500+5*100+5 = 1005


## Exercice 2 On considère la requête SQL suivante formulée sur les tables Employe et Travail :
(Q2) select nomempl from employe e, travail t where t.nuproj = 123 and e.nuempl = t.nuempl