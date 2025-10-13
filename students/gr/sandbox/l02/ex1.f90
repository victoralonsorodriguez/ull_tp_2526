! Modify the “Hello world” program to print it n times, where n is read from the terminal.

program ex1
    implicit none
    integer :: n, i
    print *, "Introduce number of iterations: "
    read *, n
    do i = 1, n
        print * , " Hello world ! "
    end do
end program ex1