function [v,i,x]=vvteam(time,VA,IniState,param,ic)

% ----------------------------------------------------
% 
% Behavioral model for volatile switching device
% INPUT:
%       time            time xaxis for simulation
%       VA              external voltage applied on the device
%       IniState        Initial state of the device
%       param           device parameters
%                       [kpos apos tau beta] 
%       ic              [A] compliance current                    
%                   
% OUTPUT
%       v               Applied Voltage
%       i               The current through the device
%       x               Internal State Variable
% ---------------------------------------------------- 


%Behavioral Model for volatile memristor
kpos = param(1); %Filament Growth
apos = param(2); %Filament Growth
tau = param(3); %Filament Decay
beta = param(4); %Filament Decay

D = 1;%Device Length;
xon = D; %Device is in LRS when state variable = D
xoff = 0; %Devive is in HRS when state variable = 0

vth = 1.744;
vhold = 1.5726; %|vhold| < |vth|

Ron = 30e3;
Roff = 15e11;

v = VA;

x = zeros(numel(time),1);
dxdt = zeros(numel(time),1);
i = zeros(numel(time),1);

for j=1:length(time)
    if(j==1)
        x(j) = IniState;
    else
        dt=time(j)-time(j-1);
        if(v(j)>=vth)
            % Internal Variable growth when applied voltage is greater than
            % threshold voltage
           dxdt(j)=(kpos*((v(j)/vth-1))^apos);
           x(j)=x(j-1)+dxdt(j)*dt;
           if(x(j)>xon) 
               x(j) = xon;
           end
           t_retrac = 0;
        elseif(v(j)<=vhold && x(j-1)>0)
            % Internal Variable retraction when applied voltage is less
            % than hold voltage
            dxdt(j)=-x(j-1)*beta*((t_retrac/tau)^(beta-1))/tau;
            t_retrac = t_retrac + dt;
            x(j) = x(j-1)+dxdt(j)*dt;
            if(x(j)<0)
                x(j) = 0;
            end
        else
            dxdt(j)=0;
            x(j) = x(j-1);
        end
    end
    % Electrical Characterization of the device
    i(j)=v(j)/(Ron + ((Roff-Ron)/(xoff-xon)*(x(j)-xon))); 
    if (i(j)>ic)
        i(j) = ic;
    end
end

end