#include <stdio.h>
#include "soviet.h" // Pega a definição de TAMANHO_MUSICA

void tocar_hino(void) {
    /* Abrindo o pipe para o aplay */
    FILE *tubo_som = popen("aplay -t raw -r 8000 -f U8 -c 1 -q", "w");

    // FILE *tubo_som = popen("cat > saida.raw", "w");
    
    if (tubo_som == NULL) {
        printf("Erro ao abrir o aplay. Verifique se está instalado.\n");
        return;
    }

    // VETOR 1: NOTAS
    int partitura_notas[TAMANHO_MUSICA] = {
        0,   // Silêncio Inicial
        20, 15, 20, 18, 16, 24, // Frase 1
        0,   // Silêncio
        24, 18, 20, 23, 20, 30, // Frase 2
        0,   // Silêncio
        30, 27, 
        0,   // Silêncio
        27, 24, 23, 
        0,   // Silêncio
        23, 20, 18, 16,
        0,   // Silêncio
        16, 15  // Final
    };

    // VETOR 2: TEMPOS
    int partitura_tempos[TAMANHO_MUSICA] = {
        4000, // Silêncio
        3000, 8000, 3000, 2000, 8000, 2000,
        1000, // Silêncio
        2000, 6000, 3000, 2000, 8000, 3000,
        1000, // Silêncio
        2000, 6000,
        1000, // Silêncio
        3000, 2000, 6000,
        1000, // Silêncio
        3000, 2000, 6000, 3000,
        1000, // Silêncio
        2000, 8000
    };

    // TOCADOR
    for (int i = 0; i < TAMANHO_MUSICA; i++) {
        
        int periodo_atual = partitura_notas[i];
        int duracao_atual = partitura_tempos[i];

        for (int t = 0; t < duracao_atual; t++) {
            
            if (periodo_atual == 0) {
                fputc(50, tubo_som);
            } 
            else {
                // Lógica da onda quadrada
                if ((t % periodo_atual) < (periodo_atual / 2)) {
                    fputc(200, tubo_som);
                } else {
                    fputc(50, tubo_som);
                }
            }
        }
    }

    pclose(tubo_som);
}