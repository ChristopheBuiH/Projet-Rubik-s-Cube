#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <sys/mman.h>
#include <stdbool.h>

#include "utils.h"

// Adresse de base du pont Lightweight HPS-to-FPGA 
#define LWHPS2FPGA_BASE 0xFF200000 
// Taille de la plage mémoire à mapper
#define LWHPS2FPGA_SPAN 0x00200000
// Offset de l'IP dans la mémoire
#define IP_OFFSET 0x00020000

uint32_t convertisseur32bits(const char *binaire) {
    uint32_t motbits = 0;
    while (*binaire) {
        motbits <<= 1;
        if (*binaire == '1') motbits |= 1;
        binaire++;
    }
    return motbits;
}

// Fonction pour séparer une chaîne de caractères binaire en 20 mots de taille souhaitée 
// (la chaîne de caractère doit avoir un multiple de six comme longueur)
void separateur(const char *str, uint8_t resultat[32]) {
    int len = strlen(str);
    int width = 6;
    int nb_mots = len / 6;
    char listemots[nb_mots][7];

    for (int i = 0; i < nb_mots; i++) {
        for (int j = 0; j < width; j++) {
            listemots[i][j] = str[(i * width) + j];
        }
        listemots[i][width] = '\0';
        resultat[i] = (uint8_t)convertisseur32bits(listemots[i]);
    }

    for (int i = nb_mots; i < 32; i++) {
        resultat[i] = 0;
    }
}

int Recuperateur(const char *jarPath, const char *inputCube, char *buffer, size_t bufferSize) {
    FILE *fp;
    char commande[1024];

    // On construit la commande : java -jar RubikSolver.jar [input]
    snprintf(commande, sizeof(commande), "java -jar %s \"%s\"", jarPath, inputCube);

    fp = popen(commande, "r"); 
    if (fp == NULL) {
        perror("Erreur lors de l'exécution du JAR");
        return 1;
    }

    if (fgets(buffer, bufferSize, fp) != NULL) {
        buffer[strcspn(buffer, "\r\n")] = '\0';
    }

    pclose(fp); 
    return 0;
}
const char* traduire_mouvement(uint8_t val) {
    switch(val) {
        case 0b110100: return "U";
        case 0b111100: return "U2";
        case 0b111000: return "U'";
        
        case 0b010100: return "R";
        case 0b011100: return "R2";
        case 0b011000: return "R'";
        
        case 0b100001: return "F";
        case 0b100011: return "F2";
        case 0b100010: return "F'";
        
        case 0b110001: return "D";
        case 0b110011: return "D2";
        case 0b110010: return "D'";
        
        case 0b010001: return "L";
        case 0b010011: return "L2";
        case 0b010010: return "L'";
        
        case 0b100100: return "B";
        case 0b101100: return "B2";
        case 0b101000: return "B'";
        
        default: return "";
    }
}

int main() {
    char input[256];
    char buffer[1024];
    uint8_t resultat[32] = {0x0};

    printf("Entrez le cube ou le scramble : ");
    fgets(input, sizeof(input), stdin);
    input[strcspn(input, "\r\n")] = '\0';

    int truc = Recuperateur("~/RUBIKSCUBESOLVER_FINAL.jar", input, buffer, sizeof(buffer));
    separateur(buffer, resultat);

    // En commentaire : le code lié à l'écriture dans la mémoire de l'IP sur le FPGA. Malheureusement, nous n'avons pas pu le mettre à profit.
    /*
    //Mon mémoire
    int fd;
    void *virtual_base;
    volatile uint32_t *reg_fpga;

    

    printf("\nOuverture de la mémoire\n");
    fflush(stdout);
    // On ouvre la Memory Map pour accéder à la mémoire physique. 
    if( (fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1 ) {
        perror("ERREUR: flop de devmem");
        return 1;
    }

    printf("Mapping de la mémoire\n");
    fflush(stdout);
    // On mappe l'adresse physique du pont dans la mémoire virtuelle de notre processus.
    virtual_base = mmap(NULL, LWHPS2FPGA_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, LWHPS2FPGA_BASE);
    
    if(virtual_base == MAP_FAILED) {
        perror("ERREUR: flop de mmap");
        close(fd);
        return 1;
    }


    reg_fpga = (uint32_t *)((uint8_t *)virtual_base + IP_OFFSET);

    printf("Écriture\n");
    fflush(stdout);

    
    uint32_t valeur = *reg_fpga;
    printf("Valeur lue : 0x%08X\n", valeur);
    

    
    for (int i = 0; i < 32; i++) {
        *(reg_fpga + i) = resultat[i];
    }
    

    // On libère la mémoire mappée et on ferme le descripteur de fichier
    if (munmap(virtual_base, LWHPS2FPGA_SPAN) != 0) {
        perror("ERREUR: flop de munmap");
    }
    close(fd);
    */

    // Création d'un fichier texte contenant les instructions binaires. 
    FILE *fichier = fopen("instructions.txt", "w");

    printf("\nInstructions :\n");

    for (int i = 0; i < 32; i++) {
        if (resultat[i] != 0) {
            
            for (int j = 5; j >= 0; j--) {
                fprintf(fichier, "%c", (resultat[i] & (1 << j)) ? '1' : '0');
            }
            fprintf(fichier, "\n"); // Un mouvement par ligne

            
            for (int j = 5; j >= 0; j--) {
                printf("%c", (resultat[i] & (1 << j)) ? '1' : '0');
            }
            printf("\n");
        }
    }

    printf("\nSéquence pour le robot : ");
    for (int i = 0; i < 32; i++) {
        if (resultat[i] != 0) {
            printf("%s ", traduire_mouvement(resultat[i]));
        }
    }
    printf("\n\n");

    return 0;
}