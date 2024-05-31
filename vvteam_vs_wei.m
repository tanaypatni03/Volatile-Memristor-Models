clear;
close all;
clc;

c1 = 0.5;
c2 = 1;

t1 = 0:1e-6:c1;
t2 = c1+1e-6:1e-6:c2;

time = [t1 t2];

[~, i1] = min(abs(time-c1));
[~, i2] = min(abs(time-c2));

va = zeros(numel(time),1);

va(1:i1) = (2.5/c1).*(time(1:i1)-time(1));
va(i1+1:i2) = va(i1)-(2.5/(c2-c1)).*(time(i1+1:i2)-time(i1));
%va(i1+1:i2) = 1;
%va(i2+1:i3) = va(i2)+(7/(c3-c2)).*(time(i2+1:i3)-time(i2));

param = [650.0000000000	0.0999997340408922	1.04445690057529	2.14261854403031 1 1.744 1.5726 30e3 15e11];

ic = 3.5e-6;

[v,i,x]=vvteam(time,va,0,param,ic);

pa=struct(...
    'A'     , 1e2,      ...% [m*s^{-1}]                   preexponential constant
    'B'     , 3e-26,    ...% [m^4/s]
    'alpha' , 0.28,     ...% [-]                          barrier lowering factor 
    'Ea0'   , 0.99,     ...% [eV]                         energy barrier at F=0
    'Ea1'   , 0.65,     ...% [eV]                         energy barrier at F=0
    'phi_a' , 0.1e-9,   ...% [m]                          samllest filament size
    'gap_a' , 0.2e-9,   ...% [m]                          samllest filament gap
    ...
    'rhom0' , 2e-6,     ...% [Ohm*m]                     CF resistivity
    'lf'    , 28e-9,    ...% [m]                         free electron length
    'p'     , 0.5,      ...% 
    'rhoox0', 2e4,      ...% [Ohm*m]                     oxide resistivity (F=0)
    'gamma' , 55e-9,    ...% [m/V]
    ...
    'kthm'  , 5e3,      ...% [W*m^{-1}*K^{-1}]            CF thermal conductivity 
    'kthox' , 1,        ...% [W*m^{-1}*K^{-1}]            oxide thermal conductivity 
    ...
    'L'     , 5e-9,     ...% [m]                          CF length (tox)
    'tau_rt', 5e-3      ...% [s]                          filament retraction time constant
);

% parameters for negative operations

% generate external voltage pulse for the simulation


I_c    = 3.5e-6;   % [A]                          compliance current

% vs: internal varirables
[vs1,s]=volatile_device(pa,time,va,I_c);

vs=table2struct([struct2table(vs1)],'ToScalar',true);

squared_diffs = (i-vs.I).^2;

mean_squared_diffs = mean(squared_diffs);

rms = sqrt(mean_squared_diffs);

mean_squared_u = mean(vs.I.^2);
sqrt_mean_squared_u = sqrt(mean_squared_u);

rmse = rms/sqrt_mean_squared_u*100

N = size(va);

out = sqrt(( (sum((va-va).^2)/sum(va.^2)) +...
            (sum((i-vs.I).^2)/(sum(vs.I.^2)/N(1))) )/N(1))*100



figure(1)
plot(v,i,'LineWidth',5);hold on
plot(v,vs.I,':','LineWidth',5);
ylabel("Current (A)");
xlabel("Voltage (V)");
ax = gca;
ax.FontSize = 15;
lgd = legend("Generic Model","Physics Model[5]");
lgd.FontSize = 20;