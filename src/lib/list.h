#include<stdbool.h>
struct test_struct
{
    char * val;
    struct test_struct *next;
};

struct test_struct* create_list(char *val);

struct test_struct* add_to_list(char *val);

char * pop_list();

struct test_struct* search_in_list(char *val, struct test_struct **prev);

int delete_from_list(char *val);

void print_list(void);
