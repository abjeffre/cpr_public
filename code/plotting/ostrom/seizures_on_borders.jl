# ########################################################################################
# ########################## Effect of Seizures ##########################################

# if RUN  == true
#     out3 = []
#     seq = [true, false]
#     for i in seq 
#         L = fill(i, 40)
#         @everywhere function newone(L)
#             cpr_abm(n = 75*9, max_forest = 9*105000, ngroups =9, nsim = 1, nrounds = 500,
#                 lattice = [3,3], harvest_limit = 2, regrow = .01, pun1_on = true,
#                 pun2_on = true, wages = 0.1, harvest_var =.1,
#                 price = 1, defensibility = 1, fines1_on = false,
#                 fines2_on = false, seized_on = L, labor = .7,
#                 invasion = true, harvest_var_ind = 0.1,
#                 travel_cost = 0.1, full_save = true)
#         end
#         println("gothere")
#         b=pmap(newone, L)
#         push!(out3, b)
#     end
#     serialize("CPR\\data\\abm\\seizures.dat", out3)
# end

# # Load 
# dat=deserialize("CPR\\data\\abm\\seizures.dat")

# # Plot

# seizures=plot(dat[1][1][:punish][:,:,1], labels = "", ylab = "Support for Boundaries",
#  xlab = "Time (seizures)", c=:black, alpha = .1, xticks = (0, " "), ylim = (0,1),
#  title = "(g)", titlelocation = :left, titlefontsize = 15)
# [plot!(dat[1][i][:punish][:,:,1], labels = "", c =:black, alpha = .025) for i in 1:40]

# noseizures=plot(dat[2][1][:punish][:,:,1], labels = "", ylab = "Support for Boundaries", xlab = "Time (no seizures)",
#  c=:black, alpha = .1, xticks = (0, " "), ylim = (0,1),
#  title = "(f)", titlelocation = :left, titlefontsize = 15)
# [plot!(dat[2][i][:punish][:,:,1], labels = "", c =:black, alpha = .025) for i in 1:40]

# ##################################################################################################
################### NEW ##########################################################################

if RUN == true
    S=[true, false]
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
        leak=L,
        price = price,
        wages = wages,
        control_learning = true,
        back_leak = true,
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
    save("seizures.jld2", "out", data)
end

dat = load("C:/Users/jeffr/Documents/Work/cpr/data/seizures.jld2")
dat = dat["out"]
alpha2 = 0.03
rounds = 1:300
seizures=plot(dat[1][1][:punish][rounds,:,1], labels = "", ylab = "Access-Rights",
 xlab = "Time (seizures)", c=:black, alpha = alpha2, xticks = (0, " "), ylim = (0,1),
 title = "(d)", titlelocation = :left, titlefontsize = 15, grid = false)
[plot!(dat[1][i][:punish][rounds,:,1], labels = "", c =:black, alpha = alpha2) for i in 1:40]
savefig("seizures.pdf")

noseizures=plot(dat[2][1][:punish][rounds,:,1], labels = "", ylab = "Access-Rights", xlab = "Time (no seizures)",
 c=:black, alpha = alpha2, xticks = (0, " "), ylim = (0,1),
 title = "(c)", titlelocation = :left, titlefontsize = 15, grid = false)
[plot!(dat[2][i][:punish][rounds,:,1], labels = "", c =:black, alpha = alpha2) for i in 1:40]
savefig("noseizures.pdf")




# S=[true, false]
# @everywhere function g(L)
#     # set up a smaller call function that allows for only a sub-set of pars to be manipulated
#     wages = 1
#     price = 3
#     outgroup = .7
#     tech = 0.00002
#     n = 30
#     ngroups = 9
#     max_forest = n*ngroups*1333
#     degrade = 1
#     limit_seed_override = collect(range(start = .1, stop = 4, length =ngroups))

#     cpr_abm(
#     n = n*ngroups,
#     max_forest = max_forest,
#     ngroups =ngroups,
#     nsim = 1,
#     lattice = [3,3],
#     limit_seed_override = limit_seed_override,
#     pun2_on = true,
#     leak=L,
#     price = price,
#     wages = wages,
#     control_learning = true,
#     back_leak = true,
#     punish_cost = 0.1,
#     tech = tech,
#     outgroup = 0.7,
#     invasion = true,
#     nrounds = 5000,
#     begin_leakage_experiment = 1)
# end
# data = []
# for i in 1:length(S)
#     par = fill(S[i], 25)    
#     dat=pmap(g, par)
#     push!(data, dat)
# end
# save("seizures2.jld2", "out", data)

