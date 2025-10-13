program matrix_mult_simple_matmul
    implicit none

    ! Matrix dimensions
    integer :: na, ma, nb, mb
    real :: A(3,4), B(3,3), C(3,4)
    integer :: i

    ! Define matrix sizes
    na = 3
    ma = 4
    nb = 3
    mb = 3

    ! Define matrices A and B
    A = reshape((/3.0,2.0,1.0, &
                  2.0,4.0,2.0, &
                  4.0,2.0,3.0, &
                  1.0,2.0,7.0/), (/na,ma/))

    B = reshape((/3.0,2.0,3.0, &
                  2.0,1.0,0.0, &
                  4.0,2.0,2.0/), (/nb,mb/))

    ! Check if B*A is possible (columns of B must equal rows of A)
    if (mb /= na) then
        print *, "ERROR: Cannot multiply B*A. Dimensions incompatible."
        print *, "B is ", nb, "x", mb, " and A is ", na, "x", ma
        stop
    end if

    ! Perform B*A using matmul
    C = matmul(B, A)

    ! Print result
    print *, "Matrix B*A ="
    do i = 1, nb
        print '(4F6.1)', C(i,1:ma)
    end do

end program matrix_mult_simple_matmul
