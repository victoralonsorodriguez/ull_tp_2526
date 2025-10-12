program ex1
  use iso_fortran_env, only: real64
  use geometry
  use particle
  implicit none

  integer :: i, j, n
  real(real64) :: dt, t_end, dt_out, t_out
  real(real64) :: t

  type(particle3d), allocatable :: particles(:)
  type(vector3d), allocatable :: a(:)

  character(len=100) :: input_filename
  integer :: ios
  integer :: unit_in, unit_out

  ! Read input filename from command line
  call get_command_argument(1, input_filename)

  open(newunit=unit_in, file=trim(input_filename), status='old', action='read', iostat=ios)
  if (ios /= 0) then
    print *, 'Error opening input file.'
    stop
  endif

  open(newunit=unit_out, file='output.dat', status='replace', action='write', iostat=ios)
  if (ios /= 0) then
    print *, 'Error opening output file.'
    stop
  endif

  ! Read simulation parameters
  read(unit_in,*) dt
  read(unit_in,*) dt_out
  read(unit_in,*) t_end
  read(unit_in,*) n

  allocate(particles(n))
  allocate(a(n))

  do i = 1, n
    read(unit_in,*) particles(i)%m, particles(i)%p%x, particles(i)%p%y, particles(i)%p%z, &
                     particles(i)%v%x, particles(i)%v%y, particles(i)%v%z
  end do

  a = vector3d(0.0_real64, 0.0_real64, 0.0_real64)

  ! Compute initial accelerations
  do i = 1, n
    do j = i + 1, n
      call update_acceleration(particles(i), particles(j), a(i), a(j))
    end do
  end do

  t_out = 0.0_real64
  t = 0.0_real64

  do while (t <= t_end)
    ! Leapfrog integration
    do i = 1, n
      particles(i)%v = particles(i)%v + a(i) * (dt / 2.0_real64)
      particles(i)%p = particles(i)%p + particles(i)%v * dt
    end do

    ! Reset accelerations
    a = vector3d(0.0_real64, 0.0_real64, 0.0_real64)

    ! Calculate new accelerations
    do i = 1, n
      do j = i + 1, n
        call update_acceleration(particles(i), particles(j), a(i), a(j))
      end do
    end do

    ! Complete velocity update
    do i = 1, n
      particles(i)%v = particles(i)%v + a(i) * (dt / 2.0_real64)
    end do

    t_out = t_out + dt
    if (t_out >= dt_out) then
      write(unit_out, '(F8.4)', advance='no') t
      do i = 1, n
        write(unit_out, '(3(F12.6,1X))', advance='no') particles(i)%p%x, particles(i)%p%y, particles(i)%p%z
      end do
      write(unit_out,*)
      t_out = 0.0_real64
    end if

    t = t + dt
  end do

  close(unit_in)
  close(unit_out)

contains

  pure subroutine update_acceleration(p1, p2, a1, a2)
    type(particle3d), intent(in) :: p1, p2
    type(vector3d), intent(inout) :: a1, a2
    type(vector3d) :: rji
    real(real64) :: r2, r3

    rji = p2%p - p1%p
    r2 = rji%x**2 + rji%y**2 + rji%z**2
    r3 = r2 * sqrt(r2)

    a1 = a1 + (p2%m / r3) * rji
    a2 = a2 - (p1%m / r3) * rji
  end subroutine update_acceleration

end program ex1


