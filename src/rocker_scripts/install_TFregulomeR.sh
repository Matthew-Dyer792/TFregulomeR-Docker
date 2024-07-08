#!/bin/bash

## Install TFregulomeR from github.

set -e

## build ARGs
NCPUS=${NCPUS:--1}

# a function to install apt packages only if they are not installed
function apt_install() {
    if ! dpkg -s "$@" >/dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            apt-get update
        fi
        apt-get install -y --no-install-recommends "$@"
    fi
}

apt_install \
    libxml2-dev \
    libcairo2-dev \
    libgit2-dev \
    default-libmysqlclient-dev \
    libpq-dev \
    libsasl2-dev \
    libsqlite3-dev \
    libssh2-1-dev \
    libxtst6 \
    libcurl4-openssl-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    unixodbc-dev \
    libbz2-dev \
    libgsl-dev \
    libxext6

install2.r --error --skipinstalled -n "$NCPUS" \
    remotes \
    BiocManager \
    dplyr \
    jsonlite \
    RSQLite \
    ggplot2 \
    ggseqlogo \
    gridExtra \
    gridGraphics \
    curl \
    gplots \
    cowplot \
    plotly \
    crosstalk \
    DT

Rscript --vanilla /rocker_scripts/get_BiocManager_version.R
BIOC_VERSION=$(cat biocmanager_version.txt)

R -e "BiocManager::install(\"GenomicRanges\", ask = F, version=\"$BIOC_VERSION\")"
R -e "BiocManager::install(\"TxDb.Hsapiens.UCSC.hg19.knownGene\", ask = F, version=\"$BIOC_VERSION\")"
R -e "BiocManager::install(\"TxDb.Hsapiens.UCSC.hg38.knownGene\", ask = F, version=\"$BIOC_VERSION\")"
R -e "BiocManager::install(\"rGREAT\", ask = F, version=\"$BIOC_VERSION\")"
R -e "BiocManager::install(\"TxDb.Mmusculus.UCSC.mm9.knownGene\", ask = F, version=\"$BIOC_VERSION\")"
R -e "BiocManager::install(\"TxDb.Mmusculus.UCSC.mm10.knownGene\", ask = F, version=\"$BIOC_VERSION\")"
R -e "BiocManager::install(\"TFBSTools\", ask = F, version=\"$BIOC_VERSION\")"

installGithub.r \
    benoukraflab/TFregulomeR

installGithub.r \
    benoukraflab/forkedTF

# Clean up
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/downloaded_packages

## Strip binary installed lybraries from RSPM
## https://github.com/rocker-org/rocker-versioned2/issues/340
strip /usr/local/lib/R/site-library/*/libs/*.so

# Check the R devtools package
echo -e "Check the R installation...\n"

R -q -e "library(GenomicRanges)"
R -q -e "library(TFregulomeR)"
R -q -e "library(rGREAT)"
R -q -e "library(forkedTF)"
R -q -e "library(TFBSTools)"

echo -e "\n R TFregulomeR installed, done!"