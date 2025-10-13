program leapfrog
  use geometry
  use particle
  implicit none

  integer :: i, j
  integer :: n
  real(kind=8) :: dt, t_end, t, dt_out, t_out
  real(kind=8) :: r2, r3
  
  type(particle3d), allocatable :: p(:) ! We re-define those using the definitions from the modules
  type(vector3d), allocatable :: a(:)
  type(vector3d) :: rji
  character(len=100) :: infile
  integer :: ios, iu

  ! --- Definir directamente el archivo ---
  infile = "input_ex.dat"

  ! --- Abrir el archivo ---
  iu = 10
  open(unit=iu, file=trim(infile), status='old', action='read', iostat=ios)
  if (ios /= 0) then
     print *, "Error: no se pudo abrir el archivo ", trim(infile)
     stop
  end if

  ! --- Leer parámetros ---
  read(iu, *) dt 		! In the example input we have the parameters ordered as here
  read(iu, *) dt_out
  read(iu, *) t_end
  read(iu, *) n

  allocate(p(n))
  allocate(a(n))

  ! --- Read particles (masses, positions and velocities) from the input file ---
  do i = 1, n
     read(iu, *) p(i)%m, p(i)%p%x, p(i)%p%y, p(i)%p%z, &
                  p(i)%v%x, p(i)%v%y, p(i)%v%z
  end do

  close(iu)

  ! --- Calcular aceleraciones iniciales ---
  a = vector3d(0.0d0, 0.0d0, 0.0d0)
  do i = 1, n
     do j = i + 1, n
        rji%x = p(j)%p%x - p(i)%p%x
        rji%y = p(j)%p%y - p(i)%p%y
        rji%z = p(j)%p%z - p(i)%p%z

        r2 = rji%x**2 + rji%y**2 + rji%z**2
        r3 = r2 * sqrt(r2)

        a(i)%x = a(i)%x + p(j)%m * rji%x / r3
        a(i)%y = a(i)%y + p(j)%m * rji%y / r3
        a(i)%z = a(i)%z + p(j)%m * rji%z / r3

        a(j)%x = a(j)%x - p(i)%m * rji%x / r3
        a(j)%y = a(j)%y - p(i)%m * rji%y / r3
        a(j)%z = a(j)%z - p(i)%m * rji%z / r3
     end do
  end do

  ! --- Abrir archivo de salida ---
  open(unit=20, file="output.dat", status="replace", action="write", iostat=ios)
  if (ios /= 0) then
     print *, "Error: no se pudo crear output.dat"
     stop
  end if

  ! --- Integración Leapfrog ---
  t_out = 0.0d0
  do t = 0.0d0, t_end, dt

     ! medio paso de velocidad
     do i = 1, n
        p(i)%v = p(i)%v + (0.5d0 * dt) * a(i)
     end do

     ! paso de posición
     do i = 1, n
        p(i)%p = p(i)%p + dt * p(i)%v
     end do

     ! recalcular aceleraciones
     a = vector3d(0.0d0, 0.0d0, 0.0d0)
     do i = 1, n
        do j = i + 1, n
           rji%x = p(j)%p%x - p(i)%p%x
           rji%y = p(j)%p%y - p(i)%p%y
           rji%z = p(j)%p%z - p(i)%p%z

           r2 = rji%x**2 + rji%y**2 + rji%z**2
           r3 = r2 * sqrt(r2)

           a(i)%x = a(i)%x + p(j)%m * rji%x / r3
           a(i)%y = a(i)%y + p(j)%m * rji%y / r3
           a(i)%z = a(i)%z + p(j)%m * rji%z / r3

           a(j)%x = a(j)%x - p(i)%m * rji%x / r3
           a(j)%y = a(j)%y - p(i)%m * rji%y / r3
           a(j)%z = a(j)%z - p(i)%m * rji%z / r3
        end do
     end do

     ! medio paso final de velocidad
     do i = 1, n
        p(i)%v = p(i)%v + (0.5d0 * dt) * a(i)
     end do

     ! salida periódica
     t_out = t_out + dt
     if (t_out >= dt_out) then
        write(20,'(F12.6, 999(F12.6))') t, (p(i)%p%x, p(i)%p%y, p(i)%p%z, i=1,n)
        t_out = 0.0d0
     end if

  end do

  close(20)

end program leapfrog

