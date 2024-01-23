##########################################################################
################### PARAMETER SWEEPS ######################################

# Parameters
punish_cost = collect(range(start = 0.001, stop = .4, length = 10)) # remeber this goes up to 2 
cb=collect(range(start = 0.001, stop = 3.999, length = 10)) # Cost Benifit Ratio
maxbc = 4 # Max CB Ratio
ngroups = 100
n= 30

temp=expand_grid(cb, punish_cost)
S=zeros(100, 3)
S[:, 1:2] = temp 
S[:,3] = maxbc.-S[:,1]

if RUN == true
    # Set up Call function - Recommend using 50 cores and over 1 terrabyte of memory. 
    base_folder = "phase_sweeps"

    ########################################
    ############# High OUTGROUP #############


    @everywhere function g(b, c, pc)
        cpr_abm(degrade = 1, n=30*100,
        ngroups = 100,
        lattice = [10,10],
        max_forest = 1333*30*100,
        tech = .00002,
        wages = c,
        price = b,
        nrounds = 10000,
        leak = true,
        learn_group_policy =false,
        invasion = true,
        nsim = 1,
        inspect_timing = "after",
        punish_cost = pc,
        outgroup = .75,
        full_save = false,
        genetic_evolution = false,
        #glearn_strat = "income",
        limit_seed_override = collect(range(start = .1, stop = 4, length =100)))
    end    

    # Run Sweeps

    for i in 1:50
        b = round.(fill(S[i, 1], 50), digits = 3)
        pc = round.(fill(S[i, 2], 50), digits = 3)
        c = round.(fill(S[i, 3], 50), digits = 3)
        dirname = string("sweep_pc",pc[1], "_c", c[1], "_b",b[1],"_iota0.75")
        if dirname ∉ readdir(base_folder)
            out=pmap(g, b, c, pc)
            mkdir(dirname)
            save(string("$base_folder/$dirname/output.jld2"), "out", out)
        else
            println("$dirname already exists - skipping")
        end
    end

    ######################
    #### OUTGROUP LOW ####


    @everywhere function g(b, c, pc)
        cpr_abm(degrade = 1, n=30*100,
        ngroups = 100,
        lattice = [10,10],
        max_forest = 1333*30*100,
        tech = .00002,
        wages = c,
        price = b,
        nrounds = 10000,
        leak = true,
        learn_group_policy =false,
        invasion = true,
        nsim = 1,
        punish_cost = pc,
        outgroup = .25,
        full_save = false,
        genetic_evolution = false,
        #glearn_strat = "income",
        limit_seed_override = collect(range(start = .1, stop = 4, length =100)))
    end    

    # Run Sweeps

    for i in 1:50
        b = round.(fill(S[i, 1], 50), digits = 3)
        pc = round.(fill(S[i, 2], 50), digits = 3)
        c = round.(fill(S[i, 3], 50), digits = 3)
        dirname = string("sweep_pc",pc[1], "_c", c[1], "_b",b[1],"_iota0.25")
        if dirname ∉ readdir(base_folder)
            out=pmap(g, b, c, pc)
            mkdir(dirname)
            save(string("$base_folder/$dirname/output.jld2"), "out", out)
        else
            println("$dirname already exists - skipping")
        end
    end



    ################################################################
    ###################### EXTRACT DATA FROM SERVERS ###############

    # For High
    base_folder = "phase_sweeps"
    rounds = 8000:10000
    stock = []
    payoff = []
    regulate = []
    exclude = []
    limit = []

    for i in 1:size(S)[1]
        println(i)
        b = round.(fill(S[i, 1], 50), digits = 3)
        pc = round.(fill(S[i, 2], 50), digits = 3)
        c = round.(fill(S[i, 3], 50), digits = 3)
        dirname2 = string("sweep_pc",pc[1], "_c", c[1], "_b",b[1],"_iota0.75")
        if dirname2 ∈ readdir(base_folder)
            out=load("$base_folder/$dirname2/output.jld2")["out"]
            push!(stock, mean([mean(Float64.(out[i][:stock][rounds, :, 1])) for i in 1:50]))
            push!(exclude, mean([mean(Float64.(out[i][:punish][rounds, :, 1])) for i in 1:50]))
            push!(regulate, mean([mean(Float64.(out[i][:punish2][rounds, :, 1])) for i in 1:50]))
            push!(limit, mean([mean(Float64.(out[i][:limit][rounds, :, 1])) for i in 1:50]))
            push!(payoff, mean([mean(Float64.(out[i][:payoffR][rounds, :, 1])) for i in 1:50]))
        else
            println(string("$dirname2 not found"))
            push!(stock, nothing)
            push!(exclude, nothing)
            push!(regulate, nothing)
            push!(limit, nothing)
            push!(payoff, nothing)
        end
    end


    save("limith.jld2", "out", limit)
    save("stockh.jld2", "out", stock)
    save("excludeh.jld2", "out", exclude)
    save("regulateh.jld2", "out", regulate)
    save("payoffh.jld2", "out", payoff)


    # For low
    base_folder = "phase_sweeps"
    
    stock = []
    payoff = []
    regulate = []
    exclude = []
    limit = []

    for i in 1:size(S)[1]
        println(i)
        b = round.(fill(S[i, 1], 50), digits = 3)
        pc = round.(fill(S[i, 2], 50), digits = 3)
        c = round.(fill(S[i, 3], 50), digits = 3)
        dirname2 = string("sweep_pc",pc[1], "_c", c[1], "_b",b[1],"_iota0.75")
        if dirname2 ∈ readdir(base_folder)
            out=load("$base_folder/$dirname2/output.jld2")["out"]
            push!(stock, mean([mean(Float64.(out[i][:stock][rounds, :, 1])) for i in 1:50]))
            push!(exclude, mean([mean(Float64.(out[i][:punish][rounds, :, 1])) for i in 1:50]))
            push!(regulate, mean([mean(Float64.(out[i][:punish2][rounds, :, 1])) for i in 1:50]))
            push!(limit, mean([mean(Float64.(out[i][:limit][rounds, :, 1])) for i in 1:50]))
            push!(payoff, mean([mean(Float64.(out[i][:payoffR][rounds, :, 1])) for i in 1:50]))
        else
            println(string("$dirname2 not found"))
            push!(stock, nothing)
            push!(exclude, nothing)
            push!(regulate, nothing)
            push!(limit, nothing)
            push!(payoff, nothing)
        end
    end


    save("limitl.jld2", "out", limit)
    save("stockl.jld2", "out", stock)
    save("excludel.jld2", "out", exclude)
    save("regulatel.jld2", "out", regulate)
    save("payoffl.jld2", "out", payoff)

