function simulate_once!(agt::Vector, bt::Billiard{T}, Δt::T) where {T<:AbstractFloat}
    broadcast = ()
    mint = Δt
    minw = 0
    k = 0
    for i = 1:length(agt)
        toc, wall = next_collision(agt[i].p, bt)
        if toc ≤ mint
            mint = toc
            minw = wall
            k = i
        end
    end

    if minw > 0 && typeof(bt[minw]) <: VirtualGate && agt[k].u[bt[minw].color] == 0
        propagate!(agt[k].p, mint + sqrt(eps(mint)))
        broadcast = detected_crossing!(agt[k], bt[minw].color)
    elseif minw > 0
        evolve!(agt[k].p, bt, 1)
    end

    for i = 1:length(agt)
        if i != k
            propagate!(agt[i].p, mint)
            if !isempty(broadcast)
                received_broadcast!(agt[i], broadcast)
            end
        end
    end
end
