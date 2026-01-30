#ifndef BANDEIRA_H
#define BANDEIRA_H

// ======================== VISUAL ========================

// PALETA DE CORES
#define COR_RESET    "\033[0m"
#define COR_VERMELHO "\033[31m"
#define COR_AMARELO  "\033[33m"

// DIMENSÕES
#define ALTURA_BANDEIRA 16
#define LARGURA_BANDEIRA 64

// GEOMETRIA DO LOSANGO
#define CENTRO_Y  5
#define CENTRO_X  8
#define TAMANHO_LOSANGO 4

// ======================== PROTÓTIPOS ========================

void desenhar_bandeira(void);

#endif