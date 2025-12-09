package cs.min2phase;

import cs.min2phase.Search;
import cs.min2phase.Tools;


public class Main {
    public static void main(String[] args) {
        // --- OPTION 1 : État du cube par chaîne de 54 caractères ---
        String cubeString = "UUBRUURULBBUURBDDUBRUFFLFFRDDFDDRDDFFFDLLLLLLRFLRBBRBB"; // Cube résolu

        // --- OPTION 2 : Générer depuis une scramble ---
         //String cubeString = Tools.fromScramble("R U R' U R U2 R' D L2 B' R2 U' D2 R2 L'");

        // Appel du solveur
        Search search = new Search();
        String solution = search.solution(cubeString, 24, 100000000, 0, 0);
        solution = solution.replace(" ","");
        System.out.println(solution);
    }
}