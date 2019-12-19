#!/usr/bin/python
import time

start_time = time.time()

N = 1000
s = 1
for idx in range(1,N+1):
    s = s*idx

elapsed_time = time.time()-start_time

f = open('PythonTime.txt','w')
f.write(str(elapsed_time))

#print elapsed_time
