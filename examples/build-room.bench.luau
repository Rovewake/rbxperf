-- Build a small room, inspect its parts, and remove it after each sample.
local function build_and_inspect_room()
	local room = Instance.new 'Model'
	room.Name = 'BenchmarkRoom'
	room.Parent = workspace

	for row = 1, 12 do
		for column = 1, 12 do
			local tile = Instance.new 'Part'
			tile.Name = 'FloorTile'
			tile.Anchored = true
			tile.CanCollide = false
			tile.CanQuery = false
			tile.Size = Vector3.new(4, 1, 4)
			tile.Position = Vector3.new(column * 4, 0, row * 4)
			tile.Parent = room
		end
	end

	local part_count = 0
	local total_volume = 0
	for _, descendant in room:GetDescendants() do
		if descendant:IsA 'BasePart' then
			part_count += 1
			const size = descendant.Size
			total_volume += size.X * size.Y * size.Z
		end
	end

	room:Destroy()
	assert(part_count == 144, 'The test room should contain 144 parts.')
	return total_volume
end

return {
	bench = build_and_inspect_room,
	warmup = 2,
	samples = 25,
}
