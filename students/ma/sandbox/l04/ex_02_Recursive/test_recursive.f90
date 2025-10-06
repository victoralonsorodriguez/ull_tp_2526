program test_recursive
    use functions
    implicit none
    integer :: n5_fact,n10_fact, n_fibo, result5_fact,result10_fact, result_fibo

    ! Task 2 ask to test the factorial with 5! and 10!
    n5_fact = 5
    n10_fact = 10
    result5_fact = factorial(n5_fact)
    result10_fact = factorial(n10_fact)
    
    print *, "The factorial of ", n5_fact, " is ", result5_fact
    print *, "The factorial of ", n10_fact, " is ", result10_fact

    print *, "-----------------------------------"

    print *, "Write an integer to compute its fibonacci number"
    read *, n_fibo
    result_fibo = fibonacci(n_fibo)
    print *, "The fibonacci number of ", n_fibo, " is ", result_fibo

end program test_recursive

!Task 5 compare with an iterative: the recursive it can be slower and can use more memory
!But it is cleaner an easier to understand