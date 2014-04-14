

NeuronLayer = {}

function NeuronLayer.new(numNeurons, numInputsPerNeuron)
	local neuronLayer = {}
	setmetatable(neuronLayer, NeuronLayer)

	neuronLayer.numNeurons = numNeurons
	neuronLayer.numInputsPerNeuron = numInputsPerNeuron
	neuronLayer.neurons = {}

	return neuronLayer
end