local neuro = require("neuro")
 
population = neuro.new("population")
 
for i = 1 , 50 do
        population:AddBrain(neuro.new("network",1,1,5,20))
end
 
local MAX_OUTPUT = 0
local MAX_FITNESS = 0

local LAST_INCREASE = 0

local BEST_GENES = nil
 
for i = 1, 200000 do
	print("------POPULATION: "..i.."-------")
        for _, brain in pairs(population.Brains) do
                output = brain:update({3})
                if output[1] > MAX_OUTPUT then 
                	print("Max output has increased: (generation="..i..")")
                	print("From: "..MAX_OUTPUT.. " to: "..output[1].. " (delta="..output[1] - MAX_OUTPUT..")")
                	MAX_OUTPUT = output[1]
                	BEST_GENES = brain:getWeights()
                	print(#BEST_GENES)
                	--print("Weights:")
                	--for i,v in pairs(BEST_GENES) do 
                	--	print(i..": "..v)
                	--end 
                	print("--------")
                end 
                brain:IncreaseFitness(output[1])
        end
       
       local new_fitness = population:GetTotalFitness()

        if new_fitness > MAX_FITNESS then 
                print("Max fitness has increased: (generation="..i..")")
               	print("From: "..MAX_FITNESS.. " to: "..new_fitness.. " (delta="..new_fitness - MAX_FITNESS..")")
               	MAX_FITNESS = new_fitness
               	print("Generations taken to evolve positively: ".. i - LAST_INCREASE)
               	LAST_INCREASE = i
               	print("<_____>")
        end 
       population:Evolve()
    --   print(population:GetTotalFitness(),output[1])
       population:resetFitness()
end