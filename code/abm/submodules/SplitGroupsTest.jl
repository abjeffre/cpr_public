function SplitGroupsTest(gid, groups, nmodels, id, traits, split_method, ngroups)
    print(any(tab(gid, ngroups).<(nmodels+1)))
    if any(tab(gid, ngroups).<(nmodels+1))
      failed = findall((tab(gid, ngroups) .< (nmodels+1)))
      println(failed)
      for i in 1:length(failed)
        gid[gid .∈ Ref(failed[i])] = sample(gid[gid .∉ Ref(failed)], sum(gid .∈ Ref(failed[i])), replace = false)
        if split_method == "random"
            print("got here")
            for i in 1:length(failed)
                tosplit=findmax(tab(gid, ngroups))[2]
                groupsize=asInt(findmax(tab(gid, ngroups))[1])
                newmembers=sample(id[gid .∈ Ref(tosplit)], groupsize)
                gid[newmembers].=failed[i]
                println("group split")
            end
        end
        if split_method == "political"
            for i in 1:length(failed)
                tosplit=findmax(tab(gid, ngroups))[2]
                groupsize=asInt(findmax(tab(gid, ngroups))[1])
                splitpoint=median(traits.harv_limit[gid.== failed[i]])
                temp=findall(x->x .> splitpoint, traits.harv_limit[gid.== tosplit])
                temp2=id[gid.==tosplit]
                newmembers=temp2[temp]
                gid[newmembers].=failed[i]
            end
        end
      end
    end
    return(gid)
  end
