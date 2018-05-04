function plot_walls!(bt::Billiard{T}) where {T<:AbstractFloat}
    for wall in bt
        xs = [wall.sp[1], wall.ep[1]]
        ys = [wall.sp[2], wall.ep[2]]
        if typeof(wall) <: VirtualGate
            color = wall.color
            alpha = 0.3
            lw = 5.0
        else
            color = :black
            alpha = 1.0
            lw = 2.0
        end
        plot!(xs, ys,
            linealpha = alpha,
            linewidth = lw,
            linecolor = color)
    end
end

function plot_agent!(agent::Agent{T}) where {T<:AbstractFloat}
    xs = [agent.p.pos[1]]
    ys = [agent.p.pos[2]]
    scatter!(xs, ys,
        marker = (:circle, 7, 0.1, :brown))
end

function plot_map(agt::Vector, bt::Billiard{T}) where {T<:AbstractFloat}
    plot()
    plot_walls!(bt)
    # Plot particle
    for i = 1:length(agt)
        plot_agent!(agt[i])
    end
    plot!(aspect_ratio=:equal, grid=:false, axis=:false, legend=:false)
end
