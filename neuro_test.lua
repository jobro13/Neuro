-- testing module of neuro which loads figures out if this work
-- very simple 1x8 network trainer which tries to get the max output

-- HOW DOES THIS LOOK

--[[ 
          __ N 
        /      \
  I ----        ---- E
        \ __ N /

  I = input neuron

  E = output neuron

  Every neuron has a start value which is added with a factor * some other variabele
  In total we have 8 variables
  These variables will be trained to give the max output
--]]

local neuro = require("neuro") -- load the brain files
 
population = neuro.new("population") -- load trainer files

local DEBUG = true -- debug
 
for i = 1 , 2 do
        -- add two brains to the population, 1x2 network
        population:AddBrain(neuro.new("network",1,1,1,2))
end
 
 -- initialize delta checkers
local MAX_OUTPUT = 0
local MAX_FITNESS = 0

local LAST_INCREASE = 0

local BEST_GENES = nil
 
-- verbose output if debug == true
function gprint(...)
	if DEBUG then
		print(...)
	end 
end

-- run 5k times
for i = 1, 5000 do

	gprint("------POPULATION: "..i.."-------")
        for _, brain in pairs(population.Brains) do
                -- input the number "3"
                output = brain:evaluate({3})
                if output[1] > MAX_OUTPUT then 
                	gprint("Max output has increased: (generation="..i..")")
                	gprint("From: "..MAX_OUTPUT.. " to: "..output[1].. " (delta="..output[1] - MAX_OUTPUT..")")
                	MAX_OUTPUT = output[1]
                	BEST_GENES = brain:getWeights()
                	gprint("--------")
                end 
                -- set fitness to the output
                -- fitness is used to define how good the brain is
                -- this is the basic training factor, higher fitnesses are better
                -- these brains are more likely to be used in increasning the values
                brain:IncreaseFitness(output[1])
        end
       
       -- figure out if max fitness of the population has increased
       local new_fitness = population:GetTotalFitness()

        if new_fitness > MAX_FITNESS then 
             	gprint("Max fitness has increased: (generation="..i..")")
              	gprint("From: "..MAX_FITNESS.. " to: "..new_fitness.. " (delta="..new_fitness - MAX_FITNESS..")")
               	MAX_FITNESS = new_fitness
               	gprint("Generations taken to evolve positively: ".. i - LAST_INCREASE)
               	LAST_INCREASE = i
               	gprint("<_____>")
        end 
        -- done with looping, evolve population with new neuron configs
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