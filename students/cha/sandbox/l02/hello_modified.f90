program hello
  implicit none
  integer :: n, i

  ! Pedir al usuario el número de repeticiones
  print *, "Introduce the number of times you want to print 'Hello world!':"
  read *, n

  ! Bucle para imprimir n veces
  do i = 1, n
     print *, "Hello world!"
  end do

end program hello
