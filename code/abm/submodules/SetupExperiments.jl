# This function sets the groups in which experimnets will be performed.
# It first checks temp to see if any experiments are active.
# If an experiment is active it sets the experiment groups 
# Groups in an experiment cannot be learned from unless otherwise specified.
# Experimental groups are defined in the function call along with special experiment groups which are 
# in the experiment but also are part of the learning pool. 
# Groups which can be learned from 

function setupExperiments(;temp = temp,
     special_leakage_group = special_leakage_group,     
     experiment_group = experiment_group,
     control_learning = control_learning,
     ngroups = ngroups)
    
    experiment =  any(temp .!= false) ?  true : false # Check to see if any experimental condition is turned on?
    # Setup special leakage control learning group
    if special_leakage_group !== nothing
        exclude_patches = experiment_group[findall(x->x ∈ special_leakage_group, experiment_group )]
        experiment_learning_groups = experiment_group[findall(x->x ∉ special_leakage_group, experiment_group ) ]
    #    exclude_patches = special_leakage_group
    else
        experiment_learning_groups = experiment_group
        exclude_patches = experiment_group
    end
    # This determines whether agents learn from experimentally controled groups or not
    # This is always true, unless experiment is true and control learning is false 
    #- then this partitions the simulation into experimental and non-experimetnal groups for the purposes of updating
    learnfromcontrol = (experiment == false) | (control_learning == true) ? true : false
    normal_groups = deleteat!(collect(1:ngroups), experiment_group)
    return experiment, exclude_patches, experiment_learning_groups, learnfromcontrol, normal_groups 
end

