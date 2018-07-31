local cellSize = 20
local columns = love.graphics.getWidth()/cellSize-1
local rows = love.graphics.getHeight()/cellSize-1

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
        for i = 2, bodySize do
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

function love.load()
    Game = newGame()
end