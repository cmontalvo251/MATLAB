import processing.core.*; 
import processing.xml.*; 

import ddf.minim.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class planets extends PApplet {

int Numplanets = 3;
int waitcounter = 0;
float x,y;
float[] R = {5,8,12};
int counter = -1;
int r[] = {0,0,255};
int g[] = {0,255,0};
int b[] = {255,0,0};
String lines[];
String strings[] = {"C","D","F"};



Minim minim;

AudioPlayer au_player1, au_player2 ;


public void setup()
{
  size(800,800);
  stroke(0,0,0,0);
  background(0);
  lines = loadStrings("position.txt");
  minim = new Minim(this) ;
  au_player1 = minim.loadFile("C.wav") ;
  au_player2 = minim.loadFile("D.wav") ;
}

public void draw()
{
  background(0);
  frameRate(60);
  counter++;
  ReadNext(counter);
  if (counter >= lines.length-1)
  {
     counter = lines.length-2;
  }
  //ellipse(x,y,R,R);
}

public void ReadNext(int ii)
{
  waitcounter++;
  float[] xvec = {0,0,0};
  float[] yvec = {0,0,0};
  float[] delr = {0,0,0};
  String[] pieces = split(lines[ii], ',');
  //println(pieces);
  for (int jj = 0;jj< Numplanets;jj++)
  {
   x = PApplet.parseFloat(pieces[jj*(Numplanets-1)]);
   y = PApplet.parseFloat(pieces[jj*(Numplanets-1)+1]);
   //print("Planet = " + jj + "\n"); 
   //print("x = " + x + " , y = " + y + "\n"); 
   fill(r[jj],g[jj],b[jj]);
   ellipse(x+width/2,y+height/2,R[jj],R[jj]);
   xvec[jj] = x;
   yvec[jj] = y;
  }
  for (int ll = 0;ll<Numplanets;ll++)
  {
    for (int jj = ll+1;jj<Numplanets;jj++)
    {
      delr[ll] = sqrt(pow(xvec[ll]-xvec[jj],2) + pow(yvec[ll]-yvec[jj],2));
     if ((delr[ll] < 10) && (waitcounter>10))
     {
        au_player1 = minim.loadFile(strings[jj] + ".wav") ;
        print(delr[ll] + "\n");
        au_player1.play();
        //minim.stop();
        waitcounter = 0;
     }
    }
  }
  
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "planets" });
  }
}
