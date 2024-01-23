    function GetPolicy(x, type, y, ngroups, gid, group_status, t)
     policy = zeros(ngroups)
     t ==1 ? wei = rand(Normal(.5, .01), length(x)) : wei = y
     for i in 1:ngroups
      if type == "equal"
       if group_status[i] == 1 policy[i]=median(x[gid.==i]) end
      end
      if type == "max"
       sum(wei) == 0 ? wei = rand(length(x)) : wei
       wei = AnalyticWeights(wei)
       if group_status[i] == 1 policy[i]=median(x[gid.==i], wei[gid.==i]) end
      end
      if type == "min"
       wei = abs.(wei.-findmax(wei)[1])
       sum(wei) == 0 ? wei = rand(length(x)) : wei
       wei = AnalyticWeights(wei)
       if group_status[i] == 1 policy[i]=median(x[gid.==i], wei[gid.==i]) end
      end
     end
     return(policy)
  end
