function ResourceDynamics(harvest, stock, max_stock, regrow, volatility, ngroups, harvest_zero = false)
      #remove stock
     if harvest_zero == false stock -= harvest end
      #regrow stock
      stock += stock*regrow.*(1 .- stock./max_stock)

      #apply volatility
      vola=rand(volatility, ngroups)
      stock .= stock.+vola.*stock

      #Check to make sure stock follows logical constraints
      stock .= ifelse.(stock .> max_stock, max_stock, stock)
      stock .= ifelse.(stock.<= 0, .01 .* max_stock, stock) #note that if the forest is depleted it will regrow back to the regrowth rate* max.
      return stock 
end
