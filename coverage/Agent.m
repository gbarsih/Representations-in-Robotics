classdef Agent < handle
  properties
    id
    region
    term
    i
    k
  end
  methods
    function obj = Agent(id, region, term, i, k)
      obj.id = id;
      obj.region = region;
      obj.term = term;
      obj.i = i;
      obj.k = k;
    end
  end
end
