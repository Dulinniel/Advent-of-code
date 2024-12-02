-- Open file
local file = io.open("input.txt", "r")

local reports = {}

function split(input, sep)
  local word = {}
  if sep == nil then
    sep = "%s"
  end
  for str in string.gmatch(input, "[^"..sep.."]+") do
    table.insert(word, tonumber(str)) -- Convert to number
  end
  return word
end

function is_monotone(report)
  local increasing = true
  local decreasing = true
  local len = tablelength(report)
  
  for i = 2, len do
    if report[i] < report[i - 1] then
      increasing = false
    elseif report[i] > report[i - 1] then
      decreasing = false
    end
  end

  return increasing or decreasing
end

function is_difference_legal(report)
  local len = tablelength(report)
  for j = 2, len do
    local difference = math.abs(report[j] - report[j - 1])
    if difference < 1 or difference > 3 then
      return false
    end
  end
  return true
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

-- Read lines
if file then
  for line in file:lines() do
    if line ~= "" then -- Skip empty lines
      table.insert(reports, line)
    end
  end
  file:close()
else
  print("Error opening file.")
end

local safe_reports = 0

for _, report_line in ipairs(reports) do
  local cut = split(report_line, "%s")
  local monotone = is_monotone(cut)
  local allowed_difference = is_difference_legal(cut)
  if monotone and allowed_difference then
    safe_reports = safe_reports + 1
    print(report_line)
  end
end

print("Safe reports: ", safe_reports)
