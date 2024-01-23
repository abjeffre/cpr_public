function ConformityLearn(agents, trait, ngroups, gmean, nmodels, out, glearn_strat, conformity_type, conformity)
      n = size(agents)[1]
      x = copy(trait)
      models = zeros(n)
      model_groups = sample(1:ngroups,gmean, n)
      for i = 1:n
        temp2 = agents.id[(agents.gid .∈ Ref(agents.gid[i])) .== (agents.id .!= i)]
        if glearn_strat == false
          model_list = ifelse(out[i]==1,
            sample(agents.id[agents.gid.==model_groups[i]], nmodels, replace = false),
            sample(temp2, nmodels, replace = false))
          else
            model_list = ifelse(out[i]==1,
              sample(agents.id[1:end .!= agents.id[i]], nmodels, replace = false),
              sample(temp2, nmodels, replace = false))
          end

        temp= copy(x[model_list])
        if conformity_type == "mean" w = abs.(temp.-mean(temp)) end
        if conformity_type == "median" w = abs.(temp.-median(temp)) end
        w=AnalyticWeights((findmax(w)[1].-w).^conformity)
        x[i]=sample(temp, w, 1)[1]
      end
      return(x)
end


