#include<stdio.h>
// take the x minutes convert to y hours z minutes
#define MIN 60
int main(void)
{
    int input_min=0;
    int output_hour=0;
    int output_min=0;
    int judge=0;
    while (1)
    {
        printf("please input minutes:");
        judge=scanf("%d",&input_min);
        if (judge == 0 )
        {
            printf("please input the correct number,now quit\n");
            break;
        }
        if (input_min >=0)
        {
            output_min = input_min % MIN;
            output_hour = input_min / MIN;    
            printf("the final is %d hour %d minutes\n",output_hour,output_min);
        }
        else
        {
            printf("please input the correct number ,now quit\n");
            break;
        }
    }
    return 0;
}
