#include <stdio.h>
#include <string.h>
#include <stdint.h>

#define IP_OFFSET 0x00011000


int Recuperateur(const char *chemin, char *buffer, size_t bufferSize);
uint8_t convertisseur32bits(const char *binaire);