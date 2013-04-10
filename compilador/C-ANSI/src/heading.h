/* heading.h */

#define YY_NO_UNPUT

#include <stdio.h>

typedef struct quad {
    char* a;
    char* b;
    char* c;
    char* d;
} quad;

typedef struct pair {
    void* a;
    void* b;
} pair;

typedef enum {
    NULO = 0,
    BOLEANO = 1,
    ENTERO = 2,
    FLOTANTE = 3,
    CADENA = 4
} TIPO_DATO;
