# Compilador
FC = gfortran

# Opciones de compilación
FFLAGS = -Wall -O2

# Archivos
MODULES = geometry particle
PROGRAM = test_geometry
OBJS = $(MODULES:%=%.o) $(PROGRAM).o

# Regla por defecto
all: $(PROGRAM).exe

# Compilar módulos
geometry.o: geometry.f90
	$(FC) $(FFLAGS) -c $<

particle.o: particle.f90 geometry.o
	$(FC) $(FFLAGS) -c $<

# Compilar programa principal
$(PROGRAM).o: $(PROGRAM).f90 $(MODULES:%=%.o)
	$(FC) $(FFLAGS) -c $<

# Enlazar ejecutable
$(PROGRAM).exe: $(OBJS)
	$(FC) $(FFLAGS) -o $@ $(OBJS)

# Limpiar archivos intermedios
clean:
	rm -f *.o *.mod *.exe
