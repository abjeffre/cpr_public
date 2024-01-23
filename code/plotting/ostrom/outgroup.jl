######################################################################################
########################### 100 GROUPS ##############################################

if run == true
    @everywhere function g(x)
        ngroups = 100
        n= 30
        cpr_abm(degrade = 1,
         n=n*ngroups,
         ngroups = ngroups,
         lattice = [1,ngroups],
         max_forest = 1333*n*ngroups,
         tech = .00002,
         wages = 1,
         price = 3,
         nrounds = 15000,
         leak = false,
         learn_group_policy =false,
         invasion = true,
         nsim = 1, 
         experiment_group = collect(1:ngroups),
         control_learning = true,
         back_leak = true,
         outgroup = x,
         full_save = true,
         genetic_evolution = false,
         #glearn_strat = "income",
         limit_seed_override = collect(range(start = .1, stop = 4, length =ngroups)))
    end

    # Run Sweep
    cnt = 1
    base_folder = "outgroup_sweeps"
    for i in [0.01, 0.1, 0.2, 0.3, 0.4, 0.5]
        S = fill(i, 50)
        out=pmap(g, S)
        dirname = string("$base_folder/ngroups100_outgroup",i)
        mkdir(dirname)
        save(string("$dirname/output.jld2"), "out", out)
        out = nothing
    end


    # Run Sweep
    cnt = 1
    base_folder = "outgroup_sweeps"
    for i in [0.6, 0.7, 0.8, 0.9, 1.0]
        S = fill(i, 50)
        out=pmap(g, S)
        dirname = string("$base_folder/ngroups100_outgroup",i)
        mkdir(dirname)
        save(string("$dirname/output.jld2"), "out", out)
        out = nothing
    end


    # Extract Data
    Stock = []
    Punish1 = []
    Punish2 = []
    Limit = []
    Payoff = []
    base_folder = "outgroup_sweeps"
    for dir in readdir(base_folder)
        dat=load(string("$base_folder/$dir/output.jld2"))
        println(dir)
        ST=[mean(convert.(Float64,dat["out"][i][:stock][14000:15000,:,1])) for i in 1:50]
        P1=[mean(convert.(Float64,dat["out"][i][:punish][14000:15000,:,1])) for i in 1:50]
        P2=[mean(convert.(Float64,dat["out"][i][:punish2][14000:15000,:,1])) for i in 1:50]
        L=[mean(convert.(Float64,dat["out"][i][:limit][14000:15000,:,1])) for i in 1:50]
        P=[mean(convert.(Float64,dat["out"][i][:payoffR][14000:15000,:,1])) for i in 1:50]        
        push!(Stock, ST)
        push!(Limit, L)
        push!(Punish1, P1)
        push!(Payoff, P)
        push!(Punish2, P2)
    end
    STOCK=[mean(mean(Stock[i])) for i in 1:11]
    LIMIT=[mean(mean(Limit[i])) for i in 1:11]
    REGULATE=[mean(mean(Punish2[i])) for i in 1:11]
    PAYOFF=[mean(mean(Payoff[i])) for i in 1:11]

    # Save Data
    save("C:/Users/jeffr/Documents/Work/cpr/data/stock_outgroup2.jld2", "out", Stock)
    save("C:/Users/jeffr/Documents/Work/cpr/data/limit_outgroup2.jld2", "out", Limit)
    save("C:/Users/jeffr/Documents/Work/cpr/data/regulate_outgroup2.jld2", "out", Punish2)
    save("C:/Users/jeffr/Documents/Work/cpr/data/payoff_outgroup2.jld2", "out", Payoff)

    save("C:/Users/jeffr/Documents/Work/cpr/data/stock_outgroup.jld2", "out", STOCK)
    save("C:/Users/jeffr/Documents/Work/cpr/data/limit_outgroup.jld2", "out", LIMIT)
    save("C:/Users/jeffr/Documents/Work/cpr/data/regulate_outgroup.jld2", "out", REGULATE)
    save("C:/Users/jeffr/Documents/Work/cpr/data/payoff_outgroup.jld2", "out", PAYOFF)
