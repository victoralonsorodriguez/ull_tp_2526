# Compilador
FC = gfortran

# Opciones de compilación
FFLAGS = -Wall -Wextra -O2

# Archivos
MODULES = geometry particle
PROGRAM = ex1
OBJECTS = $(MODULES:%=%.o) $(PROGRAM).o
EXEC = ex1

# Archivos de entrada/salida
INPUT = input.dat
OUTPUT = output.dat

# Regla por defecto
all: $(EXEC) run

# Compilar módulos
geometry.o: geometry.f90
	$(FC) $(FFLAGS) -c $<

particle.o: particle.f90 geometry.o
	$(FC) $(FFLAGS) -c $<

# Cómo compilar el ejecutable
$(EXEC): $(OBJECTS)
	$(FC) $(FFLAGS) -o $@ $(OBJECTS)

# Cómo compilar los módulos y el main
%.o: %.f90
	$(FC) $(FFLAGS) -c $<

# Ejecutar el programa con los datos
run: $(EXEC) $(INPUT)
	@echo ">>> Ejecutando $(EXEC) con $(INPUT)..."
	$(EXEC) < $(INPUT) > $(OUTPUT)
	@echo ">>> Resultado guardado en $(OUTPUT)"

# Limpiar archivos intermedios
clean:
	rm -f *.o *.mod $(EXEC) $(OUTPUT)
