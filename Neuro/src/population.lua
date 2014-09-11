local population = {}
population.settings = {
	kill_rate = 0.8 -- If a brain has lower than 0.9 * best fitness, it will die.

}
population.__index = population
local genetics = require("Neuro/src/genetics")
local neuralnet = require("Neuro/src/NeuralNet")

function population.new()
	local new = {}
	setmetatable(new, population)

	new.Population = 0 
	new.Generation = 1

	new.Brains = {}

	new.BestBrain = nil

	return new 
end 

-- Adds a Brain to the population. (type: NeuralNetwork)
function population:AddBrain(NeuralNetwork)	
	self.Population = self.Population + 1 
	table.insert(self.Brains, NeuralNetwork)
end 


-- Evolves the population
-- DOES NOT CREATE NEW OBJECTS BUT INSTEAD WRITES TO THE OLD
-- Evolves every creature with random mums and dads
function population:Evolve()
	local bestBrain = self:GetBest()
	for brain = 1, #self.Brains,2 do 

		local mum, dad = self:GetChromosome(), self:GetChromosome()
		local chrom_1, chrom_2 = mum:getWeights(), dad:getWeights() 

		local chrom_new_1, chrom_new_2 = genetics.meiosis(chrom_1, chrom_2)

		local baby1 = self.Brains[brain]
		local baby2 = self.Brains[brain+1]

		baby1:putWeights(chrom_new_1)

		if baby2 then 
			baby2:putWeights(chrom_new_2)
		end

	end 
	-- keep best brain here as we also want to check if it is still the best brain

	-- create a pseudo brain with copies

	self.Brains[1]:putWeights(bestBrain:getWeights())
end 

-- returns the best brain in the population
function population:GetBest()
	local best = -math.huge 
	local cbest = nil
	for brain_number, brain in pairs(self.Brains) do 
		if brain.fitness > best then 
			cbest = brain 
			best = brain.fitness
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
			worst = brain.fitness
		end 
	end 
	return cworst
end 

-- returns a general fitness score for the whole population.
function population:GetTotalFitness()
	local tf = 0 
	for brain_number, brain in pairs(self.Brains) do 
		tf = tf + brain.fitness
	end
	return tf 
end 

function population:resetFitness()
	for _, brain in pairs(self.Brains) do
		brain.fitness = 0
	end	
end

-- Returns a "Chromosome" from the population via a random roulette wheel style
-- Note: Chromosome is a table of weights of all nodes.
function population:GetChromosome()
	local total_fitness = self:GetTotalFitness()
	local fitness_wanted = math.random() * total_fitness
	local fitness_got = 0
	for brain_number, brain in pairs(self.Brains) do 
		fitness_got = fitness_got + brain.fitness 
		if fitness_got >= fitness_wanted then 
			return brain 
		end 
	end
end  

return population