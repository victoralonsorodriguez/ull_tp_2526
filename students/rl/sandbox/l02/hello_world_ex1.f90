! Exercise 1: Modify the “Hello world” program to print it n times, where n is read from the terminal.

! We will need to add: variable to store n, a loop to print the message n times, and a read statement
! to get n from the user

program hello_times
    implicit none
    ! it would also be valid: integer :: n, i
    integer :: n ! number of times to print
    integer :: i ! loop counter
    print *, "Enter the number of times to print 'Hello, world!':"
    read *, n
    do i = 1, n
        print *, "Hello, world!"
    end do
end program hello_times
