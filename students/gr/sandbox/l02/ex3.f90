! Write a program that prints r ! where r is a positive real number read from the terminal.

program ex3
    implicit none
    integer :: n, i, p, fact
    print *, "Introduce factorial to calculate: "
    read *, n
    if (n == 0) then
        print *, "Factorial of ", n, " is ", 1
    else
        p = 1
        do i = 1, n
            p = p*i
        end do 

        fact = p
        print *, "Factorial of ", n, " is ", fact
    end if
end program ex3