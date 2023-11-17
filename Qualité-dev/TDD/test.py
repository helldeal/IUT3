def FizzBuzz(x):
    if x < 0 or x > 100:
        raise ValueError("Le nombre doit être entre 0 et 100.")
    if x % 3 == 0 and x % 5 == 0:
        return "FizzBuzz"
    elif x % 3 == 0:
        return "Buzz"
    elif x % 5 == 0:
        return "Fizz"
    return "Rien"



import unittest

class FizzBuzzTest(unittest.TestCase):
    def testmod3et5(self):
        self.assertEqual(FizzBuzz(15), "FizzBuzz")
    
    def testmod3(self):
        self.assertEqual(FizzBuzz(9), "Buzz")
    
    def testmod5(self):
        self.assertEqual(FizzBuzz(20), "Fizz")

    def testLimite(self):
        with self.assertRaises(ValueError):
            FizzBuzz(-1)
        with self.assertRaises(ValueError):
            FizzBuzz(101)
    
    def TestContient3(self):
        self.assertEqual(FizzBuzz(43), "Fizz")
    
    def TestContient5(self):
        self.assertEqual(FizzBuzz(57), "Buzz")
    

if __name__ == '__main__':
    unittest.main()
