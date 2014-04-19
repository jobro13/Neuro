NeuralNet = {}
NeuralNet.__index = NeuralNet

Neuron = require("Neuro/src/Neuron")
InputNeuron = require("Neuro/src/InputNeuron")
Edge = require("Neuro/src/Edge")

function NeuralNet.new(numInputs, numOutputs, numHiddenLayers, neuronsPerHiddenLayer)
	local neuralNet = {}
	setmetatable(neuralNet, NeuralNet)
	
	neuralNet.inputNeurons = {}
	neuralNet.hiddenNeurons = {}
	neuralNet.outputNeurons = {}
	neuralNet.allEdges = {}
	neuralNet.fitness = 0
	
	for i = 1, numInputs do
		table.insert(neuralNet.inputNeurons, InputNeuron.new(i,neuralNet))
	end	
	
	for _ = 1, numHiddenLayers do
		for _ = 1, neuronsPerHiddenLayer do
			table.insert(neuralNet.hiddenNeurons, Neuron.new(neuralNet))
		end
	end
	
	for _ = 1, numOutputs do
		table.insert(neuralNet.outputNeurons, Neuron.new(neuralNet))
	end

	for _, inputNeuron in pairs(neuralNet.inputNeurons) do
		for i = 1, neuronsPerHiddenLayer do
			Edge.new(inputNeuron, neuralNet.hiddenNeurons[i],neuralNet)
		end
	end

	for layernum = 1, numHiddenLayers-1 do
		for neuronNum = 1, neuronsPerHiddenLayer do
			Edge.new(neuralNet.hiddenNeurons[neuronNum * layernum], neuralNet.hiddenNeurons[neuronNum * (layernum + 1)],neuralNet)
		end
	end

	if numHiddenLayers == 1 then
		for hiddennum = 1, neuronsPerHiddenLayer do
			for outputnum = 1, numOutputs do
				Edge.new(neuralNet.hiddenNeurons[hiddennum],neuralNet.outputNeurons[outputnum],neuralNet)
			end
		end
	else
		for hiddennum = (numHiddenLayers - 1) * neuronsPerHiddenLayer, numHiddenLayers * neuronsPerHiddenLayer do
			for outputnum = 1, numOutputs do
				Edge.new(neuralNet.hiddenNeurons[hiddennum],neuralNet.outputNeurons[outputnum],neuralNet)
			end
		end
	end

	return neuralNet
end

function NeuralNet:evaluate(inputs)
	if #inputs ~= #self.inputNeurons then
		error("Expected "..#self.inputNeurons.." inputs. Got "..#inputs.." inputs!")
	end
	local outputs = {}
	for _, neuron in pairs(self.outputNeurons) do
		neuron:clearEvaluateCache()
		table.insert(outputs, neuron:evaluate(inputs))
	end
	return outputs
end

function NeuralNet:IncreaseFitness(delta)
	local delta = delta or 1
	self.fitness = self.fitness + delta 
end

function NeuralNet:resetFitness()
	self.fitness = 0
end

function NeuralNet:getWeights()
	local weights = {}
	
	for _, edge in pairs(self.allEdges) do
		table.insert(weights, edge.weight)
	end
	
	return weights
end

function NeuralNet:getNumberOfWeights()
	return #self:getWeights()
end

function NeuralNet:putWeights(weights)
	for _, edge in pairs(self.allEdges) do
		edge.weight = weights[1]
		table.remove(weights,1)
	end
end

function NeuralNet.sigmoid(input, bias)
	return 1 / (1 + math.exp(-input))
end

function NeuralNet:propagateError(examples)
	for num, neuron in pairs(self.outputNeurons) do
		neuron:getError(examples[num])
	end

end

function NeuralNet:updateWeights(learningRate)
	for _, neuron in pairs(self.outputNeurons) do
		neuron:updateWeights(learningRate)
	end	
end

return NeuralNet
