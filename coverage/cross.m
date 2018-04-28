function cross(agtArr, id)
  for j=1:length(agtArr)
    if j ~= id
      agtArr(j).i = agtArr(j).i - 1;
    else
      agtArr(id).region = agtArr(id).region + 1;
      agtArr(id).k = agtArr(id).k - 1;
    end
  end
end
