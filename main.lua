-- module state
local cellSize = 20
local columns = love.graphics.getWidth()/cellSize-1
local rows = love.graphics.getHeight()/cellSize-1
local drawSize = 1 - cellSize * 0.01 -- scaled draw size
local refreshRate = 0.100 -- seconds
local sumDT = 0

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
        love.graphics.rectangle("fill", current.x, current.y, drawSize ,drawSize)
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

    local updateTail = function (tail)
        tail.x = Game.player.head.x+1
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

function love.update(dt)
    sumDT = sumDT + dt
    if sumDT >= refreshRate then
        updatePlayer()
        sumDT = sumDT - refreshRate
    end
end

function love.draw()
    love.graphics.scale(cellSize, cellSize)
    drawPlayer()
end