end

    # 
#    STO=load("C:/Users/jeffr/Documents/Work/cpr/data/stock_outgroup.jld2")
#    LIM=load("C:/User/jeffr/Documents/Work/cpr/data/limit_outgroup.jld2")
#    REG=load("C:/Users/jeffr/Documents/Work/cpr/data/regulate_outgroup.jld2")
#    Outgroup=plot([0.01, .1, .2, .3, .4, .5], REG["out"], label = "", xlab = "Out-group learning",
#    title = "(i)", titlelocation = :left, titlefontsize = 15,
#     ylim = (0,1), c = :Black, 3, ylab = "Enf. Use-Rights", grid = false)  
#     plot!([0.01, .1, .2, .3, .4, .5], LIM["out"]/5.1, label = "", c = :Black)

########################
###### TESTING #########

x = [0,.1,.2,.3,.4,.5,.6,.7,.8,.9,1]
temp=load("C:/Users/jeffr/Documents/Work/cpr/data/regulate_outgroup2.jld2")["out"]

OutgroupR = plot(title = "(i)", titlelocation = :left, titlefontsize = 15,
 xticks = (collect(0:.2:1), ("0", "0.2", "0.4", "0.6", "0.8", "1")))
for i in 1:11 scatter!(fill(x[i], 50).+rand(Normal(0,.02),50), temp[i], label = "", c = :black, alpha = .2) end
plot!(x, vec([median(temp[i]) for i in 1:11]), w =3, label = "", c = :black, ylab = "Enf. Use-Rights", xlab = "Out-Group learning", grid = false)

x = [0,.1,.2,.3,.4,.5,.6,.7,.8,.9,1]
temp=load("C:/Users/jeffr/Documents/Work/cpr/data/stock_outgroup2.jld2")["out"]

OutgroupS = plot(title = "(k)", titlelocation = :left, titlefontsize = 15,
xticks = (collect(0:.2:1), ("0", "0.2", "0.4", "0.6", "0.8", "1")))
for i in 1:11 scatter!(fill(x[i], 50).+rand(Normal(0,.02),50), temp[i], label = "", c = :black, alpha = .2) end
plot!(x, vec([median(temp[i]) for i in 1:11]), w =3, label = "", c = :black, ylab = "Resource Stock", xlab = "Out-Group learning", grid = false)

x = [0,.1,.2,.3,.4,.5,.6,.7,.8,.9,1]
temp=load("C:/Users/jeffr/Documents/Work/cpr/data/limit_outgroup2.jld2")["out"]

OutgroupL = plot(title = "(j)", titlelocation = :left, titlefontsize = 15, 
xticks = (collect(0:.2:1), ("0", "0.2", "0.4", "0.6", "0.8", "1")))
for i in 1:11 scatter!(fill(x[i], 50).+rand(Normal(0,.02),50), temp[i], label = "", c = :black, alpha = .2) end
plot!(x, vec([median(temp[i]) for i in 1:11]), w =3, label = "", c = :black, ylab = "MAH", xlab = "Out-Group learning", grid = false)
hline!([3.3], c = :red, label = "MSY", foreground_color_legend = nothing )

temp=load("C:/Users/jeffr/Documents/Work/cpr/data/payoff_outgroup2.jld2")["out"]
OutgroupP = plot(title = "(l)", titlelocation = :left, titlefontsize = 15, 
xticks = (collect(0:.2:1), ("0", "0.2", "0.4", "0.6", "0.8", "1")
))
for i in 1:11 scatter!(fill(x[i], 50).+rand(Normal(0,.02),50), temp[i], label = "", c = :black, alpha = .2) end
plot!(x, vec([median(temp[i]) for i in 1:11]), w =3, label = "", c = :black, ylab = "Payoffs", xlab = "Out-Group learning", grid = false)
