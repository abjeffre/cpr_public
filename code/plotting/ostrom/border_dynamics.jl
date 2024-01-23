
borders=function(;r = .5, # strarting bandits
    s = 1, # Starting forest stock
    x = .5, # Starting border patrols 
    k = 1,  # carrying capacity
    α =.1, # effect of eco-system health on theft
    β =.1, # loss of bandits due to internal competition and patrols
    γ = .1, # Growth in borders due to siezures
    ζ = .1, # Loss of border patrol due to competition over resources
    ω =.01, # Loss of forest due to harvesting    
    ι = .01, # regrowth rate  
    t= 1000
    )
    hists = []
    histr = []
    histx = []
            
    for i in 1:t
        #Record history
        push!(histr, r)
        push!(hists, s)
        push!(histx, x)  
        # Payoff by consumer type
        Δr =  α*s*r - β*r*x
        Δx =  γ*r*x*s -ζ*x
        Δs =  ι*s*(1-s) - ω*s*r
        Δs = isnan(Δs) ? 0 : Δs
        Δr = isnan(Δr) ? 0 : Δr
        Δx = isnan(Δx) ? 0 : Δx  
        #update
        r=copy(r+Δr)
        s=copy(s+Δs)
        x=copy(x+Δx)
        x=x > 1 ? 1 : x
        x=x < 0 ? 0.01 : x
        r=r > 1 ? 1 : r
        r=r < 0 ? 0.01 : r
        s=s > 1 ? 1 : s
        s=s < 0 ? 0 : s
    end
    out = Dict(:s =>Float16.(hists),
    :r =>Float16.(histr),
    :x =>Float16.(histx))
    return(out)
end #end function

using Plots
out=borders(γ=.2, ω = .004, t = 1000)
maintain=plot(out[:s], ylim = (0,1), label = "Resource Stock", legend = :bottomleft, c = :forestgreen, ylab = "Trait Frequency", xlab = "Time",
 title = "(e)", titlelocation = :left, titlefontsize = 15, grid = false , legendfontsize = 7,  foreground_color_legend = nothing )
plot!(out[:x], label = "Access-Rights", c =:dodgerblue)
plot!(out[:r], label = "Bandits", c = :orange3)

out=borders(γ=.2, ω = .006, t = 1000)
collapse=plot(out[:s], ylim = (0,1), label = "Resource Stock", legend = :bottomleft, c = :forestgreen, xlab = "Time", ylab = "Trait Frequency",
title = "(f)", titlelocation = :left, titlefontsize = 15, grid = false, legendfontsize = 7, foreground_color_legend = nothing )
plot!(out[:x], label = "Access-Rights", c = :dodgerblue)
plot!(out[:r], label = "Bandits", c= :orange3)
