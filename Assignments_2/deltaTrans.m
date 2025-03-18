function [delta] = deltaTrans(V_CAS,M)

k = 1.4; %Adiabatic index of air
a0 = 340.294; % Speed of sound at sea level in m/s

delta = ((1+((k-1)./2).*(V_CAS./a0).^2).^(k./(k-1)) - 1)/((1+ ((k-1)./2)*M.^2).^(k./(k-1)) - 1);

end

