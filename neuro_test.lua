local neuro = require("neuro")
 
population = neuro.new("population")

local DEBUG = true
 
for i = 1 , 2 do
        population:AddBrain(neuro.new("network",1,1,1,2))
end
 
local MAX_OUTPUT = 0
local MAX_FITNESS = 0

local LAST_INCREASE = 0

local BEST_GENES = nil
 
function gprint(...)
	if DEBUG then
		print(...)
	end 
end

for i = 1, 5000 do

	gprint("------POPULATION: "..i.."-------")
        for _, brain in pairs(population.Brains) do
                output = brain:evaluate({3})
                if output[1] > MAX_OUTPUT then 
                	gprint("Max output has increased: (generation="..i..")")
                	gprint("From: "..MAX_OUTPUT.. " to: "..output[1].. " (delta="..output[1] - MAX_OUTPUT..")")
                	MAX_OUTPUT = output[1]
                	BEST_GENES = brain:getWeights()
                	gprint("--------")
                end 
                brain:IncreaseFitness(output[1])
        end
       
       local new_fitness = population:GetTotalFitness()

        if new_fitness > MAX_FITNESS then 
             	gprint("Max fitness has increased: (generation="..i..")")
              	gprint("From: "..MAX_FITNESS.. " to: "..new_fitness.. " (delta="..new_fitness - MAX_FITNESS..")")
               	MAX_FITNESS = new_fitness
               	gprint("Generations taken to evolve positively: ".. i - LAST_INCREASE)
               	LAST_INCREASE = i
               	gprint("<_____>")
        end 
       population:Evolve()
    --   print(population:GetTotalFitness(),output[1])
       population:resetFitness()
end
print()
print("Done!")
print("Max out: "..MAX_OUTPUT.."!")
print("Max fit: "..MAX_FITNESS.."!")
print("Best gene dump:")
for i,v in pairs(BEST_GENES) do 
	print(i.. " : "..v)
end
print("Neuro out!")