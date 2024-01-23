function SeedTraits(; n=n, ngroups=ngroups, agents = agents,  ngoods=ngoods,
   gs_init = gs_init, harvest_limit = harvest_limit, harvest_var = harvest_var,
   harvest_var_ind = harvest_var_ind, seed = seed, fine_start = fine_start, 
   learn_group_policy =learn_group_policy, invasion = invasion, fine_var = fine_var)

   traits = DataFrame(
    leakage_type = zeros(n),
    punish_type = zeros(n),
    punish_type2 = zeros(n),
    fines1 = zeros(n),
    fines2 = zeros(n),
    harv_limit = zeros(n),
    og_type = zeros(n))
  
  traitTypes = ["binary" "prob" "prob" "positivecont" "positivecont" "positivecont" "prob"]
  if learn_group_policy 
      traitTypesGroup = ["binary" "prob" "prob" "positivecont" "positivecont" "grouppositivecont" "prob"] # if learn group policy then learning shifts
  else
    traitTypesGroup = nothing
  end

   temp = ones(ngoods)
  if invasion == true
    temp[1] = 100-ngoods
    effort = rand(Dirichlet(temp), n)'
    effort=DataFrame(Matrix(effort), :auto)
  else
    temp=temp*2
    effort = rand(Dirichlet(temp), n)'
    effort=DataFrame(Matrix(effort), :auto)
  end
  # Setup leakage
  for i in 1:ngroups
    leak_temp =zeros(gs_init[i])
    leak_temp[1:asInt(ceil(gs_init[i]/2))].=1 #50% START AS LEAKERS
    if invasion  leak_temp[1:asInt(ceil(gs_init[i]/(gs_init[i]*.9)))].=1 end #10% START AS LEAKERS
    Random.seed!(seed+i+2+ngroups)
    traits.leakage_type[agents.gid.==i] = sample(leak_temp, gs_init[i])
  end
  # Setup punishment
  for i in 1:ngroups
    Random.seed!(seed+(i)+2+(ngroups*2))
    traits.punish_type2[agents.gid.==i] = rand(Beta(1, (1/.1-1)), gs_init[i]) # the denominator in the beta term determines the mean
    Random.seed!(seed+(i*2)+2+(ngroups*2))
    traits.punish_type[agents.gid.==i] = rand(Beta(1, (1/.1-1)), gs_init[i]) # the denominator in the beta term determines the mean
  end
  #Setup Harvest Limit
  Random.seed!(seed+2)
  temp=abs.(rand(Normal(harvest_limit, harvest_var), ngroups))
  for i in 1:ngroups
    Random.seed!(seed+i+2)
    traits.harv_limit[agents.gid.==i] = abs.(rand(Normal(temp[i], harvest_var_ind), gs_init[i]))
  end
  # Fines
  if fine_start != nothing
    Random.seed!(seed+20)
    temp=abs.(rand(Normal(fine_start, fine_var), ngroups))
    for i in 1:ngroups
      Random.seed!(seed+i+20)
      traits.fines1[agents.gid.==i] = abs.(rand(Normal(temp[i], .3), gs_init[i]))
    end
    Random.seed!(seed+21)
    temp=abs.(rand(Normal(fine_start, fine_var), ngroups))
    for i in 1:ngroups
      Random.seed!(seed+i+21)
      traits.fines2[agents.gid.==i] = abs.(rand(Normal(temp[i], .03), gs_init[i]))
    end
  end
  # Outgroup learn
  Random.seed!(seed+56)
  if invasion == true
      traits.og_type = rand(Beta(1,10), n)
    else
      traits.og_type  = inv_logit.(rnorm(n,logit(.5), .15)) #THIS STARTS AROUND 50%
  end
  return effort, traits, traitTypes, traitTypesGroup
end



