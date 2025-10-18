module functions
    implicit none

! First task recursive function to compute the factorial of a number

    contains

    recursive function factorial(n) result(fact)
        integer, intent(in) :: n
        integer :: fact

        if (n<0) then
            print *, "A negative number does not have a factorial" ! Task 3 

        else if (n <= 1) then
            fact = 1
        else
            fact = n * factorial(n- 1)
        end if
    end function factorial

! Task 4 Fibonacci function

    recursive function fibonacci(n) result(fibo)
        integer, intent(in) :: n
        integer :: fibo

        if (n<0) then
            print *, "Enter a non-negative integer"
        
        else if (n==0) then
            fibo=0
        else if (n==1) then
            fibo=1
        else
            ! The fibonacci sequence is the sum of the two previous numbers
            fibo = fibonacci(n-1) + fibonacci(n-2)
        end if
    end function fibonacci
end module functions