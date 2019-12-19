//Problem 5
//Find the smallest number divisble by 1 through 20

#include "/media/SW_Preload/Root/Georgia_Tech/BlackBox/basic.c"

int main()
{
  int num = 2520;
  int stop = 1;
  int inc = 20;
  while(stop)
    {
      int found = 1;
      for(int i = 1;i<=inc;i++)
	{
	  if(num % i > 0)
	    {
	      found = 0;
	    }
	}
      if(found)
	{
	  stop = 0;
	}
      else
	{
	  num = num + inc;
	}
    }
  iscalardisp(num,"answer");
}