function SeedTraits(; n=n, ngroups=ngroups, agents = agents,  ngoods=ngoods,
  gs_init = gs_init, limit_seed = limit_seed, harvest_var = harvest_var,
  harvest_var_ind = harvest_var_ind, seed = seed, fine_start = fine_start, 
  learn_group_policy =learn_group_policy, invasion = invasion, fine_var = fine_var, 
  effort_seed = effort_seed, limit_seed_override=limit_seed_override)

  traits = DataFrame(
   leakage_type = zeros(n),
   punish_type = zeros(n),
   punish_type2 = zeros(n),
   fines1 = zeros(n),
   fines2 = zeros(n),
   harv_limit = zeros(n),
   og_type = zeros(n))
 
 traitTypes = ["binary" "prob" "prob" "positivecont" "positivecont" "positivecont" "prob"]
 if learn_group_policy 
     traitTypesGroup = ["binary" "prob" "prob" "positivecont" "positivecont" "grouppositivecont" "prob"] # if learn group policy then learning shifts
 else
   traitTypesGroup = nothing
 end

  temp = ones(ngoods)
 if invasion == true
   temp[1] = 100-ngoods
   effort = rand(Dirichlet(temp), n)'
   effort=DataFrame(Matrix(effort), :auto)
 else
   temp=temp*2
   effort = rand(Dirichlet(temp), n)'
   effort=DataFrame(Matrix(effort), :auto)
 end
 if effort_seed !== nothing
  for i in 1:ngroups
    temp[2] = (effort_seed[i])
    effort[agents.gid .== i, :] = rand(Dirichlet(temp), gs_init[1])'
  end
 end

 # Setup leakage
 for i in 1:ngroups
   leak_temp =zeros(gs_init[i])
   leak_temp[1:asInt(ceil(gs_init[i]/2))].=1 #50% START AS LEAKERS
   if invasion  leak_temp[1:asInt(ceil(gs_init[i]/(gs_init[i]*.9)))].=1 end #10% START AS LEAKERS
   Random.seed!(seed+i+2+ngroups)
   traits.leakage_type[agents.gid.==i] = sample(leak_temp, gs_init[i])
 end
 # Setup punishment
 for i in 1:ngroups
   Random.seed!(seed+(i)+2+(ngroups*2))
   traits.punish_type2[agents.gid.==i] = rand(Beta(1, (1/.1-1)), gs_init[i]) # the denominator in the beta term determines the mean
   Random.seed!(seed+(i*2)+2+(ngroups*2))
   traits.punish_type[agents.gid.==i] = rand(Beta(1, (1/.1-1)), gs_init[i]) # the denominator in the beta term determines the mean
 end
 #Setup Harvest Limit
 Random.seed!(seed+2)
 temp=rand(Uniform(limit_seed[1], limit_seed[2]), ngroups)
 if limit_seed_override !== nothing temp = copy(limit_seed_override) end
 for i in 1:ngroups
   Random.seed!(seed+i+2)
   traits.harv_limit[agents.gid.==i] = abs.(rand(Normal(temp[i], harvest_var_ind), gs_init[i]))
 end
 # Fines
 if fine_start != nothing
   Random.seed!(seed+20)
   temp=abs.(rand(Normal(fine_start, fine_var), ngroups))
   for i in 1:ngroups
     Random.seed!(seed+i+20)
     traits.fines1[agents.gid.==i] = abs.(rand(Normal(temp[i], .3), gs_init[i]))
   end
   Random.seed!(seed+21)
   temp=abs.(rand(Normal(fine_start, fine_var), ngroups))
   for i in 1:ngroups
     Random.seed!(seed+i+21)
     traits.fines2[agents.gid.==i] = abs.(rand(Normal(temp[i], .03), gs_init[i]))
   end
 end
 # Outgroup learn
 Random.seed!(seed+56)
 if invasion == true
     traits.og_type = rand(Beta(1,10), n)
   else
     traits.og_type  = inv_logit.(rnorm(n,logit(.5), .15)) #THIS STARTS AROUND 50%
 end
 return effort, traits, traitTypes, traitTypesGroup
end
