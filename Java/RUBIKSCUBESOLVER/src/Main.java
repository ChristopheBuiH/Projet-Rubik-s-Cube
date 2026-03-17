package cs.min2phase;

import cs.min2phase.Search;
import cs.min2phase.Tools;

public class Main {
    public static void main(String[] args) {
        // --- OPTION 1 : État du cube par chaîne de 54 caractères ---
        String cubeString = "FRDFUBRRRFDLDRUBBLDUULFRFLUDURLDUDFULDFLLFBDLBBUFBBBRR"; // Cube résolu

        // --- OPTION 2 : Générer depuis une scramble ---
         //String cubeString = Tools.fromScramble("R U R' F2 L' U2 B D' R2 U' F' L D2 B' U R' F2 D L2");

        // Appel du solveur
        Search search = new Search();
        String solution = search.solution(cubeString, 24, 100000000, 0, 0);



        System.out.println("Solution: " + solution);
    }
}