  # Harvest
  #Note that this harvest function does not pool labor before applying the elastisicty
  function GetAgHarvest(effort, gid, K, kmax, tech, labor, ag_degrade, necessity, ngroups)
    b = zeros(ngroups)
    effort = effort.*100
    for i in 1:ngroups
      b[i]=cdf.(Beta(ag_degrade[1], ag_degrade[2]), K[i]/maximum(kmax))
    end
    tech.*((1 .+ effort.^labor) .- 1).*(1 .-b[gid]) .- necessity
   end


  # Harvest
  #Note that this harvest function does not pool labor before applying the elastisicty
  function GetHarvestStone(effort, gid, K, kmax, tech, labor, ag_degrade, necessity, ngroups)
    b = zeros(ngroups)
    effort = effort.* 100
    for i in 1:ngroups
      b[i]=cdf.(Beta(ag_degrade[1], ag_degrade[2]), K[i]/maximum(kmax))
    end
    out=tech.*((1 .+ effort.^labor) .- 1).*(1 .-b[gid]) .- necessity
    ifelse.(out .< 0, out, out*2)
   end


   
   # THIS FUNCTION POOLS LABOR BEFORE APPLYING ELASTICITY IT MEANS FARMING IS COLLECTIVE.
   # AT LEAST IN THE SENSE THAT THE MARGINAL EFFECTS OF LABOR IS CALCULATED AT THE GROUP LEVEL
   # THIS IN A SENSE MAKES LAND SCARCE!
  function GetAgHarvest2(effort, gid, K, kmax, tech, labor, ag_degrade, necessity, ngroups)
    effort = effort*100
    b = zeros(ngroups)
    X =zeros(ngroups)
    for i in 1:ngroups
      b[i]=1-cdf.(Beta(ag_degrade[1], ag_degrade[2]), K[i]/maximum(kmax))
    end
    for i in 1:ngroups
      X[i] =tech*(((1+sum(effort[gid .== i])^labor)-1)*b[i])
    end
    #Now get Individual Harvests
    totaleffort = zeros(ngroups)
    for i = 1:ngroups
      temp = sum(effort[gid.==i])
      if isinf(temp) | isnan(temp)
        totaleffort[i] = 0
      else
        totaleffort[i] = temp
      end
    end
    harv = ifelse.(isnan.(effort./totaleffort[gid]), 0,
       ((effort./totaleffort[gid]) .* X[gid] .- necessity))
    return(harv)
   end
