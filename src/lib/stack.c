#include<stdio.h>
#include<stdlib.h>
#include "stack.h"

Stack * stack_push(Stack *S, char *val)
{
    Stack *new;
    new  = malloc(sizeof(Stack));
    printf(typeof(new->next));
    new->next = S;
    new->v = &val;
    return new;
}

char * stack_pop(Stack *S)
{
    (S->top)--;
    return (S->v[S->top]);
/*  Equivalent to: return (S->v[--(S->top)]);  */
}

void stack_init(Stack *S)
{
    S = malloc(sizeof(Stack));
}

int stack_full(Stack *S)
{
    return (S->top >= 20);
}

void stack_print(Stack *S)
{
    Stack *a;
    a = S;
    printf("Stack contents: ");
    while(a != NULL){
        S = a->next;
        printf("%s  ",S->v[i]); 
    }
    printf("\n");
}
void stack_free(Stack *S)
{
    Stack *a;
    a = S;
    while(a != NULL){
        S = a->next;
        free(a);
    }
}
