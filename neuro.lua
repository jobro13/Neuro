local old_require = require 
function require(what)
	if game and script and Workspace and Instance and Instance.new and game.PlaceId then 
		local wanted = what:match("/(.*)$")
		return old_require(script:FindFirstChild(wanted))
	else
		return old_require(what)
	end
end 

-- neuron
local neuron = require("Neuro/src/Neuron")

-- Network
local network = require ("Neuro/src/NeuralNet")


-- genetics [lib]
local genetics = require ("Neuro/src/genetics")

-- population manager
local population = require ("Neuro/src/population")

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