# Harvest
# Note that this harvest function does not pool labor before applying the elastisicty
# This function has No Heterogenity in the Production function. 
function GetHarvest(effort, loc, K, kmax, tech::Float64, labor::Float64, degrade::Float64, necessity, ngroups, agents)
    b = zeros(ngroups)
    effort=effort.*100
    b =   K.^degrade
    tech.*(effort.^labor).*b[loc]
end

# This function has all the heterogenity
function GetHarvest(effort, loc, K, kmax, tech::Vector{Float64}, labor::Vector{Float64}, degrade::Vector{Float64}, necessity, ngroups, agents)
    b = zeros(ngroups)
    effort=effort.*100
    for i in 1:ngroups
        b[i] =   K[i]^degrade[i]
    end
    #tech.*((1 .+ effort.^labor) .- 1).*b[loc] .- necessity
    tech[agents.gid].*((effort.^labor[agents.id]) ).*b[loc]
end

# Heterogenity in Degrade
function GetHarvest(effort, loc, K, kmax, tech::Float64, labor::Float64, degrade::Vector{Float64}, necessity, ngroups, agents)
  b = zeros(ngroups)
  effort=effort.*100
  for i in 1:ngroups
      b[i] =   K[i]^degrade[i]
  end
  #tech.*((1 .+ effort.^labor) .- 1).*b[loc] .- necessity
  tech.*(effort.^labor).*b[loc]
end

# Heterogenity in Tech
function GetHarvest(effort, loc, K, kmax, tech::Vector{Float64}, labor::Float64, degrade::Float64, necessity, ngroups, agents)
  b = zeros(ngroups)
  effort=effort.*100
  b =   K.^degrade
  #tech.*((1 .+ effort.^labor) .- 1).*b[loc] .- necessity
  tech[agents.gid].*(effort.^labor).*b[loc]
end

# Heterogenity in Labor
function GetHarvest(effort, loc, K, kmax, tech::Float64, labor::Vector{Float64}, degrade::Float64, necessity, ngroups, agents)
  b = zeros(ngroups)
  effort=effort.*100
  b =   K.^degrade
  #tech.*((1 .+ effort.^labor) .- 1).*b[loc] .- necessity
  tech.*(effort.^labor[agents.gid]).*b[loc]
end

# Heterogenity in Tech and Labor
function GetHarvest(effort, loc, K, kmax, tech::Vector{Float64}, labor::Vector{Float64}, degrade::Float64, necessity, ngroups, agents)
  b = zeros(ngroups)
  effort=effort.*100
  b =   K.^degrade
  #tech.*((1 .+ effort.^labor) .- 1).*b[loc] .- necessity
  tech[agents.gid].*(effort.^labor[agents.gid]).*b[loc]
end

# Heterogenity in Labor and Degrade
function GetHarvest(effort, loc, K, kmax, tech::Float64, labor::Vector{Float64}, degrade::Vector{Float64}, necessity, ngroups, agents)
  b = zeros(ngroups)
  effort=effort.*100
  for i in 1:ngroups
    b[i] =   K[i]^degrade[i]
  end
  #tech.*((1 .+ effort.^labor) .- 1).*b[loc] .- necessity
  tech.*(effort.^labor[agents.gid]).*b[loc]
end


# Heterogenity in Labor and Degrade
function GetHarvest(effort, loc, K, kmax, tech::Vector{Float64}, labor::Float64, degrade::Vector{Float64}, necessity, ngroups, agents)
  b = zeros(ngroups)
  effort=effort.*100
  for i in 1:ngroups
    b[i] =   K[i]^degrade[i]
  end
  #tech.*((1 .+ effort.^labor) .- 1).*b[loc] .- necessity
  tech[agents.gid].*(effort.^labor).*b[loc]
end



# Harvest
#Note that this harvest function does not pool labor before applying the elastisicty
function GetHarvestDensity(effort, loc, K, kmax, tech, labor, degrade, ngroups, agents, density_alpha)
    b = zeros(ngroups)
    dens = zeros(ngroups)
    effort=effort.*100
    for i in 1:ngroups
        b[i] =   K[i]^degrade[i]
        dens[i] = K[i]/kmax[i] 
    end
    #tech.*((1 .+ effort.^labor) .- 1).*b[loc] .- necessity
    H=tech[agents.gid].*((effort.^labor[agents.id]) ).*b[loc] 
    H = H.- H.*density_alpha.*(1 .-(K[loc]./kmax[loc]))
    return H
end


  # Harvest
  #Note that this harvest function does not pool labor before applying the elastisicty
  function GetHarvestStone(effort, loc, K, kmax, tech, labor, degrade, necessity, ngroups)
    b = zeros(ngroups)
    effort=effort.*100
    for i in 1:ngroups
      if length(degrade) == 1
        b[i] =   K[i]^degrade
      else
       b[i]=cdf.(Beta(degrade[1], degrade[2]), K[i]/maximum(kmax))
      end
    end
    out=tech.*((1 .+ effort.^labor) .- 1).*b[loc] .- necessity
    ifelse.(out .< 0, out, out*2)
   end

test=function(K, Kmax, α=1)
  H=.00001*100^.5*K 
  H = H-H*α*(1-(K/Kmax))
  return(H)
end

