function RecordHistory(; history = history, K = K, kmax = kmax, ngroups = ngroups, effort = effort,
     traits = traits, agents = agents, seized2 = seized2, SP1 = SP1, SP2 = SP2,
     rec_history = rec_history, full_save = full_save, HG = HG, loc = loc, caught2 = caught2,
      n = n, sim=sim, year = year)
    history[:stock][year,:,sim] .=round.(K./kmax, digits=3)
    history[:effort][year,:,sim] .=round.(report(effort[:,2], agents.gid, ngroups), digits=3)
    history[:limit][year,:,sim] .= round.(reportMedian(traits.harv_limit, agents.gid, ngroups), digits=3)
    history[:leakage][year,:,sim] .= round.(report(traits.leakage_type,agents.gid, ngroups), digits=3)
    # history[:og][year,:,sim] .= round.(report(traits.og_type,agents.gid, ngroups), digits=3)
    history[:harvest][year,:,sim] .= round.(report(HG,agents.gid, ngroups), digits=3)
    history[:punish][year,:,sim]  .= round.(report(traits.punish_type,agents.gid, ngroups), digits=3)
    history[:punish2][year,:,sim]  .= round.(report(traits.punish_type2,agents.gid, ngroups), digits=3)
    # history[:fine1][year,:,sim] .= round.(reportMedian(traits.fines1, agents.gid, ngroups), digits=3)
    # history[:fine2][year,:,sim]  .= round.(reportMedian(traits.fines2, agents.gid, ngroups), digits=3)
    history[:payoffR][year,:,sim] .= round.(report(agents.payoff_round,agents.gid, ngroups), digits=3)
    history[:loc][year,1:n,sim] .= loc
    history[:gid][1:n, sim] .= agents.gid
    history[:seized2][year,:,sim] .= round.(reportSum(SP2, agents.gid, ngroups), digits =2)
    history[:caught2][year,:,sim] .= round.(report(caught2, agents.gid, ngroups), digits =2)
   
    if full_save == true
    history[:limitfull][year, :, sim] .= traits.harv_limit
    history[:effortfull][year, :, sim] .= effort[:,2]
    # history[:leakfull][year, :, sim] .= traits.leakage_type
    # history[:punishfull][year, :, sim] .= traits.punish_type
    history[:punish2full][year, :, sim] .= traits.punish_type2
    history[:payoffRfull][year, :, sim] .= agents.payoff_round
    history[:harvestfull][year, :, sim] .= HG           
    #history[:effortLeak][year,:,sim] .= round.(report(effort[traits.leakage_type.==1, 2], agents.gid[traits.leakage_type.==1], ngroups), digits=2)
    #history[:effortNoLeak][year,:,sim] .= round.(report(effort[traits.leakage_type.==0, 2], agents.gid[traits.leakage_type.==1], ngroups), digits=2)
    #history[:harvestLeak][year,:,sim] .= round.(report(HG[traits.leakage_type.==1], agents.gid[traits.leakage_type.==1], ngroups), digits=2)
    #history[:harvestNoLeak][year,:,sim] .= round.(report(HG[traits.leakage_type.==0], agents.gid[traits.leakage_type.==1], ngroups), digits=2)
    history[:age_max][year,:,sim] => round.(report(agents.age,agents.gid, ngroups), digits=2)
    # history[:seized][year,:,sim] .=  round.(reportSum(SP1, agents.gid, ngroups), digits =2)
    
    # history[:seized2in][year,:,sim] .= seized2
    # history[:forsize][:,sim] .= kmax
    # history[:cel][year,:,sim] .=  round.(reportCor(effort[:,2], traits.harv_limit,agents.gid, ngroups), digits=3)
    # history[:clp2][year,:,sim] .= round.(reportCor(effort[:,2], traits.punish_type2,agents.gid, ngroups), digits=3)
    # history[:cep2][year,:,sim] .= round.(reportCor(traits.harv_limit, traits.punish_type2,agents.gid, ngroups), digits=3)
    # history[:ve][year,:,sim] .= round.(reportVar(effort[:,2],agents.gid, ngroups), digits=3)
    # history[:vp2][year,:,sim] .= round.(reportVar(traits.punish_type2,agents.gid, ngroups), digits=3)
    # history[:vl][year,:,sim] .= round.(reportVar(traits.harv_limit,agents.gid, ngroups), digits=3)
    #  history[:fstEffort][year,sim] = GetFST(effort[:,2], agents.gid, ngroups, experiment_group, experiment)
    #  history[:fstLimit][year,sim]  = GetFST(traits.harv_limit, agents.gid, ngroups, experiment_group, experiment)
    #  history[:fstLeakage][year,sim]   = GetFST(traits.leakage_type, agents.gid, ngroups, experiment_group, experiment)
    #  history[:fstPunish][year,sim]   = GetFST(traits.punish_type, agents.gid, ngroups, experiment_group, experiment)
    #  history[:fstPunish2][year,sim]  = GetFST(traits.punish_type2, agents.gid, ngroups, experiment_group, experiment)
    #  history[:fstFine1][year,sim]  = GetFST(traits.fines1, agents.gid, ngroups, experiment_group, experiment)
    #  history[:fstFine2][year,sim]  = GetFST(traits.fines2, agents.gid, ngroups, experiment_group, experiment)
    #  history[:fstOg][year,sim]  = GetFST(traits.og_type, agents.gid, ngroups, experiment_group, experiment)
    end
    if rec_history == true 
        history[:wealth][:,year,sim]  = agents.payoff
        history[:wealthgroups][:,year,sim]  = agents.gid
        history[:age][:,year,sim]  = agents.age 
    end
    return history
end