# Leapfrog Integration Simulation (Fortran)

This project implements a **3D particle simulation** using the **Leapfrog integration method**.  
The code is written in **Fortran 90** and simulates the motion of particles under Newtonian gravitational forces.

---

# Project Structure

course_exercise_1/
│
├── Graphics/
│ ├── animation.gif          # Animation generated from the simulation output
│ └── requirements.txt       # Python dependencies for visualization
│ └── figures.py             # Python script to visualize trajectories
│
├── ex1.f90                  # Main program (leapfrog integrator)
├── geometry.f90             # Defines vector3d and point3d type and vector/point operations
├── particle.f90             # Defines particle3d type (mass, position, velocity)
│
├── input.dat                # Input file with simulation parameters
├── output.dat               # Output file with particle positions
├── Makefile                 # Build script
└── README.md                # Project documentation


---

# Compilation

Make sure you have a Fortran compiler installed (e.g., `gfortran`).

To compile the program:

```bash
make
```

To clean up the generated object (.o) and module (.mod) files, run:
```bash
make clean
```


The input.dat file must contain:

</dt>        # Integration time step
</dt_out>      # Time interval between data outputs
</t_end>       # Total simulation time
n           # Number of particles
m x y z vx vy vz   # For each particle: mass, initial position, and velocity


The output file contains the simulation time followed by the 3D positions (x, y, z) of all particles at that time.

You can visualize the simulation using the Python script provided in Graphics/figures.py.
```bash
python Graphics/figures.py
```

This script reads output.dat and generates trajectory plots or animations (animation.gif) inside the Graphics/ folder.

To reproduce the same environment, use the requirements.txt file:
```bash
conda create -n neutron python=3.13.9
conda activate neutron
pip install -r Graphics/requirements.txt
```

---

# Technical Description

The code uses the Leapfrog integration method, a numerical scheme commonly used for N-body dynamics simulations.
A small softening parameter eps is included to avoid division by zero during force computation.

Main modules:

geometry.f90: Defines the vector3d type and overloaded point and vector operations.

particle.f90: Defines the particle3d type, containing mass (m), position (p), and velocity (v).

ex1.f90: Main program that:

    1. Reads initial parameters and particle data.

    2. Computes initial accelerations.

    3. Integrates motion using Leapfrog.

    4. Periodically writes positions to output.dat.
