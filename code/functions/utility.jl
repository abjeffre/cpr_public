######################################################
############# SETUP FUNCTIONS FOR ABM ################
#functions
function logit(p)
  log.(p./(1-p))
end

function vecvecMatrix(vecvec, tests_generated)
 dim0 = length(vecvec)
 dim1 = Int(length(vecvec)*tests_generated)
 dim2 = Int(length(vecvec[1])/tests_generated)
 my_array = zeros(Float64, dim1, Int(dim2))
 cnt = 1
 for i in 1:dim0
     for k in 1:tests_generated
         for j in 1:dim2
             my_array[cnt,j] = vecvec[i][k,j]
         end
         cnt +=1
     end                
   log.(p./(1-p))
 end
 return my_array
end

function vecvec_to_matrix(vecvec)
 dim1 = length(vecvec)
 dim2 = length(vecvec[1])
 my_array = zeros(Int64, dim1, dim2)
 for i in 1:dim1
     for j in 1:dim2
         my_array[i,j] = vecvec[i][j]
     end
 end
 return my_array
end

 function vecvecMatrix(vecvec, tests_generated)
  dim0 = length(vecvec)
  dim1 = Int(length(vecvec)*tests_generated)
  dim2 = Int(length(vecvec[1])/tests_generated)
  my_array = zeros(Float64, dim1, Int(dim2))
  cnt = 1
  for i in 1:dim0
      for k in 1:tests_generated
          for j in 1:dim2
              my_array[cnt,j] = vecvec[i][k,j]
          end
          cnt +=1
      end                
  end
  return my_array
end

function vecvec_to_matrix(vecvec::Vector{Vector{Int64}})
  dim1 = length(vecvec)
  dim2 = length(vecvec[1])
  my_array = zeros(Int64, dim1, dim2)
  for i in 1:dim1
      for j in 1:dim2
          my_array[i,j] = vecvec[i][j]
      end
  end
  return my_array
end

function vecvec_to_matrix(vecvec::Vector{Vector{Float64}})
  dim1 = length(vecvec)
  dim2 = length(vecvec[1])
  my_array = zeros(Float64, dim1, dim2)
  for i in 1:dim1
      for j in 1:dim2
          my_array[i,j] = vecvec[i][j]
      end
  end
  return my_array
end


#meams without nans
function nanmean(x, dims = 1)
 mean(filter(!isnan, x), dims = dims)
end


function nanmedian(x)
 median(filter(!isnan, x))
end

function nanvar(x)
 median(filter(!isnan, x))
end

function lenUnq(x)
 length(unique(x))
end

 function nanvar(x)
  median(filter(!isnan, x))
end

function lenUnq(x)
  length(unique(x))
end


function benchmark(x)
 rn1 = Dates.Time(Dates.now())
 x
 rn2 = Dates.Time(Dates.now())
 return(rn2-rn1)
end

function inv_logit(x)
    1/(1+exp(-x))
end

function softmax(x)
   exp.(x)/sum(exp.(x))
end

function rnorm(n, mu, sd)
   rand(Normal(mu, sd), n)
end

function asInt(x)
   convert(Int64, x)
end


function rbinom(n, N, p)
 asInt.(rand(Binomial(N, p), n))
end


function tab(x, ngroups)
 cnt = zeros(ngroups)
 for i = 1:ngroups
   cnt[i] = sum(x.==i)
 end
 return(cnt)
end

function report(x, gid, ngroups)
 cnt = zeros(ngroups)
 for i = 1:ngroups
   cnt[i] = mean(x[gid .== i])
     end
 return(cnt)
end

function reportSum(x, gid, ngroups)
 cnt = zeros(ngroups)
 for i = 1:ngroups
   cnt[i] = sum(x[gid .== i])
     end
 return(cnt)
end

function reportSum(x, gid, ngroups)
  cnt = zeros(ngroups)
  for i = 1:ngroups
    cnt[i] = sum(x[gid .== i])
      end
  return(cnt)
end


function reportMedian(x, gid, ngroups)
 cnt = zeros(ngroups)
 for i = 1:ngroups
     cnt[i] = median(x[gid .== i])
   end
 return(cnt)
end


function reportVar(x, gid, ngroups)
 cnt = zeros(ngroups)
 for i = 1:ngroups
     cnt[i] = var(x[gid .== i])
 end
 return(cnt)
end




function reportSkew(x, gid, ngroups)
 cnt = zeros(ngroups)
 for i = 1:ngroups
     cnt[i] = skewness(x[gid .== i])
 end
 return(cnt)
end




function reportCor(x, y, gid, ngroups)
 cnt = zeros(ngroups)
   for i = 1:ngroups
     cnt[i] = cor(x[gid .== i], y[gid .==i])
 end
 return(cnt)
