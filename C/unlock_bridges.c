#include <stdio.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>

#define RESET_MGR_BASE   0xFFD05000 // Adresse alignée sur la page (multiple de 4096)
#define BRGMODRST_OFFSET 0x1C       // L'offset pour atteindre 0xFFD0501C

int main() {
    int fd;
    void *virtual_base;
    volatile uint32_t *brgmodrst_reg;

    // 1. Ouvrir la mémoire physique
    if( (fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1 ) {
        perror("ERREUR: Impossible d'ouvrir /dev/mem");
        return 1;
    }

    // 2. Mapper la page du Reset Manager (4096 octets suffisent)
    virtual_base = mmap(NULL, 4096, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, RESET_MGR_BASE);
    if(virtual_base == MAP_FAILED) {
        perror("ERREUR: mmap a échoué");
        close(fd);
        return 1;
    }

    // 3. Pointer vers le registre exact
    brgmodrst_reg = (uint32_t *)(virtual_base + BRGMODRST_OFFSET);

    // 4. L'ÉCRITURE MAGIQUE : On écrit 0 pour désactiver le Reset des ponts (les ouvrir)
    *brgmodrst_reg = 0x0;
    
    printf("SUCCÈS : Les ponts HPS-FPGA sont maintenant ouverts !\n");

    // 5. Nettoyage
    munmap(virtual_base, 4096);
    close(fd);

    return 0;
}