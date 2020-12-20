library(here)


df_full_model = combine_dfs_old(here::here("data_BA"), "model_full")

grouped_full_model = df_full_model %>% 
  mutate(rating_metric = factor(rating_metric)) %>%
  group_by(rating_metric, init_score, deviation_function, vote_evaluation,gravity, relevance_gravity, user_opinion_function, model_type) %>% 
  dplyr::summarise(area_under_gini = mean(area_under_gini), area_under_ndcg = mean(area_under_ndcg), posts_with_no_views = mean(posts_with_no_views),ρ = mean(ρ), n = n()) 


df_deviation = combine_dfs_old(here::here("data_BA"),"deviation") %>% 
  mutate(quality_dimensions = factor(quality_dimensions)) %>% 
  filter(user_opinion_function == "Konsens")


grouped_deviation = df_deviation %>% 
  mutate(rating_metric = factor(rating_metric)) %>%
  #group_by(rating_metric, init_score, deviation_function, vote_evaluation, gravity)
  group_by(rating_metric, init_score, deviation_function, vote_evaluation,gravity, relevance_gravity, user_opinion_function, model_type) %>% 
  dplyr::summarise(area_under_gini = mean(area_under_gini), area_under_ndcg = mean(area_under_ndcg), posts_with_no_views = mean(posts_with_no_views),ρ = mean(ρ), n = n()) 


df_concentration = combine_dfs_old(here::here("data_BA"),"concentration") %>% 
  filter(user_opinion_function == "Konsens")

df_userprob = combine_dfs_old(here::here("data_BA"),"activity_voting") %>% 
  filter(user_opinion_function == "Konsens")

df_userprob$voting_probability_distribution = revalue(x = df_userprob$voting_probability_distribution, c("Distributions.Beta{Float64}(α=2.5, β=5.0)" = "Beta(2.5,5)", "Distributions.Beta{Float64}(α=1.0, β=5.0)" = "Beta(1,5)", "Distributions.Beta{Float64}(α=1.0, β=10.0)" = "Beta(1,10)","Distributions.Beta{Float64}(α=2.5, β=10.0)" = "Beta(2.5,10)"))

df_userprob$activity_distribution = revalue(x = df_userprob$activity_distribution,c("Distributions.Beta{Float64}(α=2.5, β=5.0)" = "Beta(2.5,5)", "Distributions.Beta{Float64}(α=1.0, β=5.0)" = "Beta(1,5)", "Distributions.Beta{Float64}(α=1.0, β=10.0)" = "Beta(1,10)","Distributions.Beta{Float64}(α=2.5, β=10.0)" = "Beta(2.5,10)"))

df_start_posts = combine_dfs_old(here::here("data_BA"),"start_post")

df_start_users = combine_dfs_old(here::here("data_BA"),"start_user") %>% 
  filter(user_opinion_function == "Konsens")

df_posts_per_step = combine_dfs_old(here::here("data_BA"),"posts_per_step") %>% 
  filter(user_opinion_function == "Konsens")


df_init = combine_dfs_old(here::here("data_BA","data_init_score"),"specified")

df_gravity = combine_dfs_old(here::here("data_BA","data_gravity"),"model") %>% 
  mutate(quality_dimensions = factor(quality_dimensions)) %>% 
  filter(user_opinion_function == "Konsens")

df_steps = combine_dfs_old(here::here("data_BA"),"step")


df_dims = combine_dfs_old(here::here("data_BA"),"dimensions") %>% 
  mutate(quality_dimensions = factor(quality_dimensions))

