//Problem 3

#include <iostream>

using namespace std;

void disp(int var,char name[])
{
  printf("%s%s%i%s",name," = ",var,"\n");
}


int numprime(int number)
{
  //Is this number a prime number
  //ans = isprime(number);
  int counter = 2;
  int go = 1;
  while((counter < (number/2)) && go)
  {
    if(number % counter != 0)
      {
	counter = counter + 1;
      }
    else
      {
	go = 0;
	return 0;
      }
  }
  if(counter >= (number/2))
    {
      return 1;
    }
}


int main()
{

  //int x = 13195;
  long int x = 600851475143;
  int num = 1;
  int maxprime = 1;
  int stop = 1;
  int flag;
  while(stop)
    {
      //disp(x,"x");
      flag = numprime(num);
      if(flag)
	{
	  if(x % num == 0)
	    {
	      x = x/num;
	      if(num > maxprime)
	      {
		maxprime = num;
	      }
	    }
	}
      num = num + 1;
      if(num > x)
	{
	  stop = 0; 
	}
    }
  disp(maxprime,"answer");
}


