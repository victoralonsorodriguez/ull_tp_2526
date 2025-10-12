program ex1

  use iso_fortran_env, only: real64
  use geometry
  use particle
  implicit none

  integer :: i, n
  real(real64) :: dt, t_end, dt_out, t_out
  real(real64) :: t

  type(particle3d), allocatable :: particles(:)
  type(vector3d), allocatable :: a(:) ! Array for accelerations

  character(len=100) :: input_filename
  integer :: unit_in, unit_out

  real(real64), parameter :: epsilon2 = 1.0e-6_real64

  !====================================================================
  ! MAIN PROGRAM
  !====================================================================

  ! Read the filename from the command line
  call get_command_argument(1, input_filename)

  ! Open files (simplified error handling)
  open(newunit=unit_in, file=trim(input_filename), status='old', action='read')
  open(newunit=unit_out, file='output.dat', status='replace', action='write')

  ! Read simulation parameters
  read(unit_in, *) dt
  read(unit_in, *) dt_out
  read(unit_in, *) t_end
  read(unit_in, *) n

  ! Allocate memory
  allocate(particles(n))
  allocate(a(n))

  ! Read particle data
  do i = 1, n
    read(unit_in, *) particles(i)%m, particles(i)%p%x, particles(i)%p%y, particles(i)%p%z, &
                     particles(i)%v%x, particles(i)%v%y, particles(i)%v%z
  end do

  ! Calculate initial accelerations (by calling the subroutine)
  call compute_accelerations(particles, a, n)

  ! Initialize time variables
  t_out = 0.0_real64
  t = 0.0_real64

  ! Main loop
  do while (t <= t_end)

    ! Leapfrog integration 

    ! Update velocity a half-step
    do i = 1, n
      particles(i)%v = particles(i)%v + a(i) * (dt / 2.0_real64)
    end do

    ! Update position a full-step
    do i = 1, n
      particles(i)%p = particles(i)%p + particles(i)%v * dt
    end do

    ! Recalculate accelerations with the new positions 
    call compute_accelerations(particles, a, n)

    ! Complete the velocity update
    do i = 1, n
      particles(i)%v = particles(i)%v + a(i) * (dt / 2.0_real64)
    end do

    ! Write to the output file 
    t_out = t_out + dt
    if (t_out >= dt_out) then
      write(unit_out, '(E18.8, 1X)', advance='no') t
      do i = 1, n
        write(unit_out, '(3(E18.8,1X))', advance='no') &
          particles(i)%p%x, particles(i)%p%y, particles(i)%p%z
      end do
      write(unit_out, *) 
      t_out = 0.0_real64
    end if

    t = t + dt
  end do

  ! Close files at the end
  close(unit_in)
  close(unit_out)


contains

  !====================================================================
  ! SUBROUTINE
  !====================================================================

  ! Subroutine to calculate accelerations
  subroutine compute_accelerations(particles, a, n)
    integer, intent(in) :: n
    type(particle3d), intent(in) :: particles(n)
    type(vector3d), intent(out) :: a(n)
    
    integer :: i, j
    type(vector3d) :: rij
    real(real64) :: r2, r3

    ! Reset accelerations to zero
    do i = 1, n
      a(i) = vector3d(0.0_real64, 0.0_real64, 0.0_real64)
    end do

    ! Calculate the acceleration of each particle due to all others
    do i = 1, n
      do j = i + 1, n
        rij = particles(j)%p - particles(i)%p
        r2 = rij%x**2 + rij%y**2 + rij%z**2
        r3 = (r2 + epsilon2)**(1.5_real64)
        
        a(i) = a(i) + (particles(j)%m / r3) * rij
        a(j) = a(j) - (particles(i)%m / r3) * rij 
      end do
    end do
  end subroutine compute_accelerations

end program ex1


