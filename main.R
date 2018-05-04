install.packages('devtools', repos='https://cloud.r-project.org')
options(unzip='internal') # for devtools::install_github
library(devtools)
devtools::install_github('r-lib/devtools')

stop() # comment to install local
devtools::install_local('remdat', upgrade_dependencies=FALSE)
# ripums, rgtd, etc