BiasNeuron = {}
BiasNeuron.__index = BiasNeuron
Edge = require("Neuro/src/Edge")

function BiasNeuron.new()
	local neuron = {}
	setmetatable(neuron, BiasNeuron)

	neuron.incomingEdges = {}
	neuron.outgoingEdges = {}
	neuron.type = "Bias"

	return neuron
end

function BiasNeuron:clearEvaluateCache()
	
end

function BiasNeuron:evaluate()
	return 1
end

return BiasNeuron