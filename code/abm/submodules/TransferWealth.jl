# This function should track all the children who are born and add them to a parents list

function GetChildList(babies, died, children)
    push!.(children[babies], died) 
end

function DistributWealth(died, payoff, children)
    weal = copy(payoff)
    wealPer = weal[died]./length.(children)[died]
    wealPer[wealPer .== Inf] .=0
    wealPer[wealPer .== NaN] .=0
    
    for i in 1:length(died)
        payoff[children[died][i]] = payoff[children[died[i]]] .+ 
        ones(length(children[died[i]])) .*wealPer[i]
    end
    return(payoff)
end
