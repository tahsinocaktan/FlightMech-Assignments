
function fmin = fuelcon_des(H)

cf3 = 17.549;
cf4 = 58991;
fmin = cf3 .* (1-H./cf4)

end