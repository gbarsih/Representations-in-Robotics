function [R] = real_region(p,d)

if p(1)>inv_gate(p(2),d)
    R = 1;
else
    R = 0;
end

end

