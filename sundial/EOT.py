#!/usr/bin/python

#import sys
#sys.path.append('/home/carlos/Dropbox/BlackBox/mypy/')
#from mypy import *

import numpy as np
import matplotlib.pyplot as plt

def plottool(fontsize,xlabel,ylabel,title):
    plt.rcParams.update({'font.size': fontsize})
    fig = plt.figure()
    rect = fig.patch
    rect.set_facecolor('white')
    plt.grid()
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.title(title)

W = 2*np.pi/365.24 
D = np.linspace(0,365.24,100) 
A = W*(D+10)
B = A + 2*0.0167*np.sin(W*(D-2))
C = (A-np.arctan(np.tan(B)/np.cos(23.44*np.pi/180)))/np.pi
EOTvec = -720*(C-np.round(C))
Long = -69.882778
GMT_offset = -4*15
sundial_offset = Long - GMT_offset
minute_offset = sundial_offset*4
EOT_corrected = EOTvec-minute_offset

plottool(18,'Month of the Year','Change in Minutes','CASAS REALES')
plt.plot(1+D/30,EOT_corrected,'b-',linewidth=2.0)
plt.show()

