####################################################################################################
####################################### Librerías a utilizar #######################################

setwd('C:/Users/Daniel Tobar/Carpeta/Congreso Estudiantil/2020/Estadística/Asistencia/')
library("xlsx")
library("dplyr")        # Manejo de Data frames

####################################################################################################
########################################## Importar datos ##########################################

aprobados<-read.xlsx("Asistencia_Aceptados.xlsx", sheetIndex = 1)
inscrip<- read.csv("Inscripcion_Congreso.csv", fileEncoding="utf-8")
 

####################################################################################################
######################################## Limpieza de datos #########################################
#No nos importa la frecuencia pues ya están aceptados
aprobados <- tolower(aprobados$`Dirección de correo electrónico`)
print(aprobados)
# Nada más queremos nombres y correos de inscritos
nom<-c("Nombre.de.usuario", "Primer.nombre", "Otros.nombres", "Primer.apellido", "Otros.apellidos")
ins <- inscrip[ , names(inscrip) %in% nom]

####################################################################################################
######################################## Análisis de datos #########################################

#Queremos los que estaban inscritos y tienen la asistencia mínima
ins_dip<- ins[(!duplicated(ins$Nombre.de.usuario)) & (ins$Nombre.de.usuario %in% aprobados) ,]
ins_dip<- ins_dip[order(ins_dip$Nombre.de.usuario),] #ordena por correo
print(ins_dip)
vect <- aprobados
vect <- !(aprobados%in%ins_dip$Nombre.de.usuario) #determina quiénes asistieron pero no estaban inscritos
noins_dip <- aprobados[vect]

####################################################################################################
############################################ Resultados ############################################

#write.csv(ins_dip, "Diplomas.csv", row.names = FALSE,  fileEncoding="utf-8")
#write.csv(noins_dip, "DiplomasNoIns.csv", row.names = FALSE,  fileEncoding="utf-8")

####################################################################################################
###################################### Limpieza de variables #######################################
rm(ins)
rm(ins_dip)
rm(aprobados)
rm(noins_dip)
rm(vect)
rm(inscrip)
rm(nom)


####################################################################################################

