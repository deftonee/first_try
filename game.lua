
gameScene = nil

circle_actor = nil
figures = {}
walls = {}

function inTable(tbl, item)
    for _, value in pairs(tbl) do
        if value == item then return true end
    end
    return false
end

local function move_figure_by_event(figure, event)
    if event.phase == "ended" then
        figure.touched = nil
    elseif event.phase == "began" then
        figure.touched = event.id -- track which finger was held down on the node
        figure.touchDx = event.x - figure.x
        figure.touchDy = event.y - figure.y
    end
    if event.phase == 'moved' then
        figure.x = event.x - figure.touchDx
        figure.y = event.y - figure.touchDy
    end
end


local function touchListener(self, event)
    -- если почему то нам не передали event
    if not event then return end

--    print(event.id, event.target, type(event.target))
--    print(inTable(figures, event.target))

    -- трогают не нас
    if self.touched and event.id ~= self.touched then
        return

    end

    -- трогают поле
    if not event.target then
        if event.phase ~= 'began' then
            for _, f in ipairs(figures) do
                if f.touched == event.id then
                    return move_figure_by_event(f, event)
                end
            end
        end
        return
    end

    -- нас не трогают
    if event.phase ~= 'began' and not self.touched then return end

    -- listener called for node, not system
    return move_figure_by_event(self, event)
end

local function systemTouchListener(event)
    --
    return touchListener({}, event)
end


--    for k, v in pairs(figures) do
--        print(k, v == event.target)



-- Initialise the games user interface
local function initUI()

--    -- Create grid background
--    local background = director:createRectangle({
--        x=0, y=0, w=director.displayWidth, h=director.displayHeight,
--        color=color.darkGreen,
--        zOrder=-5,
--    })

    local panel = director:createRectangle({
        x=0, y=director.displayHeight - panelHeight, w=director.displayWidth, h= panelHeight,
        color=color.green,
        zOrder=-5,
    })
    
    
    -- Create score label text
--    local Label = director:createLabel( {
--        x = 20 * fontScale, y = uiYPosition - 20 * fontScale,
--        w = director.displayWidth, h = actualFontHeight,
--        text="Score:",
--        hAlignment="left", vAlignment="top",
--        font=defaultFont,
--        textXScale = fontScale,
--        textYScale = fontScale,
--        color = color.yellow
--    })


end


-- Initialise the game
function init()
    -- Create a scene via the director to contain the main game view
    gameScene = director:createScene()
    director:startRendering()
    physics:setGravity(0, 0)
    math.randomseed(os.time())
    system:addEventListener("touch", systemTouchListener)

    for k, v in pairs(wall_params) do
        walls[k] = director:createRectangle(v)
        physics:addNode(walls[k], {type="static"})
    end

    circle_actor = director:createCircle({
        name = "ball",
        x=fieldWidth/2, y=fieldHeight/2,
        radius=10,
        xAnchor=0.5, yAnchor=0.5,
        color={255,0,0},
    })

    physics:addNode(circle_actor, {
        radius=circle_actor.radius,
        friction=0,
        density=0,
        restitution=1,
    })

    circle_actor.physics:applyLinearImpulse(math.random(5), math.random(5), 0, 0)

    local i = figures_num
    while i > 0 do
        i = i - 1

        local bodyType = math.random(0, 3)
        local x = math.random(fieldWidth)
        local y = math.random(fieldHeight)
        local b
        if bodyType == 0 then
            -- Create ball
            b = director:createCircle({
                name = "ball",
                x=x, y=y, radius=40,
                xAnchor=0.5, yAnchor=0.5,
                strokeWidth=4, strokeColor=color.red, color=color.darkRed,
            })
            physics:addNode(b, {radius=b.radius})

        elseif bodyType == 1 then
            -- Create crate
            b = director:createRectangle({
                name = "crate",
                x=x, y=y, w=40, h=40,
                xAnchor=0.5, yAnchor=0.5,
                xScale = 2, yScale = 1,
                strokeWidth=4, strokeColor=color.green, color=color.darkGreen,
            })
            physics:addNode(b, {})

        else
            -- Create triangle
            b = director:createLines({
                name = "tri",
                x=x, y=y, coords=triCoordsDraw,
                xAnchor=0.5, yAnchor=0.5,
                strokeWidth=4, strokeColor=color.cyan, color=color.darkCyan,
            })
            physics:addNode(b, {shape=triCoordsBody, })
        end
        table.insert(figures, b)

        b.touch = touchListener
        b:addEventListener('touch', b)
        b.rotation = 22.5
    end


    -- Initialise UI
    initUI()

--
--    -- initialise info panel UI
--    initInfoPanelUI()
--
--    -- Create Pause Menu
--    pauseMenu.init()
--
--    -- Create Main Menu
--    mainMenu.init()

    -- Add event touch and update handlers
--    system:addEventListener("touch", touch)
--    system:addEventListener("update", update)
end
