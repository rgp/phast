#include<stdbool.h>
#include<stdio.h>
#include<stdlib.h>
#include"../heading.h"

typedef struct Node
{
    void* element;
    struct Node *next;
    struct Node *prev;
} Node;

void ch_push(void *element, Node **head)
{
    Node *temp;
    temp = (Node*)malloc(sizeof(Node*));
    temp->element = element;
    temp->next = *head;
    temp->next = *head;
    *head = temp;
}

void* ch_pop(Node **head)
{
    Node* temp;
    temp = *head;

    *head = (*head)->next;
    free(temp);
}

void* ch_peek(Node *head)
{
    return head->element;
}

bool ch_exists_in(char* variable,  Node *a_scope)
{
    /* TODO */
    return true;
}

void ch_process(Node *head)
{
    while (head)
    {
        head = head->next;
        /* TODO: Haz algo con esta funcion */
    }
}
