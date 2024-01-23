function GetWages(effort, wages::Vector{Float64}) wages[agents.gid].*effort[:,1] end 
function GetWages(effort, wages::Float64) wages.*effort[:,1] end
