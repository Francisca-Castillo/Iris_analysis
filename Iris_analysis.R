# Install and initialize packages
install.packages("tidyverse")
install.packages("GGally")
install.packages("sampling")
install.packages("plotly")
install.packages("tibble")
library(tidyverse)
library(GGally)
library(tidyr)
library(dplyr)
library(sampling)
library(plotly)
library(tibble)
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
clean.data <- iris %>% drop_na() %>% unique()
summary(clean.data)

## Aggregation
iris %>% group_by(Species) %>% summarize_all(mean)
iris %>% group_by(Species) %>% summarize_all(median)
iris %>% group_by(Species) %>% summarize_all(sd)


## Sampling
### Random sampling
sample(c("A", "B", "C"), size = 15, replace = TRUE)
take <- sample(seq(nrow(iris)), size = 20)
take

iris[take, ]

set.seed(1000)

s <- iris %>% slice_sample(n = 20)
ggpairs(s, aes(color = Species))

## Data visualization with ggplot
### PCA
plotly::plot_ly(iris, x = ~Sepal.Length, y = ~Petal.Length, z = ~Sepal.Width,
                size = ~Petal.Width, color = ~Species, type="scatter3d")
pc <- iris %>% select(-Species) %>% as.matrix() %>% prcomp() #perform pc analysis
summary(pc)

plot(pc, type = "line") # line graph from pc object

str(pc) # convert the value of 'pc' into a string

iris_projected <- as_tibble(pc$x) %>% add_column(Species = iris$Species)
ggplot(iris_projected, aes(x = PC1, y = PC2, color = Species)) + 
  geom_point() + ggtitle("PC Species") #plot pc1 and pc2

### Scatter plot
ggplot(iris, aes(Sepal.Length, Sepal.Width))+
  geom_point(aes(color=Species, shape=Species)) +
  xlab("Sepal Length") +
  ylab("Sepal Width") +
  ggtitle("Sepal Length-Width")

### Box plot
box <- ggplot(iris, aes(Species, Sepal.Length))
box + 
  geom_boxplot(aes(fill=Species)) +
  ylab("Sepal Length") +
  ggtitle("Iris Boxplot") +
  stat_summary(fun.y=mean, geom="point", shape=5, size=4)

### Histogram
histogram <- ggplot(iris, aes(Sepal.Width))
histogram +
  geom_histogram(binwidth=0.2, color="black", aes(fill=Species)) +
  xlab("Sepal Width") + 
  ylab("Frequency") + 
  ggtitle("Histogram of Sepal Width")

### Bar Plot
bar <- ggplot(iris, aes(Sepal.Width))

bar +
  geom_bar(aes(fill=Species)) + xlab("Species") + 
  ylab("Count") +
  ggtitle("Bar plot of Sepal Width") 

### Faceting
facet <- ggplot(iris, aes(Sepal.Length, Sepal.Width, color=Species)) +
  geom_point(aes(shape=Species), size=1.5) +
  xlab("Sepal Length") +
  ylab("Sepal Width") +
  ggtitle("Faceting") 

