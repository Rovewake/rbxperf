-- Place a grid of objects, find the ones near a point, then clean up the grid.
local function find_nearby_parts()
	local pickup_area = Instance.new 'Folder'
	pickup_area.Name = 'BenchmarkPickupArea'
	pickup_area.Parent = workspace

	for row = 1, 15 do
		for column = 1, 15 do
			local pickup = Instance.new 'Part'
			pickup.Name = 'Pickup'
			pickup.Anchored = true
			pickup.CanCollide = false
			pickup.CanQuery = true
			pickup.Size = Vector3.new(2, 2, 2)
			pickup.Position = Vector3.new((column - 1) * 6, 0, (row - 1) * 6)
			pickup.Parent = pickup_area
		end
	end

	local params = OverlapParams.new()
	params.IncludeInstances = { pickup_area }
	const nearby_pickups = workspace:GetPartBoundsInRadius(Vector3.new(42, 0, 42), 20, params)
	const pickup_count = #nearby_pickups

	pickup_area:Destroy()
	assert(pickup_count > 0, 'The search point should find nearby pickups.')
	return pickup_count
end

return {
	bench = find_nearby_parts,
	warmup = 2,
	samples = 30,
}
