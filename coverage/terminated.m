function finish = terminated(agts)

finish = true;

for i=1:length(agts)
    if agts(i).term == false
        finish = false;
    end
end

end

