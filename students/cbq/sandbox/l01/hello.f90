program hello_n
    implicit none
    integer :: n, i

    print *, "Insert the number of imprints of 'Hello world':"
    read(*,*) n

    do i = 1, n
        print *, "Hello world!"
    end do
end program hello_n