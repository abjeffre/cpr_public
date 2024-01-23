      function GetIndvHarvest(harvest, effort, loc, necessity, ngroups)
        totaleffort = zeros(ngroups)
        for i = 1:ngroups
          temp = sum(effort[loc.==i])
          if isinf(temp) | isnan(temp)
            totaleffort[i] = 0
          else
            totaleffort[i] = temp
          end
        end
        harv = ifelse.(isnan.(effort./totaleffort[loc]), 0,
           ((effort./totaleffort[loc]) .* harvest[loc] .- necessity))
        return(harv)
       end
