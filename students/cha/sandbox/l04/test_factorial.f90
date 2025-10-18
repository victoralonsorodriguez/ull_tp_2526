program test_factorial
    implicit none
    integer :: n
    integer :: result_factorial

    ! Ask the user for input
    print *, "Enter a non-negative integer to compute its factorial:"
    read *, n

    ! Compute factorial
    result_factorial = factorial(n)

    ! Print result
    print *, n, "! = ", result_factorial

contains

    ! Recursive factorial function with input validation
    recursive integer function factorial(n) result(fact)
        implicit none
        integer, intent(in) :: n
    

        ! Check for invalid input
        if (n < 0) then
            print *, "ERROR: factorial is not defined for negative numbers."
            stop
        end if

        ! Base case
        if (n == 0) then
            fact = 1
        else
            fact = n * factorial(n-1)
        end if

    end function factorial

end program test_factorial


