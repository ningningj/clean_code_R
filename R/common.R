# install (if necessary) and load commonly used libraries
packages <- c("dplyr", "tidyr", "stringr")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  cat(sprintf("Installing %s\n", setdiff(packages, rownames(installed.packages()))))
  install.packages(setdiff(packages, rownames(installed.packages())))  
}
library(dplyr)
library(tidyr)
library(stringr)
rm(packages)
