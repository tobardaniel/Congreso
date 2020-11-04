####################################################################################################
####################################### Librerías a utilizar #######################################

setwd('C:/Users/Daniel Tobar/Carpeta/Congreso Estudiantil/2020/Estadística/Asistencia/')
library("dplyr")  # Manejo de Data frames
library("stringr")

####################################################################################################
########################################## Importar datos ##########################################

dip<- read.csv("Registro_Diplomas_NoIns.csv", fileEncoding="utf-8")

print(dip)

####################################################################################################
######################################## Limpieza de datos #########################################

#quitamos entradas duplicadas

dip <- dip[!(duplicated(dip$Nombre.de.usuario)),]

# Nada más queremos nombres y correos de inscritos
nom<-c("Nombre.de.usuario", "Primer.nombre", "Otros.nombres", "Primer.apellido", "Segundo.apellido")
diplomas <- dip[ , names(dip) %in% nom]
#pasamos a minúsculas los correos y a Título los nombres y quitar los guiones

diplomas$Nombre.de.usuario <- tolower(diplomas$Nombre.de.usuario)
diplomas$Primer.nombre <- str_to_title(diplomas$Primer.nombre)
diplomas$Otros.nombres <- str_to_title(diplomas$Otros.nombres)
diplomas$Primer.apellido <- str_to_title(diplomas$Primer.apellido)
diplomas$Segundo.apellido <- str_to_title(diplomas$Segundo.apellido)
diplomas$Segundo.apellido <- gsub("- - - - -", "", diplomas$Segundo.apellido) 
diplomas <- diplomas[order(diplomas$Nombre.de.usuario),]

####################################################################################################
######################################## Análisis de datos #########################################




####################################################################################################
############################################ Resultados ############################################

write.csv(diplomas, "Diplomas2.csv", row.names = FALSE,  fileEncoding="utf-8")

####################################################################################################
###################################### Limpieza de variables #######################################

rm(dip)
rm(diplomas)
rm(nom)

####################################################################################################

