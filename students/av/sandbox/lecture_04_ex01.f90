program lecture_04_ex01
    use lecture_04_ex01_mymath  ! Calling the module mymath
    implicit none

    ! Imported dp from module
    real (kind=dp) :: radius  ! Radius of circle input by the user
    real (kind=dp) :: area    ! Computed area of the circle

    ! Requesting the user to introduce a radius using the terminal
    write(*, '(/,A)', advance='no') "Introduce circle radius: "
    read *, radius

    ! For negative radius we inform the user
    if (radius<0) then
        print *, "Negative radius will be converted into positive" 
    end if 

    ! Calling cicrle_area function from the module
    area = circle_area(radius)

    ! Showing the result in the terminal
    print '(/,"The area of a circle with radius ", G0.4, " is: ", G0.4, " u^2")', abs(radius), area
    
end program lecture_04_ex01