mutable struct Agent{T<:AbstractFloat}
    bt::DynamicalBilliards.Billiard{T}
    u::Dict
    p::Particle{T}
    i::Signed
end

