Edge = {}
Edge.__index = Edge

function Edge.new(source, target, net)
	local edge = {}
	setmetatable(edge, Edge)

	edge.weight = math.random() - math.random()
	edge.source = source
	edge.target = target
	
	table.insert(net.allEdges, edge)
	
	table.insert(source.outgoingEdges, edge)
	table.insert(target.incomingEdges, edge)

	return edge
end



return Edge