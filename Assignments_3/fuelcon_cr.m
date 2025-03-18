
function fcr = fuelcon_cr(H)

Vtas = Vnom_cr(H);
cl = (2*58960*9.80665)./(1.225.*(Vtas.^2).*162.12);
D = ((0.043394 + 0.040047.*(cl.^2)).*(1.225).*(Vtas.^2).*(162.12))./2000; %drag calculation in KN
cf1 = 4.5325;
cf2 = 503.61;
cfcr = 1.0274;

thr = D; %thrust is equal to drag in cruise phase
n = cf1.*(1-(Vtas./cf2)).*(Vtas./1000);
fcr = n .* thr .* cfcr;

end