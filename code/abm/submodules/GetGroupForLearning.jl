function GetGroupForLearning(
    param,
    agents,
    distances,
    distance_adj,
    experiment,
    experiment_group)

    n = length(agents.gid)
    loc = zeros(n)
    gweight = Vector{Float64}[]
    if param[:glearn_strat] == "payoff" gweight = reportSum(agents.payoff, agents.gid, param[:ngroups])end
    for i = 1:n
      if param[:ngroups] == 2
        proposal =collect(1:2)[1:end .!= agents.gid[i]]
      else
        weights = softmax(-distances[:, agents.gid[i]]*param[:distance_adj])
        # temp = findall(x->x==0, group_status) # Find all Extinct groups
        # weights[temp] .=0  # Set all extinct groups probability to zero
        # weights[gid[i]]=0  # Set the local groups probability to zero
        if experiment == true # If experiment is on do not sample experiment groups unless otherwise stated
          if control_learning == false weights[1:ngroups .∈ Ref(experiment_group)].=0 end 
        end
        proposal = wsample(collect(1:param[:ngroups]),  weights, param[:groups_sampled], replace = false)
      end
        # Here we must how groups are sampled. 
        # We can use three social learning mechanisms
        # Use Payoff
        # Use of Stock
        if param[:glearn_strat] == "random" 
          loc[i] = sample(proposal)
        end
        if param[:glearn_strat] == "payoff" 
          loc[i] = proposal[findmax(gweight[proposal])[2]]
        end
        if param[:glearn_strat] == "stock" 
          loc[i] = proposal[findmax(K[proposal])[2]]
        end
    end
    loc=asInt.(loc)
 end

