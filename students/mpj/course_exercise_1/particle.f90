module particle
    use geometry
    implicit none

    integer, parameter :: dp = SELECTED_REAL_KIND(p=15, r=307) ! Defining our desired precision (64 bits)

    type particle3d
        type(point3d)  :: p
        type(vector3d) :: v
        real(dp) :: m
    end type particle3d

end module particle