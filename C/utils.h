#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stddef.h>


int Recuperateur(const char *jarPath, const char *inputCube, char *buffer, size_t bufferSize);
void separateur(const char *str, uint8_t resultat[32]);
uint32_t convertisseur32bits(const char *binaire);
const char* traduire_mouvement(uint8_t val);
