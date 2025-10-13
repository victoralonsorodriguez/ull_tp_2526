!not modified yet

program leapfrog
    use geometry
    use particle

    implicit none

  ! We define the integers and vectors
    integer :: i, j, n, k, n_steps
    real(8) :: dt, t_end, t, dt_out, t_out
    real(8) :: r2, r3
    type(particle3d), dimension(:), allocatable :: particles
    type(vector3d) :: rji
    type(vector3d), dimension(:), allocatable :: ac
    type(vector3d), dimension(:), allocatable :: accelerations

    ! Read input parameters
    read *, dt
    read *, dt_out  
    read *, t_end
    read *, n
    
    allocate(particles(n))
    allocate(ac(n))
    allocate(accelerations(n))

    ! First read particle data
    do i = 1, n
        read *, particles(i)%m, &
                particles(i)%p%x, particles(i)%p%y, particles(i)%p%z, &
                particles(i)%v%x, particles(i)%v%y, particles(i)%v%z
    end do

    do i = 1, n
        accelerations(i) = vector3d(0.0, 0.0, 0.0)
    end do

    do i= 1, n
        do j= i+1, n
        rji= particles(j)%p - particles(i)%p
        r2= rji%x**2 + rji%y**2 + rji%z **2
        r3= r2*sqrt(r2)
        ac(i)= (rji/r3) * particles(j)%m
        ac(j)= (rji/r3) * particles(i)%m
        accelerations(i)= accelerations(i) + ac(i)
        accelerations(j)= accelerations(j) - ac(j)
        end do
    end do

    n_steps = int(t_end / dt)
    t_out = 0.0_8
    t = 0.0_8

    do k = 0, n_steps
        t = k * dt
       
        do i = 1, n
            particles(i)%v = particles(i)%v + accelerations(i) * (dt/2.0_8)
        end do
        
        do i = 1, n
            particles(i)%p = particles(i)%p + particles(i)%v * dt
        end do
        
        do i = 1, n
            accelerations(i) = vector3d(0.0_8, 0.0_8, 0.0_8)
        end do

     do i = 1,n
        do j = i+1,n
            rji= particles(j)%p - particles(i)%p
            r2= rji%x**2 + rji%y**2 + rji%z **2
            r3= r2*sqrt(r2)
            ac(i)= (rji/r3) * particles(j)%m
            ac(j)= (rji/r3) * particles(i)%m
            accelerations(i)= accelerations(i) + ac(i)
            accelerations(j)= accelerations(j) - ac(j)
        end do
     end do

     
     do i = 1, n
            particles(i)%v = particles(i)%v + accelerations(i) * (dt/2.0)
        end do
     
     t_out = t_out + dt
     if (t_out >= dt_out) then
        do i = 1,n
           print*, particles(i)%p%x, particles(i)%p%y, particles(i)%p%z
        end do
        t_out = 0.0
     end if
 end do
  
end program leapfrog