      function GetPatch(
         ngroups,
         gid,
         group_status,
         distances,
         distance_adj,
         leakage_type,
         K,
         groups_sampled,
         experiment,
         experiment_group,
         back_leak)
         n = length(gid)
         loc = zeros(length(gid))
          for i = 1:n
            if ngroups == 2
              proposal =collect(1:2)[1:end .!= gid[i]]
            else
              weights = softmax(-distances[:, gid[i]]*distance_adj)
              temp = findall(x->x==0, group_status)
              weights[temp] .=0
              weights[gid[i]]=0
              if experiment == true
                 if back_leak == false weights[1:ngroups .∈ Ref(experiment_group)].=0 end
              end
              proposal = wsample(collect(1:ngroups),  weights, groups_sampled, replace = false)
            end
              loc[i] = ifelse(leakage_type[i]==1, proposal[findmax(K[proposal])[2]], gid[i])
          end
          loc=asInt.(loc)
      end
