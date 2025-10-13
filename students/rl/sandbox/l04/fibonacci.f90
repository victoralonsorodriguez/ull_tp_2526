! Exercise 3: write a recursive function that returns the nth Fibonacci number

program test_fibonacci
     implicit none
     integer :: n

    print *, "Enter n:"
    read *, n 

    ! print and compare
    print *, "Recursive Fibonacci(", n, ")=", fibo_recursive(n)
    print *, "Iterative Fibonacci(", n, ")=", fibo_iterative(n)

contains

    ! Recursive implementation
    recursive function fibo_recursive(n) result(f)
        implicit none
        integer, intent(in) :: n 
        integer :: f 

        if (n<0) then
            print *, "rror: Fibonacci is undefined for negative n."
            f = -1 ! placeholder to avoid issues
            ! Pending improvement: add something here to stop the execution
        else if (n==0) then
            f = 0
        else if (n==1) then
            f = 1
        else 
            f = fibo_recursive(n-1) + fibo_recursive(n-2) 
        end if

    end function fibo_recursive

    ! Iterative implementation
    function fibo_iterative(n) result(f)
        implicit none
        integer, intent(in) :: n
        integer :: f, i, a, b, c 

        if (n==0) then
            f = 0
        else if (n==1) then
            f = 1
        else
            a = 0 ! F(0)
            b = 1 ! F(1)
            do i=2, n 
                c = a+b ! compute next fibonacci number
                a = b 
                b = c 
            end do
            f = b 
        end if

    end function fibo_iterative

end program test_fibonacci