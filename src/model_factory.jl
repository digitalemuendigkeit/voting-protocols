function grid_params(model_params)
        models = []
        function rec(rest_keys, values,dic,model)
                if isempty(rest_keys)
                        push!(models, model => values)
                        return
                end
                next_key = rest_keys[1]
                new_rest_keys = filter(x -> x != next_key, rest_keys)
                vals = dic[next_key]
                if typeof(vals) <: Vector
                        for i in 1:length(vals)
                                new_values = vcat(values, next_key => vals[i])
                                rec(new_rest_keys,new_values, dic,model)
                        end
                else
                        new_values = vcat(values, next_key => vals)
                        rec(new_rest_keys,new_values, dic,model)
                end

        end

        for model in model_params
                rec(collect(keys(model[2])), [], model[2],model[1])
        end
        return models
end


create_models(model_params) = map(x -> x[1](;x[2]...),grid_params(model_params))

get_params(model_params) = map( x -> x[2], grid_params(model_params))



function param_count(param)
        if typeof(param) <: Vector
                length(param)
        else
                1
        end
end

function model_count(model_params)
        sum(map(x -> reduce(*,map(param_count,collect(values(x)))), map(x -> x[2], model_params)))
end
