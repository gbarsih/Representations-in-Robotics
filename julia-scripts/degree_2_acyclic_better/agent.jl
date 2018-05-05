mutable struct Agent{T<:AbstractFloat}
    u::Dict
    p::Particle{T}
    M::Signed
    N::Signed
    cnti::Signed
    cntk::Signed
    cntj::Signed
end

function create_agents(num_agents::Signed, graph_size::Signed, init_width::T,
    init_center::AbstractArray{T, 1}, u) where {T<:AbstractFloat}
    agt = []
    for i = 1:num_agents
        init_pos = init_width*(rand(2)-0.5) .+ init_center
        init_vel = 2π*rand()
        p = Particle(init_pos..., init_vel)
        cnti = div(num_agents*(num_agents-1), 2)
        cntk = num_agents - 1
        cntj = 1
        a = Agent(deepcopy(u), p, num_agents, graph_size, cnti, cntk, cntj)
        push!(agt, a)
    end
    return agt
end

function detected_crossing!(agent, color)
    agent.cntk -= 1
    if agent.cntk != 0 && agent.cnti == agent.cntk*(agent.cntk + 1)/2 + 1
        agent.cnti -= 1
        if agent.cntk == agent.M - agent.cntj*agent.N
            agent.cntk = agent.M - agent.cntj*agent.N - 1
            agent.cnti = div(agent.cntk*(agent.cntk + 1), 2)
            for key in keys(agent.u)
                agent.u[key] = 1
            end
            agent.u[color] = 0
            agent.cntj += 1
        else
            for key in keys(agent.u)
                agent.u[key] = 0
            end
            agent.u[color] = 1
        end
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
    elseif agent.cnti == agent.cntk*(agent.cntk + 1)/2 + 1 && (agent.cntk == broadcast[2] || agent.cntk == broadcast[2] + 1)
        agent.cnti -= 1
        if agent.cntk == agent.M - agent.cntj*agent.N
            agent.cntk = agent.M - agent.cntj*agent.N - 1
            agent.cnti = div(agent.cntk*(agent.cntk + 1), 2)
            for key in keys(agent.u)
                agent.u[key] = 1
            end
            agent.u[broadcast[1]] = 0
            agent.cntj += 1
        else
            for key in keys(agent.u)
                agent.u[key] = 0
            end
            agent.u[broadcast[1]] = 1
        end
    end
end
