

NeuralNet = {}

function NeuralNet.new(numInputs, numOutputs, numHiddenLayers, neuronsPerHiddenLayer)
	local neuralNet = {}
	setmetatable(neuralNet, NeuralNet)

	neuralNet.numInputs = numInputs
	neuralNet.numOutputs = numOutputs
	neuralNet.numHiddenLayers = numHiddenLayers
	neuralNet.neuronsPerHiddenLayer = neuronsPerHiddenLayer
	neuralNet.fitness = 0
	neuralNet.layers = {}

	return neuralNet
end

function NeuralNet:IncreaseFitness(delta)
	local delta = delta or 1
	self.fitness = self.fitness + delta 
end

function NeuralNet:getWeights()
	local weights = {}
	
	for _, layer in pairs(self.layers) do
		for _, neuron in pairs(layer.neurons) do
			for _, weight in pairs(neuron.weights) do
				table.insert(weights, weight)
			end
		end
	end
	
	return weights
end

function NeuralNet:getNumberOfWeights()
	local num = 0
	
	for _, layer in pairs(self.layers) do
		for _, neuron in pairs(layer.neurons) do
			num = num + #neruon.weights
		end
	end
	
	return num
end

function NeuralNet:putWeights(weights)

	for _, layer in pairs(self.layers) do
		for _, neuron in pairs(layer.neurons) do
			for _, weight in pairs(neuron.weights) do
				weight = weights[1]
				table.remove(weights, 1)
			end
		end
	end

end

function NeuralNet:update(inputs)
	--here be dragons
	local outputs
	
	if #inputs ~= self:getNumberOfWeights() then
		error("Expected " .. self:getNumberOfWeights() .. " inputs. Got " .. #inputs .. " inputs!")
	end
	
	for layerNum, layer in pairs(self.layers) do
		
		if layerNum > 1 then
			inputs = outputs
		end
	
		outputs = {}
		local weight = 0
		
		for neuronNum, neuron in pairs(self.layers[layerNum].neurons) do
			local netInput = 0
			
			for nNum, nWeight in pairs(neuron.weights) do
				if nNum < #neuron.weights then
					netInput = netInput + nWeight * inputs[weight]
					weight = weight + 1
				end
			end
			
			netInput = netInput + neuron.weights[#neuron.weights] * -1
			weight = 0
			
			table.insert(outputs, self.sigmoid(netInput))
		end
	end

	return outputs
end

function NeuralNet.sigmoid(input)
	return 1 / (1 + math.exp(input))
end

















return NeuralNet