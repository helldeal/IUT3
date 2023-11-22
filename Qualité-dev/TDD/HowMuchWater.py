def hmw_game(terrain):
    if sum(n < 0 for n in terrain)>0:raise ValueError("Negative values")
    maxHeight=max(terrain)
    max_index = terrain.index(max(terrain)) 
    gauche = terrain[:max_index]  
    droite = terrain[max_index + 1:] 
    print('maxbase =',maxHeight)
    print('gauche =',gauche)
    print('droite =',droite)
    
    score=0
    if len(droite)!=0:
        score+=traitementDroite(droite) 
    if len(gauche)!=0:
        score+=traitementGauche(gauche)
    return score

def traitementDroite(liste):
    score=0
    maxHeight=max(liste)
    print('maxdirect =',maxHeight)
    max_index = liste.index(max(liste)) 
    gauche = liste[:max_index] 
    print('gauche =',gauche)
    droite = liste[max_index + 1:] 
    print('droite =',droite)
    if len(gauche)!=0:
        for i in gauche:
            score+=maxHeight-i
    if len(droite)==0:return score
    score+=traitementDroite(droite)
    return score

def traitementGauche(liste):
    score=0
    maxHeight=max(liste)
    print('maxdirect =',maxHeight)
    max_index = liste.index(max(liste)) 
    gauche = liste[:max_index] 
    print('gauche =',gauche)
    droite = liste[max_index + 1:] 
    print('droite =',droite)
    if len(droite)!=0:
        for i in droite:
            score+=maxHeight-i
    if len(gauche)==0:return score
    score+=traitementGauche(gauche)
    return score


import unittest


class Test(unittest.TestCase):
    def test1(self):
        self.assertEqual(hmw_game([1, 2, 3, 4, 5]), 0)
    def test2(self):
        self.assertEqual(hmw_game([8, 2, 3, 4, 5]), 6)
    def test3(self):
        with self.assertRaises(ValueError):
            hmw_game([1, -2, 3, 4, 5, 6])
    def test4(self):
        self.assertEqual(hmw_game([10, 2, 3, 4, 5, 6, 6, 5, 0, 2, 5]), 18)  
    def test5(self):
        self.assertEqual(hmw_game([10, 2, 3, 4, 5, 6, 6, 5, 0, 2, 5, 11]), 62)
    def test6(self):
        self.assertEqual(hmw_game([10, 2, 3, 4, 5, 6, 12, 5, 0, 2, 5, 12]), 66)
    def test7(self):
        self.assertEqual(hmw_game([10, 2, 3, 4, 5, 6, 12, 5, 0, 2, 5, 12,5,8]), 69)

if __name__ == '__main__':
    unittest.main()
