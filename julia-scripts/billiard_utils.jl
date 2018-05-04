function construct_billiard(polysp::AbstractArray{T, 2}, sp::AbstractArray{T, 2},
    ep::AbstractArray{T, 2}, clr::Vector{Symbol}) where {T<:AbstractFloat}
    polyep = circshift(polysp, (0, -1))
    polyn = [0.0 -1.0; 1.0 0.0]*(polyep - polysp)

    world = []
    for i = 1:size(polysp, 2)
        wall = FiniteWall(polysp[:,i], polyep[:,i], polyn[:,i])
        push!(world, wall)
    end

    n = [0.0 -1.0; 1.0 0.0]*(ep - sp)

    for i = 1:length(clr)
        gate = VirtualGate(sp[:,i], ep[:,i], n[:,i], clr[i])
        push!(world, gate)
        gate = VirtualGate(sp[:,i], ep[:,i], -n[:,i], clr[i])
        push!(world, gate)
    end
    bt = Billiard(world)

    return bt
end

function construct_billiard(polys_sp::AbstractArray{Array{T, 2}, 1}, sp::AbstractArray{T, 2},
    ep::AbstractArray{T, 2}, clr::Vector{Symbol}) where {T<:AbstractFloat}
    polys_ep = []
    for i = 1:length(polys_sp)
        push!(polys_ep, circshift(polys_sp[i], (0, -1)))
    end
    polysp = hcat(polys_sp...)
    polyep = hcat(polys_ep...)
    polyn = [0.0 -1.0; 1.0 0.0]*(polyep - polysp)

    world = []
    for i = 1:size(polysp, 2)
        wall = FiniteWall(polysp[:,i], polyep[:,i], polyn[:,i])
        push!(world, wall)
    end

    n = [0.0 -1.0; 1.0 0.0]*(ep - sp)

    for i = 1:length(clr)
        gate = VirtualGate(sp[:,i], ep[:,i], n[:,i], clr[i])
        push!(world, gate)
        gate = VirtualGate(sp[:,i], ep[:,i], -n[:,i], clr[i])
        push!(world, gate)
    end
    bt = Billiard(world)

    return bt
end

function construct_controlmap(num_gates::T) where {T<:Signed}
    u = Dict()
    for i = 1:num_gates
        push!(u, clr[i]=>0)
    end
    return u
end
