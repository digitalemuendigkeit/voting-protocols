using Dates

function scoring(post, time, model)
    (post.votes)^1 / (time - post.timestamp + 1)^(0.3)
end

function scoring_custom(post,time,model)
    (post.votes+1)^model.votes_exp / (time - post.timestamp + 1)^model.time_exp
end

function scoring_hacker_news(post, time, model)
    (post.votes - 1)^8 / (time - post.timestamp + 1)^1.8
end

epoch = DateTime(1970,1,1)
start_time = DateTime(2020,06,20)

function scoring_reddit_hot(post, time, model)
    seconds = Dates.value(start_time - epoch)/1000 - 1134028003 + post.timestamp * 60 * 30 # 60 Sekunden pro 30 Minuten!!
    order = log(10, max(abs(post.votes-post.downvotes),1))
    round(sign(post.votes)*order + seconds/45000; digits=7)
end

function scoring_reddit_best(post,time,model)
    confidence = 0.95
    if n == 0
        return 0
    end
    z = Statistics.quantile(Normal(), 1-(1-confidence)/2)
    n = post.votes + post.downvotes
    phat = 1.0*post.votes/n
    (phat + z*z/(2*n) - z * sqrt(phat*(1- phat) + z*z/(4*n)/n)) / (1 + (z*z)/n)
end


function scoring_random(post, time, model)
    rand()
end

function scoring_best(post, time, model)
    model.user_rating_function(post.quality, ones(model.quality_dimensions))
end

function scoring_worst(post, time, model)
    - scoring_best(post, time,model)
end


function scoring_activation(post, time,model)
    (post.votes - post.score) / (time -post.timestamp + 1)^(model.time_exp)
end

function scoring_votes_divided_score(post, time, model)
    (post.votes)/(post.score+1) / (time - post.timestamp + 1)^(model.time_exp)
end

function scoring_votes_times_score(post, time, model)
    post.votes * (post.score + 1) / (time- post.timestamp + 1)^(model.time_exp)
end
