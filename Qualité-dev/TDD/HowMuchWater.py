def hmw_game(terrain):
    if sum(n < 0 for n in terrain)>0:raise ValueError("Negative values")
    maxHeight=max(terrain)
    max_index = terrain.index(max(terrain)) 
    gauche = terrain[:max_index]  
    droite = terrain[max_index + 1:] 
    score=traitementDroite(maxHeight,droite) 
    score+=traitementGauche(maxHeight,gauche)
    return score

def traitementDroite(maxInit,liste):
    score=0
    maxHeight=max(liste)
    max_index = liste.index(max(liste)) 
    gauche = liste[:max_index] 
    if len(gauche)!=0:
        for i in gauche:
            score+=maxInit-i
    droite = liste[max_index + 1:] 
    if len(droite)==0:return 0
    score+=traitementDroite(maxHeight,droite)
    return score

def traitementGauche(maxInit,liste):
    liste=liste.reverse()
    score=0
    maxHeight=max(liste)
    max_index = liste.index(max(liste)) 
    gauche = liste[:max_index] 
    if len(gauche)!=0:
        for i in gauche:
            score+=maxInit-i
    droite = liste[max_index + 1:] 
    if len(droite)==0:return 0
    score+=traitementDroite(maxHeight,droite)
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

if __name__ == '__main__':
    unittest.main()
