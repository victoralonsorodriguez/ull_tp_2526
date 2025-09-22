program real  
    implicit none
    Real :: r, result

    print *, "Insert the real number:"
    read(*,*) r

      if (r < 0 .and. r == int(r)) then
          print *, "Gamma function not defined for negative integers"
          stop
      end if
        result = gamma(r + 1)
        print *, "Factorial of real number = ", result

end program real
