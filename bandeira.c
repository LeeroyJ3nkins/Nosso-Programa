#include <stdio.h>
#include <stdlib.h> // Necessário para abs()
#include "soviet.h" // Pega as definições de CORES e TAMANHOS

void desenhar_bandeira(void) {
    printf("\n\t========== Soviet Anthem Song ==========\n\n");

    // LINHAS (i = Y)
    for (int i = 0; i < ALTURA_BANDEIRA; i++) {

        // COLUNAS (j = X)
        for (int j = 0; j < LARGURA_BANDEIRA; j++) {

            // CÁLCULO DO LOSANGO
            int distancia_vertical = abs(i - CENTRO_Y);
            int distancia_horizontal = abs(j - CENTRO_X);
            
            // Forma do losango
            int distancia_total = distancia_vertical + distancia_horizontal;
            
            if (distancia_total <= TAMANHO_LOSANGO) {
                printf(COR_AMARELO "*" COR_RESET);
            } else {
                printf(COR_VERMELHO "*" COR_RESET);
            }
        }
        printf("\n");
    }

    // Reset final
    printf(COR_RESET "\n");
}