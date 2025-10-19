program leapfrog
  use geometry
  use particle
  implicit none

  integer :: i, j, n
  real(8) :: dt, t_end, t, dt_out, t_out
  real(8) :: r2, r3
  type(vector3d) :: rji

  ! Dynamic arrays to store particles and their accelerations; size will be allocated at runtime
  type(particle3d), allocatable :: particles(:)
  type(vector3d), allocatable :: a(:)

  read *, dt        ! integration step
  read *, dt_out    ! time between two positions prints
  read *, t_end     ! total time of the simulation
  read *, n         ! number of particles

  ! Giving size to the arrays
  allocate(particles(n))
  allocate(a(n))

  ! Reading masses, positions and velocities
  do i = 1, n
     read *, particles(i)%m, particles(i)%p%x, particles(i)%p%y, particles(i)%p%z, &
             particles(i)%v%x, particles(i)%v%y, particles(i)%v%z
     a(i) = vector3d(0.0_8,0.0_8,0.0_8)
  end do

  ! Calculate the initial acceleration
  do i = 1, n
     do j = i+1, n
        rji = particles(j)%p - particles(i)%p
        r2 = rji%x**2 + rji%y**2 + rji%z**2
        r3 = r2 * sqrt(r2)
        a(i) = a(i) + particles(j)%m * rji / r3    ! Newton force
        a(j) = a(j) - particles(i)%m * rji / r3
     end do
  end do

  ! Leapfrog integration
  t_out = 0.0_8
  do t = 0.0_8, t_end, dt
     do i = 1, n
       particles(i)%v = particles(i)%v + a(i) * (dt / 2.0_8)
       particles(i)%p = particles(i)%p + particles(i)%v * dt
       a(i) = vector3d(0.0_8, 0.0_8, 0.0_8)
     end do

     do i = 1,n
        do j = i+1,n
           rji = particles(j)%p - particles(i)%p
           r2 = rji%x**2 + rji%y**2 + rji%z**2
           r3 = r2 * sqrt(r2)
           a(i) = a(i) + particles(i)%m * rji / r3
           a(j) = a(j) - particles(j)%m * rji / r3
        end do
     end do
     
     do i = 1, none
       particles(i)%v = particles(i)%v + a(i) * (dt / 2.0_8)
     end do
     
     ! Output
     t_out = t_out + dt
     if (t_out >= dt_out) then
        do i = 1,n
           print*, particles(i)%p%x, particles(i)%p%y, particles(i)%p%z
        end do
        t_out = 0.0_8
     end if
  end do
  
end program leapfrog
