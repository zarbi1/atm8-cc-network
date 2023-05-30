local expect = require "cc.expect"
local expect, field = expect.expect, expect.field
local function watchForRequests(colony)
    expect(1, colony, "table")
    local requests = colony.getRequests()
    local reqLogs = fs.open("ColonyCommunication/requestsLogs.log", "w")
    local requestLength = table.getn(requests)
    reqLogs.writeLine("Detected: " .. requestLength .. " requests")
    local toGet = {}
    for i = 1, requestLength, 1
    do
        if string.sub(requests[i].target, 1, 7) == "Builder" then
            reqLogs.writeLine("Request detected for target: " .. requests[i].target)

            table.insert(toGet,
                { id = requests[i].items[1].name, count = requests[i].count })
            reqLogs.writeLine("Added x" ..
                requests[i].count .. requests[i].items[1].displayName .. " to the list of items to get")
        end
    end


    reqLogs.writeLine("End of request Checking.")
    reqLogs.close()
    return toGet
end

return { watchForRequests = watchForRequests }
