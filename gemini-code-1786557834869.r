# 1. Cargar librerías necesarias
if(!require(openxlsx)) install.packages("openxlsx")
library(openxlsx)

# Fijar semilla para garantizar reproducibilidad
set.seed(2026)

# 2. Tamaño de la muestra
n <- 100

# 3. Generación de variables cualitativas
TipoEntorno <- sample(c("BD", "WebAPI", "Batch"), size = n, replace = TRUE, prob = c(0.3, 0.5, 0.2))
ProveedorCloud <- sample(c("AWS", "Azure", "GCP", "OnPremise"), size = n, replace = TRUE, prob = c(0.4, 0.3, 0.2, 0.1))
NivelCarga <- sample(c("Bajo", "Medio", "Alto"), size = n, replace = TRUE, prob = c(0.25, 0.50, 0.25))

# 4. Generación de variables cuantitativas dependientes del entorno/carga para dar coherencia
UsoCPU <- round(pmin(pmax(rnorm(n, mean = ifelse(NivelCarga == "Alto", 85, ifelse(NivelCarga == "Medio", 55, 25)), sd = 12), 5), 99.9), 1)

ContenedoresActivos <- round(pmax(rpois(n, lambda = ifelse(TipoEntorno == "Batch", 18, ifelse(TipoEntorno == "WebAPI", 10, 4))), 1))

UsoRAM <- round(pmin(pmax(rnorm(n, mean = ifelse(TipoEntorno == "BD", 48, ifelse(TipoEntorno == "WebAPI", 24, 16)), sd = 6), 4), 64), 1)

AnchoBanda <- round(pmax(rnorm(n, mean = ifelse(TipoEntorno == "WebAPI", 750, 250), sd = 100), 10), 1)

Latencia <- round(pmax(exp(2 + 0.03 * UsoCPU + rnorm(n, mean = 0, sd = 0.3)), 5), 1)

TasaErrores <- round(pmin(pmax(rgamma(n, shape = 1.5, scale = ifelse(UsoCPU > 80, 2.5, 0.4)), 0), 15), 2)

TiempoUpTime <- sample(1:365, size = n, replace = TRUE)

# 5. Variable categórica derivada del rendimiento (EstadoServidor)
EstadoServidor <- ifelse(UsoCPU > 85 | TasaErrores > 5.0 | Latencia > 200, "Crítico",
                  ifelse(UsoCPU > 65 | TasaErrores > 1.5 | Latencia > 100, "Degradado", "Óptimo"))

# 6. Crear Data Frame
df_servidores <- data.frame(
  ID_Nodo = paste0("NODE-", sprintf("%03d", 1:n)),
  TipoEntorno = TipoEntorno,
  ProveedorCloud = ProveedorCloud,
  NivelCarga = NivelCarga,
  EstadoServidor = EstadoServidor,
  UsoCPU = UsoCPU,
  ContenedoresActivos = ContenedoresActivos,
  UsoRAM = UsoRAM,
  AnchoBanda = AnchoBanda,
  Latencia = Latencia,
  TasaErrores = TasaErrores,
  TiempoUpTime = TiempoUpTime
)

# 7. Guardar los datos en formato Excel
write.xlsx(df_servidores, file = "BaseDatosServidores.xlsx", overwrite = TRUE)

cat("¡Archivo 'BaseDatosServidores.xlsx' generado con éxito con 100 registros!\n")