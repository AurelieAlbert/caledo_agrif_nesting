#all the steps to create the nested files from TROPICO05 to CALEDO10

# imports
import os

#NESTING TOOLS executable

agrif_coord='/mnt/meom/workdir/alberta/NEMO/release-4.0/tools/NESTING/agrif_create_coordinates.exe'
agrif_bathy='/mnt/meom/workdir/alberta/NEMO/release-4.0/tools/NESTING/agrif_create_bathy.exe'
agrif_restart='/mnt/meom/workdir/alberta/NEMO/release-4.0/tools/NESTING/agrif_create_restart.exe'


#TROPICO05 files

parent_coord='/mnt/meom/workdir/brodeau/TROPICO05/v1_TROPICO05-I/coordinates_TROPICO05.nc'
parent_mesh='/mnt/meom/workdir/brodeau/TROPICO05/v1_TROPICO05-I/mesh_mask_TROPICO05_L31_r4.0.3.nc'
parent_bathy_meter='/mnt/meom/workdir/brodeau/TROPICO05/v1_TROPICO05-I/bathy_meter_TROPICO05.nc'
parent_bathy_level='/mnt/meom/workdir/brodeau/TROPICO05/v1_TROPICO05-I/mesh_mask_TROPICO05_L31_r4.0.3.nc'

#High resolution bathymetry

bathy_hr='/mnt/meom/workdir/brodeau/data/bathy/Caledo_team/test_MNT.nc4'

#Namelist

namelist='/mnt/meom/workdir/alberta/NEMO/release-4.0/tools/NESTING/namelist_caledo10'

#Nesting param
latmin=-26.6
latmax=-16.6
lonmin=161.6
lonmax=172
        
          
os.system('cdffindij -w '+str(lonmin)+' '+str(lonmax)+' '+str(latmin)+ ' '+str(latmax)+' -c '+str(parent_mesh)+' > /mnt/meom/workdir/alberta/tmp/out.txt')
if os.path.exists('/mnt/meom/workdir/alberta/tmp/out.txt'):
	with open('/mnt/meom/workdir/alberta/tmp/out.txt','r') as txt_file:
		last_line = txt_file.readlines()[-2]

imin=os.system('tail -2 /mnt/meom/workdir/alberta/tmp/tmp.out | head -1 | awk "{print $1}" > /mnt/meom/workdir/alberta/tmp/')
imax=
jmin=
jmax=
rho=
rhot=




