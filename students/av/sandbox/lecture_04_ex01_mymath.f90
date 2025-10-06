module lecture_04_ex01_mymath
    implicit none
    
    ! Defining a parameter to improve precision (gemini)
    integer, parameter :: dp = kind(1.0D0) 

    ! Defining a constant using parameter keyword
    real (kind=dp), parameter :: pi = 3.141592653589793_dp

contains

    ! Defining a function to compute circle area
    function circle_area(r) result(a)
        real (kind=dp), intent(in) :: r
        real (kind=dp) :: a
        a = pi * r**2
    end function circle_area

end module lecture_04_ex01_mymath