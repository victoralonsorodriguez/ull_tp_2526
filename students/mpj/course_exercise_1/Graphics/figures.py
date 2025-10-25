from matplotlib.animation import FuncAnimation
import matplotlib.pylab as plt
import pandas as pd

# Reading the output file
path = "C:/Users/uSer/Documents/Máster Astrofísica/Segundo curso/Programación/fortran_course/students/mpj/course_exercise_1/output.dat"
df = pd.read_csv(path, sep=r"\s+", header=None)  # separador por espacios
df.columns = ["x", "y", "z"]
#print(df)
steps = int(len(df) / 3)


# =========================================================
# PARTICLES MOVEMENT ANIMATION
# =========================================================

# Initialising the figure
fig, ax = plt.subplots(1, 1, figsize=(8, 8))
line, = ax.plot([], [], 'o')

x_min, x_max = df["x"].min(), df["x"].max()
y_min, y_max = df["y"].min(), df["y"].max()

# 10% margin of the larger axis range to keep all particles visible
margin = 0.1 * max(x_max - x_min, y_max - y_min)

ax.set_xlim(x_min - margin, x_max + margin)
ax.set_ylim(y_min - margin, y_max + margin)
ax.set_aspect('equal', 'box')

ax.set_xlabel("x")
ax.set_ylabel("y")

title = ax.set_title('')


# Initialisation function
def init():
    line.set_data([], [])
    return line


# Función que se llama en cada frame de la animación
def update(frame):
    lines_part = range(3*frame, 3*frame + 3)
    reduced_df = df.iloc[lines_part]
    x, y = reduced_df["x"].tolist(), reduced_df["y"].tolist()

    line.set_data(x, y)
    title.set_text(f"t = {frame}")

    return line, title


# Creating the animation
ani = FuncAnimation(fig, update, init_func=init, frames=steps, interval=50, blit=False)
#ani.save("animation.gif", writer="pillow", fps=5)

plt.show()
