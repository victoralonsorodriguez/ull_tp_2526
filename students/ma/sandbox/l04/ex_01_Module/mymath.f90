module mymath
    implicit none
    real, parameter :: pi = 3.14159 

    contains
    ! We declare a pure function since it not alters global variables
    pure function circle_area(r) result(area)
        real, intent(in) :: r ! The radius 
        real :: area
        area = pi*r**2
    end function circle_area

end module mymath
