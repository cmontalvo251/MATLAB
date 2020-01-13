import numpy as np
import matplotlib.pyplot as plt

plt.close("all")

def f(x):
    return np.sqrt(1-x**2)

solns = []
dxs = []
dx = 0.1

for i in range(0,5):
    x = -1.
    sol = 0.
    while x+dx < 1:
        sol += 0.5*dx*(f(x) + f(x+dx))
        x+=dx
    print('Pi = ',sol*2)
    solns.append(sol*2-np.pi)
    dxs.append(np.log(1./dx))
    dx/=10.
    
plt.plot(dxs,solns)
plt.xlabel('log(Number of Approximations)')
plt.ylabel('Error in Solution')
plt.grid()
plt.show()