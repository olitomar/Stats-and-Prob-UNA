boxplot(loslagos$LBRAZO, main=" Titulo ", 
        xlab ="longitud en cm", ylab = " Etiqueta eje y ", 
        horizontal = T, sub="Fuente: Fuente ", las=1, col = "white")

boxplot(loslagos$LBRAZO~loslagos$ESTAFI, main=" Titulo ", 
        xlab ="longitud en cm", ylab = " Estado fisico ", 
        horizontal = T, sub="Fuente: Fuente ", las=1, col = "cyan")