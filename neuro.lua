math.randomseed(os.time())

-- neuron
local neuron = require "Neuro/src/Neuron"

-- Network
local network = require "Neuro/src/NeuralNet"

-- Network Layer
local networklayer = require "Neuro/src/NeuronLayer"


-- genetics [lib]
local genetics = require "Neuro/src/genetics"

-- population manager
local population = require "Neuro/src/population"

local neuro = {}

-- library

neuro.classes = {
neuron = neuron, 
networklayer = networklayer,
network = network, 
population = population, 
} 

-- safe output
local neurolib = {}

function neurolib.new(what, ...) 
	assert(type(what) == "string", "ClassName must be a string")
	if neuro.classes[what:lower()] then 
		return neuro.classes[what:lower()].new(...)
	else 
		error("Could not create object type: "..tostring(what).." from neuro.")
	end 
end 

neurolib.genetics = genetics 

return neurolib