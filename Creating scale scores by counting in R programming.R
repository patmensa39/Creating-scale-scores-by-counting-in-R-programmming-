#Creating scale scores by counting ####
### make sure to install all the required packages 
pacman::p_load(datasets, pacman, rio, tidyverse)

### importing the google search data 
data <- import("StateData.xlsx") %>% as_tibble()%>%
  select(state_code, museum : modernDance) %>% print()

### scaling by counting variables 
data <- data %>% mutate(
  artscount = 
    ifelse(museum > 1,1,0), +
    ifelse(scrapbook > 1,1,0) +
    ifelse(modernDance > 1,1,0))

### sorting the new variable
data %>% select(state_code, artscount, museum : modernDance) %>% 
  arrange(desc(artscount)) %>% print(n = Inf)


### Making a histogram of values 
data %>% pull(artscount) %>% hist(main = "Values of artcounts")


### creating categories using case_when 
data %<>% mutate(
  likearts = case_when(
    museum > 1 | scrapbook > 1 | modernDance > 1 ~ "Yes",
    TRUE ~ "no"
  )
) %>% 
  select(state_code, likearts, artscount, museum :modernDance) %>%
  arrange(desc(artscount)) %>% print(n = Inf)
