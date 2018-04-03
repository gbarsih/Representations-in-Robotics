using DynamicalBilliards, PyPlot

bt = billiard_rectangle()
# Plot walls:
for w in bt
  plot_obstacle(w; color = (0,0,0, 1), linewidth = 3.0)
end

# Create and plot the 3 disks:
r = 0.165
ewidth = 6.0
redcent = [0.28, 0.32]
red = Disk(redcent, r, "red")
plot_obstacle(red; edgecolor = (203/255, 60/255, 51/255),
facecolor = (213/255, 99/255, 92/255), linewidth = ewidth)

purple = Disk([1 - redcent[1], redcent[2]], r, "purple")
plot_obstacle(purple; edgecolor = (149/255, 88/255, 178/255),
facecolor = (170/255, 121/255, 193/255), linewidth = ewidth)

green = Disk([0.5, 1 - redcent[2]], r, "green")
plot_obstacle(green, edgecolor = (56/255, 152/255, 38/255),
facecolor = (96/255, 173/255, 81/255), linewidth = ewidth)

# Create billiard
bt = Billiard(bt.obstacles..., red, purple, green)

# Set axis
axis("off")
tight_layout()
gca()[:set_aspect]("equal")
xlim(-0.1,1.1)
ylim(-0.1,1.1)

# Create a particle
p = randominside(bt, 2.0)
# particle colors
darkblue = (64/255, 99/255, 216/255)
lightblue = (102/255, 130/255, 223/255)

okwargs = Dict(:linewidth => 2.0, :color => lightblue)
pkwargs = Dict(:color => darkblue, :s => 150.0)

# create the animation:
animate_evolution(p, bt, 200; col_to_plot = 7,
particle_kwargs = pkwargs, orbit_kwargs = okwargs, newfig = false)
