FROM rocker/rstudio:4.4.1

ENV LOCAL_DATABASE=/opt/database/tfregulome.sqlite

# replace with a latest or more stable link
# store file name in varibale to be carried through commands
RUN mkdir -p /opt/database && \
    wget -P /opt/database https://methmotif.org/API_TFregulomeR/downloads/TFregulomeR_database_2.3.zip && \
    unzip /opt/database/TFregulomeR_database_2.3.zip -d /opt/database && \
    rm /opt/database/TFregulomeR_database_2.3.zip && \
    mv /opt/database/TFregulomeR_database_2.3/* /opt/database/ && \
    rm -rf /opt/database/TFregulomeR_database_2.3

COPY src/rocker_scripts /rocker_scripts 
RUN /rocker_scripts/install_TFregulomeR.sh

EXPOSE 8787

CMD ["/init"]