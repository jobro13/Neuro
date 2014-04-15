

Neuron = {}

function Neuron.new(numInputs)
	local neuron = {}
	setmetatable(neuron, Neuron)

	neuron.numInputs = numInputs
	neuron.weights = {}
	
	for i = 1, numInputs + 1 do
		table.insert(neuron.weights, math.random())
	end


	return neuron
end

return Neuron
