//Problem 12

#include "/media/SW_Preload/Root/Georgia_Tech/BlackBox/basic.c"

int main()
{
  ClearHome();
  int n = 7500;
  long int num = 50;
  int divisors = 0;
  int notfound = 1;
  int divider = 2;
  double slope = 1;
  double guess = 0;
  int maxdivisors = 0;
  int len;
  char str[30];
  while(notfound)
    {
      n++;
      num = n*(n+1)/2; 
      divisors = 2;
      divider = 2;
      int2str(str,num);
      len = GetLength(str);
      if((str[len-1] == zero))
	{
	  while(divider <= num/2)
	    {
	      if ((num % divider) == 0)
		{
		  divisors++;
		}
	      divider++;
	    }
	  if (divisors > maxdivisors)
	    {
	      slope = (double)divisors/(double)n;
	      guess = (double)500/slope;
	      disp(str);
	      iscalardisp(n,"N");
	      iscalardisp(num,"triangle number");
	      iscalardisp(divisors,"number of divisors");
	      scalardisp(slope,"slope");
	      scalardisp(guess,"next guess");
	      maxdivisors = divisors;
	    }
	  //disp(n,"N");
	}
    }
}
