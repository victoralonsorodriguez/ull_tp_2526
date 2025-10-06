module geometry
    implicit none
    
    type point3d
     real(kind=8) :: x,y,z ! or with selected_kind for the program to be portable 
    end type point
    type vector3d
     real(kind=8) :: x,y,z ! or with selected_kind for the program to be portable 
    end type vector3d   

contains

  ! Sum V+P
  pure function sumvp(v, p) result(res)
    type(vector3d), intent(in) :: v
    type(point3d), intent(in)  :: p
    type(point3d) :: res

    res%x = p%x + v%x
    res%y = p%y + v%y
    res%z = p%z + v%z
  end function sumvp

  ! Sum P+V
  pure function sumpv(p, v) result(res)
    type(point3d), intent(in)  :: p
    type(vector3d), intent(in) :: v
    type(point3d) :: res

    res%x = p%x + v%x
    res%y = p%y + v%y
    res%z = p%z + v%z
  end function sumpv

  ! Subtract vector - point
  pure function subvp(v, p) result(res)
    type(vector3d), intent(in) :: v
    type(point3d), intent(in)  :: p
    type(vector3d) :: res

    res%x = v%x - p%x
    res%y = v%y - p%y
    res%z = v%z - p%z
  end function subvp

  ! Substract point - vector
  pure function subpv(p, v) result(res)
    type(point3d), intent(in)  :: p
    type(vector3d), intent(in) :: v
    type(point3d) :: res

    res%x = p%x - v%x
    res%y = p%y - v%y
    res%z = p%z - v%z
  end function subpv

  ! Distance between two points
  pure function distance(p1, p2) result(d)
    type(point3d), intent(in) :: p1, p2
    real(kind=8) :: d 

    d = sqrt((p1%x - p2%x)**2 + (p1%y - p2%y)**2 + (p1%z - p2%z)**2)
  end function distance
end module geometry
