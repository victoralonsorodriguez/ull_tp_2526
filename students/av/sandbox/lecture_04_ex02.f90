program lecture_04_ex02
    implicit none

    ! Defining a parameter to improve precision (gemini)
    integer, parameter :: dp = selected_real_kind(P=15, R=307)

    ! Defining used variables for factorial and fibonacci
    integer :: n
    real (kind=dp) :: fact
    real (kind=dp) :: fibo

    ! Defining variables for computing time
    integer :: t_start, t_end, t_rate
    real(KIND=dp) :: elapsed_time


    ! Loop for validate the user input
    do
        ! Requesting the user to introduce a nautural number using the terminal
        write(*, '(/,a)', advance='no') "Introduce a natural number (>= 0): "
        read * , n

        ! Exit loop if the number is correct
        if (n >= 0) exit

        ! Requesting to repeat the input number with a valid one
        print *, "Error: Number must be non-negative (>= 0). Try it again."
    end do

    ! Calling factorial function
    fact = factorial(n)
    print '(/,"The factorial of ", G0.3, " is: ", G0.6)', n, fact


    ! Measuring the time required to cpompute the fibonacci number recursively
    call system_clock(t_start, t_rate)

    ! Calling fibonacci function
    fibo = fibonacci(n)

    call system_clock(t_end)

    elapsed_time = real(t_end - t_start, dp) / real(t_rate, dp)
    print '(/,"The fibonacci of ", G0.3, " is: ", G0.6)', n, fibo
    print '("Fibonacci recursive computing time was: ", G0.6, " s.")', elapsed_time


    ! Measuring the time required to cpompute the fibonacci number iteratively
    call system_clock(t_start, t_rate)

    ! Calling fibonacci function
    fibo = fibonacci_iter(n)

    call system_clock(t_end)

    elapsed_time = real(t_end - t_start, dp) / real(t_rate, dp)
    print '(/,"The fibonacci of ", G0.3, " is: ", G0.6)', n, fibo
    print '("Fibonacci iterative computing time was: ", G0.6, " s.")', elapsed_time

    contains

        ! Defining some recursive functions with recursive keyword

        ! To computing factorial numbers
        recursive function factorial(n) result(fact)

            ! Defining variables
            integer, intent(in) :: n
            real(kind=dp) :: fact

            ! Checking the n number
            ! As a recursive function n'=n-1, so when n'<=1
            ! we stop the recursive function to avoid negative numbers
            if (n<=1) then
                fact = 1
            else
                ! Computing factorial as a recursive function
                fact = n * factorial(n-1)
            end if

        end function factorial

        ! To computing fibonacci numbers
        recursive function fibonacci(n) result(fibo)

            ! Defining variables
            integer, intent(in) :: n
            real(kind=dp) :: fibo

            ! Manage 0 and 1 values
            if (n == 0) then
                fibo = 0
            else if (n == 1) then
                fibo = 1
            else
                ! For values different from 0 and 1 we compute
                ! the secuence as sum of previous two values
                fibo = fibonacci(n - 1) + fibonacci(n - 2)
            end if

        end function fibonacci

        ! To computing fibonacci numbers
        elemental function fibonacci_iter(n) result(fibo)

            ! Defining variables
            integer, intent(in) :: n
            real(kind=dp) :: fibo
            real(kind=dp) :: fibo_1, fibo_2, temp
            integer :: i

            ! Managing 0 and 1 values
            if (n <= 1) then
                fibo = n
                return
            end if
            
            ! Initializing auxiliar variables
            fibo_1 = 0_dp
            fibo_2 = 1_dp

            ! For every number we compute the sum
            do i = 2, n
                temp = fibo_1 + fibo_2
                fibo_1 = fibo_2
                fibo_2 = temp
            end do

            ! Returning the final value
            fibo = fibo_2


        end function fibonacci_iter


end program lecture_04_ex02