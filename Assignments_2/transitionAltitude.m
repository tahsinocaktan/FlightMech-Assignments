function [H_trans] = transitionAltitude(theta)

T0 = 288.15; %Standard atmospheric temperature at MSL kelvin

H_trans = (1000/(0.3048*6.5)).*(T0.*(1-theta));


end



