local neuron = {} 

neuron.initialize = function(self)
	self.input = {{value = math.random(), weight = -1}} -- bias init 
	-- an input object consists of:
	-- .value = double  --> the value of the input
	-- .weight = double --> the weight of the input
end 

function neuron.addinput(self, input)
	-- get to the second last 
	assert(input.value, "Input error: no value given")
	assert(input.weight, "Input error: no weight given")
	local num_inputs = #self.input 
	self[num_inputs + 1] = self[num_inputs]
	self_num[inputs] = input 
end 

neuron.getsignal = function(self)
	local sum = 0 
	for n, input in pairs(self.input) do
		assert(input.value, "Input error: no value given")
		assert(input.weight, "Input error: no weight given")
		sum = sum + input.value * input.weight 
	end 
end