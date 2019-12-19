//Problem 7
//%%find the 1001st prime

#include "/media/SW_Preload/Root/Georgia_Tech/BlackBox/basic.c"

int main()
{

int number = 5;
int primenum = 13;
int stop = 1;
 while(stop)
   {
     if(numprime(primenum))
       {
	 number = number + 1;
       }
     if(number == 10001)
       {
	 stop = 0;
	 iscalardisp(primenum,"answer");
	 return 0;
       }
     primenum = primenum + 1;
   }
}
