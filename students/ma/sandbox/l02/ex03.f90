program ex03
  ! This program is similar to ex02, it would be nice to make a module with the factorial function if i have more time

  implicit none
  integer :: r , i, fact 

  print *, "Enter a positive real number"
    read *, r

    if (r<0) then ! Check if the number entered is valid
        print *, " The number you enter is not valid, it must be positive and real"
    else
        i=0
        fact=1
        do while(i<=r) 
            if (r==0) then
                exit
            else
                if (i==0) then
                    i=i+2
                else
                    fact=fact*i
                    i=i+1
                end if
            end if
        end do
        print *, "The factorial of", r, "is", fact
    end if  
end program ex03