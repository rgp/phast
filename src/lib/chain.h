#include<stdbool.h>

typedef struct Node Node;

void ch_push(void* element, Node **head);

void ch_pop(Node **head);

void* ch_peek(Node *head);

bool ch_exists_in(void * element, Node *a_scope);

void ch_process(Node *head);
