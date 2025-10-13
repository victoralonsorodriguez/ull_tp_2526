 program hello
    implicit none
    integer :: n ! Number of times to print the message

    print *, "Enter the number of times do you want to print Hello"
    read *, n

    do n = 1, n
       print *, "Hello world!"
    end do
 end program hello

 