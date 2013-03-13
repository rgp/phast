#include<stdbool.h>
#include"strmap.h"

typedef struct Scope Scope;

void push(StrMap *variables, Scope **head);

void pop(Scope **head);

StrMap* peek(Scope *head);

bool exists_in(char *variable, Scope *a_scope);

void print(Scope *head);
