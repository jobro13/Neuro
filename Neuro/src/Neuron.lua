Neuron = {}
Neuron.__index = Neuron
Edge = require("Neuro/src/Edge")
BiasNeuron = require("Neuro/src/BiasNeuron")

function Neuron.new(net)
	local neuron = {}
	setmetatable(neuron, Neuron)

	neuron.incomingEdges = {}
	neuron.outgoingEdges = {}
	neuron.type = "normal/output"

	table.insert(neuron.incomingEdges, Edge.new(BiasNeuron.new(), neuron, net))
	
	return neuron
end

function Neuron:evaluate(inputs)
	if self.lastOutput then return self.lastOutput end
	
	self.lastInput = {}
	local weightedSum = 0
	
	for _, edge in pairs(self.incomingEdges) do
		local theInput = edge.source:evaluate(inputs)
		table.insert(self.lastInput, theInput)
		weightedSum = weightedSum + edge.weight * theInput
	end
	
	self.lastOutput = sigmoid(weightedSum)
	self.evaluateCache = self.lastOutput
	return self.lastOutput
end

function Neuron:getError(example)
	--if self.error then return self.error end

	if not self.lastOutput then error("Neuron tried to get error with no last output!") end
	
	if #self.outgoingEdges == 0 then
		self.error = example - self.lastOutput
	else
		self.error = 0
		
		for _, edge in pairs(self.incomingEdges) do
			self.error = self.error + edge.weight * edge.source:getError(example)
		end
	end
	
	return self.error
end

function Neuron:updateWeights(learningRate)
	if self.error and self.lastOutput and self.lastInput then
		for i, edge in pairs(self.incomingEdges) do
			edge.weight = edge.weight + (learningRate * self.lastOutput * (1 - self.lastOutput) * self.error * self.lastInput[i])
		end
		for _, edge in pairs(self.outgoingEdges) do
			edge.target:updateWeights(learningRate)
		end
		self.error = nil
		self.lastOutput = nil
		self.lastInput = nil
	end
end

function Neuron:clearEvaluateCache()
	if self.lastOutput then
		self.lastOutput = nil
		for _, edge in pairs(self.incomingEdges) do
			edge.source:clearEvaluateCache()
		end
	end
end

function sigmoid(x)
	return  1 / (1 + math.exp(-x))
end


return Neuron