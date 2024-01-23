      function GetEcoSysServ(ngroups, eco_slope, eco_C, K, kmax)
        eco = zeros(ngroups)
           for i in 1:ngroups
             eco[i]=cdf.(Beta(1, eco_slope), K[i]/maximum(kmax))*eco_C
           end
         return(eco)
       end
       
       function GetEcoSysServ(ngroups, eco_system_price, K, kmax)
        eco = zeros(ngroups)
           for i in 1:ngroups
             # CHANGE THIS TO BE SOMETHING ESLE
             # eco[i]=cdf.(Beta(1, eco_slope), K[i]/maximum(kmax))*eco_C
              eco[i] = eco_system_price + K[i]
           end
         return(eco)
       end
