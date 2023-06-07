--This is the main file for the central program system, this program will:
--              -Handle the main base screen with basalt
--              -Handle Colony Comunications and requests
--              -Handle Applied System
--              -Handle Base Power
--              -Handle Base protections

--require part
local peripheralBinder = require("Helpers.peripheralBinder")
local rednetBackground = require("Background.rednetBackground")
local mainHandler = require("mainHandler")

--Startup
--Connect all peripherals
print("Booting...")
local peripherals = peripheralBinder.bind()
peripherals.mainMonitor.clear()
print("Peripherals ready !")


--RedNet setup
local isModem = peripheral.find("modem") or error("No Modem Connected to the back !")
print("Modem Connected, Starting Rednet...")
rednet.open("back")
rednet.host("CentralBase", "Base")
print("RedNet started. Computer's host: Base. Watching for CentralBase signals")
--end rednet startup
print("Program Started....")
--Main program function
local function main()
    mainHandler.start(peripherals.mainMonitor, peripherals.MEBridge, peripherals.colonyInterface)
end

--START
parallel.waitForAny(main, rednetBackground.checkForMessages)

--END
print("Stopping program...")
rednet.unhost("CentralBase", "Base")
rednet.close("back")
--clear monitor
peripherals.mainMonitor.clear()
