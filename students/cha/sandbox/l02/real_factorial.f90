program real_factorial
  implicit none
  real(8) :: r, result  ! We are use double precision

   ! NOTES:
   ! The factorial for real numbers is defined using the Gamma function:
   !   r! = Gamma(r + 1)
   ! The Gamma function is defined by the integral:
   !   Gamma(x) = ∫_0^\infty t^(x-1) * exp(-t) dt
   ! For integer n, Gamma(n+1) = n! (so it generalizes the factorial).
   !
   ! In modern Fortran (gfortran, for example), gamma() is an intrinsic function.
   ! If we didn't use gfortran, we would need to define the gamma integral

  ! Ask the user for a positive real number
  print *, "Enter a POSITIVE real number r:"
  read *, r

  if (r < 0.0d0) then  ! We put "d" because of the double precision
     print *, "Error: r must be positive."
  else
     result = gamma(r + 1.0d0)

     print *, r, "! =", result
  end if

end program real_factorial
