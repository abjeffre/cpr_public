# The Function first Samples a number of groups for each individual and stores that to be called later if needed
# The function then loops through indiviudals. It creates a reference list, other_agents_in_group that has a list of all individuals who are not the focal individual in that persons group.
# It then checks the Group learning stratgey. 
# If it is randome then it simply samples either all the agents in a an individuals 'model_group' or thier home group
# 


function GetModels(agents, ngroups, gmean, nmodels, out, learn_type, glearn_strat)
      n = size(agents)[1]
      models = zeros(n)
      model_groups = sample(1:ngroups,gmean, n)
      for i = 1:n
        other_agents_in_group = agents.id[(agents.gid .∈ Ref(agents.gid[i])) .== (agents.id .!= i)]
        if glearn_strat == false
          model_list = ifelse(out[i]==1,
            sample(agents.id[agents.gid.==model_groups[i]], nmodels, replace = false),
            sample(other_agents_in_group, nmodels, replace = false))
          else
            model_list = ifelse(out[i]==1,
              sample(agents.id[1:end .!= agents.id[i]], nmodels, replace = false),
              sample(other_agents_in_group, nmodels, replace = false))
          end

        if learn_type == "wealth"
          candidate_models = model_list[findmax(agents.payoff[model_list])[2]]
          models[i] = ifelse(agents.payoff[candidate_models] > agents.payoff[i], candidate_models, i) end
        if learn_type == "income"
            candidate_models = model_list[findmax(agents.payoff_round[model_list])[2]]
            models[i] = ifelse(agents.payoff_round[candidate_models] > agents.payoff_round[i], candidate_models, i) end
      end # End finding models
      models=convert.(Int64, models)
end
