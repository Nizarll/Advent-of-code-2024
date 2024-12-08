local grid_size = 10

local directions = {
	{ 0, 1 },
	{ 0, -1 },
	{ -1, -1 },
	{ -1, 0 },
	{ -1, 1 },
	{ 1, 0 },
	{ 1, -1 },
	{ 1, 1 },
}

local input = io.open("input.txt")
if not input then
	print("could not open input")
	return
end

local content = input:read("*all")
input:close()

local grid = {}

for i = 1, #content, grid_size do
	local chunk = content:sub(i, i + grid_size - 1)
	if #chunk == grid_size then
		table.insert(grid, chunk)
	end
end

function find_xmas()
	local rows = #grid
	local cols = grid_size
	local xmas = "xmas"
	local count = 0

	for r = 1, rows do
		for c = 1, cols do
			for _, dir in pairs(directions) do
				local word = ""
				for i = 0, #xmas - 1 do
					local nr = r + dir[1] * i
					local nc = c + dir[2] * i
					if nr < 1 or nr > rows or nc < 1 or nc > cols then
						word = nil
						break
					end
					word = word .. grid[nr]:sub(nc, nc)
				end
			end
		end
	end
	print(count)
end

find_xmas()
