# rdadmin
# <https://insideerdc.erdc.dren.mil/index.php?title=CIO_Standard_Operating_Procedures#Linux>
# mount <disk with agentPackages, redhat.sh, and unzip utility>
# mv <agentPackages, redhat.sh, and unzip utility to home>
# yum --nogpgcheck localinstall unzip<.arch.rpm>
# sudo -i
# mv <agentPackages, redhat.sh to root>
# sh install.sh -i
# sh redhat.sh
# quit

# add to .bash_profile
# export TERM=xterm-256color
# export TERMCAP=

# sudo -i # assume root
# system setup
yum install epel-release
yum install bzip2 gcc wget # need a system gcc for anaconda dependencies
yum install mdbtools # MS access database tools

# python (for anaconda)
yum install python-devel python-pip python-wheel
yum upgrade python-setuptools
pip install --upgrade pip
pip install pycosat PyYaml Requests
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
bash Miniconda2-latest-Linux-x86_64.sh
# if no to prepend anaconda:
# PATH="$PATH:~/miniconda2/bin"

# anaconda R, gdal, and linux dependencies
conda config --add channels conda-forge
# CRAN versions of sf and rpostgresql don't work with anaconda?
# NOTE: this is using system compilers; only way to use anaconda compilers is to write package?
conda install -y gcc_linux-64 gxx_linux-64 gfortran_linux-64
conda install -y "gdal>2.2.4" # -c conda-forge --override-channels installs python3 breaking conda
conda install -y R r-essentials r-sf r-rpostgresql r-rserve
conda install -y r-countrycode r-gdalUtils r-rgeos r-geosphere r-gstat r-raster r-sp # local deps
# not in conda: rnaturalearth tigris; see main.R
# mkdir ~/Desktop/tmp
# export TMPDIR=~/Desktop/tmp # if noexec causes trouble

# conda or it's version of R sets TAR=/bin/gtar; reset to /bin/tar if necessary
# export TAR=/bin/tar

# rgdal, sf, etc...
# R CMD INSTALL rgdal
# Note: Once R and conda are setup, you can use R's package manager for most things
#       (install.packages or R CMD INSTALL).
# Note: udunits2 didn't work from R's package manager, because it tries to find it in the system not
#       conda, but for cases like these conda has r-<package-name> for most r packages.  I prefer
#       R's manager, and use conda only when necessary.

# yum remove git # remove centos7 git
# git (source git necessary only for magit)
yum groupinstall "Development Tools"
yum install curl-devel gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel
wget https://github.com/git/git/archive/master.tar.gz -O git.tar.gz
	tar -zxf git.tar.gz
cd git-*
make configure
./configure --prefix=/usr/local
make install
# verify installation
which git
git --version

# emacs
sudo yum -y install libXpm-devel libjpeg-turbo-devel openjpeg-devel openjpeg2-devel turbojpeg-devel giflib-devel libtiff-devel gnutls-devel libxml2-devel GConf2-devel dbus-devel wxGTK-devel gtk3-devel
sudo yum install texinfo # makeinfo
sudo yum install libncurses-devel # missing from above (or ncurses-devel?)
wget http://git.savannah.gnu.org/cgit/emacs.git/snapshot/emacs-25.1.tar.gz
tar zxvf emacs-25.1.tar.gz
cd emacs-25.1
./autogen.sh
./configure # --without-makeinfo # if makeinfo is not available
sudo make install
# verify installation
which emacs
emacs --version
# emacs packages: auctex better-defaults ess magit smex yasnippet zenburn-theme

# postgres
# https://wiki.postgresql.org/wiki/YUM_Installation
# postgis[v]_[pgv]-devel for shp2pgsql raster2pgsql etc
# osm2pgsql 0.92 is in epel, or install recent from source at github
# if "no public key" error, invoke the following with 'XX' the version number:
# rpm --import http://yum.postgresql.org/RPM-GPG-KEY-PGDG-XX

# texlive
# sudo yum remove texlive* # remove centos texlive
yum install perl-Tk perl-Digest-MD5 # texlive dependencies
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
untar -vxzf install-tl*
cd install-tl*
./install-tl

# R packages
sudo yum install mpich
# parallel::makePSOCKCluster default port range
# sudo firewall-cmd --add-port=11000-11999/tcp

R CMD INSTALL --configure-args="
--with-Rmpi-include=/usr/include/mpich-x86_64
--with-Rmpi-libpath=/user/lib64/mpich/lib
--with-Rmpi-type=MPICH2"
Rmpi_0.6-7.tar.gz

R CMD INSTALL --configure-args="
--with-mpi-include=/usr/include/mpich-x86_64
--with-mpi-libpath=/user/lib64/mpich/lib
--with-mpi-type=MPICH2"
bigGP_0.1-6.tar.gz

# rstudio-server (https://www.rstudio.com/products/rstudio/download-server/)
wget https://download2.rstudio.org/rstudio-server-rhel-1.1.456-x86_64.rpm
sudo yum install rstudio-server-rhel-1.1.456-x86_64.rpm
sudo echo "rsession-which-r=/home/cmarmstrong/miniconda2/bin/R" >> /etc/rstudio/rserver.conf
sudo echo "rsession-ld-library-path=/home/cmarmstrong/miniconda2/lib" >> /etc/rstudio/rserver.conf
sudo firewall-cmd --add-port=8787/tcp

# TauDEM
# sudo yum install mpich
git clone git@github.com:dtarb/TauDEM.git
cd TauDEM
mkdir bin
cd src
make
# export MPIEXEC_PORT_RANGE=10100:10109
# sudo firewall-cmd --add-port=10100-10109/tcp

# R cluster ports
# sudo firewall-cmd --add-port=11000-11999/tcp
