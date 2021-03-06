library(tidyverse)
library(cowplot)
library(GGally)
library(reshape2)
library(rlist)
library(ggcorrplot)
library(openssl)
library(plyr)
library(dplyr)
library(extrafont)
library(here)


ggplot_cus = function(element)
{
  #' basic ggplot configuration
  element %>% 
  ggplot() +
  theme_bw() +
  theme(text=element_text(family="Serif")) + 
  scale_shape_manual(values=c(19,3,4,5))
    
}

ggplot_scatter = function(element)
{
  
  #' basic ggplot scatter configuration
  element %>% 
    ggplot_cus() + 
    labs(x = "T(G)", y = "T(nDCG)", size = expression(P["v=0"])) 
}



import_df = function(file)
{
  #' Imports file, renames columns and creates new columns
  #' CURRENT VERSION
  df = read_rds(file)
  df = tibble(df)
  df = df %>% 
    mutate(relevance_gravity = factor(relevance_gravity))
  df$user_opinion_function = revalue(x = df$user_opinion_function, c("consensus" = "Konsens", "dissent" = "Dissens"),warn_missing = FALSE)
  df$vote_evaluation = revalue(x = df$vote_evaluation, c("vote_difference" = "Differenz" , "vote_partition" = "Anteil", "vote_wilson" = "Wilson Score"),warn_missing = FALSE)
  df$rating_metric = revalue(x = df$rating_metric, c("metric_activation" = "Aktivität","metric_hacker_news"="Verallg. Hacker News", "metric_view" = "View", "metric_reddit_hot" = "Reddit Hot"),warn_missing = FALSE)
  df$model_type = revalue(x = df$model_type, c("upvote_system" = 1, "up_and_downvote_system" = 2),warn_missing = FALSE)
  df$deviation_function = revalue(x = df$deviation_function, c("no_deviation" = "0", "mean_deviation" = "μ", "std_deviation" = "σ"),warn_missing = FALSE)
  df$relevance_gravity = revalue(x = df$relevance_gravity, c("0" = "Q&A", "2" = "News"), warn_missing = FALSE)
  df %>% 
    mutate(ρ = 0.5 -(area_under_ndcg/2 - area_under_gini/4 - posts_with_no_views/4)) %>% 
    mutate(seed = factor(seed)) %>% 
    mutate(model_id = factor(model_id)) %>% 
    mutate(init_score = factor(init_score)) %>% 
    mutate(relevance_gravity = factor(relevance_gravity)) %>% 
    mutate(gravity = factor(gravity)) %>% 
    mutate(steps = factor(steps)) %>% 
    mutate(concentration_distribution = factor(concentration_distribution)) %>% 
    mutate(rating_metric = factor(rating_metric)) %>% 
    mutate(user_opinion_function = factor(user_opinion_function)) %>% 
    # mutate(activity_distribution = factor(activity_distribution)) %>% 
    mutate(voting_probability_distribution = factor(voting_probability_distribution))
}

import_df_old = function(file)
{
  #' Imports file, renames columns and creates new columns
  #' OLD VERSION - USED IN THE BA WITH OLD NAMING
  df = read_rds(file)
  df = tibble(df)
  df = df %>% 
    mutate(relevance_gravity = factor(relevance_gravity))
  df$user_opinion_function = revalue(x = df$user_rating_function, c("user_rating_exp2" = "Konsens", "user_rating_dist2" = "Dissens"),warn_missing = FALSE)
  df$vote_evaluation = revalue(x = df$vote_evaluation, c("vote_difference" = "Differenz" , "vote_partition" = "Anteil", "wilson_score" = "Wilson Score"),warn_missing = FALSE)
  df$rating_metric = revalue(x = df$scoring_function, c("scoring_activation" = "Aktivität","scoring_hacker_news"="Verallg. Hacker News", "scoring_view" = "View", "scoring_reddit_hot" = "Reddit Hot"),warn_missing = FALSE)
  df$model_type = revalue(x = df$model_type, c("standard_model" = 1, "downvote_model" = 2),warn_missing = FALSE)
  df$deviation_function = revalue(x = df$deviation_function, c("no_deviation" = "0", "mean_deviation" = "μ", "std_deviation" = "σ"),warn_missing = FALSE)
  df$relevance_gravity = revalue(x = df$relevance_gravity, c("0" = "Q&A", "2" = "News"), warn_missing = FALSE)
  
  
  df %>% 
    # filter(user_opinion_function == "Konsens") %>% 
    mutate(ρ = 0.5 -(area_under_ndcg/2 - area_under_gini/4 - posts_with_no_views/4)) %>% 
    mutate(seed = factor(seed)) %>% 
    mutate(model_id = factor(model_id)) %>% 
    mutate(init_score = factor(init_score)) %>% 
    mutate(relevance_gravity = factor(relevance_gravity)) %>% 
    mutate(gravity = factor(gravity)) %>% 
    mutate(steps = factor(steps)) %>% 
    mutate(concentration_distribution = factor(concentration_distribution)) %>% 
    mutate(rating_metric = factor(rating_metric)) %>% 
    mutate(user_opinion_function = factor(user_opinion_function)) %>% 
    # mutate(activity_distribution = factor(activity_distribution)) %>% 
    mutate(voting_probability_distribution = factor(voting_probability_distribution)) %>% 
    select(-c("scoring_function", "user_rating_function"))
}

combine_dfs = function(path,name)
{
  #' combines multiple observation data files of the same model configuration to one tibble
  l = cust_filter(list.files(path, full.names = TRUE),function(x){grepl(name,x)})
  reduce(map(l,import_df), bind_rows)
}

combine_dfs_old = function(path,name)
{
  #' combines multiple observation data files of the same model configuration to one tibble
  #' OLD VERSION - USED IN THE BA WITH OLD NAMING
  l = cust_filter(list.files(path, full.names = TRUE),function(x){grepl(name,x)})
  reduce(map(l,import_df_old), bind_rows)
}


cust_filter <- function(x,func)
{
  ret = c()
  for (s in x)
  {
    if (func(s))
    {
      ret = append(ret, s)
    }
  }
  ret
}


corr_matrix = function(df, feature)
{
  #' creation of custom correaltion matrix
  df = df %>% 
    filter(user_opinion_function == "Konsens")
  matrix = tibble(.rows = nrow(df)/nrow(unique(df[,feature])))
  for (name in unlist(unique(df[,feature])))
  {
    tmp_df = df %>% 
      filter(!!sym(feature) == name)
   matrix = add_column(matrix, !!sym(toString(name)) := tmp_df[,"ρ"])
  }
  matrix
}
