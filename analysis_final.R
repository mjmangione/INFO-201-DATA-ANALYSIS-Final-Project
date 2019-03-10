
library(dplyr)
library(tidyr)
library(ggplot2)
library(usmap)
library(tools)

setwd("C:/Users/Matt/Documents/INFO2012/final_assignment/")
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
#fips_codes <- readxl::read_xlsx("fips_codes.xlsx") 
#colnames(fips_codes) <- c("summary","state_code", "county_code", "ignore1", "ignore2", "ignore3", "RegionName")
#fips_codes <- fips_codes %>% 
#     mutate(fips = (paste0(state_code, county_code))) %>% 
#     select


#rent_w_fips <- left_join(rent_price, fips_codes, by = "RegionName")

# attaches crime df to the rent df with the FIPS codes for plotting
crime_vs_rent <- left_join(rent_price, crime_rates_county, by = "county_name")
#View(crime_vs_rent)

#--------------------------QUESTION 2-----------------------------#
# What is the most common crime per each category of rent price? (for 2016)

crime_vs_rent_2016 <- crime_vs_rent %>% 
     filter(year == 2016)
breaks <- c(0, 1000, 1500, 2000, 2500, Inf)
crime_vs_rent_2016 <- mutate(crime_vs_rent_2016, rent_category = cut(rent_value, 
               breaks, labels = c("$0 to $1000", "$1000 to $1500", "$1500 to $2000", "$2000 to $2500", "$2500+")))
View(crime_vs_rent_2016)
#-----------------------------------------------------------------#

# below is the county map for plotting stuff
# along with an example for plotting a map.
county_map <- map_data('county')
county_map <- county_map %>% 
     mutate(State = state.abb[match(toTitleCase(county_map$region), state.name)]) %>% 
     mutate(RegionName = paste(toTitleCase(county_map$subregion),"County"))
View(county_map)
crime_vs_rent_map_2016 <- left_join(crime_vs_rent_2016, county_map, by = c("State", "RegionName"))
View(crime_vs_rent_map_2016)

ggplot(data = crime_vs_rent_map_2016) +
     geom_polygon(aes(x = long, y = lat, group = group, fill = rent_category)) +
     scale_fill_manual(values=c("#b2182b", "#ef8a62", "#fddbc7", "#d1e5f0", "#67a9cf", "#2166ac")) +
     ggtitle("Percent Difference in Forest Levels (1992 - 2016)") +
     xlab("") +
     ylab("") +
     coord_quickmap()

