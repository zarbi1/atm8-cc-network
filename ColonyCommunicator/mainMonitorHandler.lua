--Temporary

local function displayOnMonitor(colonyData, monitor)
    --get the size
    width, height = monitor.getSize();
    middleH = height / 2
    middleW = width / 2
    monitor.clear()
    monitor.setCursorPos(middleW - 10, 1)
    monitor.setTextScale(1)
    monitor.write("Uncraftable item list: ")
    local currentLine = 4
    for key, value in pairs(colonyData) do
        monitor.setCursorPos(1, currentLine)
        monitor.write(key .. "   x" .. value)
        currentLine = currentLine + 1
    end
end

return { displayOnMonitor = displayOnMonitor }
