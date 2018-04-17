PyPlot.close()
using DynamicalBilliards, PyPlot
import DynamicalBilliards.propagate!

@inline function propagate!(p::MagneticParticle{T}, t::Real)::Void where {T}
    ω = p.omega + 0.1^2*randn(); φ0 = atan2(p.vel[2], p.vel[1])
    sinωtφ = sin(ω*t + φ0); cosωtφ = cos(ω*t + φ0)
    p.pos += SV{T}(sinωtφ/ω - sin(φ0)/ω, -cosωtφ/ω + cos(φ0)/ω)
    p.vel = SVector{2, T}(cosωtφ, sinωtφ)
    return
end
@inline function propagate!(p::MagneticParticle{T}, newpos::SVector{2,T}, t) where {T}
    ω = p.omega + 0.1^2*randn(); φ0 = atan2(p.vel[2], p.vel[1])
    p.pos = newpos
    p.vel = SVector{2, T}(cos(ω*t + φ0), sin(ω*t + φ0))
    return
end

bt = billiard_polygon(4, 1)
plot_billiard(bt)
p = randominside(bt, 0.1)
plot_particle(p)
xt, yt, vxt, vyt, t = construct(evolve!(p, bt, 100)...)
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
