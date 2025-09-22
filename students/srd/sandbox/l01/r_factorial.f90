program hello
    implicit none
    ! Declaración de variables
    INTEGER :: R, i, factorial
    ! Input del usuario
    print *, "Insert value of R (integer)"
    READ *, R
    factorial = 1
    DO i= 1,R,1
        factorial = i * factorial
    END DO
    print *, "The factorial is",factorial
end program hello
