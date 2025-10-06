! Exercise 1: Write a program that computes and prints the matrix multiplication of two real arrays
! A =([3,2,4,1],[2,4,2,2],[1,2,3,7]), 3x4 matrix
! B=([3,2,4],[2,1,2],[3,0,2]), 3x3 matrix
! We intentd to perform B x A

program matrix_multiplication
    implicit none
    integer :: i, j, k
    real :: A(3,4), B(3,3), C(3,4) ! this code only works for these matrices...

    ! A cool idea could be to randomly generate the elements of the matrixes instead of taking pre-defined ones.

    ! OJO: must define the matrices using reshape, since fortran fills them in by columns
    A = reshape( [ 3.0,2.0,4.0,1.0, &
                   2.0,4.0,2.0,2.0, &
                   1.0,2.0,3.0,7.0 ], shape(A) )


    B = reshape( [ 3.0,2.0,4.0, &
                   2.0,1.0,2.0, &
                   3.0,0.0,2.0 ], shape(B) )

    C = 0.0 ! initialize resulting matrix

    do i=1, size(B, 1) ! goes over B's  rows
        do j=1, size(A, 2) ! goes over A's columns
            do k=1, size(B, 2) ! shared/inner dimension (c_ij=sum_{k=1}^n a_ik*b_kj); A=(a_ij)_{mxn}; B=(b_ij)_{nxp}; C=(c_ij)_mxp
                C(i,j) = C(i,j) + B(i,k)*A(k,j)
            end do
        end do
    end do 

    ! Print final result
    print *, "Matrix B x A ="
    do i = 1, size(C,1)
        print "(4F8.2)", (C(i,j), j=1,size(C,2)) ! to print it nicely!
    end do

    ! NOTE: this could have been done by simply using:
    ! C = matmul(B, A)

end program matrix_multiplication