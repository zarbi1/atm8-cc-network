local pretty = require "cc.pretty"
local function isInDic(dic, key)
    return dic[key] ~= nil
end
local function buildDic(list)
    dic = {}
    for i = 1, table.getn(list), 1 do
        dic[list[i].name] = {
            amount = list[i].amount,
            fingerprint = list[i].fingerprint,
            isCraftable = list[i].isCraftable
        }
    end
    return dic
end
local function isCPUAvailable(cpuList) --check if at least 1 cpu is available
    local CPU = nil
    for i = 1, table.getn(cpuList), 1 do
        if not cpuList[i].isBusy then
            return true
        end
    end

    return false
end

return { isInDic = isInDic, buildDic = buildDic, isCPUAvailable = isCPUAvailable }
