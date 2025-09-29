program test_mymath 
    use mymath
    implicit none
    real :: r, area

    ! The exercise ask to write the area of a circle of radius 2.0, but we can test with any radius

    ! print * , "Enter the radius of the circle:"
    ! read *, r

    r = 2.0

    area =circle_area(r)

    print * , "The area of a circle is: ", area

end program test_mymath