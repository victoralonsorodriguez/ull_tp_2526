# Compilador
FC = gfortran

# Opciones de compilación
FFLAGS = -Wall -O2

# Archivos
MODULE = geometry
PROGRAM = test_geometry
OBJS = $(MODULE).o $(PROGRAM).o

# Regla por defecto
all: $(PROGRAM).exe

# Compilar módulo
$(MODULE).o: $(MODULE).f90
	$(FC) $(FFLAGS) -c $<

# Compilar programa principal
$(PROGRAM).o: $(PROGRAM).f90 $(MODULE).o
	$(FC) $(FFLAGS) -c $<

# Enlazar ejecutable
$(PROGRAM).exe: $(OBJS)
	$(FC) $(FFLAGS) -o $@ $(OBJS)

# Limpiar archivos intermedios
clean:
	rm -f *.o *.mod *.exe
