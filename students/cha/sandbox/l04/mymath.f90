module mymath
    implicit none
    ! Define a parameter pi
    real, parameter :: pi = 3.14159

contains

    ! Function to compute the area of a circle
    real function circle_area(r)
        implicit none
        real, intent(in) :: r

        circle_area = pi * r**2
    end function circle_area

end module mymath
