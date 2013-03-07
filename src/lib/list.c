#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>
#include"list.h"
#include<string.h>


struct test_struct *head = NULL;
struct test_struct *curr = NULL;

struct test_struct* create_list(char * val)
{
    struct test_struct *ptr = (struct test_struct*)malloc(sizeof(struct test_struct));
    if(NULL == ptr)
    {
        return NULL;
    }
    ptr->val = (char *)malloc(strlen(val));
    strncpy(ptr->val,val,strlen(val));
    ptr->next = NULL;

    head = curr = ptr;
    return ptr;
}

struct test_struct* add_to_list(char *val/*, bool add_to_end*/)
{
    bool add_to_end;
    if(NULL == head)
    {
        return (create_list(val));
    }

    struct test_struct *ptr = (struct test_struct*)malloc(sizeof(struct test_struct));
    if(NULL == ptr)
    {
        return NULL;
    }
    ptr->val = (char *)malloc(strlen(val));
    strncpy(ptr->val,val,strlen(val));
    ptr->next = NULL;

    add_to_end = false;

    if(add_to_end)
    {
        curr->next = ptr;
        curr = ptr;
    }
    else
    {
        ptr->next = head;
        head = ptr;
    }
    return ptr;
}

char * pop_list()
{
    struct test_struct *ptr;
    ptr = head;
    if(head != NULL){
        curr = head;
        head = head->next;
        free(curr);
        return ptr->val;
    }
    return NULL;
}



struct test_struct* search_in_list(char *val, struct test_struct **prev)
{
    struct test_struct *ptr = head;
    struct test_struct *tmp = NULL;
    bool found = false;

    while(ptr != NULL)
    {
        if(strcmp (ptr->val,val) != 0)
        {
            found = true;
            break;
        }
        else
        {
            tmp = ptr;
            ptr = ptr->next;
        }
    }

    if(true == found)
    {
        if(prev)
            *prev = tmp;
        return ptr;
    }
    else
    {
        return NULL;
    }
}

int delete_from_list(char *val)
{
    struct test_struct *prev = NULL;
    struct test_struct *del = NULL;

    del = search_in_list(val,&prev);
    if(del == NULL)
    {
        return -1;
    }
    else
    {
        if(prev != NULL)
            prev->next = del->next;

        if(del == curr)
        {
            curr = prev;
        }
        else if(del == head)
        {
            head = del->next;
        }
    }

    free(del);
    del = NULL;

    return 0;
}

void print_list(void)
{
    struct test_struct *ptr = head;

    while(ptr != NULL)
    {
        ptr = ptr->next;
    }

    return;
}
void clean_list(void)
{
    struct test_struct *ptr = head;

    while(ptr != NULL)
    {
        free(ptr->val);

        head = ptr->next;
        free(ptr);
        ptr = head;
    }

    return;
}
