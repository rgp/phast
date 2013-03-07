typedef struct
{
    char * v;
    struct Stack *prev;
    struct Stack *next;
} Stack;

Stack * stack_push(Stack *S, char *val);
char * stack_pop(Stack *S);
void stack_init(Stack *S);
int stack_full(Stack *S);
void stack_print(Stack *S);
void stack_free(Stack *S);

