local helpers = require("helpers")
local requestWatcher = require("requestWatcher")
local mainMonitorHandler = require("mainMonitorHandler")
local colonyCheck = require("colonyCheck")
local rednetBackground = require("rednetBackground")
print("Booting...")
--check for the colony integrator
local colony = peripheral.find("colonyIntegrator")
if colony == nil then
    printError("No Colony Integrator Found")
    return -1
end
print("Watching the " .. colony.getColonyName() .. " colony")
--check for the ME connection
local meBridge = peripheral.find("meBridge")
if meBridge == nil then
    printError("No ME Bridge detected")
    return -1
end
print("Me Bridge Connected.")
local nbCraftingCPU = table.getn(meBridge.getCraftingCPUs())
if nbCraftingCPU == 0 then
    printError("No crafting CPU Connected...")
    return -1
end
print("Applied system connected.")

----------------------------TEMPORARY SECTION-----------------------
local mainMonitor = peripheral.find("monitor")
if mainMonitor == nil then
    printError("No monitor found")
    return -1
end
print("Monitor connected.")
----------------------------END TEMPORARY SECTION---------------------

--Rednet Startup
local isModem = peripheral.find("modem") or error("No Modem Connected to the back !")
print("Modem Connected, Starting Rednet...")
rednet.open("back")
rednet.host("EndTask", "ColonyCommunicator")
print("RedNet started. Computer's host: ColonyCommunicator. Watching for EndTask signal")
--end rednet startup
--Main program stratup
local logInterval = 10
local checkInterval = 60 --in sec

function colonyWarper()  -- little so that we can send throught our arguments.
    colonyCheck.startCheck(mainMonitor, mainMonitorHandler, checkInterval, meBridge, colony, requestWatcher,
        helpers, logInterval)
end

parallel.waitForAny(rednetBackground.checkForMessage, colonyWarper)
--stop rednet
rednet.unhost("EndTask", "ColonyCommunicator")
rednet.close("back")


--clear monitor
mainMonitor.clear()
