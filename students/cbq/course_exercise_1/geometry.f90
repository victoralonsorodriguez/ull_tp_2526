module geometry
    implicit none
    type :: vector3d
        real :: x , y, z
    end type vector3d

    interface operator (+)
        module procedure sumvv , sumrv
    end interface

    interface operator (*)
        module procedure mulrv
    end interface

    contains
    pure type ( vector2d ) function sumvv (a , b )
    type ( vector2d ) , intent ( in ) :: a , b
    sumvv = vector2d ( a % x + b %x , a % y + b % y )
    end function sumvv
    pure type ( vector2d ) function mulrv (a , b )
    real , intent ( in ) :: a

end module geometry