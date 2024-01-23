function SocialTransmission(trait, models, fidelity, types)
        x=copy(trait)
        n=size(x)[1]
        k=size(x)[2]
        trans_error = rand(n,k) .< fidelity
        self = models .== collect(1:n)
        #trans_error[self,:] .=0
        if types == "Dirichlet"
                temp=(Matrix(x).*5).+.01
                n_error  = zeros(n,k)
                for i in 1:n
                        n_error[i,:] = rand(Dirichlet(temp[i,:]), 1)'
                end
                x =  ifelse.(trans_error[:,1], n_error[models,:], x[models,:])
        else
                for i in 1:k
                        if types[i] == "binary" x[:,i]=ifelse.(trans_error[:,i], ifelse.(x[models,i].==1,0,1), x[models,i])  end
                        if types[i] == "prob"
                                n_error = rand(Normal(), n)
                                proposal = inv_logit.(logit.(x[models,i]) .+ n_error)
                                proposal = ifelse.(proposal .> .999, .9, proposal)                                
                                new_value = ifelse.(proposal .< 0.001, .1, proposal)
                                x[:,i] =  ifelse.(trans_error[:,i], new_value, x[models,i])
                        end
                        if types[i] == "positivecont"
                                 n_error = rand(Normal(0, .2), n)
                                 proposed = x[models,i] .+ n_error
                                 x[:,i] =  ifelse.(trans_error[:,i], ifelse.(proposed .<= 0, .1, proposed), x[models,i])
                                 #new = rand(Uniform(0, 6), n)
                                 #x[:,i] =  ifelse.(trans_error[:,i], n_error, x[models,i])
                        end
                end
        end
        return(x)
end


######################CONTINUE HERES
function SocialTransmission2(trait, trait2, models, fidelity, types)
        x=copy(trait)
        x2 = copy(trait2)
        n=size(x)[1]
        k=size(x)[2]
        trans_error = rand(n,k) .< fidelity
        self = models .== collect(1:n)
        #trans_error[self,:] .=0
        if types == "Dirichlet"
                temp=(Matrix(x).*5).+.01
               # println(temp)
                n_error  = zeros(n,k)
                for i in 1:n
                        n_error[i,:] = rand(Dirichlet(temp[i,:]), 1)'
                end
                x =  ifelse.(self, x, ifelse.(trans_error[:,1], n_error[models,:], x[models,:]))
        end
        return(x)
end

################################# SOCAIL TRASNMISSION GROUP ################

function SocialTransmissionGroup(trait, models, fidelity, types, agents, ngroups, out)
        x=copy(trait)
        n=size(x)[1]
        k=size(x)[2]
        trans_error = rand(n,k) .< fidelity
        self = models .== collect(1:n)
        #trans_error[self,:] .=0
        if types == "Dirichlet"
                temp=(Matrix(x).*5).+.01
                n_error  = zeros(n,k)
                for i in 1:n
                        n_error[i,:] = rand(Dirichlet(temp[i,:]), 1)'
                end
                x =  ifelse.(trans_error[:,1], n_error[models,:], x[models,:])
        else
                for i in 1:k
                        if types[i] == "binary" x[:,i]=ifelse.(trans_error[:,i], ifelse.(x[models,i].==1,0,1), x[models,i])  end
                        if types[i] == "prob"
                                n_error = rand(Normal(), n)
                                x[:,i] =  ifelse.(trans_error[:,i], inv_logit.(logit.(x[models,i]) .+ n_error), x[models,i])
                        end
                        if types[i] == "positivecont"
                                n_error = rand(Normal(0, .2), n)
                                proposed = x[models,i] .+ n_error
                                x[:,i] =  ifelse.(trans_error[:,i], ifelse.(proposed .<= 0, .1, proposed), x[models,i])
                        end
                        if types[i] == "grouppositivecont"
                                medians =reportMedian(x[:,i], agents.gid, ngroups)
                                x[:,i][Bool.(out)]=medians[agents.gid][Bool.(out)]
                                n_error = rand(Normal(0, .2), n)
                                proposed = x[models,i] .+ n_error
                                x[:,i] =  ifelse.(trans_error[:,i], ifelse.(proposed .<= 0, .1, proposed), x[models,i])
                        end
                end
        end
        return(x)
    end
    