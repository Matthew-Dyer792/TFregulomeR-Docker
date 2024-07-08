FROM rocker/rstudio:4.4.0

# LABEL org.opencontainers.image.licenses="GPL-2.0-or-later" \
#       org.opencontainers.image.source="https://github.com/rocker-org/rocker-versioned2" \
#       org.opencontainers.image.vendor="Rocker Project" \
#       org.opencontainers.image.authors="Carl Boettiger <cboettig@ropensci.org>"

ENV LOCAL_DATABASE=/opt/database/tfregulome.sqlite

RUN mkdir /opt/database
COPY database/TFregulomeR_database_2.3 /opt/database

COPY src/rocker_scripts /rocker_scripts 
RUN /rocker_scripts/install_TFregulomeR_full_base.sh

EXPOSE 8787

CMD ["/init"]