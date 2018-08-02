local cellSize = 24
local columns = math.floor(love.graphics.getWidth()/cellSize)-1
local rows = math.floor(love.graphics.getHeight()/cellSize)-1
local scaledDrawSize = 0.8

-- constructors
local newSegment = function(x, y)
    local s = {}
    s.x = x
    s.y = y
    return s
end

local newPlayer = function()
    local bodySize = 3

    local newBody = function()
        local x = math.floor(columns/2)
        local y = math.floor(rows/2)
        local head = newSegment(x, y)
        local current = head
        for i = bodySize-1, bodySize do
            current.next = newSegment(current.x-1, current.y)
            current = current.next
        end
        return head
    end

    local p = {}
    p.color = { r = 1, g = 1, b = 1 }
    p.head = newBody()
    p.direction = "right"
    return p
end

local newGame = function()
    local g = {}
    g.isOver = true
    g.player = newPlayer()
    return g
end

-- behavior
local setFont = function()
    local fontSize = cellSize
    local font = love.graphics.newFont("nes.otf", fontSize)
    love.graphics.setFont(font)
end

local drawPlayer = function()
    local drawSegment = function(current)
        love.graphics.rectangle("fill", current.x, current.y,
            scaledDrawSize , scaledDrawSize)
    end

    local current = Game.player.head
    while current.next ~= nil do
        drawSegment(current)
        current = current.next
    end
    drawSegment(current)
end

local updatePlayer = function()
    local popTail = function()
        local previous = {}
        local current = Game.player.head
        while current.next ~= nil do
            previous = current
            current = current.next
        end
        previous.next = nil
        return current
    end

    local updateSegment = function (segment)
        if Game.player.direction == "right" then
            local dx = Game.player.head.x+1
            if dx == columns+1 then dx = 0 end
            segment.x = dx
            segment.y = Game.player.head.y
        end
        if Game.player.direction == "left" then
            local dx = Game.player.head.x-1
            if dx == -1 then dx = columns end
            segment.x = dx
            segment.y = Game.player.head.y
        end
        if Game.player.direction == "up" then
            local dy = Game.player.head.y-1
            if dy == -1 then dy = rows end
            segment.y = dy
            segment.x = Game.player.head.x
        end
        if Game.player.direction == "down" then
            local dy = Game.player.head.y+1
            if dy == rows+1 then dy = 0 end
            segment.y = dy
            segment.x = Game.player.head.x
        end
    end

    local pushHead = function(segment)
        segment.next = Game.player.head
        Game.player.head = segment
    end

    local updatePosition = function()
        local segment = popTail()
        updateSegment(segment)
        pushHead(segment)
    end

    local checkCollision = function()
    end

    updatePosition()
    checkCollision()
end

-- LÖVE --
function love.load()
    Game = newGame()
    setFont()
end

function love.keypressed(k)
    if k == "q" or k == "escape" then love.event.quit() end
    if k == "up" or k == "down" or k == "left" or k == "right" then
        if Game.player ~= nil then
            Game.player.direction = k 
        end
    end
    if k == "space" then Game.isOver = not Game.isOver end
end

function love.update(dt)
    if Game.isOver then
        Game.player = nil
    else
        if Game.player == nil then 
            Game.player = newPlayer()
        end
        updatePlayer()
    end
end

function love.draw()
    love.graphics.scale(cellSize, cellSize)

    if Game.isOver then
    else
        drawPlayer()
    end
end