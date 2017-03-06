# -*- coding: utf-8 -*-
"""
Created on Sun Mar  5 13:27:27 2017

@author: Rafael Castrillo

Robot para descargar datos históricos
"""
import time
from selenium import webdriver
from selenium.webdriver.support.ui import Select

fechas = [str(x).zfill(2) + "/" + str(y) for x in range(1,13) 
    for y in range(2010, 2017)]

browser = webdriver.Chrome("C:/Users/Rafael Castrillo/Documents/chromedriver.exe")

url = 'https://www.sugef.fi.cr/servicios/reportes/Actividad_Atraso.aspx'
browser.get(url)

inicial = "ctl00_MainContentPlaceHolder_FiltroReportesUserControl1_PeriodoInicialDropDownList"
final = "ctl00_MainContentPlaceHolder_FiltroReportesUserControl1_PeriodoFinalDropDownList"
input = "ctl00_MainContentPlaceHolder_FiltroReportesUserControl1_TextoSimpleExportButton"

for fecha in fechas:

    select_ini = Select(browser.find_element_by_id(inicial))
    select_fin = Select(browser.find_element_by_id(final))
    select_ini.select_by_visible_text(fecha)
    select_fin.select_by_visible_text(fecha)
    
    browser.find_element_by_id(input).click()
    
    time.sleep(15)
    
browser.close()

browser.quit()
