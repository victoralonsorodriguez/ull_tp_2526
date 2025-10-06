! Exercise 1B: create a main program file that uses the mymath module and 
! calculates the area of c circle with radius 2.
! Finally, compile and link the module and program

program test
    use mymath
    implicit none
    print *, circle_area(2.0)
end program test

! NOTA: it's not what the exercise asks, but it could be made more general like this:

! program test
! use mymath
! real :: r
! print *, "Enter radius of the circle:"
! read *, r
! print *, "The area of a circle with radius", r, "is", circle_area(r)
! end program test

! Both source files can be compiled together using:
! gfortran -o ex1 test_mymath.f90 mymath.f90