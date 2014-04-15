local genetics = {} 

genetics.settings = {
	-- How much cross overs happen
	cross_over_rate = 0.5,
	-- How much mutations happen
	mutation_rate = 0.1,
	-- The maximum mutex per mutation
	mutation_mutex_max = 0.3
}

genetics.__index = genetics

function genetics.crossover(mum_c, dad_c)
	local do_crossover = math.random() < genetics.settings.cross_over_rate 
	if not do_crossover or mum_c == dad_c then 
		return mum_c, dad_c 
	else 
		local len = #mum_c
		if len ~= #dad_c then 
			error("Weight lenght error, chromosome length not equal")
		else 
			local cross_over_point = math.random(2, len-1) -- No need to cross over at start or end 

			local function get(chromosome_1, chromosome_2)
				local out = {}
				for weight_number, weight in pairs(chromosome_1) do 
					if weight_number < cross_over_point then 
						out[weight_number] = chromosome_1[weight_number]
					else 
						out[weight_number] = chromosome_2[weight_number]
					end 
				end 
				return out 
			end 

			local new_mum_c = get(mum_c, dad_c)
			local new_dad_c = get(dad_c, mum_c)
			return new_mum_c, new_dad_c
		end 
	end 
end 

function genetics.mutate(chromosome)
	local new = {}
	for weight_number, weight in pairs(chromosome) do 
		if math.random() < genetics.settings.mutation_rate then 
			new[weight_number] = weight + genetics.settings.mutation_mutex_max * (1 - 2 *math.random())
		else 
			new[weight_number] = weight 
		end 
	end
	return new 
end 


function genetics.meiosis(mum_c, dad_c)
	local mum_c, dad_c = genetics.crossover(mum_c, dad_c)
	local mum_c, dad_c = genetics.mutate(mum_c), genetics.mutate(dad_c)

	return mum_c, dad_c
end

return genetics