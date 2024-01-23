# ##########################################################################################
# ##################### SELF REUGLATION ON POLICY ##########################################
# # Load 
# ############# Borders on Self Regulation ##########
# if RUN  == true
#     S=collect(0.1:.05:1)
#     # set up a smaller call function that allows for only a sub-set of pars to be manipulated
#     S=collect(0.1:.05:1)
#     # set up a smaller call function that allows for only a sub-set of pars to be manipulated
#     @everywhere function g(L)
#         cpr_abm(n = 75*9, max_forest = 9*105000, ngroups =9, nsim = 50,
#         lattice = [3,3], harvest_limit = 4, harvest_var = .7, harvest_var_ind = .1,
#         regrow = .01, pun2_on = true, leak=true, nrounds = 1000,
#         wages = 0.1, price = 1, experiment_punish1=L, experiment_group = collect(1:1:9), back_leak = true,
#         fines1_on = false, punish_cost = 0.1, labor = .7, invasion = true, learn_group_policy = true, control_learning = true)
#     end
#     dat=pmap(g, S)
#     dat=serialize("CPR\\data\\abm\\regulation.dat", dat)
# end


# dat = deserialize("cpr\\data\\abm\\regulation.dat")

# y1 = [mean(mean(dat[i][:punish2][900:1000,:,:], dims =2)[:,1,:], dims = 1) for i in 1:length(dat)]
# a=reduce(vcat, y1)
# μ = mean(a, dims = 2)
# a=reduce(vcat, y1)
# a=reduce(vcat, a)

# y2 = [mean(mean(dat[i][:limit][900:1000,:,:], dims =2)[:,1,:], dims = 1) for i in 1:length(dat)]
# # a2=reduce(vcat, y1)
# # μ = mean(a2, dims = 2)
# a2=reduce(vcat, y2)
# a2=reduce(vcat, a2)


# Selection=scatter(a, a2, c=:black, ylim = (0, 6), label = false, xlab = "Support for Regulation", yticks = (0, " "), 
# ylab = "MAH", alpha = .3,
# title = "(j)", titlelocation = :left, titlefontsize = 15)
# hline!([3.5], lw = 2, c=:red, label = "MSY", )

########################################################
########## NEW #########################################



dat = load("C:/Users/jeffr/Documents/Work/cpr/data/borders_on_reg.jld2")
dat = dat["out"]



global x1 = []
global y1 =[]
for i in 1:19
    a=[mean(dat[i][j][:punish2][4400:5000,:,:], dims = 1) for j in 1:50]
    a=reduce(vcat, a)
    a=reduce(vcat, a)
    global x1 = [x1; a]
    global y1 = [y1; fill(i, size(a)[1])]
end


global x2 = []
global y2 =[]
for i in 1:19
    a=[mean(dat[i][j][:limit][4400:5000,:,:], dims = 1) for j in 1:50]
    a=reduce(vcat, a)
    a=reduce(vcat, a)
    global x2 = [x2; a]
    global y2 = [y2; fill(i, size(a)[1])]
end


seq = x2
Selection=scatter(x1, x2, c=:black, label = false, xlab = "Enf. Use-Rights", yticks = (0, " "), yrotation = 90,
ylab = "MAH", alpha = .3, grid = false,  ytick = ((minimum(seq), maximum(seq)), ("Low MAH", "High MAH")),
title = "(m)", titlelocation = :left, titlefontsize = 15)
hline!([3.3], lw = 2, c=:red, label = "MSY", legendfontsize = 3,  foreground_color_legend = nothing)