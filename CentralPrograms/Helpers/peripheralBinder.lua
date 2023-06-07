--Bind the peripherals
local function bind()
    --check for the colony integrator
    local colony = peripheral.find("colonyIntegrator")
    if colony == nil then
        error("No Colony Integrator Found")
        return -1
    end
    print("Watching the " .. colony.getColonyName() .. " colony")
    --check for the ME connection
    local meBridge = peripheral.find("meBridge")
    if meBridge == nil then
        error("No ME Bridge detected")
        return -1
    end
    print("Me Bridge Connected.")
    local nbCraftingCPU = table.getn(meBridge.getCraftingCPUs())
    if nbCraftingCPU == 0 then
        error("No crafting CPU Connected...")
        return -1
    end
    print("Applied system connected.")
    local mainMonitor = peripheral.find("monitor")
    if mainMonitor == nil then
        error("No monitor found")
        return -1
    end
    print("Monitor connected.")

    return { colonyInterface = colony, MEBridge = meBridge, mainMonitor = mainMonitor }
end

return { bind = bind }
