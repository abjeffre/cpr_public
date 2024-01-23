
    function RWLearn2(agents, effort, memory, αlearn)
        x = copy(effort)
        x[:,2]=ifelse.(x[:,2] .== 1, .99, x[:,2])
        x[:,2]=ifelse.(x[:,2] .== 0, .01, x[:,2])
        n = size(agents)[1]
        δS = agents.payoff_round - memory[:payoff_round]
        δV = logit.(x[:,2]) - logit.(memory[:effort][:,2])
        ne= ifelse.((δS .!== 0) .&  (δV .== 0), inv_logit.(ifelse.(x[:,2].==1, 4.6, logit.(x[:,2])) .+ rand(Normal(0, 1.5), n)),
                inv_logit.(αlearn.*δS.*δV .+ logit.(x[:,2])))
        x[:,2] = round.(ne, digits = 3)
        #println(x)
        x[:,1] = 1 .- x[:,2]
        return(x)
    end
