########################################################################################
########################## HETEROGENITY IN PATCH SIZE ##################################


mf = 30*1333
seq = collect(mf:2000:(mf*4))

if RUN  == true
    out = []
    for i in seq
        b=cpr_abm(n = 30*2,
         max_forest = 2*mf,
         ngroups =2,
         nsim = 100,
         nrounds = 1000,
         tech = 0.000002,
         price =3,
         wages =1,
         lattice = [1,2],
         pun1_on = false,
         pun2_on = false,
         defensibility = 1,
         fines1_on = false,
         fines2_on = false,
         seized_on = true, 
         labor = 1,
         invasion = true,
         travel_cost = .2,
         full_save = true,
         regrow  = 0.01,
         kmax_data = [i, mf])
        push!(out, b)
    end
    dat=serialize("cpr\\data\\abm\\patch_heterogenity.dat", out)
end

# Load 
out=deserialize("CPR\\data\\abm\\patch_heterogenity.dat")

# seq = collect(1:1:length(out))
# Plot
leakage=[mean(out[i][:leakage][1:200,2,1]) for i in 1:length(out)]
heterogenity=plot(seq, leakage, label = false, xlab = "Heterogenity in patch size",
 ylab = "Banditry", c = :black, title = "(a)", titlelocation = :left, titlefontsize = 15, alpha = .1)
xticks!([minimum(seq), maximum(seq)], ["Low", "High"], ylim = (0, 1), grid = false)

for j in 2:100 
    leakage=[mean(out[i][:leakage][1:200,2,j]) for i in 1:length(out)]
    plot!(seq, leakage, label = false, xlab = "Heterogenity in patch size",
    ylab = "Banditry", c = :black, title = "(a)", titlelocation = :left, titlefontsize = 15, alpha = .1)
    xticks!([minimum(seq), maximum(seq)], ["Low", "High"], ylim = (0, 1), grid = false)
end