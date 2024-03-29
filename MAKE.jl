####################
#LOAD PACKAGES #####

######################################
############ DETERMINE COMPUTER ######
using Distributed
@everywhere using DataFrames
@everywhere using Statistics
@everywhere using Distributions
@everywhere using Random
@everywhere using Distributions
@everywhere using StatsBase
@everywhere using Plots
@everywhere using Plots.PlotMeasures
@everywhere using JLD2
@everywhere using Serialization
@everywhere using Statistics
@everywhere using ColorSchemes
@everywhere using GLM
@everywhere using CSV


if gethostname()  == "ECOD038"
    cd("Y:\\eco_andrews\\Projects\\")
elseif gethostname()== "DESKTOP-H4MPGAP"
    cd("C:\\Users\\jeffr\\Documents\\Work\\")
elseif gethostname()== "jeffrey_andrews"
    cd("C:\\Users\\jeffr\\OneDrive\\Documents\\Ostrom\\")
end


#####################################
######## Initalize Functions ########

@everywhere include(string(pwd(), "\\cpr_public\\code\\functions\\utility.jl"))

######################################
#### Initalize submodules ############

@everywhere files = readdir(string(pwd(), ("\\cpr_public\\code\\abm\\submodules")))
@everywhere for i in files  include(string(pwd(), "\\cpr_public\\code\\abm\\submodules\\$i")) end

######################################
######### CHOOSE ABM VERSION #########

@everywhere include(string(pwd(), "\\cpr_public\\code\\abm\\abm_public.jl"))


########################################
######## DRAW PANELS ###################
# If plots are already saved set run == false - otherwise true
RUN = false


include(string(pwd(), "\\cpr_public\\code\\plotting\\ostrom\\threshold.jl"))
include(string(pwd(), "\\cpr_public\\code\\plotting\\ostrom\\stringent_policy.jl"))
include(string(pwd(), "\\cpr_public\\code\\plotting\\ostrom\\selfregulation_on_policy.jl"))
include(string(pwd(), "\\cpr_public\\code\\plotting\\ostrom\\seizures_on_borders.jl"))
include(string(pwd(), "\\cpr_public\\code\\plotting\\ostrom\\policy_on_payoff.jl"))
include(string(pwd(), "\\cpr_public\\code\\plotting\\ostrom\\outgroup.jl"))
include(string(pwd(), "\\cpr_public\\code\\plotting\\ostrom\\heterogenity_on_bandits.jl"))
include(string(pwd(), "\\cpr_public\\code\\plotting\\ostrom\\borders_on_selfregulation.jl"))
include(string(pwd(), "\\cpr_public\\code\\plotting\\ostrom\\border_dynamics.jl"))
include(string(pwd(), "\\cpr_public\\code\\plotting\\ostrom\\bandits_on_selfregulation.jl"))
# include(string(pwd(), "\\cpr_public\\code\\plotting\\ostrom\\bandits_on_borders.jl"))
include(string(pwd(), "\\cpr_public\\code\\plotting\\ostrom\\banditry_on_policy.jl"))


######################################
############ MAKE FIGURE 2 ###########

include(string(pwd(), "\\cpr_public\\code\\plotting\\main_fig.jl"))

######################################
############ PLOTS FOR SI 1 ##########

using GLM