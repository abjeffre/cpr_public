  # Harvest
      function GetGroupHarvest(effort, loc, K, kmax, tech, labor, degrade, ngroups)
       b = zeros(ngroups)
       X =zeros(ngroups)
       for i in 1:ngroups
         X[i] =tech[i]*((sum(effort[loc .== i])^labor[i])*K[i]^degrade[i])
       end
       return(X)
      end
