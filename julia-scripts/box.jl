using DynamicalBilliards, PyPlot

bt = billiard_polygon(6, 1)
plot_billiard(bt)
p = randominside(bt, 0.5)
# plot_particle(p)
xt, yt, vxt, vyt, t = construct(evolve!(p, bt, 10)...)
plot_billiard(bt, xt, yt)
plot_particle(p)

# # Create billiard
# bt = Billiard(bt.obstacles...)
#
# # Set axis
# axis("off")
# tight_layout()
# gca()[:set_aspect]("equal")
# xlim(-0.1,1.1)
# ylim(-0.1,1.1)
#
# # Create a particle
# p = randominside(bt, 0.1)
# # particle colors
# darkblue = (64/255, 99/255, 216/255)
# lightblue = (102/255, 130/255, 223/255)
#
# okwargs = Dict(:linewidth => 2.0, :color => lightblue)
# pkwargs = Dict(:color => darkblue, :s => 150.0)
#
# # create the animation:
# animate_evolution(p, bt, 200; col_to_plot = 7,
# particle_kwargs = pkwargs, orbit_kwargs = okwargs, newfig = false)
