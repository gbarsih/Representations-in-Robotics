function plot_gate(ratio,loc,top,right,d)

%ratio: number between 0 and 1, proportion of blank area to working area
%loc: position of the blank area, between 0 and 1;
%top/right: top/right limit of the box
N = 1000;
gate_length = 1;
available_length = gate_length*(1-ratio);
blank_length = gate_length-available_length;

y_l = linspace(0,loc-blank_length/2,N);
x_l = inv_gate(y_l,d);
y_t = linspace(loc+blank_length/2,top,N);
x_t = inv_gate(y_t,d);

boxx = [0 right right 0 0];
boxy = [0 0 top top 0];
plot(x_l,y_l,'b','LineWidth',2);
hold on
plot(x_t,y_t,'b','LineWidth',2);
plot(boxx,boxy,'k','LineWidth',2.5);
hold off

end

