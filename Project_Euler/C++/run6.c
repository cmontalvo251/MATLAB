//Problem #6
//%%Find the square of the sum minus the sum of the squares of the
//%number from 1 to 100

#include "/media/SW_Preload/Root/Georgia_Tech/BlackBox/basic.c"

int main()
{
  int len = CalcLength(1,100,1);
  double x[len];
  CreateVec(x,len,1,1);
  double answer = SQUARE(sum(x,len)) - squaresum(x,len);
  scalardisp(answer,"answer");
}
