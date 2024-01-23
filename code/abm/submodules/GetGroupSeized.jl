  function GetGroupSeized(harvest, caught, loc, ngroups)
    seized = zeros(ngroups)
    for i in 1:ngroups
      seized[i]=sum(harvest[loc.==i].*caught[loc.==i])
    end
    return(seized)
  end
