//Problem 4 
//Find the two largest 3 digit numbers whose product is a
//palindrome.

#include "/media/SW_Preload/Root/Georgia_Tech/BlackBox/basic.c"

int main()
{
  ClearHome();
  int len1 = CalcLength(101,999,1);
  double num1[len1];
  CreateVec(num1,len1,101,1);
  //show(num1,len1,"num1");
  double num2[len1];
  CreateVec(num2,len1,101,1);
  int largest = 101;
  int product = 0;
  //cout << ispalindrome(101) << endl;
  for(int i = 0;i<len1;i++)
    {
      for(int j = 0;j<len1;j++)
	{
	  product = num1[i]*num2[j];
	  if(product > largest)
	    {
	      if(ispalindrome(product))
		{
		  largest = product;
		}
	    }
	}
    }

  iscalardisp(largest,"answer");
}