end


#################################################
############# PLOT ι = 0.75 #####################

reg = load(string("C:/user/jeffr/Documents/Work/cpr/data/regulateh",".jld2"))["out"]
sto = load(string("C:/user/jeffr/Documents/Work/cpr/data/stockh",".jld2"))["out"]
exc = load(string("C:/user/jeffr/Documents/Work/cpr/data/excludeh",".jld2"))["out"]
lim = load(string("C:/user/jeffr/Documents/Work/cpr/data/limith",".jld2"))["out"]
pay = load(string("C:/user/jeffr/Documents/Work/cpr/data/payoffh",".jld2"))["out"]

sto=ifelse.(sto.== nothing, 0, sto)
exc=ifelse.(exc.== nothing, 0, exc)
reg=ifelse.(reg.== nothing, 0, reg)
pay=ifelse.(pay.== nothing, 0, pay)
lim=ifelse.(lim.== nothing, 0, lim)

stom=reshape(sto, 10, 10)
excm=reshape(exc, 10, 10)
regm=reshape(reg, 10, 10)
limm=reshape(lim, 10, 10)
paym=reshape(pay, 10, 10)

using pyplot
hex = heatmap(excm, clim = (0, 1), xlab = "cᵣ & cₓ", ylab = "p/w", title = "Enforce Access Rights" )
hreg = heatmap(regm, clim = (0, 1), xlab = "cᵣ & cₓ", ylab = "p/w", title = "Enforce Use Rights" )
hlim = heatmap(limm, clim = (0, 6), xlab = "cᵣ & cₓ", ylab = "p/w", title = "MAH" )
hsto = heatmap(stom, clim = (0, 1), xlab = "cᵣ & cₓ", ylab = "p/w", title = "Resource Stock") 
hpay = heatmap(paym, clim = (0, 8), xlab = "cᵣ & cₓ", ylab = "p/w",title = "Payoffs" )

x = .3
collective =(excm .> x) .& (regm .> x)
hcol=heatmap(collective, xlab = "cᵣ & cₓ", ylab = "p/w", title = "Phase Space")
plot(hex, hreg, hlim, hsto, hpay, hcol, titlefontsize = 14, size = (1500, 1500), layout = grid(3,2))
savefig("sweeps_iota075.pdf")



#################################################
############# PLOT ι = 0.25 #####################

reg = load(string("C:/user/jeffr/Documents/Work/cpr/data/regulatel",".jld2"))["out"]
sto = load(string("C:/user/jeffr/Documents/Work/cpr/data/stockl",".jld2"))["out"]
exc = load(string("C:/user/jeffr/Documents/Work/cpr/data/excludel",".jld2"))["out"]
lim = load(string("C:/user/jeffr/Documents/Work/cpr/data/limitl",".jld2"))["out"]
pay = load(string("C:/user/jeffr/Documents/Work/cpr/data/payoffl",".jld2"))["out"]

sto=ifelse.(sto.== nothing, 0, sto)
exc=ifelse.(exc.== nothing, 0, exc)
reg=ifelse.(reg.== nothing, 0, reg)
pay=ifelse.(pay.== nothing, 0, pay)
lim=ifelse.(lim.== nothing, 0, lim)


stom=reshape(sto, 10, 10)
excm=reshape(exc, 10, 10)
regm=reshape(reg, 10, 10)
limm=reshape(lim, 10, 10)
paym=reshape(pay, 10, 10)

using pyplot()
hex = heatmap(excm, clim = (0, 1), xlab = "cᵣ & cₓ", ylab = "p/w", title = "Enforce Access-Rights" )
hreg = heatmap(regm, clim = (0, 1), xlab = "cᵣ & cₓ", ylab = "p/w", title = "Enforce Use-Rights" )
hlim = heatmap(limm, clim = (0, 6), xlab = "cᵣ & cₓ", ylab = "p/w", title = "MAH" )
hsto = heatmap(stom, clim = (0, 1), xlab = "cᵣ & cₓ", ylab = "p/w", title = "Resource Stock") 
hpay = heatmap(paym, clim = (0, 8), xlab = "cᵣ & cₓ", ylab = "p/w",title = "Payoffs" )

x = .3
collective =(excm .> x) .& (regm .> x)
hcol=heatmap(collective, xlab = "cᵣ & cₓ", ylab = "p/w", title = "Phase Space")
plot(hex, hreg, hlim, hsto, hpay, hcol, titlefontsize = 14, size = (1500, 1500), layout = grid(3,2))
savefig("sweeps_iota025.pdf")
