using DynamicalBilliards, Plots
include("agent.jl")
include("billiard_utils.jl")
include("plot_utils.jl")
include("randomfinitewall.jl")
include("simulation.jl")
include("vgate.jl")

include("problem_setup.jl")

bt = construct_billiard(poly, sp, ep, clr)
u = construct_controlmap(length(clr))

agt = create_agents(num_agents, init_width, init_center, u)

# Loop manually from here if you want to see step by step plots
# for j = 1:1000
    simulate_once!(agt, bt, 0.1)
# end

plot_map(agt, bt)
