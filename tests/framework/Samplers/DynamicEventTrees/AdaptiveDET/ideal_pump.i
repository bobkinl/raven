  # End preconditioning block
  # close Executioner section
[GlobalParams]
  initial_p = 1.e5
  initial_v = 0.0
  initial_T = 300.
[]
[FluidProperties]
  [./eos]
    type = LinearFluidProperties
    p_0 = 1.e5 # Pa
    rho_0 = 1.e3 # kg/m^3
    a2 = 1.e7 # m^2/s^2
    beta = .46e-3 # K^{-1}  #Comment: This number should be positive for water. alpha = 1/V dV/dT = -1/rho d_rho/dT
    cv = 4.18e3 # J/kg-K, could be a global parameter?
    e_0 = 1.254e6 # J/kg
    T_0 = 300 # K
  [../]
[]
[Components]
  # Pipes
  [./pipe1]
    # geometry
    type = Pipe
    fp = eos
    position = '0 0 0'
    orientation = '1 0 0'
    A = 3.14159265E-04 # 2.0 cm (0.02 m) in diameter, A = 1/4 * PI * d^2
    Dh = 2.e-2
    f = 0.01
    Hw = 0.0 # not setting Hw means that Hw is calculated by models, need set 0 for no heat transfer
    length = 1
    n_elems = 20
  [../]
  [./pipe2]
    # geometry
    type = Pipe
    fp = eos
    position = '1.2 0 0'
    orientation = '1 0 0'
    A = 0.785398163e-4 # 1.0 cm (0.01 m) in diameter, A = 1/4 * PI * d^2
    Dh = 1.e-2
    f = 0.01
    Hw = 0.0
    length = 1
    n_elems = 20
  [../]
  [./pump]
    type = IdealPump
    fp = eos
    inputs = 'pipe1(out)'
    outputs = 'pipe2(in)'
    mass_flow_rate = 0.3141159265 # rho * u * A (kg/s)
  [../]
  [./inlet_TDV]
    type = TimeDependentVolume
    input = 'pipe1(in)'
    p = 1.0e5
    T = 300.0
  [../]
  [./outlet_TDV]
    type = TimeDependentVolume
    input = 'pipe2(out)'
    p = 1.e5
    T = 300.0
  [../]
[]
[Preconditioning]
  [./SMP_PJFNK]
    type = SMP
    full = true
    solve_type = PJFNK
    line_search = basic
  [../]
[]
[Executioner]
  type = RavenExecutioner
  control_logic_file = 'ideal_pump_control.py'
  dt = 1.e-1
  dtmin = 1.e-10
  dtmax = 9999
#e_tol = 10.0
#e_max = 99999.
#max_increase = 10
  petsc_options_iname = '-ksp_gmres_restart -pc_type'
  petsc_options_value = '300 lu'
  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-8
  nl_max_its = 10
  l_tol = 1e-8 # Relative linear tolerance for each Krylov solve
  l_max_its = 100 # Number of linear iterations for each Krylov solve
  start_time = 0.0
  end_time = 5.0
#num_steps = 10 # The number of timesteps in a transient run
  [./Quadrature]
    # Specify the order as FIRST, otherwise you will get warnings in DEBUG mode...
    type = TRAP
    order = FIRST
  [../]
[]
[Outputs]
  # Turn on performance logging
  exodus = true
#output_displaced = true
#perf_log = true
[]
[Controlled]
  [./pipe1_Area]
    print_csv = true
    component_name = pipe1
    property_name = Area
    data_type = double
  [../]
  [./pipe1_Dh]
    print_csv = true
    component_name = pipe1
    property_name = Dh
    data_type = double
  [../]
  [./pipe1_Hw]
    print_csv = true
    component_name = pipe1
    property_name = Hw
    data_type = double
  [../]
  [./pipe2_Area]
    component_name = pipe2
    property_name = Area
    data_type = double
  [../]
  [./pipe2_Dh]
    component_name = pipe2
    property_name = Dh
    data_type = double
  [../]
  [./pipe2_Hw]
    component_name = pipe2
    property_name = Hw
    data_type = double
  [../]
  [./pump_mass_flow_rate]
    print_csv = true
    component_name = pump
    property_name = 'mass_flow_rate'
    data_type = double
  [../]
  [./inlet_TDV_p_bc]
    component_name = 'inlet_TDV'
    property_name = 'p'
    data_type = double
    print_csv = True
  [../]
  [./inlet_TDV_T_bc]
    component_name = 'inlet_TDV'
    property_name = 'T'
    data_type = double
  [../]
  [./outlet_TDV_p_bc]
    component_name = 'outlet_TDV'
    property_name = 'p'
    data_type = double
  [../]
  [./outlet_TDV_T_bc]
    component_name = 'outlet_TDV'
    property_name = 'T'
    data_type = double
  [../]
[]
[Monitored]
[]
[Auxiliary]
  [./depressurizationOn]
    data_type =  bool
    initial_value =  False
    print_csv = True
  [../]
  [./systemFailed]
    data_type =  bool
    initial_value =  False
    print_csv = True
  [../]
 [./endSimulation]
    data_type =  bool
    initial_value =  False
    print_csv = True
 [../]
 [./depresSystemDistThreshold]
 data_type =  double
 initial_value =  1.0
 print_csv = True
 [../]
 [./depressurizationOnTime]
 data_type =  double
 initial_value =  0.0
 print_csv = True
 [../]
 [./PressureFailureDistThreshold]
 data_type =  double
 initial_value =  1.0
 print_csv = True
 [../]
 [./PressureFailureValue]
 data_type =  double
 initial_value =  0.0
 print_csv = True
 [../]
 [./fakePressure]
 data_type =  double
 initial_value =  0.0
 print_csv = True
 [../]
[]
[Distributions]
 RNG_seed = 1
 [./PressureFailureDist]
 type = UniformDistribution
 xMin = 1.01e5
 xMax = 1.15e5
 ProbabilityThreshold = 1.0
 [../]
 [./depresSystemDist]
 type = UniformDistribution
 xMin = 0.0
 xMax = 5.0
 ProbabilityThreshold = 1.0
 [../]
[]
