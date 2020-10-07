# caledo_agrif_nesting
 
## 06-10-2020

2 CALEDO10 targets (cf https://drive.google.com/drive/u/1/folders/1U61EuFd591yzrFNSV_EoIL87N_S5DYkU) :
  - CALEDO10a : 14.56°S-26.3°S x 161°E-172°E
  - CALEDO10b : 14°S-28°S x 161°E-172°E
  
pb dans nesting bathymetry => mettre logical ln_agrif_domain à false dans le fichier : ```/mnt/meom/workdir/alberta/NEMO/release-4.0/tools/NESTING/tmp_namelist```

## 15-09-2020
A script to gather all the steps needed for nesting TROPICO05 input files into CALEDO10 : https://github.com/AurelieAlbert/caledo_agrif_nesting/blob/master/nesting_tropico05-caledo10.bash

Some pre-requisite :
 - Nesting Tools are downloaded via ``` svn co http://forge.ipsl.jussieu.fr/nemo/svn/NEMO/releases/release-4.0/ ``` and compiled on cal1 with ``` ./maketools -m meom_ifort -n NESTING. ```
 - CDFTOOLS : https://github.com/meom-group/CDFTOOLS, already installed on cal1
 - TROPICO05 inputs : /mnt/meom/workdir/brodeau/TROPICO05/TROPICO05-I





