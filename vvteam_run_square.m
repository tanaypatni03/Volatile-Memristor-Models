clear;
close all;
clc;

c1 = 5e-3;
c2 = 25e-3;
c3 = 35e-3;

t1 = 0:1e-6:c1;
t2 = c1+1e-6:1e-6:c2;
t3 = c2+1e-6:1e-6:c3;

time = [t1 t2 t3];

v1 = t1.*0 + -1;
v2 = t2.*0 + 3;
v3 = t3.*0 + -1;

va = [v1 v2 v3];

plot(time,va)

param = [15 1.5 15e-3 4];

for j = 10e-3
    param = [150 0.45 j 5];
    [v,i,x]=vvteam(time,va,0,param,7);
    
    figure(1)
    subplot(3,1,1);
    plot(time,v); 
    xlabel("Applied Voltage",LineWidth=5); hold on
    subplot(3,1,2);
    plot(time,i); 
    xlabel("Current",LineWidth=5); hold on
    subplot(3,1,3); 
    plot(time,x);
    xlabel("State Variable",LineWidth=5); hold on;
end
