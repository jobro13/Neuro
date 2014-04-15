local neuro = require("neuro")
 
population = neuro.new("population")
 
for i = 1 , 50 do
        population:AddBrain(neuro.new("network",1,1,5,20))
end
 
 
for i = 1, 200000 do
        for _, brain in pairs(population.Brains) do
                output = brain:update({3})
                brain:IncreaseFitness(output[1])
        end
       
        population:Evolve()
        print(population:GetTotalFitness(),output[1])
        population:resetFitness()
end