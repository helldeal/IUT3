# JDK

Alexandre Clenet

## Quelle est la version de la plateforme Java install´ee sur votre poste ?
```
java -version

java version "20.0.2" 2023-07-18
Java(TM) SE Runtime Environment (build 20.0.2+9-78)
Java HotSpot(TM) 64-Bit Server VM (build 20.0.2+9-78, mixed mode, sharing)
```
## Où est-elle?
```
which java

/c/Program Files/Java/jdk-20/bin/java
```

## A quoi ressemble le bytecode?

```
javac Exemple1.java

-Création de Exemple1.class
```
```
less Exemple1.class

<CA><FE><BA><BE>^@^@^@@^@I
^@^B^@^C^G^@^D^L^@^E^@^F^A^@^Pjava/lang/Object^A^@^F<init>^A^@^C()V     ^@^H^@  ^G^@
^L^@^K^@^L^A^@^HExemple1^A^@^Ax^A^@^AI
^@^H^@^N^L^@^E^@^O^A^@^D(I)V    ^@^Q^@^R^G^@^S^L^@^T^@^U^A^@^Pjava/lang/System^A^@^Cout^A^@^ULjava/io/PrintStream;
...
```
```
xxd Exemple1.class

00000000: cafe babe 0000 0040 0049 0a00 0200 0307  .......@.I......
00000010: 0004 0c00 0500 0601 0010 6a61 7661 2f6c  ..........java/l
00000020: 616e 672f 4f62 6a65 6374 0100 063c 696e  ang/Object...<in   
...
```
```
javap -c -s Exemple1.class | less

Compiled from "Exemple1.java"
public class Exemple1 {
  public Exemple1(int);
    descriptor: (I)V
    Code:
       0: aload_0
       1: invokespecial #1                  // Method java/lang/Object."<init>":
()V
       4: aload_0
       5: iload_1
       6: putfield      #7                  // Field x:I
       9: return

  public int compute(int);
    descriptor: (I)I
    Code:
       0: aload_0
       1: getfield      #7                  // Field x:I
       4: iload_1
       5: iadd
       6: ireturn
...
```

Le main de cette classe n'en fait rien. Comprenez sa (basique)
intention et corrigez le.
```
Exemple1 e1 = new Exemple1(1);
        System.out.println("The result is " + e1.compute(5));
        new Scanner(System.in).nextLine();
        System.exit(1);


EXEC : 
java Exemple1.java
The result is 6

```