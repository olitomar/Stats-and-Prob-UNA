if(!require("readxl")){
  install.packages("readxl")
  library("readxl")
}

loslagos <- read_excel("loslagos.xlsx")
head(loslagos)
str(loslagos)

median(loslagos$ESTATURA[loslagos$ESTAFI==1])
mean(loslagos$ESTATURA[loslagos$ESTAFI==1])
median(loslagos$ESTATURA[loslagos$ESTAFI==2])
mean(loslagos$ESTATURA[loslagos$ESTAFI==2])
median(loslagos$ESTATURA[loslagos$ESTAFI==3])
mean(loslagos$ESTATURA[loslagos$ESTAFI==3])

Tabla.abs <- table(loslagos$ESTATURA)
Tabla.abs
Tabla.rel <- prop.table(loslagos$ESTATURA)
Tabla.rel

hist(loslagos$LBRAZO, breaks=4, freq = T, main = "Titulo",
     cex.main=0.9,
     xlab="Etiqueta X", ylab="Etiqueta y ",
     col="red",
     border="blue")

install.packages("modeest")
library("modeest")

mfv(loslagos$LBRAZO)
mean(loslagos$LBRAZO)
IQR(loslagos$LBRAZO)

grupos_lbrazo <- cut(loslagos$LBRAZO, breaks = 4, include.lowest = TRUE, right = FALSE)
grupos_lbrazo

clases <- as.vector(table(grupos_lbrazo))
frec_absoluta <- as.vector(table(grupos_lbrazo))
frec_porcentual <- as.vector(table(grupos_lbrazo))
nombre1<-c("Clase 1", "Clase 2","Clase 3 ", "Clase 4")

tablad <- data.frame(
  Variable = nombre1, 
  clases
  #frec_absoluta,
  #frec_porcentual
)
colnames(tablad)=c("Frec Abs","Frec Porc")

#formato a las tablas
if(!require("flextable")){
  install.packages("flextable")
  library("flextable")
}

tabla<-flextable::align(flextable(tablad),align="center",part = "all")
tabla<-set_caption(tabla, "Cuadro :")
tabla <- add_footer_lines(tabla, "Fuente: ")
tabla <- color(tabla, part ="all", color ="gray21")
tabla <- color(tabla, part ="header", color ="gray14")
tabla <- color(tabla, part ="footer", color ="black")
tabla