clear;
close all;
clc;

c1 = 2e-3;
c2 = 15e-3;
c3 = 100e-3;

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



for j = 10e-3:10e-3:100e-3
    for k = 5
    param = [150 0.45 j k 1 1.744 1.5726 30e3 15e11];
    [v,i,x]=vvteam(time,va,0,param,7);
    
    figure(1)
    %subplot(3,1,1);
    %plot(time,v, "LineWidth",3);
    %title("Applied Voltage")
    %xlabel("Time (s)","FontSize",20); 
    %ylabel("Voltage (V)","FontSize",20);
    %cx = gca;
    %cx.FontSize = 15;
    %hold on
    subplot(2,1,1);
    plot(time,i, "LineWidth",3); 
    title("Current through the device","FontSize",20)
    xlabel("Time (s)","FontSize",20); 
    ylabel("Current (A)","FontSize",20);
    ax = gca;
    ax.FontSize = 15;
    hold on
    lgd = legend("10ms","20ms","30ms","40ms","50ms","60ms","70ms","80ms","90ms","100ms");
    subplot(2,1,2); 
    plot(time,x, "LineWidth",3);
    title("State Variable","FontSize",20)
    xlabel("Time (s)","FontSize",20); 
    ylabel("State Varable","FontSize",20);
    bx = gca;
    bx.FontSize = 15;
    hold on;
    lgd1 = legend("10ms","20ms","30ms","40ms","50ms","60ms","70ms","80ms","90ms","100ms");
    end
end
lgd.FontSize = 12;
lgd1.FontSize = 12;
title(lgd,"\tau","FontSize",20,"FontWeight","bold");
title(lgd1,"\tau","FontSize",20,"FontWeight","bold");