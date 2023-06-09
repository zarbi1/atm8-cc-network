local mineColonyHelpers = require("Helpers.mineColonyFunctions")
local ColonyReq = {}
local ColonyReqPointer = 1
local ColonyFramePointers = { mainFrame = nil, uncraftListFrame = nil }
local ItemFrameDataPointers = { name = nil, id = nil, amount = nil, available = nil, nbt = nil, availableText = nil }
local function openSubFrame(id, frames) -- we create a function which switches the frame for us
    if (frames[id] ~= nil) then
        for k, v in pairs(frames) do
            v:hide()
        end
        frames[id]:show()
    end
end



local function InitMain(frame)
    frame:addLabel():setText("Zarbi OS - Home"):setFontSize(1):setPosition("parent.w * 0.4", 1)
end


local function RefreshReqList(req)
    --first empty the list
    ColonyFramePointers.uncraftListFrame:clear()
    --Now fill it with the new req
    for i = 1, table.getn(req), 1 do
        ColonyFramePointers.uncraftListFrame:addItem(req[i].displayName, nil, nil, req[i])
    end
end



local function FakeScroll(frame, direction)
    if direction == "Previous" then
        if ColonyReqPointer == 1 then
            return -- there is nothing in prefix
        end
        ColonyReqPointer = ColonyReqPointer - 1
    else --next
        if ColonyReqPointer >= table.getn(ColonyReq) then
            return
        end
        ColonyReqPointer = ColonyReqPointer + 1
    end
    RefreshReqList(ColonyReq[ColonyReqPointer])
    return
end

local function InitMineColony(frame, itemFrame)
    frame:addLabel():setText("Zarbi OS - Colony Status"):setFontSize(1):setPosition("parent.w * 0.3", 1)
    frame:addLabel():setText("Uncraftable Item List"):setPosition(2, 3)
    local list = frame:addList():setPosition(2, 5):onSelect(function(self, event, item)
        mineColonyHelpers.MineColonyItemSelected(itemFrame, frame, item)
    end)
    -- declar the pointers
    ColonyFramePointers.mainFrame = frame
    ColonyFramePointers.uncraftListFrame = list
    --up
    frame:addButton():setText("Previous"):setPosition(20, 6):onClick(function(self, event, button, x, y)
        if (event == "mouse_click") then
            FakeScroll(list, "Previous")
        end
    end)
    frame:addButton():setText("Next"):setPosition(20, 10):onClick(function(self, event, button, x, y)
        if (event == "mouse_click") then
            FakeScroll(list, "Next")
        end
    end)
end

local function InitApplied(frame)
    frame:addLabel():setText("Zarbi OS - Applied System"):setFontSize(1):setPosition("parent.w * 0.3", 1)
end

local function InitItemFrame(mainFrame, colonyFrame)
    local itemFrame = mainFrame:addFrame():setPosition(1, 2):setSize("parent.w", "parent.h-1"):hide()
    itemFrame:addButton():setText("Close"):setPosition(2, 2):onClick(function(self)
        colonyFrame:show()
        itemFrame:hide()
    end)
    itemFrame:addLabel():setText("Item Information"):setPosition(2, 6)
    itemFrame:addPane():setSize("parent.w * 0.25", 1):setPosition(2, 8):setBackground(false, "\140", colors.blue)
    itemFrame:addLabel():setText("Item Name: "):setPosition(2, 10)
    local nameLabel = itemFrame:addLabel():setText("Null"):setPosition(16, 10)
    itemFrame:addLabel():setText("Item ID: "):setPosition(2, 12)
    local idLabel = itemFrame:addLabel():setText("NUll"):setPosition(16, 12)
    itemFrame:addLabel():setText("Amount Asked: "):setPosition(2, 14)
    local amountLabel = itemFrame:addLabel():setText("Null"):setPosition(16, 14)
    itemFrame:addLabel():setText("Available Amount: "):setPosition(2, 16)
    local availableLabel = itemFrame:addLabel():setText("Null"):setPosition(20, 16)

    local availableBar = itemFrame:addProgressbar():setDirection("right"):setProgressBar(colors.blue):setProgress(0)
        :setPosition(2, 18)

    --register the pointers
    ItemFrameDataPointers.name = nameLabel
    ItemFrameDataPointers.amount = amountLabel
    ItemFrameDataPointers.id = idLabel
    ItemFrameDataPointers.available = availableBar
    ItemFrameDataPointers.availableText = availableLabel




    return itemFrame
end

local function PrepFrames(mainFrame)
    local subFrames = {
        mainFrame:addFrame():setPosition(1, 2):setSize("parent.w", "parent.h-1"), -- program start
        mainFrame:addFrame():setPosition(1, 2):setSize("parent.w", "parent.h-1"):hide(),
        mainFrame:addFrame():setPosition(1, 2):setSize("parent.w", "parent.h-1"):hide(),
    }
    local menubar = mainFrame:addMenubar():setScrollable() -- we create a menubar in our main frame.
        :setSize("parent.w")
        :onChange(function(self, val)
            openSubFrame(self:getItemIndex(), subFrames) -- here we open the sub frame based on the table index
        end)
        :addItem("Home")
        :addItem("MineColony")
        :addItem("Applied")

    --Init Special Frames
    local itemFrame = InitItemFrame(mainFrame, subFrames[2])

    --Init Features
    InitMain(subFrames[1])
    InitMineColony(subFrames[2], itemFrame)
    InitApplied(subFrames[3])
    return subFrames
end

return {
    PrepFrames = PrepFrames,
    ColonyReq = ColonyReq,
    ColonyReqPointer = ColonyReqPointer,
    RefreshReqList = RefreshReqList,
    ItemFrameDataPointers = ItemFrameDataPointers
}
