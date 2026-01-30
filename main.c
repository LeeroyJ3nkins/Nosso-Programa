#include <stdio.h>
#include "soviet.h"

int main() {
    printf("\033[H\033[J");
    
    // Bandeira
    desenhar_bandeira();

    // Hino
    tocar_hino();
    
    return 0;
}