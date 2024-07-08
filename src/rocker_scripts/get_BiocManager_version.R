# A method to export the current BiocManager version

version <- as.character(BiocManager::version())

fileConn<-file("biocmanager_version.txt")
writeLines(c(version), fileConn)
close(fileConn)