end




function isnumber(val)
 if typeof(val)<:Number
   x  =  ifelse(isnan(val), false, true)
 else
   x = false
 end
 return(x)
end



# note that we use \notin
# we also use \in
# vectorized versions include .\in .\notin

function standardize2(x)
  (x.-mean(x))/std(x)
end

function distance(x)
 n = length(x)
 Dist = zeros(n,n)
 for i = 1:n, j=1:n
   cordi = findall( x -> x == i, x )
   cordj =  findall( x -> x == j, x )
   Dist[i, j] =  sqrt(abs(cordi[1][1]-cordj[1][1])^2 + abs(cordi[1][2]-cordj[1][2])^2)
 end
 return(Dist)
end


function wsample2(data, weights, size)
         w = convert.(Float64, vec(sample_payoff[weights]))
         wsample(data, w, size)
     end



"""
Create a Data Frame from All Combinations of Factor Variables (see R's base::expand.grid)
# Arguments
... Array, Dict, or Tuple containing at least one value
# Return
A DataFrame containing one row for each combination of the supplied argument. The first factors vary fastest.
# Examples
```julia
expand_grid([1,2],["owl","cat"])
expand_grid((1,2),("owl","cat"))
expand_grid((1,2)) # -> Returns a DataFrame with 2 rows of 1 and 2.
```
"""
function expand_grid(args...)
   nargs= length(args)

   if nargs == 0
     error("expand_grid need at least one argument")
   end

   iArgs= 1:nargs
   nmc= "Var" .* string.(iArgs)
   nm= nmc
   d= map(length, args)
   orep= prod(d)
   rep_fac= [1]
   # cargs = []

   if orep == 0
       error("One or more argument(s) have a length of 0")
   end

   cargs= Array{Any}(undef,orep,nargs)

   for i in iArgs
       x= args[i]
       nx= length(x)
       orep= Int(orep/nx)
       mapped_nx= vcat(map((x,y) -> repeat([x],y), collect(1:nx), repeat(rep_fac,nx))...)
       cargs[:,i] .= x[repeat(mapped_nx,orep)]
       rep_fac= rep_fac * nx
   end
  return(cargs)
end


function normalize(x)
 dt = fit(UnitRangeTransform, x, dims=1) #normalize limit
 StatsBase.transform(dt, x) #normalize limit
end

# #Multilevel mean
# function mmean
#   r2i1["stock"][:,:,sim]
# for sim in 1:20
#      temp[:,i] = mean(r2i1["stock"][:,:,sim], dims =2)
#  end
# S=zeros(3000)
# S = mean(temp, dims =2)
# end


function findallmax(arr)
   max_positions = Vector{Int}()
   min_val = typemin(eltype(arr))
   for i in eachindex(arr)
       if arr[i] > min_val
           min_val = arr[i]
           empty!(max_positions)
           push!(max_positions, i)
       elseif arr[i] == min_val
           push!(max_positions, i)
       end
   end
   max_positions
end


function GetFST(trait, gid, ngroups, experiment_group, experiment)
  experiment == false ? egroup = -99 : egroup = copy(experiment_group)
  round(var(report(trait[gid  .∉ Ref(egroup)], gid[gid  .∉ Ref(egroup)], ngroups)[collect(1:ngroups) .∉ Ref(egroup)])/var(trait[gid  .∉ Ref(egroup)]),  digits=4)
end
 function GetFST(trait, gid, ngroups, experiment_group, experiment)
   experiment == false ? egroup = -99 : egroup = copy(experiment_group)
   round(var(report(trait[gid  .∉ Ref(egroup)], gid[gid  .∉ Ref(egroup)], ngroups)[collect(1:ngroups) .∉ Ref(egroup)])/var(trait[gid  .∉ Ref(egroup)]),  digits=4)
 end


allequal_1(x) = all(y->y==x[1],x)


function QuantCut(x, p)
 @assert issorted(p)
 q = quantile(x, p; sorted = true)
 searchsortedfirst.(Ref(q), x)
end

function Theil(x)
 sum(x./mean(x).*log.(x./mean(x)))/length(x)
end

import Base.sum
using DataFrames
function sum(S::DataFrame; dims  = nothing)
 if dims == nothing 
   out = sum(Matrix(S))
 elseif  dims == 2
   out = sum.(eachrow(S))
 elseif dims == 1
   out = sum.(eachcol(S))
 end
 return(out)
end



import Base.all
using DataFrames
function all(S::DataFrame; dims  = nothing)
 if dims == nothing 
   out = all(Matrix(S))
 elseif  dims == 2
   out = all(Matrix(S), dims = 2)
 elseif dims == 1
   out = all(Matrix(S), dims =1)
 end
 return(out)
