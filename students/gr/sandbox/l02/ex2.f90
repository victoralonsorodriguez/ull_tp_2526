! Write a program that prints factorials n! from 0 to n.

program ex2
    implicit none
    integer :: n, i, j, p, fact
    !print *, "Intruduce number of iterations: "
    !read *, n
    n = 10
    do i = 0, n
        if (i == 0) then
            print *, "Factorial of ", i, " is ", 1
        else
            p = 1
            do j = 1, i
                p = p*j
            end do 

            fact = p
            print *, "Factorial of ", i, " is ", fact
        end if
    end do
end program ex2