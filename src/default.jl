
"""
Default iteration evaluation functions
"""
default_model_properties = [
    dcg,
    ndcg,
    gini,
]

"""
Default model evaluation functions
"""
default_evaluation_functions = [
    @area_under(:ndcg),
    @area_under(:gini),
    posts_with_no_views,
    @model_property_function(:activity_distribution),
    @model_property_function(:concentration_distribution),
    @model_property_function(:init_score),
    @model_property_function(:new_posts_per_step),
    @model_property_function(:model_id),
    @model_property_function(:model_type),
    @model_property_function(:quality_dimensions),
    @model_property_function(:quality_distribution),
    @model_property_function(:rating_metric),
    @model_property_function(:seed),
    @model_property_function(:sorted),
    @model_property_function(:start_posts),
    @model_property_function(:start_users),
    @model_property_function(:steps),
    @model_property_function(:gravity),
    @model_property_function(:relevance_gravity),
    @model_property_function(:user),
    @model_property_function(:user_opinion_function),
    @model_property_function(:voting_probability_distribution),
    @model_property_function(:deviation_function),
    @model_property_function(:vote_evaluation),
    @model_df_column(:gini),
    @model_df_column(:dcg),
    @model_df_column(:ndcg),
]

sort!(default_evaluation_functions, by = x -> string(x))

"""
default models for evaluation
"""

default_models = [
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_hacker_news,
            :init_score => 50,
            :vote_evaluation => vote_difference,
            :deviation_function => no_deviation,
            :gravity => 0,
            :relevance_gravity => 0,
            :user_opinion_function => consensus,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_hacker_news,
            :init_score => 50,
            :vote_evaluation => vote_difference,
            :deviation_function => mean_deviation,
            :gravity => 2,
            :relevance_gravity => 2,
            :user_opinion_function => consensus,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_hacker_news,
            :init_score => 50,
            :vote_evaluation => vote_difference,
            :deviation_function => mean_deviation,
            :gravity => 2,
            :relevance_gravity => 0,
            :user_opinion_function => dissent,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_hacker_news,
            :init_score => 50,
            :vote_evaluation => vote_difference,
            :deviation_function => mean_deviation,
            :gravity => 2,
            :relevance_gravity => 2,
            :user_opinion_function => dissent,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_view,
            :init_score => 20,
            :vote_evaluation => vote_difference,
            :deviation_function => mean_deviation,
            :gravity => 0,
            :relevance_gravity => 0,
            :user_opinion_function => consensus,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_view,
            :init_score => 30,
            :vote_evaluation => vote_wilson,
            :deviation_function => mean_deviation,
            :gravity => 2,
            :relevance_gravity => 2,
            :user_opinion_function => consensus,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_view,
            :init_score => 30,
            :vote_evaluation => vote_wilson,
            :deviation_function => mean_deviation,
            :gravity => 2,
            :relevance_gravity => 0,
            :user_opinion_function => dissent,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_view,
            :init_score => 30,
            :vote_evaluation => vote_wilson,
            :deviation_function => mean_deviation,
            :gravity => 2,
            :relevance_gravity => 2,
            :user_opinion_function => dissent,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_activation,
            :init_score => 10,
            :vote_evaluation => vote_difference,
            :deviation_function => no_deviation,
            :gravity => 2,
            :relevance_gravity => 0,
            :user_opinion_function => consensus,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_activation,
            :init_score => 30,
            :vote_evaluation => vote_difference,
            :deviation_function => mean_deviation,
            :gravity => 2,
            :relevance_gravity => 2,
            :user_opinion_function => consensus,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_activation,
            :init_score => 30,
            :vote_evaluation => vote_difference,
            :deviation_function => mean_deviation,
            :gravity => 2,
            :relevance_gravity => 0,
            :user_opinion_function => dissent,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_activation,
            :init_score => 30,
            :vote_evaluation => vote_difference,
            :deviation_function => mean_deviation,
            :gravity => 2,
            :relevance_gravity => 2,
            :user_opinion_function => dissent,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_reddit_hot,
            :init_score => 30000,
            :vote_evaluation => vote_difference,
            :deviation_function => no_deviation,
            :relevance_gravity => 0,
            :user_opinion_function => consensus,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_reddit_hot,
            :init_score => 30000,
            :vote_evaluation => vote_difference,
            :deviation_function => mean_deviation,
            :relevance_gravity => 2,
            :user_opinion_function => consensus,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_reddit_hot,
            :init_score => 30000,
            :vote_evaluation => vote_difference,
            :deviation_function => mean_deviation,
            :relevance_gravity => 0,
            :user_opinion_function => dissent,
        ),
    ),
    (
        up_and_downvote_system,
        Dict(
            :rating_metric => metric_reddit_hot,
            :init_score => 30000,
            :vote_evaluation => vote_difference,
            :deviation_function => mean_deviation,
            :relevance_gravity => 2,
            :user_opinion_function => dissent,
        )
    )
]
