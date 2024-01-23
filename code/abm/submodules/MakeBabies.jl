
function MakeBabies(pop, id, sample_payoff, died, new_agents = nothing)
    sample_payoff[died] .=0
    sample_payoff[(id) .∉ Ref(pop)] .=0
    add = new_agents == nothing ? length(died) : new_agents
    babies=wsample(id, sample_payoff, add, replace = true)
    return(babies)
end

