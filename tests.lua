local enabled = true -- set to false to disable tests

local checks = {
  Vehicles = {
    name = true,
    model = true,
    brand = true,
    category = true,
    price = true,
    hash = true,
    type = true,
    shop = true,
  },
  Items = {
    name = true,
    label = true,
    weight = true,
    type = true,
    image = true,
    description = true,
  }
}

if not enabled then return end
print("----------------------------------------------------")
print("Running tests on QBCore Shared files")
print("This can be disabled in qb-debug/tests.lua on line 1")
print("----------------------------------------------------")

if not QBShared then return print("QBShared not loaded") end

local issues = {}

local function addIssue(issue)
  table.insert(issues, issue)
  warn(issue)
end

for key, data in pairs(QBShared.Vehicles) do
  for check, run in pairs(checks.Vehicles) do
    if run and not data[check] then
      addIssue(("Vehicle %s has no %s"):format(key, check))
    end
  end
end

for key, data in pairs(QBShared.Items) do
  for check, run in pairs(checks.Items) do
    if run and not data[check] then
      addIssue(("Item %s has no %s"):format(key, check))
    end
  end
end

if #issues == 0 then
  print("^2All tests passed^7")
else
  print("Tests failed")
  CreateThread(function()
    while true do
      Wait(500)
      print("Issues:")
      for i, issue in ipairs(issues) do
        print(("%d. %s"):format(i, issue))
      end
      print("^1 Fix your qb-core shared files before continuing ^7")
    end
  end)
end