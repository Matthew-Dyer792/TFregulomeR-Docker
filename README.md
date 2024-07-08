## TFregulomeR Docker Environment
This repository contains Docker configurations and scripts for building RStudio images with pre-installed TFregulomeR and forkedTF R packages. These images are extended from the Rocker project images.
Repository Structure
The repository is organized into three main folders:

1. `builds`: Contains Dockerfiles for building RStudio images with TFregulomeR and forkedTF.
2. `database`: An empty folder where users can download the TFregulomeR local database mirror.
3. `src`: Contains modified installation scripts from Rocker that are copied into the Docker image and run during the build process.

## Setting up the TFregulomeR Database
To download the TFregulomeR local database mirror, run the following commands:
```bash
wget -P database https://methmotif.org/API_TFregulomeR/downloads/TFregulomeR_database_2.3.zip
unzip database/TFregulomeR_database_2.3.zip -d database
rm database/TFregulomeR_database_2.3.zip
```

## Building or Pulling the Docker Image
You can either build the Docker image locally or pull it from Docker Hub.

### Building the Image
To build the Docker image locally:
```bash
sudo docker build --no-cache . -t benoukraflab/tfregulomer:2.3.3 -f builds/TFregulomeR_rstudio_local_db.Dockerfile
```

Pulling the Image
To pull the pre-built Docker image from Docker Hub:
```bash
docker pull benoukraflab/tfregulomer
```
[https://hub.docker.com/r/benoukraflab/tfregulomer](https://hub.docker.com/r/benoukraflab/tfregulomer)

## Running the Docker Image
To start a container using the TFregulomeR Docker image:
```
sudo docker run --rm -ti -e PASSWORD=1234 -p 8787:8787 --mount type=bind,src=/home/USERNAME/projects,target=/home/rstudio/Projects benoukraflab/tfregulomer:2.3.3
```
This command will start an RStudio server with TFregulomeR and forkedTF pre-installed.

The Rstudio instance exists at [localhost:8787/](http://localhost:8787/)

- Username: rstudio
- Password: 1234

## ENV Variable
LOCAL_DATABASE=/opt/database/tfregulome.sqlite

## Additional Information
The relevant webpages for the key software is included below: 

- [TFregulomeR](https://github.com/benoukraflab/TFregulomeR) GitHub
- [forkedTF](https://github.com/benoukraflab/forkedTF) GitHub
- [database](https://methmotif.org/API_TFregulomeR/downloads/) repo

## License
GPL-3.0 license