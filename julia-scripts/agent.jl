mutable struct Agent{T<:AbstractFloat}
    u::Dict
    p::Particle{T}
    cnti::Signed
    cntk::Signed
end

function create_agents(num_agents::Signed, init_width::T,
    init_center::AbstractArray{T, 1}, u) where {T<:AbstractFloat}
    agt = []
    for i = 1:num_agents
        init_pos = init_width*(rand(2)-0.5) .+ init_center
        init_vel = 2π*rand()
        p = Particle(init_pos..., init_vel)
        cnti = div(num_agents*(num_agents-1), 2)
        cntk = num_agents - 1
        a = Agent(deepcopy(u), p, cnti, cntk)
        push!(agt, a)
    end
    return agt
end

function detected_crossing!(agent, color)
    agent.cntk -= 1
    if agent.cnti == agent.cntk*(agent.cntk + 1)/2 + 1
        agent.cnti -= 1
        for key in keys(agent.u)
            agent.u[key] = 0
        end
        agent.u[color] = 1
    else
        for key in keys(agent.u)
            agent.u[key] = 1
        end
    end
    return (color, agent.cntk)
end

function received_broadcast!(agent, broadcast)
    agent.cnti -= 1
    if agent.cnti == agent.cntk*(agent.cntk - 1)/2
        for key in keys(agent.u)
            agent.u[key] = 1
        end
    elseif agent.cnti == agent.cntk*(agent.cntk + 1)/2 + 1 && agent.cntk == broadcast[2]
        agent.cnti -= 1
        for key in keys(agent.u)
            agent.u[key] = 0
        end
        agent.u[broadcast[1]] = 1
    end
end
