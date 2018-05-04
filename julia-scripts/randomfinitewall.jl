import DynamicalBilliards.specular!
@inline function specular!(p::AbstractParticle{T}, r::FiniteWall{T})::Void where {T}
    n = normalvec(r, p.pos)
    φ = atan2(n[2], n[1]) + 0.95(π*rand() - π/2) #this cannot be exactly π/2
    p.vel = SVector{2,T}(cos(φ), sin(φ))
    return nothing
end

import DynamicalBilliards.collisiontime
function collisiontime(p::Particle{T}, w::FiniteWall{T})::T where {T}
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
