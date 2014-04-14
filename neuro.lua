

-- neuron
local neuron = require "require/neuron"

-- network 
local network = require "require/network"

-- genetics
local genetics = require "require/genetics"

-- library

local neurolib = {}




function neurolib.createneuron()
	return neuron.new()
end

function neurolib.createnetwork()
	return network.new()
end

function neurolib.network()
	return neurolib.createnetwork()
end 

function neurolib.neuron()
	return neurolib.createneuron()
end 

function neurolib.new(what) 
	if what == "neuron" then 
		return neurolib.createneuron()
	elseif what == "network" then 
		return neurolib.createnetwork()
	else 
		error("Could not create object type: "..tostring(what).." from neuro.")
	end 
end 