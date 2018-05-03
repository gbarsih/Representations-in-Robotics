using StaticArrays
struct VirtualGate{T<:AbstractFloat} <: Wall{T}
    sp::MVector{2,T}
    ep::MVector{2,T}
    normal::MVector{2,T}
    color::String
    name::String
end
function VirtualGate(sp::AbstractVector, ep::AbstractVector,
    n::AbstractVector, color::String, name::String = "Virtual Gate")
    T = eltype(sp) <: Integer ? Float64 : eltype(sp)
    n = normalize(n)
    d = dot(n, ep-sp)
    if abs(d) > 10eps(T)
        error("Normal vector is not actually normal to the wall: dot = $d")
    end
    return VirtualGate{T}(MVector{2,T}(sp), MVector{2,T}(ep), MVector{2,T}(n), color, name)
end

import DynamicalBilliards.specular!
@inline function specular!(p::AbstractParticle{T}, r::VirtualGate{T})::Void where {T}
    n = normalvec(r, p.pos)
    φ = atan2(n[2], n[1]) + 0.95(π*rand() - π/2) #this cannot be exactly π/2
    p.vel = MVector{2,T}(cos(φ), sin(φ))
    return nothing
end

import DynamicalBilliards.translation
translation(w::VirtualGate, vec) = VirtualGate(w.sp + vec, w.ep + vec, w.normal, w.color)
