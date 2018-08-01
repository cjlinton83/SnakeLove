-- module state
local cellSize = 20
local columns = love.graphics.getWidth()/cellSize-1
local rows = love.graphics.getHeight()/cellSize-1
local scaledSize = 1 - cellSize * 0.01
local refreshRate = 0.075 -- seconds
local sumDT = 0
local playerDirection = "right"

-- module constructors
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
    return p
end

local newGame = function()
    local g = {}
    g.isOver = true
    g.player = newPlayer()
    return g
end

-- module behavior
local drawPlayer = function()
    local drawSegment = function(current)
        love.graphics.rectangle("fill", current.x, current.y, scaledSize ,scaledSize)
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

    -- update to the new coordinates before pushing to head of body
    local updateTail = function (tail)
        if playerDirection == "right" then
            local dx = Game.player.head.x+1
            if dx == columns+1 then dx = 0 end
            tail.x = dx
            tail.y = Game.player.head.y
        end
        if playerDirection == "left" then
            local dx = Game.player.head.x-1
            if dx == -1 then dx = columns end
            tail.x = dx
            tail.y = Game.player.head.y
        end
        if playerDirection == "up" then
            local dy = Game.player.head.y-1
            if dy == -1 then dy = rows end
            tail.y = dy
            tail.x = Game.player.head.x
        end
        if playerDirection == "down" then
            local dy = Game.player.head.y+1
            if dy == rows+1 then dy = 0 end
            tail.y = dy
            tail.x = Game.player.head.x
        end
    end

    local pushHead = function(tail)
        tail.next = Game.player.head
        Game.player.head = tail
    end

    local tail = popTail()
    updateTail(tail)
    pushHead(tail)
end

-- love defined callbacks
function love.load()
    Game = newGame()
end

function love.keypressed(k)
    if k == "q" or k == "escape" then love.event.quit() end
    if k == "up" then playerDirection = "up" end
    if k == "down" then playerDirection = "down" end
    if k == "left" then playerDirection = "left" end
    if k == "right" then playerDirection = "right" end
    if k == "space" then Game.isOver = false end
    if k == "o" then Game.isOver = true end
end

function love.update(dt)
    if not Game.isOver then
        sumDT = sumDT + dt
        if sumDT >= refreshRate then
            updatePlayer()
            sumDT = sumDT - refreshRate
        end
    end
end

function love.draw()
    love.graphics.print("playerDirection: " .. playerDirection)

    love.graphics.scale(cellSize, cellSize)
    drawPlayer()
end