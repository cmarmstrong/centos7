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
# setupw
yum install epel-release
yum install bzip2 gcc wget # need a system gcc for anaconda dependencies
yum install python-devel python-pip python-wheel
yum upgrade python-setuptools

# python
pip install --upgrade pip
pip install pycosat PyYaml Requests
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
bash Miniconda2-latest-Linux-x86_64.sh
# if no to prepend anaconda:
# PATH="$PATH:~/miniconda2/bin"

# anaconda R, gdal, and linux dependencies
conda config --add channels conda-forge
# CRAN versions of sf and rpostgresql don't work with anaconda?
# NOTE: this is using system compilers; need to activate root environment?
conda install gcc_linux-64 gxx_linux-64 gfortran_linux-64 gdal R r-essentials r-sf r-rpostgresql r-rserve
# mkdir ~/Desktop/tmp
# export TMPDIR=~/Desktop/tmp # if noexec causes trouble

# rgdal, sf, etc...
# R CMD INSTALL rgdal
# Note: Once R and conda are setup, you can use R's package manager for most things (install.packages or R CMD INSTALL).
#       udunits2 didn't work from R's package manager, because it tries to find it in the system not conda,
#       but for cases like these conda has r-<package-name> for most r packages.  I prefer R's manager, and use conda only
#       when necessary.

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
