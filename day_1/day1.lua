function file_exists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

function read_file(f)
	if not file_exists(f) then
		print("file " .. f .. "does not exist !")
		os.exit(1)
		return
	end
	local lines = {}
	for line in io.lines(f) do
		lines[#lines + 1] = line
	end
	return lines
end

function parse_file(content)
	local tokens = {}
	for tok in string.gmatch(content, "%S+") do
		tokens[#tokens + 1] = tok
	end
	return tokens
end

--PART 1
--
local file_name = "input.txt"
local file_content = read_file(file_name)
local values = {
	{},
	{},
}
--CONSTRUCT TABLES
for i = 1, #file_content do
	local input = parse_file(file_content[i])
	values[1][#values[1] + 1] = input[1]
	values[2][#values[2] + 1] = input[2]
end

--SORT TABLE
table.sort(values[1])
table.sort(values[2])

--considering columns are of same size
local total_sum = 0
for i = 1, #file_content do
	total_sum = total_sum + math.abs(values[1][i] - values[2][i])
end
print("total distance is :" .. total_sum)

--PART 2
--

local file_name = "input.txt"
local file_content = read_file(file_name)
local values = {
	{},
	{},
}
local frequencies = {}
--CONSTRUCT TABLES
for i = 1, #file_content do
	local input = parse_file(file_content[i])

	if frequencies[input[2]] then
		frequencies[input[2]] = frequencies[input[2]] + 1
	else
		frequencies[input[2]] = 1
	end
	values[1][#values[1] + 1] = input[1]
	values[2][#values[2] + 1] = input[2]
end

--SORT TABLE
table.sort(values[1])
table.sort(values[2])

--considering columns are of same size

function get_frequency(number)
	if frequencies[number] then
		return frequencies[number]
	else
		return 0
	end
end

local second_sum = 0

for i = 1, #file_content do
	second_sum = second_sum + values[1][i] * get_frequency(values[1][i])
end
print("new distance is :" .. second_sum)
