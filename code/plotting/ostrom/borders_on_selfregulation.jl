# ###################################################
# ############# Borders on Self Regulation ##########
# # Note we increase the amount of forest to ensure that it does not bottom out by the time we sample the amount of support for borders. 
# if RUN  == true
#     # set up a smaller call function that allows for only a sub-set of pars to be manipulated
#     S=collect(0.1:.05:1)
#     # set up a smaller call function that allows for only a sub-set of pars to be manipulated
#     @everywhere function g(L)
#         cpr_abm(n = 75*9, max_forest = 9*105000, ngroups =9, nsim = 50,
#         lattice = [3,3], harvest_limit = 2, harvest_var = .01, harvest_var_ind = .1,
#         regrow = .01, pun2_on = true, leak=true, nrounds = 1000,
#         wages = 0.1, price = 1, experiment_punish1=L, experiment_group = collect(1:1:9), back_leak = true,
#         fines1_on = false, punish_cost = 0.1, labor = .7, invasion = true, learn_group_policy = true, control_learning = true)
#     end
#     dat=pmap(g, S)
#     serialize("borders_on_reg.dat", dat)
# end


# dat = deserialize("cpr\\data\\abm\\borders_on_reg.dat")

# groups = collect(1:1:9)
# y = [mean(dat[i][:punish2][400:500,groups,:], dims =1) for i in 1:length(dat)]
# μ = [median(y[i]) for i in 1:length(dat)]
# a = [reduce(vcat, y[i]) for i in 1:length(y)]
# PI = [quantile(a[i], [0.31,.68]) for i in 1:size(y)[1]]
# PI=vecvec_to_matrix(PI) 
# x1=collect(.1:.05:1)
# x=reduce(vcat, [fill(i, size(dat[1][:stock])[3]*9) for i in x1])
# a=reduce(vcat, a)

# borders_on_selfreg=plot([μ μ], fillrange=[PI[:,1] PI[:,2]], fillalpha=0.3, c=:grey, label = false,
#  xlab = "Presence of Boundaries", ylab = "Support for Regulation",
# xticks = (collect(0:4:20), ("0", "0.2", "0.4", "0.6", "0.8", "1")),
# title = "(j)", titlelocation = :left, titlefontsize = 15)
# scatter!(x[collect(1:10:8550)]*20, a[collect(1:10:8550)], c=:black, alpha = .2, label = false)


###########################################################
#################### NEW ##################################

if RUN  == true
    # set up a smaller call function that allows for only a sub-set of pars to be manipulated
    S=collect(0.1:.05:1)
    @everywhere function g(L)
        # set up a smaller call function that allows for only a sub-set of pars to be manipulated
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
        leak=true,
        experiment_punish1=L,
        experiment_group = collect(1:ngroups),
        price = price,
        wages = wages,
        control_learning = true,
        back_leak = true,
        punish_cost = 0.1,
        tech = tech,
        outgroup = outgroup,
        invasion = true,
        nrounds = 5000,
        begin_leakage_experiment = 1)
    end
    data = []
    for i in 1:length(S)
        par = fill(S[i], 50)    
        dat=pmap(g, par)
        push!(data, dat)
    end

    save("C:/Users/jeffr/Documents/Work/cpr/data/borders_on_reg.jld2", "out", data)
end


dat = load("C:/Users/jeffr/Documents/Work/cpr/data/borders_on_reg.jld2")
dat = dat["out"]

groups = 1:9
global x = []
global y =[]
for i in 1:19
    a=[mean(dat[i][j][:punish2][4500:5000,groups,:], dims = 1) for j in 1:50]
    a=reduce(vcat, a)
    a=reduce(vcat, a)
    global x = [x; a]
    global y = [y; fill(i, size(a)[1])]
end


borders_on_self_regulation_new = plot([mean([mean(dat[i][j][:punish2][4500:5000,:,:]) for j in 1:50]) for i in 1:19], c=:black, label = false,
xlab = "Access-Rights", ylab = "Enf. Use-Rights", w = 3,
xticks = (collect(0:4:20), ("0", "0.2", "0.4", "0.6", "0.8", "1")),
title = "(h)", titlelocation = :left, titlefontsize = 15, ylim = (0, 1), xlim = (0, 20))
scatter!(y, x, label = "", c=:black, alpha = .05,  markerstrokecolor = :black,  grid = false)

savefig("borders_on_self_regulation_new.pdf")