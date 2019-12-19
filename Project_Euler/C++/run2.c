//Problem 2
//Find the sum of all even Fibbanacci numbers from 1 to 
//%under 4 million

#include <iostream>

using namespace std;

void disp(int var,char name[])
{
  printf("%s%s%i%s",name," = ",var,"\n");
}

int main()
{
  int add = 1;
  int fibnum = 2;
  int sum = 2;
  int stop = 1;
  int temp = 0;;
  while(stop)
    {
      temp = fibnum;
      fibnum = fibnum + add;
      if(fibnum > 4e6)
	{
	  disp(sum,"answer");
	  return 0;
	}
      if(fibnum % 2 == 0)
	{
	  sum = sum + fibnum;
	}
      add = temp;
    }
  return 0;

}
