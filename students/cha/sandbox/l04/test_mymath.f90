program test_mymath
    use mymath
    implicit none
    real :: r, area

    r = 2.0
    area = circle_area(r)

    print *, "The area of a circle with radius ", r, " is ", area

end program test_mymath
