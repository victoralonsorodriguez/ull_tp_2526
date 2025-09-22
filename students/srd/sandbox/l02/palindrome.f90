program palindrome
    implicit none
    integer :: n
    character(len=50) :: numStr, revStr
    integer :: i, lenN

    ! Pedir número
    print *, "Introduce un número entero:"
    read *, n

    ! Convertir a cadena
    write(numStr, '(I0)') n   ! I0: convierte entero sin espacios
    lenN = len_trim(numStr)   ! longitud real

    ! Construir cadena invertida
    revStr = ""
    do i = 1, lenN
        revStr(i:i) = numStr(lenN-i+1:lenN-i+1)
    end do

    ! Comprobar
    if (trim(numStr(1:lenN)) == trim(revStr(1:lenN))) then
        print *, n, "es capicúa"
    else
        print *, n, "NO es capicúa"
    end if

end program palindrome

