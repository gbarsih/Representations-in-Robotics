function objArr = Agent(graph)
  objArr = [];
  % N = length(graph);
  N = graph(1);
  i = N*(N-1)/2;
  for j = 1:graph(1)
    obj = Agent(j,1,false,i,N-1);
    objArr = [objArr obj];
  end
end
