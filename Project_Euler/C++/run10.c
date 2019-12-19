//Problem 10
//Find the sum of all primes below 2million

//#include "/media/SW_Preload/Root/Georgia_Tech/BlackBox/basic.c"
#include "/cygdrive/c/Users/carlos/Dropbox/BlackBox/basic.c"

int main()
{
  int end = 2000000;
  int len = CalcLength(1,end,1);
  scalardisp(len,"Len");
  int* primenumbers = iCreateVec(1,end,1);
  //ivecdisp(primenumbers,end,"PrimeNumbers");
  primes(primenumbers,len);
  return 0;
  long long int ans = isum(primenumbers,len);
  iscalardisp(ans,"answer");
  //ivecdisp(primenumbers,len,"primes");

  return 0;
}
