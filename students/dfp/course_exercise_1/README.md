# N-Body Simulation Project

This project implements an N-body gravitational simulation using both Fortran and Python, demonstrating the performance differences between compiled and interpreted languages for computationally intensive tasks.

## Overview

The simulation uses the leapfrog integration method to solve the N-body problem, computing gravitational forces between particles and evolving their positions and velocities over time. The project includes setup generators for different initial configurations and visualization tools for the results.

## Project Structure

### Core Simulation Files
- **`ex1.f90`** - Main Fortran simulation program
- **`ex1.py`** - Python equivalent of the simulation
- **`geometry.f90`** - Fortran module for 3D vector operations
- **`particle.f90`** - Fortran module for particle data structures

### Setup and Visualization
- **`setup.py`** - Python script to generate initial particle configurations
- **`animation.py`** - Python script to create animated visualizations
- **`makefile`** - Build system for Fortran components

### Data Files (not uploaded)
- **`setup_*.dat`** - Initial particle configurations (disk, random, hannu)
- **`output_*.dat`** - Simulation output data
- **`animation_*.gif`** - Generated animation files

## Features

### Initial Configurations
1. **Disk Galaxy**: Exponential disk profile with circular velocities
2. **Random Distribution**: Uniform random distribution in a cubic box
3. **Custom Configurations**: Support for user-defined setups

### Integration Method
- **Leapfrog Integration**: Second-order symplectic integrator
- **Adaptive Time Stepping**: Configurable time steps for accuracy vs. performance
- **Optional Softening**: Gravitational softening parameter to avoid singularities

## Performance Comparison: Fortran vs Python

A critical aspect of this project is the dramatic performance difference between the two implementations:

| Language | Disk Simulation Time | Performance Ratio |
|----------|---------------------|-------------------|
| **Fortran** | **94 seconds** | **1x (baseline)** |
| **Python** | **34 minutes 40 seconds** | **~22x slower** |

### Analysis

The performance difference demonstrates several key concepts:

1. **Compiled vs Interpreted**: Fortran is compiled to optimized machine code, while Python is interpreted
2. **Memory Management**: Fortran uses static arrays with predictable memory access patterns
3. **Loop Optimization**: Fortran compilers can heavily optimize nested loops, crucial for O(N²) force calculations
4. **Numerical Libraries**: While Python uses NumPy (which is fast), the overhead of Python function calls becomes significant in tight loops

### When to Use Each

**Use Fortran when:**
- Maximum performance is critical
- Working with large-scale simulations (N > 10,000 particles)
- Running production scientific codes
- Memory usage must be minimized

**Use Python when:**
- Rapid prototyping and development
- Interactive analysis and visualization
- Integration with scientific Python ecosystem
- Educational purposes and code readability

## Building and Running

### Fortran Version

```bash
# Compile the Fortran code
make

# Run with a setup file
./ex1 < setup_disk.dat

# Clean build artifacts
make clean
```

### Python Version

```bash
# Generate initial configurations
python setup.py

# Run the simulation
python ex1.py

# Create animations
python animation.py
```

## Simulation Parameters

Key parameters in setup files:
- **dt**: Integration time step (e.g., 5e-5)
- **dt_out**: Output interval (e.g., 0.05)
- **t_end**: Total simulation time (e.g., 8.0)
- **n**: Number of particles (e.g., 500)

## Visualization

The project includes 3D animation capabilities:
- Particle trajectories over time
- Configurable viewing angles and zoom
- Export to GIF format
- Dark theme optimized for astrophysical visualization

## Dependencies

### Fortran
- `gfortran` compiler
- Standard Fortran 2008+ features

### Python
- `numpy` - Numerical computations
- `matplotlib` - Plotting and animation
- `tqdm` - Progress bars

## Educational Value

This project serves as an excellent demonstration of:
- Numerical integration methods in physics
- Performance considerations in scientific computing
- Language trade-offs for computational problems
- Modern Fortran programming practices
- Scientific Python ecosystem usage

## Future Enhancements

Potential improvements include:
- OpenMP parallelization for Fortran version
- GPU acceleration using CUDA or OpenCL
- Adaptive time stepping algorithms
- Tree-based force calculation methods (Barnes-Hut)
- Additional initial condition generators (galaxy mergers, stellar clusters)
