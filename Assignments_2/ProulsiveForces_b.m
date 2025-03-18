% İniş itme kuvvetini hesapla (Bu değerler zaten descentThrust fonksiyonunda hesaplandığı için tekrar hesaplamaya gerek yok)
[ThrDes_jet, ThrDes_turbo, ThrDes_Piston] = descentThrust(ThrMaxJet_c, ThrMaxTurbo_c, ThrMaxPiston_c);

Hp_values = linspace(0, 17500, 200);


figure;
subplot(2,2,1); plot(Hp_values, ThrDes_jet, 'r');xlabel('Hp (ft)');ylabel('ThrDes jet (N)');
subplot(2,2,2); plot(Hp_values, ThrDes_turbo, 'r'); xlabel('Hp (ft)'); ylabel('ThrDes turbo (N)');
subplot(2,2,3); plot(Hp_values, ThrDes_Piston, 'r'); xlabel('Hp (ft)'); ylabel('ThrDes Piston (N)');



