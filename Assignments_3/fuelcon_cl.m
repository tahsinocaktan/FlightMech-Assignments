
function fnom = fuelcon_cl(H)

Vtas = Vnom_cl(H);
Thr = (thrmaxclimb(H, Vtas))./1000; %unit is converted to KN
cf1 = 4.5325;
cf2 = 503.61;
n = cf1.*(1-(Vtas./cf2)).*(Vtas./1000);
fnom = n .* Thr;

end