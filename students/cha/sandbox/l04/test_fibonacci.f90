program test_fibonacci
    implicit none
    integer :: n
    integer :: fib_n

    ! Ask the user for input
    print *, "Enter a non-negative integer n to compute the nth Fibonacci number:"
    read *, n

    ! Check for invalid input
    if (n < 0) then
        print *, "ERROR: Fibonacci is not defined for negative numbers."
        stop
    end if

    ! Compute Fibonacci
    fib_n = fibonacci(n)

    ! Print result
    print *, "Fibonacci(", n, ") = ", fib_n

contains

    ! Recursive Fibonacci function
    recursive integer function fibonacci(n) result(fib)
        implicit none
        integer, intent(in) :: n

        ! Base cases
        if (n == 0) then
            fib = 0
        else if (n == 1) then
            fib = 1
        else
            ! Recursive call
            fib = fibonacci(n-1) + fibonacci(n-2)
        end if

    end function fibonacci

end program test_fibonacci
