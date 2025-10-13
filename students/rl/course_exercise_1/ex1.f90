! Take the old leapfrog.f90 code and modify it to use the geometry and particle
! modules. Store the program in ex1.f90 file.
! DISCLAIMER: THIS IS STILL IN PROGRESS AND NEEDS TO BE CLEANED UP

program leapfrog

   use geometry
   use particle
   implicit none

   integer :: i, j, n
   real :: dt, t_end, t, dt_out, t_out
   real :: r2, r3
   type(vector3d) :: rji
   type(particle3d), allocatable :: p(:)
   type(vector3d), allocatable :: a(:)
   character(len=100) :: infile
   integer :: input_unit, output_unit, ios

   !real, dimension(:), allocatable :: m
   !real, dimension(:,:), allocatable :: r,v,a
   !real, dimension(3) :: rji

   call get_command_argument(1, infile)
   if (len_trim(infile) == 0) then
      print *, "Usage: ./ex1 <input_file>"
      stop
   end if

   input_unit = 10
   open(unit=input_unit, file=trim(infile), status='old', action='read', iostat=ios)
   if (ios /= 0) then
      print *, "Error: cannot open input file ", trim(infile)
      stop
   end if

   read (input_unit, *) dt ! time step 
   read (input_unit, *) dt_out ! output interval
   read (input_unit, *) t_end ! end time
   read (input_unit, *) n ! number of particles

   allocate(p(n))
   allocate(a(n))

   !allocate(m(n))
   !allocate(r(n,3))
   !allocate(v(n,3))
   !allocate(a(n,3))

   ! Read particle data: m, position (x y z), velocity (vx vy vz)
   do i = 1, n
      read (input_unit, *) p(i)%m, p(i)%p%x, p(i)%p%y, p(i)%p%z, p(i)%v%x, p(i)%v%y, p(i)%v%z
   end do

   close(input_unit)
   ! Compute initial acceleration components
   !type(vector3d), allocatable :: a(:)
   !allocate(a(n))
   a = vector3d(0.0, 0.0, 0.0)
   
   do i = 1,n
      do j = i+1,n
         ! for each unique pair of particles (i,j) (no double-counting):
         rji = p(j)%p - p(i)%p ! vector from i to j
         !r2 = sum(rji**2)
         r2 = rji%x**2 + rji%y**2 + rji%z**2
         r3 = r2 * sqrt(r2)
         a(i) = a(i) + (p(j)%m/r3)* rji
         a(j) = a(j) - (p(i)%m / r3) * rji
      end do
   end do

   output_unit = 20
   open(unit=output_unit, file="output.dat", status="replace", action="write")

   t_out = 0.0 ! initialize output timer
   t = 0.0
   ! Time integration loop
    !do t = 0.0, t_end, dt
    do while (t <= t_end)
        ! Half-step velocity update
        do i = 1, n
            p(i)%v = p(i)%v + 0.5 *dt*a(i)
        end do

        !  Full step position update 
        do i = 1, n
            p(i)%p = p(i)%p + dt * p(i)%v
        end do

        ! Recompute acceleration components
        a = vector3d(0.0, 0.0, 0.0)
        do i = 1, n
            do j = i+1, n
                rji = p(j)%p - p(i)%p
                r2 = rji%x**2 + rji%y**2 + rji%z**2
                r3 = r2 * sqrt(r2)
                a(i) = a(i) + (p(j)%m / r3) * rji
                a(j) = a(j) - (p(i)%m / r3) * rji
            end do
        end do

        ! Finish the velocity update (this completes the other half step)
        do i = 1, n
            p(i)%v = p(i)%v + 0.5 * dt * a(i)
        end do

        ! Output: write out all the particle positions at intervals in a .dat file
        t_out = t_out + dt
        if (t_out >= dt_out) then
            write(output_unit, '(F10.4)', advance='no') t
            do i = 1, n
                write(output_unit, '(3(1X,F12.6))', advance='no') p(i)%p%x, p(i)%p%y, p(i)%p%z
            end do
            write(output_unit, *)  ! newline
            t_out = 0.0
        end if

        t = t + dt
    end do

    close(output_unit)
    print *, "Simulation complete. Results have been written in file output.dat"
  
end program leapfrog