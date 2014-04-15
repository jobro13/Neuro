local neuron = {} 

function neuron.randw()
	-- returns a double -1 < w < 1
	return (1 - (math.random() * 2))
end

function neuron.sigmoid(input)
	return 1 / (1 + e^(-input))
end

function neuron:initialize(num_inputs)
	self.input = {{value = -1, weight = randw()}} -- bias init 
	-- an input object consists of:
	-- .value = double  --> the value of the input
	-- .weight = double --> the weight of the input
	if num_inputs then 
		for input_number = 1, num_inputs do 
			local new = {value = 1, weight = randw()}
			self:addinput(new)
		end
	end 
end 

function neuron:addinput(input)
	-- get to the second last 
	assert(input.value, "Input error: no value given")
	assert(input.weight, "Input error: no weight given")
	local num_inputs = #self.input 
	self[num_inputs + 1] = self[num_inputs]
	self_num[inputs] = input 
end 

function neuron:getsignal()
	local sum = 0 
	for n, input in pairs(self.input) do
		assert(input.value, "Input error: no value given")
		assert(input.weight, "Input error: no weight given")
		sum = sum + input.value * input.weight 
	end 
	return self:sigmoid(sum)
end

function neuro.new(num_inputs)

	-- self:initialize(num_inputs)
end 