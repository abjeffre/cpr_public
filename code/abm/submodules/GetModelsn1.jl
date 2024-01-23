
function GetModelsn1(agents, history, learn_type, year)
    n = size(agents)[1]
    models = zeros(n)
    #This is for when n == ngroups or each group has one person
    payoff=history[:payoffR][year-1,:,1]      
    for i in 1:n
        temp2 = agents.id[(agents.id .== agents.id .!= i)]
        model_list = sample(temp2, 1, replace = false)
        if learn_type == "wealth"
            model_temp = model_list[findmax(payoff[model_list])[2]]
            models[i] = ifelse(payoff[model_temp] > agents.payoff[i], model_temp, i) 
        end
        if learn_type == "income"
            model_temp = model_list[findmax(agents.payoff_round[model_list])[2]]
            models[i] = ifelse(payoff[model_temp] > agents.payoff_round[i], model_temp, i) 
        end   
    end 
    models=convert.(Int64, models)
    return(models)
end # End finding models
        
