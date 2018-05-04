struct VirtualGate{T<:AbstractFloat} <: Wall{T}
    sp::SVector{2,T}
    ep::SVector{2,T}
    normal::SVector{2,T}
    width::T
    center::SVector{2,T}
    color::Symbol
    name::String
end
function VirtualGate(sp::AbstractVector, ep::AbstractVector,
    n::AbstractVector, color::Symbol, name::String = "Virtual Gate")
    T = eltype(sp) <: Integer ? Float64 : eltype(sp)
    n = normalize(n)
    d = dot(n, ep-sp)
    if abs(d) > 10eps(T)
        error("Normal vector is not actually normal to the wall: dot = $d")
    end
    w = norm(ep - sp)
    center = @. (ep+sp)/2
    return VirtualGate{T}(SVector{2,T}(sp), SVector{2,T}(ep), SVector{2,T}(n), w, SVector{2,T}(center), color, name)
end

import DynamicalBilliards.specular!
@inline function specular!(p::AbstractParticle{T}, r::VirtualGate{T})::Void where {T}
    n = normalvec(r, p.pos)
    φ = atan2(n[2], n[1]) + 0.95(π*rand() - π/2) #this cannot be exactly π/2
    p.vel = SVector{2,T}(cos(φ), sin(φ))
    return nothing
end

import DynamicalBilliards.translation
translation(w::VirtualGate, vec) = VirtualGate(w.sp + vec, w.ep + vec, w.normal, w.color)

import DynamicalBilliards.collisiontime
function collisiontime(p::Particle{T}, w::VirtualGate{T})::T where {T}
    n = normalvec(w, p.pos)
    denom = dot(p.vel, n)
    # case of velocity pointing away of wall:
    denom ≥ 0 && return Inf
    posdot = dot(w.sp-p.pos, n)
    # Case of particle starting behind finite wall:
    posdot ≥ 0 && return Inf
    colt = posdot/denom
    intersection = p.pos .+ colt .* p.vel
    dfc = norm(intersection - w.center)
    if dfc > w.width/2
        return Inf
    else
        return colt
    end
end

@inline function project_to_line(point, c, n)
    posdot = dot(c - point, n)
    intersection = point + posdot*n
end

import DynamicalBilliards.distance_init
function distance_init(pos::SVector{2,T}, w::VirtualGate{T})::T where {T}
    n = normalvec(w, pos)
    posdot = dot(w.sp - pos, n)
    if posdot ≥ 0 # I am behind wall
        intersection = project_to_line(pos, w.center, n)
        dfc = norm(intersection - w.center)
        if dfc > w.width/2
            return +1.0 # but not directly behind
        else
            return -1.0
        end
    end
    v1 = pos - w.sp
    dot(v1, n)
end
