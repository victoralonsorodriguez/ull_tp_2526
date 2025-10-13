program hello
    integer :: n, i

    print *, 'How many times?'
    read *, n

    do i = 1, n, 1
        print *, " Hello world !"
    end do

end program hello