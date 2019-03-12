# Question 3: How do cities compare to the rest of the US in terms of crime? 
# cities --> high population county
library("dplyr")
library("maps")
source("analysis_final.R")

#visualization --> high population country
#use crime vs rent$ population to ge each crime per 100,000 people 
#out of all valid counties, get the average for each crime/ 100,000 people 
# mutate crime_vs_rent $ population to get each crime per 100,000 people 
# filter so that you only have high population regions ( or choose counties  which are know to contain larger cities)

# crimve_vs_population <- crime_vs_rent$population
# 
# crime_population <-crime_vs_rent %>%
#   mutate(
#     total_population = population,
#     crimerate_by_population = crime_rate_per_100000 * 100000 / population
#   ) %>%
#   group_by(RegionName) %>%
#   summarise(
#     average_amount_crime_per_population = mean(crime_rate_by_population)
#   )

crime_trends_population <- crime_vs_rent_2016 %>% 
  summarize(ave_murder = mean_NA(MURDER/population), ave_rape = mean_NA(RAPE/population), ave_robbery = mean_NA(ROBBERY/population),
            ave_agrasslt = mean_NA(AGASSLT/population), ave_burg = mean_NA(BURGLRY/population), ave_larc = mean_NA(LARCENY/population),
            ave_gta = mean_NA(MVTHEFT/population), ave_arson = mean_NA(ARSON/population)) 

  
  


  


