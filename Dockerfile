FROM rocker/r-ver:3.6.3

RUN apt-get update && apt-get install -y \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    xtail \
    wget

RUN apt-get install libfftw3-3 libfftw3-dev libtiff5-dev -y

RUN apt-get install libssl-dev -y

RUN apt-get update && apt-get install -y --no-install-recommends \
    libxml2-dev \
    zlib1g-dev \
    #libfftw3-dev \
    gdal-bin \
    libgdal-dev \
    libxt-dev 
    #libfftw3-3 \
    #libtiff5-dev


#RUN apt-get install libfftw3-3 libfftw3-dev libtiff5-dev


# Download and install shiny server
RUN wget --no-verbose https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    . /etc/environment && \
    R -e "install.packages(c('shiny', 'rmarkdown'), repos='$MRAN')" && \
    #R -e "devtools::install_github('filipematias23/FIELDimageR')" && \
    #cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/ && \
    cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/ && \
    chown shiny:shiny /var/lib/shiny-server

RUN install2.r --error \
    sp \
    raster \
    rgdal \
    scales \
    xml2 \
    git2r \
    usethis \
    fftwtools \
    devtools \
    shinydashboard \
    leaflet

RUN installGithub.r filipematias23/FIELDimageR

EXPOSE 3838

ADD shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]

