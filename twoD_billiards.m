clc
close all
%textprogressbar('running sim:   ');
ratio = 0.1;
loc = 0.3;
top = 1;
right = 1;
d = 0.9;
dt = 0.001;
T = 2000;
t = 1:T/dt;

sigma = 0.1;

x_r = rand();
y_r = rand();
vx = 2;
vy = -1;
p = [x_r y_r]';
v = [vx vy]';
h_x = x_r;
h_y = y_r;


figure('rend','painters','pos',[10 10 1500 600])
hold on
h = scatter(x_r,y_r,50,'o','MarkerFaceColor','r');
h.XDataSource = 'x_r';
h.YDataSource = 'y_r';


region = real_region(p,d);
est_region = region;
changes = 0;
act_changes = 0;
gate_length = top;
available_length = gate_length*(1-ratio);
blank_length = gate_length-available_length;

perf = ones(length(t),1);
phist= ones(length(t),2);
corr = perf;

for i = 1:length(t)
    pn = p+dt*v;
    if(pn(1)>=right || pn(1)<=0)
        wall = [0 1];
        angle = 2*atan2(v(1)*wall(2)-v(2)*wall(1),v(1)*wall(1)+ v(2)*wall(2));
        R = [cos(angle) -sin(angle); sin(angle) cos(angle)];
        v = R*v+sigma*randn(2,1);
    end
    if(pn(2)>=top || pn(2)<=0)
        wall = [1 0];
        angle = 2*atan2(v(1)*wall(2)-v(2)*wall(1),v(1)*wall(1)+ v(2)*wall(2));
        R = [cos(angle) -sin(angle); sin(angle) cos(angle)];
        v = R*v+sigma*randn(2,1);
    end
    
    %plot([p(1) pn(1)],[p(2) pn(2)],'r','LineWidth',1);
    
    p = pn;
    new_region = real_region(p,d);
    if(new_region~=region)
        if((p(2)<=loc-blank_length/2)||(p(2)>=loc+blank_length/2))%in beam
            changes = changes+1;
            est_region = ~est_region; 
        end
        act_changes = act_changes+1;
        region = new_region;
    end
    corr(i) = (region==est_region);
    x_r = p(1);
    y_r = p(2);
    perf(i) = changes/act_changes;
    phist(i,:) = p;
    progress = i/length(t)*100;
    %textprogressbar(progress);
    
end

for i=2:(length(corr)-1)
    corr(i)=corr(i-1)+corr(i);
end

refreshdata
close all

figure
plot(corr./t')

figure('rend','painters','pos',[10 10 1500 600])
subplot(1,2,1)
plot(phist(:,1),phist(:,2),'r','LineWidth',0.1);
hold on
plot_gate(ratio,loc,top,right,d);
hold off
axis([0 right 0 top])
axis equal
t = linspace(0,T,T/dt);
subplot(1,2,2)
plot(t,perf,'LineWidth',1.2)
ylim([0 1])

