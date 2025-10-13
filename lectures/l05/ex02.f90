program dynamic_demo
  implicit none
  real, dimension(:), allocatable :: y
  integer :: n, i, ierr

  print *, "Enter size:"
  read *, n
  allocate(y(n), stat=ierr)
  if (ierr /= 0) then
    print*, 'Memory allocation failed'
    stop
  end if

  do i = 1, n
    y(i) = i * 0.5
  end do

  print *, "y(n) = ", y(n)
  deallocate(y)
end program dynamic_demo
