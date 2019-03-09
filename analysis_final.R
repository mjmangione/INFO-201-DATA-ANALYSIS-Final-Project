library(dplyr)
library(tidyr)
library(ggplot2)
library(usmap)

crime_rates_county <- read.csv("crime_data_w_population_and_crime_rate.csv", stringsAsFactors = FALSE) 
rent_price <- read.csv("county_median_rental_price.csv", stringsAsFactors = FALSE)

#organizes/gathers yearly rent prices
rent_price <- rent_price %>%
     select(-Metro, -StateCodeFIPS, -MunicipalCodeFIPS, -SizeRank) %>% 
     mutate(county_name = (paste0(RegionName, ", ", State))) %>% 
     gather(key = "year", value = "rent", -RegionName, -State, -county_name) 
rent_price$year <- substr(rent_price$year, 2, 5)
rent_price <- rent_price %>% 
     filter(!is.na(rent)) %>% 
     group_by(year, RegionName, State, county_name) %>% 
     summarize(rent_value = median(rent))
View(rent_price)

# Creates crime data frame  
crime_rates_county <- crime_rates_county %>%
     select(county_name, crime_rate_per_100000, index, MURDER, RAPE, ROBBERY, AGASSLT, 
            BURGLRY, LARCENY, MVTHEFT, ARSON, population, FIPS_ST)

# attaches FIPS codes to the rental info
fips_codes <- readxl::read_xlsx("fips_codes.xlsx") 
colnames(fips_codes) <- c("summary","state_code", "county_code", "ignore1", "ignore2", "ignore3", "RegionName")
fips_codes <- fips_codes %>% 
     mutate(fips = (paste0(state_code, county_code))) %>% 
     select(RegionName, fips)
rent_w_fips <- left_join(rent_price, fips_codes, by = "RegionName")

# attaches crime df to the rent df with the FIPS codes for plotting
crime_vs_rent <- left_join(rent_w_fips, crime_rates_county, by = "county_name")
View(crime_vs_rent)

#--------------------------QUESTION 1-----------------------------#
# What is the most common crime per each category of rent price? (for 2016)

crime_vs_rent <- crime_vs_rent %>% 
     filter(year ==)

#-----------------------------------------------------------------#

# for plotting based off counties // NOT COMPLETE // USES OLD VARIABLES 
View(crime_vs_rent_2016)
plot_usmap(regions = "counties", data = rent_2016, values = "X2016.08") + 
     labs(title = "US Counties", subtitle = "This is a blank map of the counties of the United States.") + 
     theme(panel.background = element_rect(colour = "black", fill = "lightblue"))


