local population = {}

local genetics = require "Neuro/src/genetics"

function population.new()
	local new = {}
	setmetatable(new, population)

	new.Population = 0 
	new.Generation = 1

	new.Brains = {}

	return new 
end 

-- Adds a Brain to the population. (type: NeuralNetwork)
function population:AddBrain(NeuralNetwork)	
	self.Population = self.Population + 1 
	table.insert(self.Brains, NeuralNetwork)
end 


-- Evolves the population
-- DOES NOT CREATE NEW OBJECTS BUT INSTEAD WRITES TO THE OLD
function population:Evolve()
	local mum, dad = self:GetChromosome(), self:GetChromosome()
	local chrom_1, chrom_2 = mum:getWeights(), dad:getWeights() 

	local chrom_new_1, chrom_new_2 = genetics.meiosis(chrom_1, chrom_2)

	mum:putWeights(chrom_new_1)
	dad:putWeights(chrom_new_2)
end 

-- returns the best brain in the population
function population:GetBest()
	local best = -math.huge 
	local cbest = nil
	for brain_number, brain in pairs(self.Brains) do 
		if brain.Fitness > best then 
			cbest = brain 
			best = brain.Fitness
		end 
	end 
	return cbest 
end 

-- returns the worst brain in the population
function population:GetWorst()
	local worst = math.huge 
	local cworst = nil
	for brain_number, brain in pairs(self.Brains) do 
		if brain.Fitness < worst then 
			cworst = brain 
			worst = brain.Fitness
		end 
	end 
	return cworst
end 

-- returns a general fitness score for the whole population.
function population:GetTotalFitness()
	local tf = 0 
	for brain_number, brain in pairs(self.Brains) do 
		tf = tf + brain.Fitness
	end
	return tf 
end 

-- Returns a "Chromosome" from the population via a random roulette wheel style
-- Note: Chromosome is a table of weights of all nodes.
function population:GetChromosome()
	local total_fitness = self:GetTotalFitness()
	local fitness_wanted = math.random() * total_fitness
	local fitness_got = 0
	for brain_number, brain in pairs(self.Brains) do 
		fitness_got = fitness_got + brain.Fitness 
		if fitness_got >= fitness_wanted then 
			return brain 
		end 
	end
end  

return population
