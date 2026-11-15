#mi primer grafico

if(!require("readxl")){
install.packages("readxl")
library("readxl")
}

datos1<- read_excel("basedatos.xlsx")

tablagrafico1<-prop.table(table(datos1$Frecuenciadeuso))
tablagrafico1<-round(100*tablagrafico1,2) #En porcentaje y redondeando

#rownames(tablagrafico1)<-c("",)

sectores<-pie(tablagrafico1, #tabla de frecuencias porcentuales
              labels=paste(tablagrafico1,"%"),#las etiquetas para los sectores
              col=rainbow(length(tablagrafico1)), # o c("red","Green" ) asignar colores
              main="Gráfico N°1.
Porcentaje de estudiantes según Frecuencia
de uso de la IA. Universidad Nacional, Heredia.
I ciclo 2025.",
              #font.main=1, #tipo de letra al título
              cex.main=0.8, #tamaño de letra al titulo
              cex.sub=0.7,cex=0.9,
              sub = "Fuente: Departamento de Bienestar Estudiantil.")
legend("topright", c("Diario", "Mensual", "Rara vez", "Semanal"), cex = 0.6, fill = rainbow(length(tablagrafico1)))