# Install and initialize packages
install.packages("tidyverse")
install.packages("GGally")
library(tidyverse)
library(GGally)
renv::snapshot()

# Loading and exploring data
data(iris)
iris <- as_tibble(iris)
iris
summary(iris)
print (iris, n = 6, widht = Inf)

# Data Manipulation

## Data Quality
iris %>% summarize_if(is.numeric, mean)

ggpairs(iris, aes(color = Species))
