        function GetSeizedPay(seized, contrib, gid, ngroups)
            totalcont = zeros(ngroups)
            for i = 1:ngroups
              totalcont[i] = sum(contrib[gid .==i])
            end
              ifelse.(isnan.(seized[gid].*(contrib./totalcont[gid])), 0,seized[gid].*(contrib./totalcont[gid]))
            end
