local basalt = require("basalt")
local uiElements = require("Components.uiElements")
local mineColonyHeplers = require("Helpers.mineColonyFunctions")
local uiHelpers = require("Helpers.uiHelpers")
local colonyBackGround = require("Background.colonyBackground")
local function start(monitor, meBridge, colonyInterface)
    --bind the monitor
    local mainFrame = basalt.addMonitor()
    mainFrame:setMonitor(monitor)
    mainFrame:setTheme({ FrameBG = colors.lightGray, FrameFG = colors.black })
    --local main = basalt.createFrame():setTheme({ FrameBG = colors.lightGray, FrameFG = colors.black }) -- we change the default bg and fg color for frames
    --Start the main program
    uiHelpers.PrepFrames(mainFrame)
    --launch the main loop
    function launchColonyCheck()
        colonyBackGround.startCheck(60, meBridge, colonyInterface, 5)
    end

    --test Only
    -- mineColonyHeplers.RefreshUncraftableList({ {
    --     id = "Tst Name",
    --     count = 18,
    --     nbt = { "No data for now" },
    --     displayName = "test displayName",
    --     available = 15
    -- } })
    --end test Only

    local colonyThread = mainFrame:addThread():start(launchColonyCheck)
    basalt.autoUpdate()
end




return { start = start }
