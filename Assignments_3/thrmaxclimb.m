
function Thr_maxcl = thrmaxclimb(Hp, Vtas)

ctc1 = 12191000;        
ctc2 =28299;
ctc3 =55788;

Thr_maxcl = (ctc1./Vtas).*(1-Hp./ctc2) + ctc3;

end
