function checkForMessages() --continiously check for a end task order
    while true do
        local id, message = rednet.receive("EndTask", 5)
        if id and message == "end-task" then
            print("End Task order received from computer: " .. id)
            break
        end
    end
end

return { checkForMessages = checkForMessages }
