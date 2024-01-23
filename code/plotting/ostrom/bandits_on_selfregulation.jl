# ####################################################################
# ####### BANDITRY ON BORDERS  #######################################

# # Note we increase the amount of forest to ensure that it does not bottom out by the time we sample the amount of support for borders. 
# if RUN  == true
#     S=collect(0.01:.05:1)
#     # set up a smaller call function that allows for only a sub-set of pars to be manipulated
#     @everywhere function g(L)
#         cpr_abm(n = 75*9, max_forest = 9*105000, ngroups =9, nsim = 20,
#         lattice = [3,3], harvest_limit = 3.4, harvest_var = .01, harvest_var_ind = .01,
#         regrow = .01, pun2_on = true, leak=false, pun1_on = false, experiment_group = [5,6],
#         wages = 0.1, price = 1, defensibility = 1, experiment_leak = L, 
#         experiment_effort =1, control_learning = false,
#         fines1_on = false, punish_cost = 0.1, labor = .7, 
#         invasion = true, begin_leakage_experiment = 1)
#     end
#     dat=pmap(g, S)
#     serialize("bandits_on_selfreg.dat", dat)
# end

# # Load 
# using Serialization
# dat = deserialize("cpr\\data\\abm\\bandits_on_selfreg.dat")

# groups = [collect(1:1:4); collect(7:1:9)]
# y = [mean(dat[i][:punish2][400:500,groups,:], dims =1) for i in 1:length(dat)]
# μ = [median(y[i]) for i in 1:length(dat)]
# a = [reduce(vcat, y[i]) for i in 1:length(y)]
# PI = [quantile(a[i], [0.31,.68]) for i in 1:size(y)[1]]
# PI=vecvec_to_matrix(PI) 
# x1=collect(.01:.05:1)
# x=reduce(vcat, [fill(i, length(dat)*7) for i in x1])
# a=reduce(vcat, a)

# bandits_on_self_regulation=plot([μ μ], fillrange=[PI[:,1] PI[:,2]], fillalpha=0.3, c=:grey, label = false,
#  xlab = "Roving Banditry", ylab = "Support for Regulation",
# xticks = (collect(0:4:20), ("0", "0.2", "0.4", "0.6", "0.8", "1")),
# title = "(c)", titlelocation = :left, titlefontsize = 15)
# scatter!(x.*20, a, c=:black, alpha = .2, label = false)



######################################################
########### NEW ######################################
if run == true
    S=collect(0.01:.05:1)
    # set up a smaller call function that allows for only a sub-set of pars to be manipulated
    @everywhere function g(L)
        wages = 1
        price = 3
        outgroup = .4
        tech = 0.00002
        n = 30
        ngroups = 9
        max_forest = n*ngroups*1333
        degrade = 1
        limit_seed_override = collect(range(start = .1, stop = 4, length =ngroups))

        cpr_abm(
        n = n*ngroups,
        max_forest = max_forest,
        ngroups =ngroups,
        nsim = 1,
        lattice = [3,3],
        limit_seed_override = limit_seed_override,
        pun2_on = true,
        leak=false,
        pun1_on = false,
        experiment_group = [5,6],
        price = price,
        wages = wages,
        experiment_leak = L, 
        experiment_effort =1,
        control_learning = false,
        punish_cost = 0.1,
        tech = tech,
        outgroup = outgroup,
        invasion = true,
        nrounds = 2000,
        begin_leakage_experiment = 1)
    end

    data = []
    for i in 1:length(S)
        par = fill(S[i], 50)    
        dat=pmap(g, par)
        push!(data, dat)
    end
    save("bandits_on_selfreg.jld2", "out", data)
end

dat = load("C:/Users/jeffr/Documents/Work/cpr/data/bandits_on_selfreg.jld2")
dat = dat["out"]

groups = [collect(1:1:4); collect(7:1:9)]
global x = []
global y =[]
for i in 1:20
    a=[mean(dat[i][j][:punish2][1900:2000,groups,:], dims = 1) for j in 1:50]
    a=reduce(vcat, a)
    a=reduce(vcat, a)
    global x = [x; a]
    global y = [y; fill(i, size(a)[1])]
end


groups = [collect(1:1:4); collect(7:1:9)]
bandits_on_self_regulation_new = plot([mean([mean(dat[i][j][:punish2][1900:2000,groups,:]) for j in 1:50]) for i in 1:20], c=:black, label = false,
xlab = "Banditry", ylab = "Enf. Use-Rights",  w = 3,
xticks = (collect(0:4:20), ("0", "0.2", "0.4", "0.6", "0.8", "1")),
title = "(g)", titlelocation = :left, titlefontsize = 15, ylim = (0, 1))
scatter!(y, x, label = "", c=:black, alpha = .05, markerstrokecolor = :black, grid = false)
savefig("bandits_on_self_regulation_new.pdf")