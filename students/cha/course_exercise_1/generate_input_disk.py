import numpy as np

# --- Simulation parameters ---
n_particles = 50
disk_radius = 1.0
filename = "input_disk.dat"

# --- Input file parameters ---
dt = "0.001"
dt_out = "0.01"
t_end = "10.0"

particle_mass = 1.0e-3   # mass of each particle
M_central = 1.0          # mass of the central body
G = 1.0                  # gravitational constant

# --- Vertical dispersion ---
z_dispersion = 0.05       # typical vertical thickness of the disk (position)
vz_dispersion = 0.05      # vertical velocity dispersion

# --- Generate positions ---
radius = np.sqrt(np.random.uniform(0, 1, n_particles)) * disk_radius
angle = np.random.uniform(0, 2 * np.pi, n_particles)
pos_x = radius * np.cos(angle)
pos_y = radius * np.sin(angle)
pos_z = np.random.normal(0.0, z_dispersion, n_particles)  # vertical dispersion

# --- Circular orbital velocities ---
velocity_mag = np.sqrt(G * M_central / np.maximum(radius, 0.05))
vel_x = -velocity_mag * np.sin(angle)
vel_y = velocity_mag * np.cos(angle)
vel_z = np.random.normal(0.0, vz_dispersion, n_particles)  # vertical velocity dispersion

# --- Write the input file ---
with open(filename, "w") as f:
    # Global parameters
    f.write(f"{dt}\n{dt_out}\n{t_end}\n{n_particles + 1}\n")

    # Central mass fixed at the origin
    f.write(f"{M_central} 0.0 0.0 0.0 0.0 0.0 0.0\n")

    # Orbiting particles
    for i in range(n_particles):
        f.write(
            f"{particle_mass} "
            f"{pos_x[i]:.8f} {pos_y[i]:.8f} {pos_z[i]:.8f} "
            f"{vel_x[i]:.8f} {vel_y[i]:.8f} {vel_z[i]:.8f}\n"
        )

print(f"File '{filename}' successfully generated with {n_particles} particles + central mass.")
