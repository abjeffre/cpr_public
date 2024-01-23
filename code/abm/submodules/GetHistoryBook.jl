function getHistoryBook(;n = n, nrounds = nrounds, ngroups = ngroups,
     nsim = nsim, full_save = full_save, pgrowth_data = pgrowth_data,
     rec_history = rec_history, population_growth = population_growth)
    history=Dict{Symbol, Any}(
    :stock => zeros(nrounds, ngroups, nsim),
    :effort => zeros(nrounds, ngroups, nsim),
    :limit => zeros(nrounds, ngroups, nsim),
    :leakage => zeros(nrounds, ngroups, nsim),
    # :og => zeros(nrounds, ngroups, nsim),
    :harvest => zeros(nrounds, ngroups, nsim),
    :punish => zeros(nrounds, ngroups, nsim),
    :punish2 => zeros(nrounds, ngroups, nsim),
    # :cel =>  zeros(nrounds, ngroups, nsim),
    # :clp2 => zeros(nrounds, ngroups, nsim),
    # :cep2 => zeros(nrounds, ngroups, nsim),
    # :fine1 => zeros(nrounds, ngroups, nsim),
    # :fine2 =>zeros(nrounds, ngroups, nsim),
    :loc => ifelse(population_growth == true, zeros(nrounds, convert(Int, sum(pgrowth_data)*ngroups + n), nsim), zeros(nrounds, n, nsim)),
    :gid => ifelse(population_growth == true, zeros(convert(Int, sum(pgrowth_data)*ngroups + n), nsim), zeros(n, nsim)),
    :payoffR => zeros(nrounds, ngroups, nsim),
    :seized2 => zeros(nrounds, ngroups, nsim),
    :caught2 => zeros(nrounds, ngroups, nsim))

  if full_save == true 
    history[:limitfull] = zeros(nrounds, n, nsim)
    history[:effortfull] = zeros(nrounds, n, nsim)
    # history[:leakfull] = zeros(nrounds, n, nsim)
    # history[:limitfull] = zeros(nrounds, n, nsim)
    # history[:punishfull] = zeros(nrounds, n, nsim)
    history[:punish2full] = zeros(nrounds, n, nsim)
    history[:payoffRfull] = zeros(nrounds, n, nsim)
    history[:harvestfull] = zeros(nrounds, n, nsim)            
    #history[:effortLeak] = zeros(nrounds, ngroups, nsim)
    #history[:effortNoLeak] = zeros(nrounds, ngroups, nsim)
    #history[:harvestLeak] = zeros(nrounds, ngroups, nsim)
    #history[:harvestNoLeak] = zeros(nrounds, ngroups, nsim)
    history[:age_max] = zeros(nrounds, ngroups, nsim)
    #history[:seized] = zeros(nrounds, ngroups, nsim)
    #history[:seized2in] = zeros(nrounds, ngroups, nsim)
    #history[:forsize] =  zeros(ngroups, nsim)
    history[:models] =  zeros(nrounds, n, nsim)
    #history[:cel] =  zeros(nrounds, ngroups, nsim)
    #history[:clp2] = zeros(nrounds, ngroups, nsim)
    #history[:cep2] = zeros(nrounds, ngroups, nsim)
    #history[:ve] = zeros(nrounds, ngroups, nsim)
    #history[:vp2] = zeros(nrounds, ngroups, nsim)
    #history[:vl] = zeros(nrounds, ngroups, nsim)
    #history[:roi] = zeros(nrounds, ngroups, nsim)
    #history[:fstEffort] = zeros(nrounds, nsim)
    #history[:fstLimit] = zeros(nrounds, nsim)
    #history[:fstLeakage] = zeros(nrounds, nsim)
    #history[:fstPunish] = zeros(nrounds, nsim)
    #history[:fstPunish2] = zeros(nrounds, nsim)
    #history[:fstFine1] = zeros(nrounds, nsim)
    #history[:fstFine2] = zeros(nrounds, nsim)
    #history[:fstOg] = zeros(nrounds, nsim)
    history[:wealth] = Float64[]
    history[:wealthgroups] = Float64[]
  end
  if rec_history == true
    history[:wealth] = zeros(n, nrounds, nsim)
    history[:wealthgroups] = zeros(n, nrounds, nsim)
    history[:age] = zeros(n, nrounds, nsim)
  end

 return history
end