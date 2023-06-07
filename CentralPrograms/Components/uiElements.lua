--Currently not Implemented

local function loading(mainFrame)
    local pane1 = mainFrame:addPane():setSize("parent.w * 0.17", 1):setPosition("parent.w * 0.45", "parent.h * 0.6")
        :setBackground(false, "\140",
            colors.blue)
    local pane2 = mainFrame:addPane():setSize(1, "parent.h * 0.39"):setPosition("parent.w * 0.45",
            "parent.h * 0.2")
        :setBackground(false, "\149",
            colors.red)

    local pane4 = mainFrame:addPane():setSize(1, "parent.h * 0.39"):setPosition("parent.w * 0.61",
            "parent.h * 0.2")
        :setBackground(false, "\149",
            colors.red)

    local pane3 = mainFrame:addPane():setSize("parent.w * 0.17", 1):setPosition("parent.w * 0.45", "parent.h * 0.2")
        :setBackground(false, "\140",
            colors.blue)

    -- I know it's ugly, please create a PR if you have a better solution, my knowledge with basalt is very limited haha
    local changeState = true


    --CYCLE I

    pane1:animatePosition(pane1:getX(), pane1:getY(), 1, 0, "linear",
        function()
            pane1:setBackground(false, "\140",
                colors.red)
        end)
    pane2:animatePosition(pane2:getX(), pane2:getY(), 0.5, 0, "linear",
        function()
            pane2:setBackground(false, "\149",
                colors.blue)
        end)

    pane3:animatePosition(pane3:getX(), pane3:getY(), 1, 0, "linear",
        function()
            pane3:setBackground(false, "\140",
                colors.red)
        end)

    pane4:animatePosition(pane4:getX(), pane4:getY(), 0.5, 0, "linear",
        function()
            pane4:setBackground(false, "\149",
                colors.blue)
        end)
    --autodestruct
end

return { loading = loading }
