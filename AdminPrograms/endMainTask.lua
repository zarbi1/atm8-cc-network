arg = { ... }
if table.getn(arg) ~= 1 then
    error("Please provide the correct number of arguments", 0)
end
-- check for pericomppheral
local findModem = peripheral.find("modem") or error("No modem attached", 0)
--open the modem
rednet.open("back")
print("Searching for computer '" .. arg[1] .. "'")
local computer = rednet.lookup("EndTask", arg[1])
if not computer then
    rednet.close("back")
    error("No computer with the name: '" .. arg[1] .. "' was found on the EndTask protocol", 0)
end
print("Computer Found ! ID:" .. computer)
print("Sending End Task Order...")

local sent = rednet.send(computer, "end-task", "EndTask")
if not sent then
    rednet.close("back")
    error("Could not send message.", 0)
end
print("Message Sent !")
--finally, close the modem
rednet.close("back")
