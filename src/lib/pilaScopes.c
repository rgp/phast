#include<stdbool.h>
#include<stdio.h>
#include<stdlib.h>
#include"strmap.h"
#include"../heading.h"

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

static void elements_clean(const char *key,void *tmp)
{
    free(tmp);
}

void pop(Scope **head)
{
    Scope* temp;
    temp = *head;

    *head = (*head)->next;
    hashmapProcess(temp->variables,elements_clean);
    deleteHashmap(temp->variables);
    free(temp);
}



StrMap* peek(Scope *head)
{
    return head->variables;
}

static void stack_iter(const char *key, void *tmp)
{
    quad* obj = (quad*)tmp;
    //printf("key: %s values: %p\n", key,obj->a);
    /* printf("key: %s values: %s,%s,%s,%s\n", key, obj->a,obj->b,obj->c,obj->d); */
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
        /* printf("Scope: %d\n", i); */
        /* printf("variables:\n"); */
        //sm_enum(head->variables, stack_iter, NULL);
        /* hashmapProcess(head->variables,stack_iter); */
        printf("\n");
        i++;
        head = head->next;
    }
}
