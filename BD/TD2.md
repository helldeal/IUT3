# Gestion de la concurrence d’accès

## Exercice 1 
Indiquer pour chacune de ces questions le résultat de l’exécution des transactions T1 et T2 (sérialisable, perte de mise à jour, etc.) .

a)   
T1:find S
T1:find C1
T1:upd S
T1:upd C1
T2:find S
T2:find C2
T2:upd S
T2:upd C2   
serialisable

b)   
T1:find S   
T1:find C1  
T2:find S    
T2:find C2    
T2:upd S   
T2:upd C2    
T1:upd S    
T1:upd C1   
perte de mise à jour 

c)     
T1:find S  
T1:find C1  
T1:upd S   
T2:find S  
T2:find C2  
T2:upd S   
T1:upd C1  
T2:upd C2     
serialisable 

d)   
T1:find S  
T1:find C1  
T1:upd S  
T2:find S  
T2:find C2  
T2:upd S  
T2:upd C2  
T2:commit  
T1:upd  
C1  
T1:Rollback   
problème de lecture sale

e)  
T1:find S  
T2:find S  
T1:upd S   
T2:find C2  
T2:find S  
T1:Commit  
T2:upd C2  
T2:Commit     
problème de lecture non reproductible  


## Exercice 2
Nous considérons une séquence d'opérations impliquant des transactions T1,T2,T3,T4
où A et B sont deux granules de la base de données. On suppose que T1,T2,T3 et T4 suivent
respectivement les protocoles PSE, PS, PX et PUE (vus en cours). Compléter le tableau suivant en
indiquant à chaque instant t l’état de la pile et le graphe d’attente entre transactions.

| TP (PSE) | T2(PS) | T3 (PX) | T4 (PUE) | Temps |  pile de verrou   |   attentes  |
| ------ | ---- | ----- | ------ | --- | --- | --- |
|    D     |        |         |          |   t1    |     |     |
|          |    D   |         |          |   t2    |     |     |
|          |        |         |    D     |   t3    |     |     |
|  Find A  |        |         |          |   t4    |  T1,SE,A   |     |
|          |        |         |  Find B  |   t5    |  T4,UE,B   |     |
|          | Find B |         |          |   t6    |  T2,S,B   |     |
|          |        |    D    |          |   t7    |     |     |
|          | Find A |         |          |   t8    | T2,S,A    |     |
|          |        |         |  Upd B   |   t9    | T4,X,B   |  T4(B) -> T2(B)   |
|          |        |  Find B |          |   t10   | T3,X,B   |  T3(B) -> T4(B) -> T2(B)   |  
|  Find B  |        |         |          |   t11   | T1,SE,B    | T1(B) -> T3(B) -> T4(B) -> T2(B)   |
|          |  Udp B |         |          |   t12   | fin T4,UE,B   |     |
|          |        |         |  Commit  |   t13   | fin T4,X,B    |     |
|          | Commit |         |          |   t14   | fin T2,S,A    |     |
|          |        |  Find A |          |   t15   |     |  Pas possible   |
|  Commit  |        |         |          |   t16   | fin T1,SE,A  |     |
|          |        |  Commit |          |   t17   |     |     |


## Exercice 3 
On considère le tableau de l’exercice précédent. Compléter ce tableau en
adoptant une approche préventive (Wait-Die / Wound-Wait). Comparer le résultat de
ces deux approches.

| TP (PSE) | T2(PS) | T3 (PX) | T4 (PUE) | Temps |  pile de verrou   |   attentes  |
| ------ | ---- | ----- | ------ | --- | --- | --- |
|    D     |        |         |          |   t1    |     |     |
|          |    D   |         |          |   t2    |     |     |
|          |        |         |    D     |   t3    |     |     |
|  Find A  |        |         |          |   t4    |  T1,SE,A   |     |
|          |        |         |  Find B  |   t5    |  T4,UE,B   |     |
|          | Find B |         |          |   t6    |  T2,S,B   |     |
|          |        |    D    |          |   t7    |     |     |
|          | Find A |         |          |   t8    | T2,S,A    |     |
|          |        |         |  Upd B   |   t9    | T4,X,B   |  T4(B) -> T2(B)   |
|          |        |  Find B |          |   t10   | T3,X,B   |   |  
|  Find B  |        |         |          |   t11   | T1,SE,B    |   |
|          |  Udp B |         |          |   t12   |    |     |
|          |        |         |  Commit  |   t13   |     |     |
|          | Commit |         |          |   t14   |     |     |
|          |        |  Find A |          |   t15   |     |     |
|  Commit  |        |         |          |   t16   |      |     |
|          |        |  Commit |          |   t17   |     |     |
