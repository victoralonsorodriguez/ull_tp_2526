program test_geometry
    use geometry  ! Import the module
    use particle

    implicit none

    ! Variables
    type(vector3d) :: v
    type(vector3d) :: w
    real(8)  :: dist
    real(8)  :: ang
    type(vector3d) :: n
    type(vector3d) :: cross

    type(particle3d) :: particula

    ! Execution
    v = vector3d(1.0_8,2.0_8,3.0_8) + point3d(4.0_8,5.0_8,6.0_8)
    w = vector3d(1.0_8, 2.0_8, 3.0_8) / 7.0_8
    dist = distance(point3d(1.0_8,2.0_8,3.0_8), point3d(4.0_8,5.0_8,6.0_8))
    ang = angle( vector3d(1.0_8,2.0_8,3.0_8), vector3d(4.0_8,5.0_8,6.0_8))
    n = normalize( vector3d(5, 1, 2) )
    cross = cross_product( vector3d(1.0_8,2.0_8,3.0_8), vector3d(4.0_8,5.0_8,6.0_8) )

    particula = particle3d( point3d(1.0_8,2.0_8,3.0_8), vector3d(4.0_8,5.0_8,6.0_8), 7.0_8 )

    print *, 'v = ', v%x, v%y, v%z
    print *, 'w = ', w%x, w%y, w%z
    print *, 'distancia = ', dist
    print * , 'angle = ', ang
    print *, 'vector normalizado = ', n%x, n%y, n%z
    print *, 'prod vectorial = ', cross%x, cross%y, cross%z

    print *, 'particula = ', particula
    print *, 'masa particula = ', particula%m

end program test_geometry