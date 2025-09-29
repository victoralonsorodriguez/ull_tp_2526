program static_demo
  implicit none
  real, dimension(100) :: x
  integer :: i

  do i = 1, 100
    x(i) = i * 0.1
  end do

  print *, "x(100) = ", x(100)
end program static_demo
