#include<stdbool.h>
#include"hashmap.h"

typedef struct Scope Scope;

void push(hashmap *variables, Scope **head);

void pop(Scope **head);

hashmap* peek(Scope *head);

bool exists_in(char *variable, Scope *a_scope);

void print(Scope *head);
