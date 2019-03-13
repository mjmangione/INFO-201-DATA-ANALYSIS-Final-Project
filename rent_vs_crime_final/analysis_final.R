library(dplyr)
library(tidyr)
library(ggplot2)
library(usmap)
library(tools)

#<<<<<<< HEAD

#=======
#>>>>>>> e198e33cf7257fbc81dad7e5920f26ba2a886532
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
               Aggravated_Assault = mean_NA(AGASSLT/population), Burglary = mean_NA(BURGLRY/population), Larceny = mean_NA(LARCENY/population),
               Car_Theft = mean_NA(MVTHEFT/population), Arson = mean_NA(ARSON/population)) 

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
     summarize(Murder = mean_NA(MURDER/population), Rape = mean_NA(RAPE/population), Robbery = mean_NA(ROBBERY/population),
               Aggravated_Assault = mean_NA(AGASSLT/population), Burglary = mean_NA(BURGLRY/population), Larceny = mean_NA(LARCENY/population),
               `Car Theft` = mean_NA(MVTHEFT/population), Arson = mean_NA(ARSON/population)) 

rearranged_crimes <- crime_per_category %>% 
     gather(key = crime, value = crime_by_pop, -rent_category) 
ave_crime <- rearranged_crimes %>%      
     group_by(crime) %>% 
     summarize(average = mean(crime_by_pop), stddev = sd(crime_by_pop))
fav_crime_by_rent <- left_join(rearranged_crimes, ave_crime, by = "crime") %>% 
     mutate(crime_diff = (crime_by_pop - average)/stddev) %>%
     group_by(rent_category) %>% 
     filter(crime_diff == max(crime_diff)) %>% 
     select(Rent = rent_category, `Most Popular Crime` = crime) %>% 
     arrange(Rent)

#---------------------------QUESTION 3------------------------------------#
#How do cities compare to the rest of the US in terms of crime?

#Creates a data frame analyzing highly populated counties and low populated counties
colnames(crime_vs_rent)[8:15] <- c("Murder","Rape", "Robbery", "Aggravated_Assault", "Burglary", "Larceny", "Car_Theft", "Arson")
population_vs_crime <- crime_vs_rent %>%
  mutate(
    high_population = (population > 1500000),
    low_population = (population < 1500000),
    total_crime = Murder + Rape + Robbery + Aggravated_Assault + Burglary + Larceny + Car_Theft + Arson) %>%
 gather(type_of_crime, frequency, Murder:Arson) %>%
  select(-rent_value) %>% 
  filter(year == "2016")

#Used for table in shiny, if total crime column is used when the data frame is gathered it looks weird and 
#doesn't align right
population_vs_types__of_crime <- population_vs_crime %>%
  select(-total_crime)

#filters out duplicates of counties and I can find the range of population 
population <- crime_vs_rent %>% 
  filter(year == "2016")

population_range <- range(population$population, na.rm = TRUE)

crime_rate_per_100000_range <- range(population$crime_rate_per_100000, na.rm = TRUE)
 



#find the top 5 populated counties 
top_counties <- crime_vs_rent %>%
  select(-rent_value) %>%
  mutate(
    total_crime =Murder + Rape + Robbery + Aggravated_Assault + Burglary + Larceny + Car_Theft + Arson) %>%
    filter( year == "2016")%>%
  gather(
    type_of_crime, amount_of_crime, Murder:Arson
  ) %>%
  group_by(RegionName)%>%
  arrange(desc(population))%>%
  head(40)

top_counties_stats <- top_counties %>%
  group_by(year) %>%
  summarise(
    Average_crime_rates_per_1000000 = mean_NA(crime_rate_per_100000),
    Median_crime_rates_per_1000000 = median(crime_rate_per_100000)
  )

#finds the top 5 lowest populated counties 
bottom_counties <- crime_vs_rent %>%
  select(-rent_value) %>%
  mutate(
    total_crime =Murder + Rape + Robbery + Aggravated_Assault + Burglary + Larceny + Car_Theft + Arson) %>%
  filter( year == "2016")%>%
  gather(
    type_of_crime, amount_of_crime, Murder:Arson
  ) %>%
  filter(population == min(population)) %>%
  arrange(population) %>%
  head(40) 

#Used this to write Analysis
bottom_5_stats <- bottom_counties %>%
  group_by(year) %>%
  summarise(
    Average_crime_rate = mean_NA(crime_rate_per_100000),
    Median_crime_rate = median(crime_rate_per_100000)
  )
  
  
#ggplot for Top 5 highly populated counties 
top_5 <- ggplot(top_counties) +
  geom_col(
    mapping = aes(x= county_name, y = amount_of_crime,  fill= type_of_crime)
  )  +
    theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
  xlab("County Names") +
  ylab("Total Crime") +
  guides(fill=guide_legend(title="Type Of Crime")) +
  ggtitle("Top 5 Highly Populated Counties") 

top_5

# ggplot(data = top_counties) +
# geom_point(mapping = aes(x= population, y = total_crime, color = county_name))+
# 
# ggplot(data = bottom_counties) +
#   geom_point(mapping = aes( x = population, y = total_crime, color = county_name))


  
#ggplot for Top 5 low populated counties 
bottom_5 <- ggplot(bottom_counties) +
  geom_col(
    mapping = aes(x= county_name, y = amount_of_crime,  fill= type_of_crime)
  )  +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
  xlab("County Names") +
  ylab("Total Crime") +
  guides(fill=guide_legend(title="Type Of Crime")) +
  ggtitle("Lowest 5 Populated Counties")

bottom_5



  
