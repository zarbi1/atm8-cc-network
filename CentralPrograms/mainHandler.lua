local basalt = require("basalt")


local function start(monitor, meBridge, colonyInterface)
    --bind the monitor
    --local mainFrame = basalt.addMonitor()
    --mainFrame:setMonitor(monitor)



    --Start the main program



    basalt.autoUpdate()
end
start()
return { start = start }
