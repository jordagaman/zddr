FROM  rocker/verse

WORKDIR /home/rstudio
COPY . zddr
WORKDIR /home/rstudio/zddr

RUN install2.r --error --skipinstalled pryr languageserver

RUN Rscript -e 'library(devtools); build(vignettes = FALSE); install(upgrade = FALSE)'