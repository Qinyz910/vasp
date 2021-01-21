#!/bin/bash

vaspkit -task 303

cat > INCAR-scf <<!
SYSTEM = ThS2 
ISTART = 0 
NWRITE = 2 
PREC = Accurate 
ENCUT = 600 
GGA = PE 
NSW = 0 
ISIF = 2 
ISYM = 2 
NBLOCK = 1 
KBLOCK = 1 
IBRION = -1 
NELM = 80 
EDIFF = 1E-05 
EDIFFG = -0.01 
ALGO = Normal 
LDIAG = .TRUE. 
LREAL = .FALSE. 
ISMEAR = 0 
SIGMA = 0.02 
ICHARG = 2 
LPLANE = .TRUE. 
NPAR = 4 
LSCALU = .FALSE. 
NSIM = 4 
LWAVE = .TRUE. 
LCHARG = .TRUE. 
ICORELEVEL = 1
!

cat > INCAR-band <<!
SYSTEM = ThS2 
ISTART = 1 
NWRITE = 2 
PREC = Accurate
ENCUT = 600 
GGA = PE 
NSW = 0 
ISIF = 2 
ISYM = 2 
NBLOCK = 1 
KBLOCK = 1 
IBRION = -1 
NELM = 80 
EDIFF = 1E-05 
EDIFFG = -0.01 
ALGO = Normal 
LDIAG = .TRUE. 
LREAL = .FALSE. 
ISMEAR = 0 
SIGMA = 0.02 
ICHARG = 11 
LPLANE = .TRUE. 
NPAR = 4 
LSCALU = .FALSE. 
NSIM = 4 
LWAVE = .FALSE. 
LCHARG = .FALSE. 
ICORELEVEL = 1 
LORBIT = 11
!

cp INCAR-scf INCAR
echo "scf"; time mpirun -np 8 vasp
rm INCAR


cp KPATH.in KPOINTS
cp INCAR-band INCAR
echo "band"; time mpirun -np 8 vasp

vaspkit -task 211