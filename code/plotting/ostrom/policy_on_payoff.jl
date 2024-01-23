# #####################################################################################
# ############################## Policy on Payoffs ####################################

# # Load 
# dat = deserialize("cpr\\data\\abm\\regulation.dat")


# y1 = [mean(mean(dat[i][:payoffR][900:1000,:,:], dims =2)[:,1,:], dims = 1) for i in 1:length(dat)]
# a=reduce(vcat, y1).+(collect(0.1:.05:1).*0.1) # adjust for institutional costs
# μ = mean(a, dims = 2)
# a=reduce(vcat, y1)
# a=reduce(vcat, a)


# y2 = [mean(mean(dat[i][:limit][900:1000,:,:], dims =2)[:,1,:], dims = 1) for i in 1:length(dat)]
# a2=reduce(vcat, y2)
# μ = mean(a2, dims = 2)
# a2=reduce(vcat, y2)
# a2=reduce(vcat, a2)


# y3 = [mean(mean(dat[i][:punish2][900:1000,:,:], dims =2)[:,1,:], dims = 1) for i in 1:length(dat)]
# a3=reduce(vcat, y3)
# μ = mean(a3, dims = 2)
# a3=reduce(vcat, y3)
# a3=reduce(vcat, a3)

# a3 = ifelse.(a3 .> .4, :red, :black)

# Covariance=scatter(a2[a3 .== :red], a[a3 .== :red], c=:orange, label = false, xlab = "MAH", xticks = (0, " "),  
# ylab = "Payoffs", labels = "Enforced", alpha = .1, markerstrokecolor = :orange,  grid = false,
# title = "(k)", titlelocation = :left, titlefontsize = 15)
# scatter!(a2[a3 .== :black], a[a3 .== :black], c=:black, label = false, xlab = "MAH",  
# ylab = "Payoffs", labels = ("Not Enforced"), alpha = .1)
# vline!([3.5, 3.5], c=:red, label = "MSY")



##########################################################################
################ NEW #####################################################



dat = load("C:/Users/jeffr/Documents/Work/cpr/data/borders_on_reg.jld2")
dat = dat["out"]



global x = []
global y =[]
for i in 1:19
    a=[mean(dat[i][j][:payoffR][4400:5000,:,:], dims = 1) for j in 1:50]
    a=reduce(vcat, a)
    a=reduce(vcat, a)
    global x = [x; a]
    global y = [y; fill(i, size(a)[1])]
end



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


x1 = ifelse.(x1 .> .3, :red, :black)

seq = x2

Covariance=scatter(x2[x1 .== :red], x[x1 .== :red], c=:orange, label = false, xlab = "MAH",  xtick = ((minimum(seq), maximum(seq)), ("Low MAH", "High MAH")), yticks = (0, " "),  
ylab = "Payoffs", labels = "Enforced", alpha = .25, markerstrokecolor = :orange,  grid = false, 
title = "(m)", titlelocation = :left, titlefontsize = 15, legendfontsize=11,  ylim = (0, 15),  foreground_color_legend = nothing )
scatter!(x2[x1 .== :black], x[x1 .== :black], c=:black, label = false, xlab = "MAH",  
ylab = "Payoffs", labels = ("Not Enforced"), alpha = .25)
vline!([3.3, 3.3], c=:red, label = "MSY")

savefig("Covariance.pdf")

