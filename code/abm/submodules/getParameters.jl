Dict{Symbol, Any}(
    :nsim => 1,                       # Number of simulations per call
    :nrounds => 1000,                 # Number of rounds per generation
    :n => 300,                        # Size of the population
    :ngroups => 2,                    # Number of Groups in the population
    :lattice => [1,2],                # This controls the dimensions of the lattice that the world exists on
    :mortality_rate => 0.03,          # The number of deaths per 100 people
    :mutation => 0.01,                # Rate of mutation on traits
    :wages => .1,                     # Wage rate in other sectors - opportunity costs
    :max_forest => 350000,            # Average max stock
    :var_forest => 0,                 # Controls athe heterogeneity in forest size across diffrent groups
    :degrade => 1,                    # This measures how degradable a resource is(when invasion the resource declines linearly with size and as it increase it degrades more quickly, if negative it decreases the rate of degredation), degradable resource means that as the resouce declines in size beyond its max more additional labor is required to harvest the same amount
    :regrow => .01,                   # The regrowth rate
    :volatility => 0,                 # The volatility of the resource each round - set as variance on a normal
    :pollution => false,              # Pollution provides a public cost based on 
    :pol_slope => .1,                 # As the slope increases the rate at which pollution increases as the resource declines increase
    :pol_C => .1,                     # As the constant increases the total amount of polution increases
    :ecosys => false,                 # Eco-system services provide a public good to all members of a group proportionalm to size of resource
    :eco_slope => 1,                  # As the slope increases the resource will continue to produce ecosystem servies
    :eco_C => .01,                    # As the constant increases the total net benifit of the ecosystem services increases
    :tech => 1,                       # Used for scaling Cobb Douglas production function
    :labor => .7,                     # The elasticity of labor on harvesting production
    :price => 1.0,                    # This sets the price of the resource on the market
    :ngoods => 2,                     # Specifiies the number of sectors
    :necessity => 0,                  # This sets the minimum amount of the good the household requires
    :monitor_tech => 1,               # This controls the efficacy of monitnoring, higher values increase the detection rate -  to understand the functio check plot(curve(pbeta(i, 1, x), 0, 5), where i is the proportion of monitors in a pop
    :defensibility => 1,              # This sets the maximum possible insepction rate if all indiviudals participate in guarding it.
    :def_perc => true,                # This sets the maximum possible insepction rate if all indiviudals participate in guarding it.
    :punish_cost => 0.1,              # This is the cost that must be paid for individuals <0 to monitor their forests - For the default conditions this is about 10 percent of mean payoffs
    :fine => 0.0,                     # This controls the size of the fine issued when caught, note that in a real world situation this could be recouped by the injured parties but it is not
    :limit_seed => [0, 5],            # This is the average harvest limit. If a person is a punisher it controls the max effort a person is allowed to allocate
    :harvest_var => 1.5,              # Harvest limit group offset 
    :harvest_var_ind => .5,           # Harvest limit individual offset
    :pun2_on => true,                 # Turns punishment on or off. 
    :pun1_on => true,                 # Turns group borders on or lff
    :seized_on => true,               # Turns seizures on or nff
    :fines_evolve => true,            # If false fines stay fixed at initial value
    :fines1_on => false,              # Turns on fines for local agents
    :fines2_on => false,              # Turns on fines for non locals
    :fine_start => 1,                 # Determine mean fine value for all populations at the beginiing SET TO NOHTING TO TURN OFF
    :fine_var => .2,                  # Determines the group offset for fines at the begining
    :distance_adj =>0.9,              # This affects the proboabilty of sampling a more close group.
    :travel_cost => .00,              # This basically controls the travel time for individuals who travel to neightboring communities to steal from Note that higher values mean less leakage
    :groups_sampled => 1,             # When leakers sample candidate wards to visit they draw this number of groups to compare forest sizes
    :social_learning => true,         # Toggels whether Presitge Biased Tranmission is on
    :nmodels => 3,                    # The number of models sampled to copy from in social learning
    :fidelity => 0.02,                # This is the fidelity of social transmission
    :learn_type => "income",          # Two Options - "wealth" and "income" indiviudals can choose to copy wealth or income if copy wealth they copy total overall payoffs, if copy income they copy payoffs from the previous round
    :outgroup => 0.01,                # This is the probability that the individual samples from the whole population and not just his group when updating0...
    :baseline => .01,                 # Baseline payoff to be added each round -
    :leak => true,                    # This controls whether individuals are able to move into neightboring territory to harvest
    :verbose => false,                # verbose reporting for debugging
    :seed => 1984,
    :og_on => false,                  # THe evolution of listening to outgroup members.
    :experiment_leak => false,        # THIS SETS THE VALUE OF THE OTHER GROUP LEAKAGE and Punish
    :experiment_punish1 => false,     # THIS SETS THE VALUE OF THE OTHER GROUPS PUNISHMENT
    :experiment_punish2 => false,     # THIS SETS THE VALUE OF THE OTHER GROUPS PUNISHMENT
    :experiment_limit => false,       # THIS SETS THE VALUE OF THE OTHER GROUPS LIMIT
    :experiment_effort => false,      # THIS SETS THE VALUE OF THE OTHER GROUPS LIMIT
    :experiment_price => false,      # THIS SETS THE VALUE OF THE OTHER GROUPS LIMIT
    :experiment_group => 1,           # Determines the set of groups which the experiment will be run on
    :experiment_stock => false,
    :cmls => false,                   # Determines whether cmls will operate
    :invasion => false,                   # Checks invasion criteria by setting all trait start values to near invasion
    :glearn_strat => false,           # options: "wealth", "income", "env"
    :split_method => "random",        # How groups split is CLMS is on
    :kmax_data => nothing,            # This takes data for k
    :back_leak => false,              # Determines whether or not individuals can back_invade
    :fines_on => false,               # Turns fines on or off!
    :inspect_timing => nothing,       # options: nothing, "before", "after", if nothing then it randomizes to half and half
    :inher => false,                  # Turns wealth inheretence on or off
    :tech_data => nothing,            # The modle can recieve data specifiying the technological capacity of the system over time
    :harvest_type => "individual",    # Individuals can pool labor before harvests 
    :policy_weight => "equal",        # Typically takes wealth as a weight, but can take any-data that can be used to rank people.
    :rec_history =>  false,           # You can record the history of wealth but it is costly. 
    :resource_zero => false,          # Sets resource to invasion to observe regrowth dynamics
    :harvest_zero => false,           # Automatically sets harvest to invasion to observe simple regrowth dynamics
    :wealth_degrade => nothing,       # When wealth is passed on it degrades by some percent
    :slearn_freq => 1,                # Not opperational - it defines the frequency of social learning 
    :reset_stock => 100000,           # Is the year in which resources are reset to max
    :socialLearnYear => nothing,      # Which years individuals are allowed to socially learn in  - specify as a vector of dates
    :αlearn => 1,                     # Controls learning rate
    :indvLearn => false,              # Controls whehter individual learning is turned on
    :full_save => false,              # Saves everything if true
    :compress_data => true,           # Compresses data to Float64 if true
    :control_learning => false,       # Agents can learn from experimental groups if true
    :learn_group_policy => false,     # Agents learn the policy of targeted out group not trait of inidivudal
    :bsm => "individual",              # Defines how gains from seizures are split options => "Collective" or "individual"
    :genetic_evolution => true,        # defines whether or not genetic evolution opperates. 
    :special_leakage_group => nothing, # If the leakage experiment group cannot be the same as the other groups. 
    :begin_leakage_experiment => 200000, # this is set so large that it doesnt ping unless changed.
    :population_growth => false,
    :pgrowth_data => nothing,
    :unitTest => false,
    :special_experiment_leak => nothing,
    :α => 1,
    :population_data => nothing,
    :new_leakage_experiment => nothing,
    :kseed => nothing,
    :limit_seed_override => nothing,
    :effort_seed => nothing)