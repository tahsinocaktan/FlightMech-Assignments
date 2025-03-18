function [ThrDes_jet, ThrDes_turbo, ThrDes_Piston] = descentThrust(ThrMaxJet_c, ThrMaxTurbo_c, ThrMaxPiston_c)

Ctdes_low = 0.20136; %from .opf file
Ctdes_high = 0.31659; %from .opf file

Hp_des = 8000; %m/s
Hp_values = linspace(0, 17500, 200); %m/s

ThrDes_jet = zeros(1, 200);
ThrDes_turbo = zeros(1, 200);
ThrDes_Piston = zeros(1, 200);



    for i = 1:200
         
        if (Hp_values(i) > Hp_des)
    
            ThrDes_jet(i) = Ctdes_high * ThrMaxJet_c(i);
            ThrDes_turbo(i) = Ctdes_high * ThrMaxTurbo_c(i);
            ThrDes_Piston(i) = Ctdes_high * ThrMaxPiston_c(i);
    
        elseif (Hp_values(i) <= Hp_des)
            
            ThrDes_jet(i) = Ctdes_low * ThrMaxJet_c(i);
            ThrDes_turbo(i) = Ctdes_low * ThrMaxTurbo_c(i);
            ThrDes_Piston(i) = Ctdes_low * ThrMaxPiston_c(i);  
            
        end
    end
end


