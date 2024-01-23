
regulators=function(;
    r = .5, # strarting bandits
    s = 1, # Starting forest stock
    x = .5, # Starting border patrols 
    u = .1, # starting regulators
    k = 1,  # carrying capacity
    α =.1, # effect of eco-system health on theft
    β =.1, # loss of bandits due to internal competition and patrols
    γ = .1, # Growth in borders due to siezures
    ζ = .1, # Loss of border patrol due to competition over resources
    δ = .1, # Growth in regulators due to regulators and stock
    ϕ = .1, # The effect of regulators on regrowth
    Ω = .1, # loss of regulators due to banditry
    Γ = .1, # Increase in leakage caused by strict regulators
    λ = .1, # Loss of regulators due to local competition
    ω =.01, # Loss of forest due to harvesting    
    ι = .01, # regrowth rate  
    t= 1000
    )
    hists = []
    histr = []
    histu = []
    histx = []
             
    for i in 1:t
        #Record history
        push!(histr, r)
        push!(hists, s)
        push!(histu, u)  
        push!(histx, x)
        # Payoff by consumer type
        Δr =  α*s*r - β*r*x 
        Δx =  γ*r*x*s - ζ*x
        Δu =  δ*u*s - Ω*r*(1-x)*u
        Δs =  ι*s*(1-s) - ω*s*r + ϕ*u
        Δs = isnan(Δs) ? 0 : Δs
        Δr = isnan(Δr) ? 0 : Δr
        Δu = isnan(Δu) ? 0 : Δu  
        Δx = isnan(Δx) ? 0 : Δx  
        #update
        r=copy(r+Δr)
        s=copy(s+Δs)
        u=copy(u+Δu)
        x=copy(x+Δx)
        x=x > 1 ? 1 : x
        x=x < 0 ? 0.01 : x
        r=r > 1 ? 1 : r
        r=r < 0 ? 0.01 : r
        u=u > 1 ? 1 : u
        u=u < 0 ? 0.01 : u
        s=s > 1 ? 1 : s
        s=s < 0 ? 0 : s 
    end
    out = Dict(:s =>Float16.(hists),
    :r =>Float16.(histr),
    :u =>Float16.(histu),
    :x =>Float16.(histx))
    return(out)
end #end function

using Plots
out=regulators(γ=.10, ω = .005, t = 1000, u=.1, Ω = .1, δ=.10, β = .100)
plot(out[:s], ylim = (0,1), label = "Resource Stock", legend = :bottomleft, c = :green, ylab = "Trait Frequency", xlab = "Time",
 title = "(e)", titlelocation = :left, titlefontsize = 15)
plot!(out[:x], label = "Access-Rights", c =:blue)
plot!(out[:r], label = "Roving bandits", c = :red)
plot!(out[:u], label = "Use-Rights", c = :orange)

