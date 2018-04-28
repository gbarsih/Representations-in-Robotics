function newgraph = updategraph(graph, agtArr)
  newgraph = zeros(length(graph), 1);
  for j=1:length(agtArr)
    newgraph(agtArr(j).region) = newgraph(agtArr(j).region) + 1;
  end
end
