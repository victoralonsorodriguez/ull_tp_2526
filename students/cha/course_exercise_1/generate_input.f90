program generate_input
  implicit none
  integer, parameter :: dp = selected_real_kind(15, 307)
  integer :: N, i
  real(dp) :: L, v_max, m, dt, dt_out, t_end
  real(dp) :: x, y, z, vx, vy, vz
  character(len=256) :: filename
  integer :: outunit

  ! Parámetros
  N = 5          ! número de partículas
  L = 5.0_dp     ! tamaño del cubo de posiciones
  v_max = 0.5_dp ! velocidad máxima inicial
  m = 1.0_dp     ! masa de las partículas

  dt = 0.01_dp
  dt_out = 0.1_dp
  t_end = 50.0_dp  ! tiempo total de integración

  filename = 'input.dat'
  open(unit=10, file=filename, status='replace', action='write', iostat=i)
  if (i /= 0) then
     print *, "Error al abrir archivo ", trim(filename)
     stop
  end if

  ! Escribir parámetros de integración
  write(10,*) dt
  write(10,*) dt_out
  write(10,*) t_end
  write(10,*) N

  ! Inicializar posiciones y velocidades aleatorias
  call random_seed()
  do i = 1, N
     call random_number(x)
     call random_number(y)
     call random_number(z)
     call random_number(vx)
     call random_number(vy)
     call random_number(vz)

     x = x*L
     y = y*L
     z = z*L
     vx = (vx - 0.5_dp) * 2.0_dp * v_max
     vy = (vy - 0.5_dp) * 2.0_dp * v_max
     vz = (vz - 0.5_dp) * 2.0_dp * v_max

     write(10,'(7F12.6)') m, x, y, z, vx, vy, vz
  end do

  close(10)
  print *, "Archivo input.dat generado con", N, "partículas."
end program generate_input
