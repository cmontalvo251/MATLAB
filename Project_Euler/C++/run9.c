//Problem #9
//Find a*b*c such that a+b+c = 1000 and a^2 + b^2 = c^2

#include "/media/SW_Preload/Root/Georgia_Tech/BlackBox/basic.c"

int main()
{
  double alpha = 1000;
  double a,b,c;
  int i;
  for(i = 1;i<=1000;i++)
    {
      b = i;
      c = (2*alpha*b-2*SQUARE(b)-SQUARE(alpha))/(2*b-2*alpha);
      if(c > 0 && floor(c) == c)
	{
	  if (SQUARE(c) >= SQUARE(b))
	    {
	      a = sqrt(SQUARE(c) - SQUARE(b));
	      if(floor(a) == a) 
		{
		  scalardisp(a*b*c,"answer");
		  return 0;
		}
	    }
	}
    }
}
