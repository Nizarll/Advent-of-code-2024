---

function sign(a)
	return a / math.abs(a)
end

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

function is_valid(content)
	local prev_number
	local ascending = true
	local descending = true

	for tok in string.gmatch(content, "%S+") do
		local number = tonumber(tok)
		if prev_number then
			if number < prev_number then
				ascending = false
			end
			if number > prev_number then
				descending = false
			end
			if math.abs(number - prev_number) > 3 then
				return false
			end
			if prev_number == number then
				return false
			end
		end
		prev_number = number
	end

	return ascending or descending
end

--PART 1
local file_name = "input.txt"
local file_content = read_file(file_name)

local result = 0
for _, line in pairs(file_content) do
	if is_valid(line) then
		print(line)
		result = result + 1
	end
end
print("safe reports: " .. result)

-- part 2

function is_valid_part_2(content)
	local numbers = {}
	for tok in string.gmatch(content, "%S+") do
		table.insert(numbers, tonumber(tok))
	end

	if is_valid(content) then
		return true
	end

	for i = 1, #numbers do
		local modified_sequence = {}
		for j = 1, #numbers do
			if j ~= i then
				table.insert(modified_sequence, numbers[j])
			end
		end
		local modified_content = table.concat(modified_sequence, " ")
		if is_valid(modified_content) then
			return true
		end
	end

	return false
end

result = 0
for _, line in pairs(read_file(file_name)) do
	if is_valid_part_2(line) then
		print(line)
		result = result + 1
	end
end
print("sanitized safe reports: " .. result)
