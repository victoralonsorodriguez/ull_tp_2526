program matrix_mult

    implicit none
    integer, parameter :: n = 3, m = 4, p = 3
    real :: A(n,m), B(m,p), C(n,p)
    integer :: i, j, k

    ! We define matrix A 
    A = reshape((/3.0,2.0,1.0, &
                  2.0,4.0,2.0, &
                  4.0,2.0,3.0, &
                  1.0,2.0,7.0/), (/n,m/))

    ! We define matrix B 
    B = reshape((/3.0,2.0,3.0, &
                  2.0,1.0,0.0, &
                  4.0,2.0,2.0, &
                  1.0,1.0,1.0/), (/m,p/))

    ! We initialize result matrix C as a zeros-matrix
    C = 0.0

    ! Each element C(i,j) = sum over k of A(i,k)*B(k,j)
    do i = 1, n
        do j = 1, p
            do k = 1, m
                C(i,j) = C(i,j) + A(i,k) * B(k,j)
            end do
        end do
    end do

    print *, 'Matrix A =', A
    print *
    print *, 'Matrix B =', B
    print *
    print *, 'Matrix C = A*B:', C


end program matrix_mult

