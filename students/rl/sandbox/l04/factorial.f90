! Exercise 2: write a recursive function that computes n!

program testing
    implicit none
    integer :: n

    ! Test the function (as I would prefer to do it):
    print *, "Enter a number to compute its factorial:"
    read *, n 
    print *, n, "! = ", factorial(n)

    ! NOTA: what the exercise asks for would be:
    !n = 5
    !print *, n, "! = ", factorial(n)

    !n = 10
    !print *, n, "! = ", factorial(n)

contains

    recursive function factorial(n) result(facto)
        integer, intent(in) :: n
        integer :: facto 

        if (n < 0) then
            print *, "ERROR: factorial can't be computed for a negative number!"
            facto = -1 ! to keep code from crashing 
            ! should find a better way to stop the code? Pending improvement...
        else if (n==0) then
            facto = 1
        else
            facto = n*factorial(n-1)
        end if

    end function factorial

end program testing