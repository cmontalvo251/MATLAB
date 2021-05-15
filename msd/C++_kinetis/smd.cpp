#include <stdio.h>
using namespace std;

#define NOSTATES 2

double TINITIAL,TFINAL,TIMESTEP,State[NOSTATES],m,c,k;
double TIMEON,xcommand,xdotcommand,kp,kd;

// void Read_Inputs() {
//   FILE* inputfile = fopen("SMD.txt","rb");
//   char dummy[256];
//   fscanf(inputfile,"%lf %s \n",&TINITIAL,dummy);
//   fscanf(inputfile,"%lf %s \n",&TFINAL,dummy);
//   fscanf(inputfile,"%lf %s \n",&TIMESTEP,dummy);
//   fscanf(inputfile,"%lf %s \n",&State[0],dummy);
//   fscanf(inputfile,"%lf %s \n",&State[1],dummy);
//   fscanf(inputfile,"%lf %s \n",&m,dummy);
//   fscanf(inputfile,"%lf %s \n",&c,dummy);
//   fscanf(inputfile,"%lf %s \n",&k,dummy);
//   fscanf(inputfile,"%lf %s \n",&TIMEON,dummy);
//   fscanf(inputfile,"%lf %s \n",&xcommand,dummy);
//   fscanf(inputfile,"%lf %s \n",&xdotcommand,dummy);
//   fscanf(inputfile,"%lf %s \n",&kp,dummy);
//   fscanf(inputfile,"%lf %s \n",&kd,dummy);
//   fclose(inputfile);
// }

void Hard_Coded_Inputs() {
  TINITIAL = 0;
  TFINAL = 10;
  TIMESTEP = 0.1;
  State[0] = 1;
  State[1] = -2;
  m = 1;
  c = 2;
  k = 3;
  TIMEON = 5;
  xcommand = 1;
  xdotcommand = 0;
  kp = 30;
  kd = 10;
}

double Control(double State[NOSTATES],double TIME) {
  double ucontrol = 0;
  if (TIME > TIMEON) {
    ucontrol = -kp*(State[0]-xcommand) - kd*(State[1]-xdotcommand);
  }
  return ucontrol;
}

void Derivatives(double StateDot[NOSTATES],double State[NOSTATES],double ucontrol) {
  double A[2][2],B[2];
  //Create A and B matrices
  A[0][0] = 0;
  A[0][1] = 1;
  A[1][0] = -k/m;
  A[1][1] = -c/m;
  B[0] = 0;
  B[1] = 1/m;
  //Compute xdot = A*x + B*u
  StateDot[0] = A[0][0]*State[0] + A[0][1]*State[1] + B[0]*ucontrol;
  StateDot[1] = A[1][0]*State[0] + A[1][1]*State[1] + B[1]*ucontrol;
}

int main() {
  double StateDot[NOSTATES];
  printf("Spring Mass Damper Program \n");
  //Read Inputs (This won't work on the Kinetis
  //Read_Inputs();
  //Just get Hard_Coded_Inputs
  Hard_Coded_Inputs();
  //Initialize Control
  double ucontrol;
  ucontrol = Control(State,0);
  //Initialize StateDerivatives
  Derivatives(StateDot,State,ucontrol);
  //Create OUTPUT FILE
  //FILE* outputfile = fopen("SimulationResults.txt","wb");
  //Loop until TIME > TFINAL
  for (double TIME = TINITIAL;TIME<=TFINAL;TIME+=TIMESTEP) {
    //Output to File
    //fprintf(outputfile,"%lf %lf %lf \n",TIME,State[0],State[1]);
    //Notify User of Progress
    printf("Simulation %lf Percent Complete \n",TIME/TFINAL*100);
    //Euler's Method
    ucontrol = Control(State,TIME);
    Derivatives(StateDot,State,ucontrol);
    State[0]+=StateDot[0]*TIMESTEP;
    State[1]+=StateDot[1]*TIMESTEP;
  }
  //fclose(outputfile);
}



