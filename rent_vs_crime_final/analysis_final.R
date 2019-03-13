library(dplyr)
library(tidyr)
library(ggplot2)
library(usmap)
library(tools)

# setwd("C:/Users/Matt/Documents/INFO2012/final_assignment/rent_vs_crime_final/")
crime_rates_county <- read.csv("data/crime_data_w_population_and_crime_rate.csv", stringsAsFactors = FALSE) 
rent_price <- read.csv("data/county_median_rental_price.csv", stringsAsFactors = FALSE)

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

# Creates crime data frame  
crime_rates_county <- crime_rates_county %>%
     select(county_name, crime_rate_per_100000, index, MURDER, RAPE, ROBBERY, AGASSLT, 
            BURGLRY, LARCENY, MVTHEFT, ARSON, population, FIPS_ST)

# attaches crime df to the rent df with the FIPS codes for plotting
crime_vs_rent <- left_join(rent_price, crime_rates_county, by = "county_name")

#--------------------------QUESTION 1-----------------------------#
# How do crime rates affect rental prices after 2016 in areas of high and low crime.

# Creates a data frame for the top 5 highest counties by crime rate for 2016
high_crimes <- crime_vs_rent %>%
  arrange(-crime_rate_per_100000) %>%
  head(n = 39) %>%
  select(year, RegionName, State, rent_value, crime_rate_per_100000)

# Creates a data frame for the lowest 5 counties by crime rate for 2016
low_crimes <- crime_vs_rent %>%
  arrange(crime_rate_per_100000) %>%
  head(n=35) %>%
  select(year, RegionName, State, rent_value, crime_rate_per_100000)

# I think for visualizations for Q1, we can simply display the two above data frames. Analysis can then be intertwined between these two displays
# If we want we can also create a graph for each data frame using ggplot, something like this in the server:
# p <- ggplot(data = high_crimes) +
# geom_point(mapping = aes(x = rent_value , y = crime_rate_per_100000, color = RegionName))

# and the same thing for low crimes. These two data frames are almost exactly the same in size and thus can be compared very easily. 
#-----------------------------------------------------------------#


#--------------------------QUESTION 2-----------------------------#
# What is the most common crime per each category of rent price? (for 2016)
mean_NA <- function(x) {
     if (all(is.na(x))) 
          x[NA_integer_] 
     else mean(x, na.rm = TRUE)
}

crime_vs_rent_2016 <- crime_vs_rent %>% 
     filter(year == 2016)
breaks <- c(0, 1000, 1500, 2000, 2500, Inf)
crime_vs_rent_2016 <- mutate(crime_vs_rent_2016, rent_category = cut(rent_value, 
               breaks, labels = c("$0 to $1000", "$1000 to $1500", "$1500 to $2000", "$2000 to $2500", "$2500+")))

# df great for a interactive plot (select the inputted crime)
crime_trends_vs_rent <- crime_vs_rent_2016 %>%
     group_by(rent_value) %>% 
     summarize(Murder = mean_NA(MURDER/population), Rape = mean_NA(RAPE/population), Robbery = mean_NA(ROBBERY/population),
               `Aggravated Assault` = mean_NA(AGASSLT/population), Burglary = mean_NA(BURGLRY/population), Larceny = mean_NA(LARCENY/population),
               `Car Theft` = mean_NA(MVTHEFT/population), Arson = mean_NA(ARSON/population)) 

ggplot(data = crime_trends_vs_rent) +
     geom_smooth(mapping = aes(x = rent_value, y = Murder)) +
     geom_point(mapping = aes(x = rent_value, y = Murder))
     
#-- below is the per category stuff --#
# methodology for finding the most popular crime:
#    -per each rent category (broken above), the average is taken for each crime
#    -the average and std dev is taken for each type of crime, and therefore z-scores are 
#         assigned for each rent_category/crime type
#    -based upon the z-scores, the most positively extraneous is chosen as the most popular,
#         which does not mean at all that this rent category has the highest rate of it, just
#         that this rent category has the most abnormal amount of this type of crime.

crime_per_category <- crime_vs_rent_2016 %>% 
     group_by(rent_category) %>% 
     summarize(ave_murder = mean_NA(MURDER/population), ave_rape = mean_NA(RAPE/population), ave_robbery = mean_NA(ROBBERY/population),
               ave_agrasslt = mean_NA(AGASSLT/population), ave_burg = mean_NA(BURGLRY/population), ave_larc = mean_NA(LARCENY/population),
               ave_gta = mean_NA(MVTHEFT/population), ave_arson = mean_NA(ARSON/population))

rearranged_crimes <- crime_per_category %>% 
     gather(key = crime, value = crime_by_pop, -rent_category) 
ave_crime <- rearranged_crimes %>%      
     group_by(crime) %>% 
     summarize(average = mean(crime_by_pop), stddev = sd(crime_by_pop))
fav_crime_by_rent <- left_join(rearranged_crimes, ave_crime, by = "crime") %>% 
     mutate(crime_diff = (crime_by_pop - average)/stddev) %>%
     group_by(rent_category) %>% 
     filter(crime_diff == max(crime_diff))

#-----------------------------------------------------------------#

# below is the county map for plotting stuff
# along with an example for plotting a map.
county_map <- map_data('county')
county_map <- county_map %>% 
     mutate(State = state.abb[match(toTitleCase(county_map$region), state.name)]) %>% 
     mutate(RegionName = paste(toTitleCase(county_map$subregion),"County"))

crime_vs_rent_map_2016 <- left_join(crime_vs_rent_2016, county_map, by = c("State", "RegionName"))

ggplot(data = crime_vs_rent_map_2016) +
     geom_polygon(aes(x = long, y = lat, group = group, fill = rent_category)) +
     scale_fill_manual(values=c("#b2182b", "#ef8a62", "#fddbc7", "#d1e5f0", "#67a9cf", "#2166ac")) +
     ggtitle("Percent Difference in Forest Levels (1992 - 2016)") +
     xlab("") +
     ylab("") +
     coord_quickmap()

