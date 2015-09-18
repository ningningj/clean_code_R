### messy_code.R
### Examples from OHI FAO Commodities data_prep.R
library(dplyr)
library(tidyr)
library(stringr)
dir_g<-'~/github/clean_code_R'
dir_d<-file.path(dir_g,'data')
setwd(dir_g)
for (f in list.files(file.path(dir_d,'raw'),pattern=glob2rx('*.csv'),full.names=T)) { 
  # f=list.files(file.path(dir_d,'raw'),pattern=glob2rx('*.csv'),full.names=T)[1]
  cat(sprintf('\n\n\n====\nfile: %s\n',basename(f)))
  d<-read.csv(f,check.names=F,strip.white=TRUE,stringsAsFactors=F)
  units<-c('tonnes','usd')[str_detect(f,c('quant','value'))]
  suppressWarnings({
    m<-d %>% rename(country=`Country (Country)`,commodity=`Commodity (Commodity)`,trade=`Trade flow (Trade flow)`) %>%
      gather(year,value,-country,-commodity,-trade)
  })
  m<-m %>% filter(!country %in% c('Totals','Yugoslavia SFR')) %>%
    mutate(value= str_replace(value, fixed(' F'),''),
           value=ifelse(value=='...',NA,value), 
           value=str_replace(value,fixed('0 0'),0.1),
           value=str_replace(value,fixed('-'),'0'),
           value=ifelse(value=='',NA,value)) %>%
    mutate(value=as.numeric(as.character(value)),
           year=as.integer(as.character(year))) %>%
    select(-trade) %>% arrange(country,commodity,is.na(value),year)
  c2p<-read.csv(file.path(dir_g,'R/commodities2products.csv'),na.strings='')
  m<-m %>% inner_join(c2p,by='commodity')
  stopifnot(sum(c('Bonaire','Saba','Sint Maarten','Sint Eustatius')%in%m$country)==0)
  m_ant<-m %>% filter(country=='Netherlands Antilles') %>%
    mutate(value=value/4,
      'Bonaire'=value,
      'Saba'=value,
      'Sint Maarten'=value,
      'Sint Eustatius'=value) %>%
    select(-value,-country) %>%
    gather(country,value,-commodity,-product,-year) %>%
    mutate(country=as.character(country))
  m<-m %>%
    filter(country!='Netherlands Antilles') %>%
    bind_rows(m_ant)
  names(m)[names(m)=='value']<-units  
  h<-sprintf('%s/%s.csv',dir_d,units)
  write.csv(m,h,row.names=FALSE,na='')
}


