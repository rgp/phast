#include<stdbool.h>
#include<stdio.h>
#include<stdlib.h>
#include"chain.h"
#include"../heading.h"

void ch_push(void *element, Node **head)
{
    Node *temp;
    temp = (Node*)malloc(sizeof(Node));
    temp->element = element;
    temp->next = *head;
    *head = temp;
}

void* ch_pop(Node **head)
{
    Node* temp;
    void* elem;
    temp = *head;
    elem = temp->element;

    *head = (*head)->next;
    free(temp);
    return elem;
}

void ch_clean(Node **head)
{
    while (*head)
    {
        ch_pop(head);
    }
}

void* ch_peek(Node *head)
{
    return head->element;
}

void* ch_peekNext(Node *head)
{
    Node* tmp = head->next;
    return tmp;
}

bool ch_exists_in(void* variable,  Node *a_scope)
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
