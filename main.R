install.packages('devtools', repos='https://cloud.r-project.org')
options(unzip='internal') # for devtools::install_github
library(devtools)
devtools::install_github('r-lib/devtools')

## stop() # comment to install others
install.packages(c('rnaturalearth', 'tigris'))
BiocInstaller::bioclite(c('aroma.light'))
devtools::install_local('rv', dependencies=FALSE)
devtools::install_local('raccess', dependencies=FALSE)
devtools::install_local('rlandscan', dependencies=FALSE)
devtools::install_local('rsoils', dependencies=FALSE)
devtools::install_local('rspam', dependencies=FALSE)
devtools::install_local('rvisnav', dependencies=FALSE)
devtools::install_local('rworldclim', dependencies=FALSE)
devtools::install_local('remdat', dependencies=FALSE)
devtools::install_local('rgtd', dependencies=FALSE)
devtools::install_local('rnino', dependencies=FALSE)
devtools::install_local('ripums', dependencies=FALSE)
