#include<stdbool.h>
#include<stdio.h>
#include<stdlib.h>
#include"strmap.h"

typedef struct Scope
{
    StrMap *variables;
    struct Scope *next;
} Scope;

void push(StrMap *variables, Scope **head)
{
    Scope *temp;
    temp = (Scope*)malloc(sizeof(Scope*));
    temp->variables = variables;
    temp->next = *head;
    *head = temp;
}

void pop(Scope **head)
{
    Scope* temp;
    temp = *head;

    *head = (*head)->next;
    deleteHashmap(temp->variables);
    free(temp);
}



StrMap* peek(Scope *head)
{
    return head->variables;
}

static void stack_iter(const char *key, const char *value, const void *obj)
{
    printf("key: %s value: %s\n", key, value);
}



bool exists_in(char* variable,  Scope *a_scope)
{
    return true;
}

void print(Scope *head)
{
    int i = 0;

    while (head)
    {
        printf("Scope: %d\n", i);
        printf("variables:\n");
        //sm_enum(head->variables, stack_iter, NULL);
        printf("\n");
        i++;
        head = head->next;
    }
}
