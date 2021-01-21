#!/bin/bash
for i in 300 350 400 450 500 550 600 650 700
do  cat > INCAR << !
test encut
ISTART = 1
ICHARG = 1
ENCUT = $i eV
ISMEAR = 0 
SIGMA = 0.05
LWAVE = .FALSE
LCHARGE = .FALSE
!
mpirun -np 8 vasp
rm -f WAVECAR CHGCAR
echo "ENCUT = $i eV was performed above"
E= `grep "TOTEN" OUTCAR |awk '{print $5}'`
cputime= `grep "CPU" OUTCAR |awk '{print $6}'`
echo $i $E $cputime >> compare
done
