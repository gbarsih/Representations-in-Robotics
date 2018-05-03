using DynamicalBilliards, PyPlot
include("vgate.jl")
include("agent.jl")

# Close plots
PyPlot.close()

# Choose number of agents
num_agents = 5

# Construct a rectangular environment
world = Obstacle[billiard_rectangle(5.0, 1.0; setting = "random").obstacles...]

# Define the virtual gates
sp = [
      2.0 0.0;
      3.0 0.0;
     ]'

ep = [
      2.0 1.0;
      3.0 1.0;
     ]'
n = [
     -1.0 0.0;
     -1.0 0.0;
    ]'
clr = [
        "red",
        "blue"
      ]

u = Dict()
for i = 1:length(clr)
    gate = VirtualGate(sp[:,i], ep[:,i], n[:,i], clr[i])
    push!(world, gate)
    push!(u, clr[i]=>0)
end

agt = []
for i = 1:num_agents
    bt = Billiard(deepcopy(world))
    p = randominside(bt)
    a = Agent(bt, deepcopy(u), p, 0)
    push!(agt, a)
    plot_particle(p; color=(0.5, 0.0, 0.0))
end

for j = 1:100
    mint = Inf
    minw = 0
    k = 0
    for i = 1:num_agents
        toc, wall = next_collision(agt[i].p, agt[i].bt)
        if toc ≤ mint
            mint = toc
            minw = wall
            k = i
        end
    end

    for i = 1:num_agents
        if i==k && typeof(world[minw]) <: VirtualGate && agt[i].u[world[minw].color] == 0
            propagate!(agt[i].p, mint)
            agt[i].bt[minw].normal[:] *= -1
            agt[i].u[world[minw].color] = 1
        else
            evolve!(agt[i].p, agt[i].bt, mint)
        end
    end
end

# Post Plotting
for i = 1:num_agents
    plot_particle(agt[i].p; color=(0.0, 0.5, 0.0))
end
plot_billiard(agt[1].bt)
