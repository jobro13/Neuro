InputNeuron = {}
InputNeuron.__index = InputNeuron
Edge = require("Neuro/src/Edge")
BiasNeuron = require("Neuro/src/BiasNeuron")

function InputNeuron.new(index, net)
	local neuron = {}
	setmetatable(neuron, InputNeuron)

	neuron.index = index
	
	neuron.incomingEdges = {}
	neuron.outgoingEdges = {}
	neuron.type = "Input"

	table.insert(neuron.incomingEdges, Edge.new(BiasNeuron.new(), neuron, net))
	

	return neuron
end

function InputNeuron:evaluate(inputs)
	self.lastOutput = inputs[self.index]
	return self.lastOutput 
end

function InputNeuron:getError(example)
	for _, edge in pairs(self.outgoingEdges) do
		edge.target:getError(example)
	end
end

function InputNeuron:updateWeights(learningRate)
	for _, edge in pairs(self.outgoingEdges) do
		edge.target:updateWeights(learningRate)
	end
end

function InputNeuron:clearEvaluateCache()
	self.lastOutput = nil
end

function sigmoid(x)
	return  1 / (1 + math.exp(-input))
end


return InputNeuron