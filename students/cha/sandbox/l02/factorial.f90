program factorials
  implicit none
  integer :: n, i
  integer(16) :: fact  ! If we dont use 16-bytes we'll have some issues dealing with big numbers

  ! Ask the user for n
  print *, "Enter an integer n:"
  read *, n


  fact = 1   ! We initialize factorial (like a counter, but multipliying)

  ! Loop to calculate factorials from 0 to n
  do i = 0, n
     if (i == 0) then
        fact = 1
     else
        fact = fact * i
     end if
     print *, i, "! =", fact
  end do

end program factorials
