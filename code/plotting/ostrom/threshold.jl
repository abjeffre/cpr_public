# using Plots.PlotMeasures
if RUN == true
 out = []
 ngroups =2
 n = 30
 for i in 0.001:.005:.25
     c = cpr_abm(degrade = 1, n=30*ngroups, ngroups = ngroups, lattice = [1,2],
         max_forest = 1333*30*ngroups, tech = .00002, wages = 1, price = 3, nrounds = 3000, leak = false,
         labor = 1,
          learn_group_policy =false, invasion = false, nsim = 1, pun2_on = false, experiment_effort = i,
         experiment_group = collect(1:ngroups), control_learning = false, back_leak = true, outgroup = .0,
         full_save = true, genetic_evolution = false, glearn_strat = "income", fidelity = .01
         )
     push!(out, c)
 end
 save("cpr/data/Threshold.jld2", "out", out)
end 

out = load("cpr/data/Threshold.jld2")["out"]

 pay=[median(out[i][:payoffR][2000:3000,1,1]) for i in 1:length(out)]
 stock=[median(out[i][:stock][2000:3000,1,1]) for i in 1:length(out)]
 Threshold=plot(stock, pay, xlab = "Stock", ylab = "Payoff", c =:black, label = "")
 vline!([.50, .50], title = "(n)", titlelocation = :left, titlefontsize = 15, grid = false, label = "MSY",
 foreground_color_legend = nothing)




# plot!(collect(0.02:.02: 1), effort.*40)

# plot(out[3][:stock][:,1,1])

#effort = collect(0.001:.005:.25)
#Threshold2=plot(effort, pay, xlab = "Stock", ylab = "Payoff", c =:black, label = "")
#vline!([.50, .50], title = "(n)", titlelocation = :left, titlefontsize = 15, grid = false, label = "MSY",
#foreground_color_legend = nothing)



