function [ThrMaxJet_c, ThrMaxTurbo_c, ThrMaxPiston_c] = climbThrust(Hp, Vtas)

Ctc_1 = 2051.6; %from opf file 
Ctc_2 = 24368; %from opf file 
Ctc_3 = 64336; %from opf file 


ThrMaxJet_c = Ctc_1.*(1 - (Hp./Ctc_2) + Ctc_3 .* (Hp.^2));

ThrMaxTurbo_c = (Ctc_1./Vtas).*(1-(Hp./Ctc_2)) + Ctc_3;

ThrMaxPiston_c = (Ctc_1).*(1-(Hp./Ctc_2)) + Ctc_3./Vtas;


end

