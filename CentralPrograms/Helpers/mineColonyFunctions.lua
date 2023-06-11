local itemFrameDataPointers = { itemName = "", itemNBT = {}, item_id = "", amount = 0, current_amount = 0 }
local pretty = require "cc.pretty"
local function MineColonyItemSelected(itemFrame, frame, item)
    local uiHelpers = require("Helpers.uiHelpers")
    --hide all the elements that are on the current frame to show the items informations
    frame:hide()
    itemFrame:show()
    uiHelpers.ItemFrameDataPointers.name:setText(item.text)
    uiHelpers.ItemFrameDataPointers.id:setText(item.args[1].id)
    uiHelpers.ItemFrameDataPointers.amount:setText(item.args[1].count)
    --compute percentage
    local availability = math.floor((item.args[1].available / item.args[1].count) * 100 + 0.5)
    uiHelpers.ItemFrameDataPointers.available:setProgress(availability)
    uiHelpers.ItemFrameDataPointers.availableText:setText(item.args[1].available .. " out of " .. item.args[1].count)
end

local function RefreshUncraftableList(newList)
    local uiHelpers = require("Helpers.uiHelpers")
    -- sperate the data if needed then push it
    local listLen = table.getn(newList)
    if listLen <= 8 then
        uiHelpers.ColonyReq = { newList }
        uiHelpers.ColonyReqPointer = 1 --we need to reset the pointer
        --refresh the list
        uiHelpers.RefreshReqList(newList)
        return
    end
    -- the list is too big so we slice it
    local finalList = { {} }

    local currentListCount = 1
    local currentIndex = 1
    for i = 1, listLen, 1 do
        if currentListCount == 8 then
            currentIndex = currentIndex + 1
            table.insert(finalList, { newList[i] })
            currentListCount = 1
        else
            table.insert(finalList[currentIndex], newList[i])
        end
    end
    --and finally refresh
    uiHelpers.ColonyReqPointer = 1 --we need to reset the pointer
    uiHelpers.ColonyReq = finalList
    uiHelpers.RefreshReqList(finalList)
end


return {
    MineColonyItemSelected = MineColonyItemSelected,
    RefreshUncraftableList = RefreshUncraftableList,
    itemFrameDataPointers = itemFrameDataPointers
}
