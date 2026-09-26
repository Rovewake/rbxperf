-- Build a wall grid and cast rays across it to check which sight lines are blocked.
local function count_blocked_sight_lines()
	local obstacle_field = Instance.new 'Folder'
	obstacle_field.Name = 'BenchmarkObstacleField'
	obstacle_field.Parent = workspace

	for row = 1, 8 do
		for column = 1, 10 do
			local obstacle = Instance.new 'Part'
			obstacle.Name = 'Obstacle'
			obstacle.Anchored = true
			obstacle.CanCollide = false
			obstacle.CanQuery = true
			obstacle.Size = Vector3.new(2, 10, 4)
			obstacle.Position = Vector3.new(column * 12, 5, row * 8)
			obstacle.Parent = obstacle_field
		end
	end

	local params = RaycastParams.new()
	params.IncludeInstances = { obstacle_field }
	local blocked_lines = 0
	for ray_index = 1, 64 do
		local row = ((ray_index - 1) % 8) + 1
		local height = math.floor((ray_index - 1) / 8) + 1
		const origin = Vector3.new(0, height, row * 8)
		const direction = Vector3.new(140, 0, 0)
		if workspace:Raycast(origin, direction, params) then
			blocked_lines += 1
		end
	end

	obstacle_field:Destroy()
	assert(blocked_lines == 64, 'Every test sight line should hit an obstacle.')
	return blocked_lines
end

return {
	bench = count_blocked_sight_lines,
	warmup = 2,
	samples = 30,
}
