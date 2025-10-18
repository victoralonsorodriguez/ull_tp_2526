program palindrome_check
    implicit none
    integer :: n, original, reversed, digit

    ! Read integer from user
    print *, "Enter an integer:"
    read *, n

    original = n
    reversed = 0

    ! A weird loop to reverse the digits 
    ! (i don't know if there is a better option to do it)
    do while (n > 0)
        digit = mod(n, 10)          ! last digit
        reversed = reversed * 10 + digit
        n = n / 10                  ! remove last digit
    end do

    ! Check if palindrome
    if (original == reversed) then
        print *, "The number is a palindrome!"
    else
        print *, "The number is NOT a palindrome"
    end if

end program palindrome_check
