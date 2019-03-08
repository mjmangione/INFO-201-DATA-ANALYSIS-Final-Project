library(dplyr)
library(ggplot2)
library(usmap)

setwd("C:/Users/Matt/Documents/INFO2012/final_assignment")
crime_rates_county <- read.csv("crime_data_w_population_and_crime_rate.csv", stringsAsFactors = FALSE) 
rent_price <- read.csv("county_median_rental_price.csv", stringsAsFactors = FALSE)
View(rent_price)
rent_price <- rent_price %>%
     select(-Metro, -StateCodeFIPS, -MunicipalCodeFIPS, -SizeRank) %>% 
     mutate(county_name = (paste0(RegionName, ", ", State)))
colnames(rent_price) <- lapplysubstr(1,5)
# Creates a viewable sample of the crime dataframe with the first 5 rows. 
crime_rates_county <- crime_rates_county %>%
     select(county_name, crime_rate_per_100000, index, MURDER, RAPE, ROBBERY, AGASSLT, 
            BURGLRY, LARCENY, MVTHEFT, ARSON, population, FIPS_ST)

fips_codes <- readxl::read_xlsx("fips_codes.xlsx") 
colnames(fips_codes) <- c("summary","state_code", "county_code", "ignore1", "ignore2", "ignore3", "RegionName")
fips_codes <- fips_codes %>% 
     mutate(fips = (paste0(state_code, county_code))) %>% 
     select(RegionName, fips)

     
rent_w_fips <- left_join(rent_price, fips_codes, by = "RegionName")
crime_vs_rent_2016 <- left_join(rent_w_fips, crime_rates_county, by = "county_name")
rent_2016 <- select(crime_vs_rent_2016, fips, X2016.08)
View(crime_vs_rent_2016)
plot_usmap(regions = "counties", data = rent_2016, values = "X2016.08") + 
     labs(title = "US Counties", subtitle = "This is a blank map of the counties of the United States.") + 
     theme(panel.background = element_rect(colour = "black", fill = "lightblue"))


