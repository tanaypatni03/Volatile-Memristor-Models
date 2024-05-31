clear;
close all;
clc;

T = 2e-3; 
t2 = linspace(0, 60e-3, 100e-3/1e-6);
v2 = (square(t2/T*2*pi) + 1);

t2 = t2 + 10e-3;

t3 = t2(end)+1e-6:1e-6:t2(end)+T/2;
v3 = 0*t3 + 2;

t4 = t3(end)+1e-6:1e-6:t3(end)+200e-3;
v4 = 0*t4 - 1;

t1 = 0:1e-6:10e-3;
v1 = 0*t1 - 1;

time = [t1 t2 t3 t4];
va = [v1 v2 v3 v4];

plot(time,va)

for j = 10e-2
    param = [150 0.45 j 8.5 1 1.744 1.5726 30e3 15e11];
    [v,i,x]=vvteam(time,va,0,param,10);
    
    figure(1)
    subplot(3,1,1);
    plot(time,v); 
    xlabel("Applied Voltage"); hold on
    subplot(3,1,2);
    plot(time,i); 
    xlabel("Current"); hold on
    subplot(3,1,3); 
    plot(time,x);
    xlabel("State Variable"); hold on;
end