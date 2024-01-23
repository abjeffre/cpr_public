 function GetInspection(harvest, x, loc, gid, policy, monitor_tech, def, type)
  caught = asInt.(zeros(length(x)))
  for i = 1:length(x)
    if type == "nonlocal"
      prob_caught = (sum(x[gid .== loc[i]])/def[gid[i]]).^monitor_tech
      prob_caught =prob_caught > 1 ? 1 : prob_caught
      if loc[i] != gid[i]
                caught[i] = rbinom(1, 1, prob_caught)[1]
      end
    end
    if type == "local"
       prob_caught = (sum(x[gid .== loc[i]])/def[gid[i]]).^monitor_tech
       prob_caught = prob_caught > 1 ? 1 : prob_caught
       if loc[i] == gid[i]
         if harvest[i] >= policy[gid[i]] caught[i] = rbinom(1, 1, prob_caught)[1]end
       end
     end
    end
    return(caught)
  end




  # function GetInspection(harvest, x, loc, gid, policy, monitor_tech, def, type,)
  #   caught = asInt.(zeros(length(x)))
  #   for i = 1:length(x)
  #     if type == "nonlocal"
  #       prob_caught = cdf.(Beta(monitor_tech[1], monitor_tech[2]), sum(x[gid .== loc[i]])/def[gid[i]])
  #       if loc[i] != gid[i]
  #                 caught[i] = rbinom(1, 1, prob_caught)[1]
  #       end
  #     end
  #     if type == "local"
  #        prob_caught = cdf.(Beta(monitor_tech[1], monitor_tech[2]), sum(x[gid .== loc[i]])/def[gid[i]])
  #        if loc[i] == gid[i]
  #          if harvest[i] >= policy[gid[i]] caught[i] = rbinom(1, 1, prob_caught)[1]end
  #        end
  #      end
  #     end
  #     return(caught)
  #   end
  
  
  
  
    