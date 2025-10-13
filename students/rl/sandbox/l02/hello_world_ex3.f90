! Exercise 3: Write a program that prints r! where r is a positive real number read from the terminal.
! NOTA: for real numbers, r!=gamma(r+1)

program hello_ex3
    implicit none
    real :: r !real number input
    real :: result !result from the factorial

    do
        print *, "Enter a positive real number r to compute r!:"
        read *, r
        if (r > 0.0) exit ! leave the loop if input is valid
        print *, "Error: Please enter a POSITIVE real number!"
    end do

    ! We must compute it using gamma function: r! = gamma(r+1)
    result = gamma(r + 1.0)
    print *, r, "! =", result

end program hello_ex3
