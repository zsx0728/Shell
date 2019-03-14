#include<stdio.h>
#include<unistd.h>
#include<limits.h>
int main()
{
    char a[PATH_MAX];
    if(getcwd(a,PATH_MAX)==NULL)
    {
        perror("getcwd failed!");
        return 1;
    }
    printf("print the current directory:%s\n",a);
    return 0;
}