end


function removeInd(x, ind)
 temp =copy(x)        
 deleteat!(temp,ind)
 return(temp)
end


### Non Dominated nonDominatedSorting

function dominates2(x, y)
 strict_inequality_found = false
 for i in eachindex(x)
     y[i] > x[i] && return false
     strict_inequality_found |= x[i] > y[i]
 end
 return strict_inequality_found
end


function nds4(arr)
 fronts = Vector{Int64}[]
 o = size(arr)[2]
 ind = collect(axes(arr, 1))
 a = SVector{o}.(eachrow(arr))
 while !isempty(a)
     red = [all(x -> !dominates2(x, y), a) for y in a]
     push!(fronts, ind[red])
     deleteat!(ind, red)
     deleteat!(a, red)
 end
 return fronts
end




function crowdD(arr, frontrank)
  out = []
  N = size(arr)[1]
  J = length(arr[1,:])
  D = zeros(N)
  df = DataFrame(arr, :auto)
  df[:, "id"] = collect(1:N)
  for i in 1:maximum(frontrank)
    #println(i)
    A=df[frontrank.==i,:]
    inds = findall(frontrank .==i)
    store = zeros(length(inds), J+1)
    store[:,end] = inds
    for j in 1:J
      S=sort(df[inds,:], j)
      n = length(S[:,1])      
      mx = maximum(S[:,j])
      mn = minimum(S[:,j])
      mxmn = mx.-mn
      d = zeros(n)
      d[1,:] .= Inf
      d[n,:] .= Inf
      for k in 2:(n-1)
          d[k]=(S[k+1,j] - S[k-1,j])/mxmn
      end
      #set back to original order
      S[:,"dist"] = d
      S=sort(S, "id")
      store[:,j]=S[:,"dist"]
    end
    Dtemp=sum(store[:, 1:(end-1)], dims = 2)
    D[inds] = Dtemp
  end
  return(D)  
end
 
import Base.sum
using DataFrames
function sum(S::DataFrame; dims  = nothing)
  if dims == nothing 
    out = sum(Matrix(S))
  elseif  dims == 2
    out = sum.(eachrow(S))
  elseif dims == 1
    out = sum.(eachcol(S))
  end
  return(out)
end



import Base.all
using DataFrames
function all(S::DataFrame; dims  = nothing)
  if dims == nothing 
    out = all(Matrix(S))
  elseif  dims == 2
    out = all(Matrix(S), dims = 2)
  elseif dims == 1
    out = all(Matrix(S), dims =1)
  end
  return(out)
end


function removeInd(x, ind)
  temp =copy(x)        
  deleteat!(temp,ind)
  return(temp)
end


### Non Dominated nonDominatedSorting

function dominates2(x, y)
  strict_inequality_found = false
  for i in eachindex(x)
      y[i] > x[i] && return false
      strict_inequality_found |= x[i] > y[i]
  end
  return strict_inequality_found
end


function nds4(arr)
  fronts = Vector{Int64}[]
  o = size(arr)[2]
  ind = collect(axes(arr, 1))
  a = SVector{o}.(eachrow(arr))
  while !isempty(a)
      red = [all(x -> !dominates2(x, y), a) for y in a]
      push!(fronts, ind[red])
      deleteat!(ind, red)
      deleteat!(a, red)
  end
  return fronts
end



function crowdD(arr, frontrank)
  out = []
  N = size(arr)[1]
  J = length(arr[1,:])
  D = zeros(N)
  for i in 1:maximum(frontrank)
      println(i)
      A=arr[frontrank.==i,:]
      inds = findall(frontrank .==i)
      S=sort(arr[frontrank.==i,:], dims = 1)
      n = length(S[:,1])      
      indsFront = zeros(Int64, n, J)
      a=collect(1:n)
      indin = zeros(Int64, n, J)
      for j in 1:J
        indsFront[:,j] = Int.(sortperm(A[:,j]))
        indin[:,j]=indexin(a, indsFront[:,j])
      end

      mx = maximum(S, dims=1)
      mn = minimum(S, dims =1)
      mxmn = mx.-mn
      d = zeros(n, J)
      d[1,:] .= Inf
      d[n,:] .= Inf
      store = []
      for j in 1:J
          for k in 2:(n-1)
              d[k, j]=(S[k+1,j] - S[k-1,j])/mxmn[j]
          end
          #set back to original order
          d[:,j]=d[indin[:,j]]
      end
      D[inds] = sum(d, dims = 2)     
  end
  return(D)
end

##########################
######## Reorder  #########
function reorder(x)
  n=length(x)
  y=zeros(n)
  for i in 1:length(unique(x))
      ind=findall(x.== sort(unique(x))[i])        
      y[ind] .= i
  end
  return(y)
end