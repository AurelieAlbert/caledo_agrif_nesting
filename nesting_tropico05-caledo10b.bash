#all the steps to create the nested files from TROPICO05 to CALEDO10

#Parameters

parent=TROPICO05
child=CALEDO10b
TMPDIR=/mnt/meom/workdir/alberta/CALEDO/NESTING_${parent}-${child}

echo "creating TMPDIR : $TMPDIR"
mkdir -p $TMPDIR

latmin=-28
latmax=-14
lonmin=161
lonmax=172

#TROPICO05 files

parent_coord=/mnt/meom/workdir/brodeau/TROPICO05/TROPICO05-I/coordinates_TROPICO05.nc
parent_mesh=/mnt/meom/workdir/brodeau/TROPICO05/TROPICO05-I/mesh_mask_TROPICO05_L31_trunk.nc
parent_bathy_meter=/mnt/meom/workdir/brodeau/TROPICO05/TROPICO05-I/bathy_meter_TROPICO05.nc
parent_domain=/mnt/meom/workdir/brodeau/TROPICO05/TROPICO05-I/domain_cfg_L31_trunk_TROPICO05.nc

echo "linking parent grid files"
ln -sf ${parent_coord} $TMPDIR/coordinates.nc
ln -sf ${parent_mesh} $TMPDIR/meshmask.nc
ln -sf ${parent_bathy_meter} $TMPDIR/bathy_meter.nc
ln -sf ${parent_domain} $TMPDIR/domain_cfg.nc


#High resolution bathymetry

bathy_hr=/mnt/meom/workdir/brodeau/data/bathy/Caledo_team/test_MNT.nc4
name_hr=Depth

echo "linking high resolution bathymetry"
ln -sf ${bathy_hr} $TMPDIR/bathy_hr.nc


#NESTING TOOLS executable

agrif_coord=/mnt/meom/workdir/alberta/NEMO/release-4.0/tools/NESTING/agrif_create_coordinates.exe
agrif_bathy=/mnt/meom/workdir/alberta/NEMO/release-4.0/tools/NESTING/agrif_create_bathy.exe
agrif_restart=/mnt/meom/workdir/alberta/NEMO/release-4.0/tools/NESTING/agrif_create_restart.exe


#Namelist

namelist=namelist_caledo10

echo "getting the coordinates of child grid within parent grid"          
cdffindij -w $lonmin $lonmax $latmin $latmax -c $parent_mesh > $TMPDIR/cdffindij-out.txt

imin=$(tail -2 $TMPDIR/cdffindij-out.txt | head -1 | awk '{print $1}')
imax=$(tail -2 $TMPDIR/cdffindij-out.txt | head -1 | awk '{print $2}')
jmin=$(tail -2 $TMPDIR/cdffindij-out.txt | head -1 | awk '{print $3}')
jmax=$(tail -2 $TMPDIR/cdffindij-out.txt | head -1 | awk '{print $4}')


factor_space=5
factor_time=5

ppkth=21.43336197938
ppacr=3.0
ppdzmin=0 #999999. 
pphmax=0 #999999. 
psur=-4762.96143546300
pa0=255.58049070440 
pa1=245.58132232490
N=31
ldbletanh=.false.
pa2=0 #999999.  
ppkth2=0 #999999.  
ppacr2=0 #999999.  

echo "prepping the namelist" 
cp /mnt/meom/workdir/alberta/NEMO/release-4.0/tools/NESTING/tmp_namelist $TMPDIR/$namelist


sed -i "s/NAMEHR/${name_hr}/g"           $TMPDIR/$namelist
sed -i "s/IMIN/$imin/g"                  $TMPDIR/$namelist
sed -i "s/IMAX/$imax/g"                  $TMPDIR/$namelist
sed -i "s/JMIN/$jmin/g"                  $TMPDIR/$namelist
sed -i "s/JMAX/$jmax/g"                  $TMPDIR/$namelist
sed -i "s/RHOT/$factor_time/g"           $TMPDIR/$namelist
sed -i "s/RHO/$factor_space/g"           $TMPDIR/$namelist
sed -i "s/PPKTH2/$ppkth2/g"              $TMPDIR/$namelist
sed -i "s/PPACR2/$ppacr2/g"              $TMPDIR/$namelist
sed -i "s/PPKTH/$ppkth/g"                $TMPDIR/$namelist
sed -i "s/PPACR/$ppacr/g"                $TMPDIR/$namelist
sed -i "s/PPDZMIN/$ppdzmin/g"            $TMPDIR/$namelist
sed -i "s/PPHMAX/$pphmax/g"              $TMPDIR/$namelist
sed -i "s/PSUR/$psur/g"                  $TMPDIR/$namelist
sed -i "s/PA0/$pa0/g"                    $TMPDIR/$namelist
sed -i "s/PA1/$pa1/g"                    $TMPDIR/$namelist
sed -i "s/NN/$N/g"                       $TMPDIR/$namelist
sed -i "s/LDBLETANH/$ldbletanh/g"        $TMPDIR/$namelist
sed -i "s/PA2/$pa2/g"                    $TMPDIR/$namelist

#Running nesting tools
echo "running the nesting tools" 
cd $TMPDIR

$agrif_coord $namelist
$agrif_bathy $namelist
