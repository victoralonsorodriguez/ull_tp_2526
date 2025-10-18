! Exercise 2: Write a program that reads an integer from the user and checks if it is a palindrome
! (that means it reads the same forwards and backwards, like 121 or 1331).

! The plan to solve this is:
! 1. Saving the original number.
! 2. Reversing its digits by using integer division and modulo
! 3. Comparing the reversed number to the original

program palindrome
    implicit none
    integer :: n, i, len
    character(len=20) :: str ! string, assuming no one will input a number larger than this
    logical :: is_palindrome

    print *, "Enter an integer to check if it is a palindrome:"
    read *, n

    ! convert integer to string 
    write(str, '(I0)') n ! minimum number of digits
    len = len_trim(str) ! returns the length of character string, ignoring any trailing blanks.

    ! assume palindrome until proven otherwise
    is_palindrome=.true.

    ! we compare characters from both ends
    do i = 1, len/2
        if (str(i:i) /= str(len-i+1:len-i+1)) then 
            ! str(i:i) is the i-th character of the string
            ! str(len-i+1:len-i+1) means the character symmetric to str(i:i) from the other end
            ! so if they are not the same, the number can`t be a palindrome
            is_palindrome = .false.
            exit
        end if
    end do

    ! print result
    if (is_palindrome) then
        print *, trim(str), " is a palindrome :)"
    else
        print *, trim(str), " is not a palindrome :("
    end if 

end program palindrome