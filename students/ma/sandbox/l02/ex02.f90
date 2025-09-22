program factorials
    implicit none
    integer :: n, i, fact ! n is for the number and i for the loop, fact for the acumulation and result

    print *, "Enter a number to calculate its factorial"
    read *, n

    if (n<0) then ! Check if the number entered is valid
        print *, " The number you enter is not valid, it must be positive"
    else
        i=0
        fact=1
        do while(i<=n) 
            if (i==0) then
                print *, fact
                i=i+2
            else
                fact=fact*i
                i=i+1
                print *, fact
            end if
        end do
    end if  
end program factorials