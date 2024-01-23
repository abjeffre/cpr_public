
      #Calcualte pollition costs
       function GetPollution(effort, loc, ngroups, pol_slope, pol_C, K, kmax)
       pol = zeros(ngroups)
          for i in 1:ngroups
            pol[i]=(1 .- cdf.(Beta(pol_slope, 1), K[i]/maximum(kmax)))*pol_C
            pol[i] = mean(effort[loc .==i])*pol[i]
          end
          return(pol)
        end
