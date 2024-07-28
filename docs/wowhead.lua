-- Get the filename from the command line argument
local inputFilePath = arg[1]

if not inputFilePath then
    print("Usage: lua script.lua <filename>")
    return
end

-- Define the output file path
local outputFilePath = inputFilePath:gsub("%.%w+$", "_results.txt")

-- Function to split a string by a given delimiter
local function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

-- Open the input file in read mode
local inputFile, err = io.open(inputFilePath, "r")

-- Check if the file was opened successfully
if not inputFile then
    print("Could not open input file: " .. err)
    return
end

-- Read the first line (numbers)
local numberLine = inputFile:read("*l")

-- Read the second line (texts)
local textLine = inputFile:read("*l")

-- Close the input file
inputFile:close()

-- Split the lines by commas
local numbers = split(numberLine, ",")
local texts = split(textLine, ",")

-- Create a table to store the number-text pairs
local numberTextTable = {}

-- Populate the table
for i = 1, #numbers do
    local number = tonumber(numbers[i]:match("^%s*(.-)%s*$"))
    local text = texts[i]:match("^%s*(.-)%s*$")
    table.insert(numberTextTable, {number = number, text = text})
end

-- Sort the table by text first, then by number if the texts are the same
table.sort(numberTextTable, function(a, b)
    if a.text == b.text then
        return a.number < b.number
    else
        return a.text < b.text
    end
end)

-- Open the output file in write mode
local outputFile, err = io.open(outputFilePath, "w")

-- Check if the file was opened successfully
if not outputFile then
    print("Could not open output file: " .. err)
    return
end

-- Write the table to the output file
outputFile:write("{\n")
for _, pair in ipairs(numberTextTable) do
    outputFile:write("  [" .. pair.number .. "] = \"" .. pair.text .. "\",\n")
end
outputFile:write("}\n")

-- Close the output file
outputFile:close()

print("Table successfully written to " .. outputFilePath)
