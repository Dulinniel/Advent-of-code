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
  local len = #report
  
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
  for j = 2, #report do
    local difference = math.abs(report[j] - report[j - 1])
    if difference < 1 or difference > 3 then
      return false
    end
  end
  return true
end

function is_safe(report)
  if is_monotone(report) and is_difference_legal(report) then
    return true
  end

  -- Test removing each level because sometimes, I lose O(n) and find O(n^2)
  for i = 1, #report do
    local modified_report = {}
    for j = 1, #report do
      if j ~= i then
        table.insert(modified_report, report[j])
      end
    end

    if is_monotone(modified_report) and is_difference_legal(modified_report) then
      return true
    end
  end

  return false
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
  local report = split(report_line, "%s")
  if is_safe(report) then
    safe_reports = safe_reports + 1
    print(report_line)
  end
end

print("Safe reports: ", safe_reports)
