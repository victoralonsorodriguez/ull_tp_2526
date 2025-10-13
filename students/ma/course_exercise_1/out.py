# -*- coding: utf-8 -*-
"""
Created on Sat Oct 11 11:41:38 2025

@author: angeles
"""

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation


t,p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z = np.loadtxt('output.dat', unpack=True)

fig, ax = plt.subplots()


line1, = ax.plot([], [], '-', color='grey', alpha=0.2)
line2, = ax.plot([], [], '-', color='grey', alpha=0.2)
line3, = ax.plot([], [], '-', color='grey', alpha=0.2)

point1, = ax.plot([], [], 'o')
point2, = ax.plot([], [], 'o')
point3, = ax.plot([], [], 'o')


ax.set_xlabel("x")
ax.set_ylabel("y")


ax.set_xlim(min(p1x.min(), p2x.min(), p3x.min()) - 1,
            max(p1x.max(), p2x.max(), p3x.max()) + 1)
ax.set_ylim(min(p1y.min(), p2y.min(), p3y.min()) - 1,
            max(p1y.max(), p2y.max(), p3y.max()) + 1)

def animate(i):

    # En 2D
    
    point1.set_data(p1x[i], p1y[i])
    point2.set_data(p2x[i], p2y[i])
    point3.set_data(p3x[i], p3y[i])
    
    line1.set_data(p1x[:i], p1y[:i])
    line2.set_data(p2x[:i], p2y[:i])
    line3.set_data(p3x[:i], p3y[:i])

    
    ax.set_title(r"$t = %.3f$" % t[i])
  
    
    return line1, line2, line3, point1, point2, point3

    


ani = animation.FuncAnimation(fig, animate, frames=len(t), interval=30)
    
ani.save('particles.gif',  writer='pillow')