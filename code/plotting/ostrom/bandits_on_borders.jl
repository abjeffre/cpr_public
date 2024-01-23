####################################################################
####### BANDITRY ON BORDERS  #######################################

# Note we increase the amount of forest to ensure that it does not bottom out by the time we sample the amount of support for borders. 
if RUN  == true
    S=collect(0.1:.05:1)
    # set up a smaller call function that allows for only a sub-set of pars to be manipulated
    @everywhere function g(L)
        cpr_abm(n = 75*2, max_forest = 2*150000, ngroups =2, nsim = 100,
        lattice = [1,2], harvest_limit = 1, harvest_var = .01, harvest_var_ind = .01,
        regrow = .01, pun2_on = true, leak=false,
        wages = 0.1, price = 1, defensibility = 1, experiment_leak = L, experiment_effort =.7, experiment_punish2=1,
         fines1_on = false, punish_cost = 0.075, labor = .7, invasion = true, begin_leakage_experiment = 1)
    end
    dat=pmap(g, S)
    serialize("borders.dat", dat)
end

# Load 

dat = deserialize("C:\\Users\\jeffr\\Documents\\Work\\cpr\\data\\abm\\borders.dat")


y = [mean(dat[i][:punish][400:500,2,:], dims =1) for i in 1:length(dat)]
a=reduce(vcat, y)
μ = median(a, dims = 2)
PI = [quantile(a[i,:], [0.31,.68]) for i in 1:size(a)[1]]
PI=vecvec_to_matrix(PI) 
y=reduce(vcat, a)
x=collect(.01:.05:1)
x=repeat(x, 10)

mean(y)
border=plot([μ μ], fillrange=[PI[:,1] PI[:,2]], fillalpha=0.3, c=:grey, label = false,
 xlab = "Bandity", ylab = "Access-Rights",
xticks = (collect(0:4:20), ("0", "0.2", "0.4", "0.6", "0.8", "1")),
title = "(g)", titlelocation = :left, titlefontsize = 15)
scatter!(x.*19, y, c=:black, alpha = .2, label = false)



