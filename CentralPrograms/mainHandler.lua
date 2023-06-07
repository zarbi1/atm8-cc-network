local basalt = require("basalt")
local uiElements = require("Components.uiElements")
local uiHelpers = require("Helpers.uiHelpers")
local function start(monitor, meBridge, colonyInterface)
    --bind the monitor
    local mainFrame = basalt.addMonitor()
    mainFrame:setMonitor(monitor)
    mainFrame:setTheme({ FrameBG = colors.lightGray, FrameFG = colors.black })
    --local main = basalt.createFrame():setTheme({ FrameBG = colors.lightGray, FrameFG = colors.black }) -- we change the default bg and fg color for frames
    --Start the main program
    uiHelpers.PrepFrames(mainFrame)


    basalt.autoUpdate()
end




return { start = start }
