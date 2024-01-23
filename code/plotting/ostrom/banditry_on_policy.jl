# ###################################################################
# ##################### BANDITRY ON POLICY ##########################

#  # Multicore 2 groups
#  # Uses special Leakage group
# if RUN == true
#     L = fill(.01, 40)
#     ng = fill(9, 40) 
#     @everywhere function g2(L, ng)  
#         cpr_abm(labor = .7, max_forest = 105000*ng, n = ng*75, ngroups = ng, 
#         lattice = [3,3], harvest_limit = 2, harvest_var = 0.5, nrounds = 5000, travel_cost = 0,
#         harvest_var_ind = 0.1, experiment_group = collect(1:1:ng), invasion = true, nsim = 1, regrow = 0.01,
#         experiment_punish2 = 1, experiment_punish1 = 0.01,  experiment_leak = L, special_leakage_group = 5,
#         leak=false, control_learning = true, back_leak= true, pun1_on = true, groups_sampled = 8, seized_on = false,
#         begin_leakage_experiment = 1)
#     end
#     dat=pmap(g2, L, ng)
#     serialize("CPR\\data\\abm\\lowleak.dat", dat)
#     L = fill(1, 40)
#     ng = fill(9, 40)
#     @everywhere function g2(L, ng) 
#         cpr_abm(labor = .7, max_forest = 105000*ng, n = ng*75, ngroups = ng, 
#         lattice = [3,3], harvest_limit = 2, harvest_var = 0.5, nrounds = 5000, travel_cost = 0,
#         harvest_var_ind = 0.1, experiment_group = collect(1:1:ng), invasion = true, nsim = 1, regrow = 0.01,
#         experiment_punish2 = 1, experiment_punish1 = 0.01,  experiment_leak = L, special_leakage_group = 5,
#         leak=false, control_learning = true, back_leak= true, pun1_on = true, groups_sampled = 8, seized_on = false,
#         begin_leakage_experiment = 1)
#     end

#     dat=pmap(g2, L, ng)
#     serialize("CPR\\data\\abm\\highleak.dat", dat)
# end

# println("got here")

# using Serialization
# dat=[deserialize("CPR\\data\\abm\\lowleak.dat"), deserialize("CPR\\data\\abm\\highleak.dat")]

# annotate = [" (no banditry)", " (banditry)"]
# plotsl = []
# for j in 1:2
#     trim = collect(1:10:5000)
#     groups = [collect(1:4);collect(6:9)]
#     lab = ifelse(j == 1, "(e)", "(d)")
#     col = ifelse.(dat[j][1][:stock][trim,groups,1] .> .1, :green, :black)
#     a=plot(dat[j][1][:limit][trim,groups,1], label = "", alpha = 0.1, linecolor=col, xticks = (0, ""), yticks = (0, ""),
#      xlab = string("Time", annotate[j]), ylab = "MAH", ylim = (0, 6.1),
#      title = lab, titlelocation = :left, titlefontsize = 15)
#     for i in 1:40
#         col = ifelse.(dat[j][i][:stock][trim,groups,1] .> .1, :green, :black)
#         plot!(dat[j][i][:limit][trim,groups,1], label = "", alpha = 0.1, c=col)
#     end

#     hline!([3.5, 3.5], c = :red, label = "")
#     push!(plotsl, a)
# end

# savefig(plotsl[2], "test2.pdf")
#######################################################################
################### NEW ###############################################

if RUN == true
    S=[true, false]
    @everywhere function g(l)
        cpr_abm(degrade = 1,
        n=30*100,
        ngroups = 100,
        lattice = [10,10],
        max_forest = 1333*30*100,
        tech = .00002,
        wages = 1,
        price = 3,
        nrounds = 5000,
        leak = l,
        pun1_on = false,
        learn_group_policy =false,
        invasion = true,
        nsim = 1,
        travel_cost = 0,
        inspect_timing = "after",
        outgroup = .7,
        full_save = false,
        genetic_evolution = false,
        #glearn_strat = "income",
        limit_seed_override = collect(range(start = .1, stop = 4, length =100)))
    end    
    data = []
    for i in 1:length(S)
        println(i)
        par = fill(S[i], 25)    
        dat=pmap(g, par)
        push!(data, dat)
    end
    save("leakage_on_policy.jld2", "out", data)
end

dat = load("C:/Users/jeffr/Documents/Work/cpr/data/leakage_on_policy.jld2")
dat = dat["out"]
annotate = [" (banditry)", " (no banditry)"]
plotsl = []
for j in 1:2
    trim = collect(1:100:5000)
    groups = collect(1:100)
    lab = ifelse(j == 1, "(p)", "(o)")
    col = ifelse.(dat[j][1][:stock][trim,groups,1] .> .3, :green, :black)
    a=plot(dat[j][1][:limit][trim,groups,1], label = "", alpha = 0.01, linecolor=col,  yticks = (0, ""),
     xlab = string("Time", annotate[j]), ylab = "MAH", ylim = (0, 10), grid = false, ytick = ((0, 9), ("Low MAH", "High MAH")), yrotation = 90,
     title = lab, titlelocation = :left, titlefontsize = 15);
    for i in 1:25
        col = ifelse.(dat[j][i][:stock][trim,groups,1] .> .3, :green, :black)
        al = ifelse.(dat[j][i][:stock][trim,groups,1] .> .3, .1, .001)

        plot!(dat[j][i][:limit][trim,groups,1], label = "", alpha = .01, c=col)
    end
    hline!([3.5, 3.5], c = :red, label = "MSY", foreground_color_legend = nothing)
    push!(plotsl, a)
end


savefig(plotsl[1], "test1.pdf")
savefig(plotsl[2], "test2.pdf")



