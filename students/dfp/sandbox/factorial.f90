PROGRAM factorial
    INTEGER (16) :: n, i, n_fact = 1
    PRINT *, "Eneter a value for n"
    READ *, n
    DO i = 1, n, 1
        n_fact = n_fact * i
        PRINT *, i , "! = " , n_fact
    END DO
END PROGRAM
