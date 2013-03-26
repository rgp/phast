#include<stdbool.h>

typedef struct Node
{
    void* element;
    struct Node *next;
    struct Node *prev;
} Node;

void ch_push(void* element, Node **head);

void* ch_pop(Node **head);

void* ch_peek(Node *head);
void* ch_peekN(Node *head);

bool ch_exists_in(void * element, Node *a_scope);

void ch_process(Node *head);
