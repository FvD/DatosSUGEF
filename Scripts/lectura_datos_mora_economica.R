library(tidyverse)
library(lubridate)
library(stringr)


# Script para descargar y limpiar datos de SUGEF --------------------------

# Función para leer los archivos txt
read_files <- function(file, path, colnames, coltypes) {
  readr::read_tsv(paste(path, file, sep = "/"), col_names = colnames,
    locale = locale(encoding = "iso-8859-1", decimal_mark = "."), 
    col_types = coltypes, skip = 1)
}

path <- "Datos/Cartera por actividad y mora"
files <- dir(path)
colnames <- c("sector", "actividad", "entidad_per", "cred_ad", "cred_30",
              "cred_60", "cred_90", "cred_180", "cred_mas", "cred_cj",
              "cred_tot")
coltypes <- paste(c(rep("c", 3), rep("d", 8), "-"), collapse = "")

datos <- lapply(files, read_files, path, colnames, coltypes) %>% bind_rows()

datos <- datos %>%
  mutate(
    sector = str_to_title(sector),
    actividad = gsub("[A-Za-z]-", "", actividad),
    fecha = dmy(paste0("01/", str_extract(entidad_per, "\\d{2}/\\d{4}"))),
    entidad = gsub("\\s\\d{2}/\\d{4}|\\s\\-\\s.*", "", entidad_per)
  ) %>% select(-entidad_per)

glimpse(datos)
summary(datos)
