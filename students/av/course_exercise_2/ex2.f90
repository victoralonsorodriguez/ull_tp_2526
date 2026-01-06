! main program for exercise 2
program ex2
    use geometry
    use particle
    use barnes_hut_module
    implicit none

    ! variables for simulation
    integer :: n_particles, i, step
    real(kind=dp) :: dt, t_end, t, dt_out
    
    ! arrays using custom types
    type(particle3d), dimension(:), allocatable :: particles
    type(vector3d), dimension(:), allocatable :: accelerations
    
    ! octree root
    type(cell_t), pointer :: root => null()

    ! i/o variables
    integer, parameter :: u_in = 10, u_out = 20
    character(len=256) :: filename_in, filename_out
    character(len=256) :: arg_string
    integer :: num_args, arg_idx
    logical :: input_file_set = .false.

    ! temporary read variables
    real(kind=dp) :: m, rx, ry, rz, vx, vy, vz


    ! parse command line arguments (-i for input, -o for output)
    filename_in = 'input.dat'
    filename_out = 'output.dat'
    num_args = command_argument_count()
    arg_idx = 1

    do while (arg_idx <= num_args)
        call get_command_argument(arg_idx, arg_string)
        
        if (trim(arg_string) == '-i') then
            arg_idx = arg_idx + 1
            call get_command_argument(arg_idx, filename_in)
        else if (trim(arg_string) == '-o') then
            arg_idx = arg_idx + 1
            call get_command_argument(arg_idx, filename_out)
        end if
        
        arg_idx = arg_idx + 1
    end do

    ! check if the default or specified file exists
    inquire(file=trim(filename_in), exist=input_file_set)
    if (.not. input_file_set) then
        print *, "error: input file '", trim(filename_in), "' not found."
        print *, "usage: ./ex2 [-i <input_file>] [-o <output_file>]"
        stop
    end if


    ! read input
    print *, "reading input from ", filename_in
    open(unit=u_in, file=filename_in, status='old', action='read')
    
    read(u_in, *) dt
    read(u_in, *) dt_out ! assuming this is output interval or similar
    read(u_in, *) t_end  ! assuming this is max time or steps
    read(u_in, *) n_particles
    
    print *, "n_particles:", n_particles, " dt:", dt
    
    allocate(particles(n_particles))
    allocate(accelerations(n_particles))
    
    do i = 1, n_particles
        read(u_in, *) m, rx, ry, rz, vx, vy, vz
        particles(i)%m = m
        particles(i)%p = point3d(rx, ry, rz)
        particles(i)%v = vector3d(vx, vy, vz)
    end do
    close(u_in)


    ! simulation loop
    open(unit=u_out, file=filename_out, status='replace', action='write')
    
    t = 0.0_dp
    step = 0
    
    ! initial force calculation
    call build_tree(root, particles)
    call calculate_forces(root, particles, accelerations)
    
    do while (t < t_end)
        
        !--- velocity verlet ---!
        ! v(t + 0.5*dt) = v(t) + 0.5 * a(t) * dt
        ! r(t + dt)     = r(t) + v(t + 0.5*dt) * dt
        do i = 1, n_particles
            particles(i)%v = particles(i)%v + accelerations(i) * (0.5_dp * dt)
            particles(i)%p = particles(i)%p + particles(i)%v * dt
        end do
        
        !--- recalculate forces ---!
        ! destroy old tree and build new one with new positions
        call delete_tree(root)
        call build_tree(root, particles)
        
        ! calculate new accelerations a(t + dt)
        call calculate_forces(root, particles, accelerations)
        
        !--- velocity verlet ---!
        ! v(t + dt) = v(t + 0.5*dt) + 0.5 * a(t + dt) * dt
        do i = 1, n_particles
            particles(i)%v = particles(i)%v + accelerations(i) * (0.5_dp * dt)
        end do
        
        !--- output format ---!
        ! time p1x p1y p1z p2x p2y p2z...   
        write(u_out, '(f10.5)', advance='no') t
        do i = 1, n_particles
            write(u_out, '(3(1x, es12.5))', advance='no') particles(i)%p%x, particles(i)%p%y, particles(i)%p%z
        end do
        write(u_out, *)
        
        t = t + dt
        step = step + 1
        
        if (mod(step, 100) == 0) print *, "step:", step, " time:", t
        
    end do
    
    call delete_tree(root)
    close(u_out)
    print *, "simulation finished. output written to ", filename_out

end program ex2