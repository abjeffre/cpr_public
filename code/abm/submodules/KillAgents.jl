function KillAgents(pop, id, age, mortality_rate, sample_payoff)
#    println("ages : ",length(unique(age[pop])))
#    println("payoff: ", length(unique(sample_payoff[pop])))

    if  length(unique(age[pop])) == 1
        age[pop] .=age[pop].+rand(0:1, length(age[pop]))
    end

    if  length(unique(sample_payoff[pop])) == 1
        sample_payoff[pop] .=  sample_payoff[pop].+rand(length(sample_payoff[pop]))
    end

    #println(age[pop].^5.5)
    #println(standardize2(sample_payoff[pop]).^25)
    mortality_risk = AnalyticWeights(softmax(standardize2(age[pop].^6) .- standardize2(sample_payoff[pop].^.25)))
    #println(mortality_risk)
    to_die = asInt(round(mortality_rate*length(pop), digits =0))
    died=wsample(pop, mortality_risk, to_die, replace = false)
    return(died)
end
