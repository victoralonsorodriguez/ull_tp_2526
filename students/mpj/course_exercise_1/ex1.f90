program leapfrog
  use geometry
  use particle
  implicit none

  integer :: i, j, n
  real(dp) :: dt, t_end, t, dt_out, t_out
  real(dp) :: r2, r3
  type(vector3d) :: rji

  ! Softing parameter to avoid division by zero
  real(dp), parameter :: eps = 1.0e-5_dp

  ! Dynamic arrays to store particles and their accelerations; size will be allocated at runtime
  type(particle3d), allocatable :: particles(:)
  type(vector3d), allocatable :: a(:)

  ! Input parameters
  integer :: arg_count
  character(len=200) :: input_file
  integer :: ios, unit

  ! Output parameters
  character(len=200) :: output_file
  integer :: out_unit

  ! Opening the input file
  unit = 10
  input_file = "input.dat"
  open(unit, file=trim(input_file), status='old', action='read', iostat=ios)
  
  if (ios /= 0) then
   print *, "Error: can't open file ", trim(input_file)
   stop
  end if

  ! Opening the output file
  out_unit = 20
  output_file = "output.dat"
  open(out_unit, file=trim(output_file), status='replace', action='write', iostat=ios)

  if (ios /= 0) then
   print *, "Error: can't open file ", trim(output_file)
   stop
  end if

  ! Reading the input from the input file
  read (unit, *) dt        ! integration step
  read (unit, *) dt_out    ! time between two positions prints
  read (unit, *) t_end     ! total time of the simulation
  read (unit, *) n         ! number of particles

  ! Giving size to the arrays
  allocate(particles(n))
  allocate(a(n))

  ! Reading masses, positions and velocities
  do i = 1, n
     read (unit, *) particles(i)%m, particles(i)%p%x, particles(i)%p%y, particles(i)%p%z, &
             particles(i)%v%x, particles(i)%v%y, particles(i)%v%z
     a(i) = vector3d(0.0_dp,0.0_dp,0.0_dp)
  end do

  close(unit)

  ! Calculate the initial acceleration
  do i = 1, n
     do j = i+1, n
        rji = particles(j)%p - particles(i)%p
        r2 = rji%x**2 + rji%y**2 + rji%z**2 + eps**2
        r3 = r2 * sqrt(r2)
        a(i) = a(i) + particles(j)%m * rji / r3    ! Newton force
        a(j) = a(j) - particles(i)%m * rji / r3
     end do
  end do

  ! Leapfrog integration
  t_out = 0.0_dp
  do t = 0.0_dp, t_end, dt
     do i = 1, n
       particles(i)%v = particles(i)%v + a(i) * (dt / 2.0_dp)
       particles(i)%p = particles(i)%p + particles(i)%v * dt
       a(i) = vector3d(0.0_dp, 0.0_dp, 0.0_dp)
     end do

     do i = 1,n
        do j = i+1,n
           rji = particles(j)%p - particles(i)%p
           r2 = rji%x**2 + rji%y**2 + rji%z**2 + eps**2
           r3 = r2 * sqrt(r2)
           a(i) = a(i) + particles(i)%m * rji / r3
           a(j) = a(j) - particles(j)%m * rji / r3
        end do
     end do
     
     do i = 1, n
       particles(i)%v = particles(i)%v + a(i) * (dt / 2.0_dp)
     end do
     
     ! Output
     t_out = t_out + dt
     if (t_out >= dt_out) then
      write(out_unit, '(F10.5,1X)', advance='no') t  ! We update the time
      do i = 1,n
        write(out_unit, '(3F16.10,1X)', advance='no') particles(i)%p%x, particles(i)%p%y, particles(i)%p%z
      end do
      write(out_unit,*)  ! line break
        t_out = 0.0_dp
     end if
  end do

  close(out_unit)

  ! Clean up
  deallocate(particles)
  deallocate(a)
  
end program leapfrog
