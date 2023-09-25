package fr.nantes.iut.lpmiar;
import java.util.Scanner;

public class Exemple1
{
    private int x;
    
    public Exemple1 (int x)
    {
        this.x = x;
    }

    public int compute (int y)
    {
        return x + y;
    }

    public static void main (String args[])
    {
        Exemple1 e1 = new Exemple1(1);
        System.out.println("The result is " + e1.compute(5));
        new Scanner(System.in).nextLine();
        System.exit(1);
    }
}

