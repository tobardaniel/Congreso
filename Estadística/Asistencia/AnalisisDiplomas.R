####################################################################################################
####################################### Librerías a utilizar #######################################

setwd('C:/Users/Daniel Tobar/Carpeta/Congreso Estudiantil/2020/Estadística/Asistencia/')
#install.packages("dplyr")
#install.packages("xlsx")
library("xlsx")
library("dplyr")        # Manejo de Data frames

####################################################################################################
########################################## Importar datos ##########################################

aprobados<-read.xlsx("Asistencia_Aceptados.xlsx", sheetIndex = 1)
inscrip<- read.csv("Inscripcion_Congreso.csv", fileEncoding="utf-8")

 

####################################################################################################
######################################## Limpieza de datos #########################################

# La frecuencia de los aprobados no es necesaria
borrar <- c("Freq")
ap <- aprobados[ , !(names(aprobados) %in% borrar)]
# Nada más queremos nombres y correos de inscritos
nom<-c("Nombre.de.usuario", "Primer.nombre", "Otros.nombres", "Primer.apellido", "Otros.apellidos")
ins <- inscrip[ , names(inscrip) %in% nom]

####################################################################################################
######################################## Análisis de datos #########################################

#Queremos los que estaban inscritos y tienen la asistencia mínima
print(length(ap))
ins_dip<- ins[(!duplicated(ins$Nombre.de.usuario)) & (ins$Nombre.de.usuario %in% ap) ,]
print(nrow(ins_dip))
vect <- ap
vect <- !(ap%in%ins_dip$Nombre.de.usuario)
noins_dip <- aprobados[vect,]

####################################################################################################
############################################ Resultados ############################################

write.csv(ins_dip, "Diplomas.csv", row.names = FALSE, , fileEncoding="utf-8")
write.csv(noins_dip, "DiplomasNoIns.csv", row.names = FALSE, , fileEncoding="utf-8")

####################################################################################################
###################################### Limpieza de variables #######################################



####################################################################################################

