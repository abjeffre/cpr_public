function MutateAgents(trait, mutation, types)
        x=copy(trait)
        n=size(x)[1]
        length(size(x)) > 1 ? k=size(x)[2] : k = 1
        trans_error = rand(n,k) .< mutation
        if types == "Dirichlet"
                temp = Matrix(x).*5 .+ .01
                n_error  = zeros(n,k)
                for i in 1:n
                        n_error[i,:] = rand(Dirichlet(temp[i,:]), 1)'
                end
                x =  ifelse.(trans_error[:,1], n_error, x)
        else
                for i in 1:k
                        if types[i] == "binary" x[:,i]=ifelse.(trans_error[:,i], ifelse.(x[:,i].==1,0,1), x[:,i])  end
                        if types[i] == "prob"
                                n_error = rand(Normal(),  n)
                                proposal = inv_logit.(logit.(x[:,i]) .+ n_error)
                                proposal = ifelse.(proposal .> .999, .9, proposal)                                
                                new_value = ifelse.(proposal .< 0.001, .1, proposal)
                                x[:,i] =  ifelse.(trans_error[:,i], new_value, x[:,i])
                        end
                        if types[i] == "positivecont"
  #                             n_error = rand(Normal(1, .02), n)
#                               x[:,i] =  ifelse.(trans_error[:,i], (x[:,i]) .* n_error, x[:,i])
                                n_error = rand(Normal(0, .2), n)
                                proposed = x[:,i] .+ n_error
                                #println(proposed)
                                x[:,i] =  ifelse.(trans_error[:,i], ifelse.(proposed .<= 0, .1, proposed), x[:,i])
                        end
                end
        end
        return(x)
end
