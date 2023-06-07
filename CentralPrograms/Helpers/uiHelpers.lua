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

local function InitMineColony(frame)
    frame:addLabel():setText("Zarbi OS - Colony Status"):setFontSize(1):setPosition("parent.w * 0.3", 1)
    frame:addLabel():setText("Uncraftable Item List"):setPosition(2, 3)
end

local function InitApplied(frame)
    frame:addLabel():setText("Zarbi OS - Applied System"):setFontSize(1):setPosition("parent.w * 0.3", 1)
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

    InitMain(subFrames[1])
    InitMineColony(subFrames[2])
    InitApplied(subFrames[3])
    return subFrames
end

return { PrepFrames = PrepFrames }
