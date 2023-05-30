local function startCheck(mainMonitor, mainMonitorHandler, interval, meBridge, colony, requestWatcher, helpers,
                          logInterval)
    print("Job Started.")
    local logs = fs.open("ColonyCommunication/systemLogs.log", "w")

    local nbLoopSinceLog = 0
    while true do
        if logInterval == nbLoopSinceLog then
            logs.close()
            nbLoopSinceLog = 0
            --clear the logs for the new loop
            logs = fs.open("ColonyCommunication/systemLogs.log", "w")
        end

        local uncraftableItems = {} --names only, represent the list of items
        logs.writeLine("LOOP NUMBER: " .. nbLoopSinceLog)
        logs.writeLine("--------------Starting Computing....--------------")
        --UPDATE: only check at night
        logs.writeLine("Checking for requests...")
        local requests = requestWatcher.watchForRequests(colony)

        if table.getn(requests) == 0 then
            logs.writeLine("No requests found")
            --simulate "continue"
        else
            logs.writeLine("Requests found, contacting Applied.....")
            --end debug
            --first go through the requested items and check if they are in the applied storage
            --first get all the items that are in the applied storage and create a hashtable -> because getItem() bugs when the item is not present
            local ae2Items = helpers.buildDic(meBridge.listItems())
            logs.writeLine("Item list set.")
            for i = 1, table.getn(requests), 1 do
                --check if it's in the applied storage and the correct amount
                local itemName = requests[i].id
                local currentItem = { name = itemName }                            --must cast into table
                if ae2Items[itemName] == nil or ae2Items[itemName].amount < requests[i].count then -- item not found or not enougth
                    logs.writeLine("Item: " .. itemName ..
                        " was not found in the storage, or there is not enougth of it. Searching if craft exists...")

                    if not meBridge.isItemCraftable(currentItem) then
                        --add item to uncraftable list
                        uncraftableItems[itemName] = requests[i].count
                        logs.writeLine("Item: " ..
                            itemName .. " is not craftable and has been added to the uncraftable list.")
                    else
                        logs.writeLine("Item: " ..
                            itemName .. " is craftable. Sending craft order...")
                        --check if item is being crafted
                        if meBridge.isItemCrafting(currentItem) then
                            logs.writeLine("Item: " .. itemName .. " is already being crafted.")
                        else
                            --check if cpu is available
                            if not helpers.isCPUAvailable(meBridge.getCraftingCPUs()) then
                                logs.writeLine("No CPU available at the moment, skipping....")
                            else
                                meBridge.craftItem({ name = itemName, count = requests[i].count })
                                logs.writeLine("Item: x" ..
                                    requests[i].count .. itemName .. " are successfully being crafted !")
                            end
                        end
                    end
                else -- item is in the storage
                    logs.writeLine("Item: " ..
                        itemName ..
                        " is in the storage and with the correct amount, sending export order of " ..
                        requests[i].count .. " units...")
                    --export it to the under chest, can update by warping the chest to the peripheral network back at the colony
                    meBridge.exportItem({ name = itemName, count = requests[i].count }, "south")
                    logs.writeLine("Item successfully exported !")
                end
            end
        end
        --update Monitor
        mainMonitorHandler.displayOnMonitor(uncraftableItems, mainMonitor)
        logs.writeLine("--------------Loop Ended--------------")
        logs.flush()
        nbLoopSinceLog = nbLoopSinceLog + 1
        sleep(interval)
    end
end

return { startCheck = startCheck }
