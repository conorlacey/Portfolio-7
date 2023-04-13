rm(list = ls())
setwd("/Users/conorlacey/Documents/Grad School/R Projects/Thesis Presentation")
library(tidyverse)
library(gganimate)
library(transformr)

# Graph Frames ------------------------------------------------------------
a <- seq(0, 2, length = 100)
b <- seq(1, .5, length = 100)

prior_post<- tibble(x = 0, y = 0, group = 0)
for (i in 1:100){
x<-seq(-4,4, length.out = 1e4)
y<-dnorm(x, a[i], b[i])
y<-y/max(y)*(.5)
dat <- tibble(x = x, y = y, group = i)
prior_post <- bind_rows(prior_post, dat)
}
prior_post <- prior_post[-1,]

prior_post %>% ggplot(aes(x=x, y=y)) + 
  geom_line(alpha=0.5, linewidth = 2, color = "#4169E1") +
  geom_vline(xintercept = 2) +
  #Animation
  labs (title = "Amount of Prior Knowledge = {frame_time}%",
        x = "dMACS",
        y = "Density") + 
  transition_time(group) + 
  ease_aes('linear')

# Graph Spike and Slab ----------------------------------------------------
a <- seq(0, 2, length = 100)
b <- seq(1, .5, length = 100)
c <- seq(.5,.4, length = 100)

prior_post_slab<- data.frame(x = 0, y = 0, group = 0)
for (i in 1:100){
  x<-seq(-4,4, length.out = 1e4)
  y<-dnorm(x, a[i], b[i])
  y<-y/max(y)*(c[i])
  dat <- tibble(x = x, y = y, group = i)
  prior_post_slab <- bind_rows(prior_post_slab, dat)
}
prior_post_slab <- prior_post_slab[-1,]

spike.x <- rep(0,200)
a <- seq(.5,.6, length =100)
group <- c(seq(1:100))

prior_post_spike <- data.frame(spike.y = 0, group = 0)
for (i in 1:100){
  b <- 0
  c <- a[i]
  dat <- data.frame(spike.y = c(b,c), group = i)
  prior_post_spike <- bind_rows(prior_post_spike, dat)
}
prior_post_spike <- prior_post_spike[-1,]
prior_post_spike <- bind_cols(spike.x = spike.x, prior_post_spike)


ggplot() + 
  geom_line(data = prior_post_slab,
            aes(x=x,y=y),alpha=0.5, 
            linewidth = 2, color = "#4169E1") +
  geom_line(data = prior_post_spike,
            aes(x = spike.x, y = spike.y), 
            alpha = 0.5, linewidth = 2, color = "red") +
  #Animation
  labs (title = "Amount of Prior Knowledge = {frame_time}%",
        x = "dMACS",
        y = "Density") + 
  transition_time(group) + 
  ease_aes('linear') 



