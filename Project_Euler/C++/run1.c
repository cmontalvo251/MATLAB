//Problem 1
//Find the sum of all multiples of 3 and 5 below 1000
#include <math.h>
#include <iostream>

using namespace std;

void show(double vec[],int num,char name[])
{
  printf("%s%s",name," = ");
  int i;
  for(i=0;i<num;i++)
    {
      printf("%lf%s",vec[i]," ");
    }
  printf("%s","\n");
}

void CreateVec(double vec[],int num,int inc)
{
  double val = 0;
  int i;
  for(i = 0;i<num;i++)
    {
      val = val + inc;
      vec[i] = val;
    }
}

double sum(double vec[],int num)
{
  double ans = 0;
  int i;
  for(i = 0;i<num;i++)
    {
      ans = ans + vec[i];
    }

  return ans;

} 

int main()

{
  //Calculate the number of 3s,5s,and 15s before 1000
  int num3 = (double)999/(3);
  int num5 = (double)999/5;
  int num15 = (double)999/15;

  //Create Vectors
  double threes[num3];
  double fives[num5];
  double fifteens[num15];
  CreateVec(threes,num3,3);
  CreateVec(fives,num5,5);
  CreateVec(fifteens,num15,15);
  //show(threes,num3,"threes");
  //show(fives,num5,"fives");
  //show(fifteens,num15,"fifteens");
  int i;
  double answer = 0;

  for(i = 0;i<num15;i++)
    {
      for(int j = 0;j<num5;j++)
	{
	  if(fives[j] == fifteens[i])
	    {
	      fives[j] = 0;
	    }
	}
    }

  answer = sum(threes,num3) + sum(fives,num5);

  cout << answer << endl;

  return 0;

}
