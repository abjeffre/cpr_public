# 



function GetModelsn1(agents, ngroups, gmean, nmodels, out, learn_type, glearn_strat)
    n = size(agents)[1]
    models = zeros(n)
    #This is for when n == ngroups or each group has one person
    for i in 1:n
        temp2 = agents.id[(agents.id .== agents.id .!= i)]
        model_list = sample(temp2, nmodels, replace = false)
        if learn_type == "wealth"
            model_temp = model_list[findmax(agents.payoff[model_list])[2]]
            models[i] = ifelse(agents.payoff[model_temp] > agents.payoff[i], model_temp, i) 
        end
        if learn_type == "income"
            model_temp = model_list[findmax(agents.payoff_round[model_list])[2]]
            models[i] = ifelse(agents.payoff_round[model_temp] > agents.payoff_round[i], model_temp, i) 
        end   
    end 
    models=convert.(Int64, models)
end # End finding models
        



function GetModelsn2(agents, ngroups, gmean, nmodels, out, learn_type, glearn_strat)
    n = size(agents)[1]
    #This is for when n == ngroups or each group has one person
    if learn_type == "wealth"
        w=ProbabilityWeights(agents.payoff.^5)
        models=sample(agents.id, w, n)
    end
    if learn_type == "income"
        w=ProbabilityWeights(agents.payoff_round.^5)
        models=sample(agents.id, w, n)
    end   
    models=convert.(Int64, models)
    return(models)
end # End finding models
        


function GetModelsn1(agents, ngroups, gmean, nmodels, out, learn_type, glearn_strat)
    #     n = size(agents)[1]
    #     models = zeros(n)
    #     #This is for when n == ngroups or each group has one person
    #     if lenUnq(agents.gid) == n
    #         for i in 1:n
    #             temp2 = agents.id[(agents.id .== agents.id .!= i)]
    #             model_list = sample(temp2, nmodels, replace = false)
    #             if learn_type == "wealth"
    #                 model_temp = model_list[findmax(agents.payoff[model_list])[2]]
    #                 models[i] = ifelse(agents.payoff[model_temp] > agents.payoff[i], model_temp, i) 
    #             end
    #             if learn_type == "income"
    #                 model_temp = model_list[findmax(agents.payoff_round[model_list])[2]]
    #                 models[i] = ifelse(agents.payoff_round[model_temp] > agents.payoff_round[i], model_temp, i) 
    #             end   
    #         end 
    #     else     #This is for the normal case
    #         model_groups = sample(1:ngroups,gmean, n)
    #         for i = 1:n
    #            if glearn_strat == false
    #             model_list = ifelse(out[i]==1,
    #               sample(agents.id[agents.gid.==model_groups[i]], nmodels, replace = false),
    #               sample(temp2, nmodels, replace = false))
    #             else
    #               model_list = ifelse(out[i]==1,
    #                 sample(agents.id[1:end .!= agents.id[i]], nmodels, replace = false),
    #                 sample(temp2, nmodels, replace = false))
    #             end
        
    #           if learn_type == "wealth"
    #             model_temp = model_list[findmax(agents.payoff[model_list])[2]]
    #             models[i] = ifelse(agents.payoff[model_temp] > agents.payoff[i], model_temp, i) end
    #           if learn_type == "income"
    #               model_temp = model_list[findmax(agents.payoff_round[model_list])[2]]
    #               models[i] = ifelse(agents.payoff_round[model_temp] > agents.payoff_round[i], model_temp, i) end
    #         end # End finding models
    #     end
    #     models=convert.(Int64, models)
    # end # End finding models
            
    