Neuron = require("Neuro/src/Neuron")
NeuronLayer = {}
NeuronLayer.__index = NeuronLayer

function NeuronLayer.new(numNeurons, numInputsPerNeuron)
	local neuronLayer = {}
	setmetatable(neuronLayer, NeuronLayer)

	neuronLayer.numNeurons = numNeurons
	neuronLayer.numInputsPerNeuron = numInputsPerNeuron
	neuronLayer.neurons = {}
	
	for neuronNum = 1, numNeurons do
		table.insert(neuronLayer.neurons, Neuron.new(numInputsPerNeuron))
	end

	return neuronLayer
end

return NeuronLayer