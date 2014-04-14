local neuron = {} 

neuron.threshold = 1 -- if sum > threshold then fire

neuron.initialize = function(self)
	self.input = {} 
	-- an input object consists of:
	-- .value = double  --> the value of the input
	-- .weight = double --> the weight of the input
end 

neuron.getsignal = function(self)
	local sum = 0 
	for n, input in pairs(self.input) do
		assert(input.value, "Input error: no value given")
		assert(input.weight, "Input error: no weight given")
		sum = sum + input.value * input.weight 
	end 
end