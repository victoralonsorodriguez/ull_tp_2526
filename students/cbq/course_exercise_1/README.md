This git program uses direct numerical integration to study the kinematics of a system consisting of gravitationally interacting particles using the leapfrog integration method. The principal program ex1.f90, uses the Leapfrog integration using the input.dat that has the given form:

dt
dt_out
t_end
n
m1 p1x p1y p1z v1x v1y v1z
m2 p2x p2y p2z v2x v2y v2z
...
mn pnx pny pnz vnx vny vnz

where:

- **`dt`** = Integration time step  
- **`dt_out`** = Time interval for data output  
- **`t_end`** = Total simulation time  
- **`n`** = Number of particles in the system  
- **`m`** = Particle mass  
- **`p(x, y, z)`** = Initial position vector of each particle  
- **`v(x, y, z)`** = Initial velocity vector of each particle 

The program ex1 also uses two modules: the geometry and particle module.

In the geometry module

