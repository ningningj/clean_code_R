### ohiprep/src/R/fao_fxn.R
### Function(s) to help clean and manipulate FAO data.
###
### Provenance:
###   Apr2015: created by Casey O'Hara (oharac)


fao_clean_data <- function(fao_data, sub_0_0 = 0.1) {
  ### Swaps out FAO-specific codes for OHI-specific interpretations.
  fao_cleaned <- fao_data %>%
    mutate(  
      value = str_replace(value, fixed( ' F'),    ''),
      ### FAO denotes with F when they have estimated the value using best available data; drop flag
      value = ifelse(value == '...', NA, value), 
      ### FAO's code for NA; swap it out for NA
      value = str_replace(value, fixed('0 0'), sub_0_0),  
      ### FAO denotes something as '0 0' when it is > 0 but < 1/2 of a unit. 
      ### Replace with sub_0_0 value.
      value = str_replace(value, fixed(  '-'),   '0'),  
      ### FAO's code for true 0; swap it out
      value = ifelse(value =='', NA, value)) %>%
    mutate(
      value = as.numeric(as.character(value)),
      ### convert value and year strings to numbers
      year  = as.integer(as.character(year)))       
  ### search in R_inferno.pdf for "shame on you" - factors!
  
  # print(head(fao_cleaned))
  return(fao_cleaned)
}
