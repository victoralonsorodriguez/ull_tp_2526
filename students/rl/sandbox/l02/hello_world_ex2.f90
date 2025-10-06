! Exercise 2: Write a program that prints factorials n! from 0 to n. We need to:
! Read an integer n from the terminal
! Use a loop to compute and print the factorials from 0! to n!. 0!=1 and n! = n*(n-1)!
! Within said loop, print 

program hello_ex2
    implicit none
    integer :: n       ! input number
    integer :: i       ! loop counter
    integer :: fact    ! to store factorial values
    
    ! We will keep asking until the user enters a valid (non-negative) integer
    do
        print *, "Enter a non-negative integer n to compute factorials from 0! to n!:"
        read *, n
        if (n >= 0) exit     ! leave the loop if input is valid
        print *, "Error: Please enter a NON-NEGATIVE integer!"
    end do

    print *, "Factorials from 0! to ", n , "! :"

    ! Initialize the factorial
    fact = 1

    ! Print 0! first
    print *, "0! = ", fact 

    ! Loop from 1 to n
    do i = 1, n
        fact = fact*i
        print *, i, "! = ", fact
    end do
end program hello_ex2
