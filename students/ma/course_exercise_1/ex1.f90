program leapfrog_integration
  use geometry
  use particles
  implicit none

! NO ESTA PRIMERA VERSION

! Copio el leapfrog tal cual y arreglo
  integer :: i, j
  integer :: n ! Number of part
  real(dp) :: dt, t_end, t, dt_out, t_out
  real(dp) :: rs, r2, r3
  integer :: ierr ! This is to check and deallocate


  type(particle3d), dimension(:), allocatable :: part ! It would be an array of particles
  type(vector3d), dimension(:), allocatable :: a ! We define particle acceleration
  type(vector3d), dimension(3) :: rji


  read *, dt
  read *, dt_out
  read *, t_end
  read *, n

  ! We are going to associate the components of the particle type for simplicity

  allocate(part(n))
  allocate(a(n)) 

  do i = 1, n 
     read *, part(i)%m, part(i)%p, part(i)%v
  end do

  a = vector3d(0.0,0.0,0.0)
  do i = 1,n
     do j = i+1,n
           rji = vector3d(part(j)%p%x-part(i)%p%x, part(j)%p%y-part(i)%p%y, part(j)%p%z-part(i)%p%z) 
           ! rji it would be easier if I define a subpp in geometry
           rs = distance(part(j)%p, part(i)%p) ! Here we calculate the distance with the function
           r3 = rs**3 ! Since the output of distance is the sqrt
           a(i) = a(i) + (part(j)%m * rji) / r3
           a(j) = a(j) - (part(i)%m * rji) / r3
        end do
  end do

  t_out = 0.0
  do t = 0.0, t_end, dt
     part%v = part%v + a * dt/2
     part%p = part%p + part%v * dt ! Here we are using the supv of the geometry module
     a = 0.0
     do i = 1,n
        do j = i+1,n
           rji = vector3d(part(j)%p%x-part(i)%p%x, part(j)%p%y-part(i)%p%y, part(j)%p%z-part(i)%p%z) 
           rs = distance(part(j)%p, part(i)%p) 
           r3 = rs**3 
           a(i) = a(i) + (part(j)%m * rji) / r3
           a(j) = a(j) - (part(i)%m * rji) / r3
        end do
     end do
     
     part%v = part%v + a * dt/2 ! Here we are using the multvr of the geometry module
     
     t_out = t_out + dt
     if (t_out >= dt_out) then
        do i = 1,n
           print*, part(i)%p
        end do
        t_out = 0.0
     end if
  end do

  ! Seguramente aqui deberia de liberar memoria con un deallocate

  ! Now finally we are going to check the status of the arrays and deallocate

 if (allocated(part)) deallocate(part, stat=ierr)
 if (allocated(a)) deallocate(a, stat=ierr)


end program leapfrog_integration










