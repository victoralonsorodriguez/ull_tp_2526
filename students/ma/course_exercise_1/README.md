Angeles Moreno Guedes -- ma/course_exercise_1

This code has four files. The main program is ex1.f90 where the leapfrog integration is made
The ex1.f90 uses the module geometry that includes several functions to compute vector and points operations.
And particles module that defines a derived type to descripe the principal characteristics of a particle to describe his movement

In order to use the code is important to first compile it with the makefile using make in the directory where the code is

make

And then if you want to run a test you can use

make test

The program has a default input.dat with the initial conditions of the particles time and number of particles
If you want to change it it is convenient to use the same name input.dat
Finally the output will be an output.dat with time pos1x pos1y pos1z ....posnx posny posnz that will appear when the program ends in the same
folder.
