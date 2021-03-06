%% Initialize

clc; close all;
graph = [6, 0, 0, 0, 0, 0];
agts = agents(graph);

%% Loop

while ~terminated(agts)

    for j=1:length(agts)
        if agts(j).i == agts(j).k*(agts(j).k - 1)/2
            agts(j).term = true;
        end
        if ~agts(j).term
            cross(agts, j);
        end
    end

    for j=1:length(agts)
        if ~agts(j).term
            agts(j).i = agts(j).i - 1;
        end
    end

    graph = updategraph(graph, agts);
end

%% Plot

bar(graph)
