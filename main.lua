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

    local update = function(game)
        local popTail = function()
            local previous = {}
            local current = game.player.head
            while current.next ~= nil do
                previous = current
                current = current.next
            end
            previous.next = nil
            return current
        end
    
        local updateSegment = function (segment)
            if game.player.direction == "right" then
                local dx = game.player.head.x+1
                if dx == columns+1 then dx = 0 end
                segment.x = dx
                segment.y = game.player.head.y
            end
            if game.player.direction == "left" then
                local dx = game.player.head.x-1
                if dx == -1 then dx = columns end
                segment.x = dx
                segment.y = game.player.head.y
            end
            if game.player.direction == "up" then
                local dy = game.player.head.y-1
                if dy == -1 then dy = rows end
                segment.y = dy
                segment.x = game.player.head.x
            end
            if game.player.direction == "down" then
                local dy = game.player.head.y+1
                if dy == rows+1 then dy = 0 end
                segment.y = dy
                segment.x = game.player.head.x
            end
        end
    
        local pushHead = function(segment)
            segment.next = game.player.head
            game.player.head = segment
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

    local draw = function(game)
        love.graphics.scale(cellSize, cellSize)
        
        local drawSegment = function(current)
            love.graphics.rectangle("fill", current.x, current.y,
                scaledDrawSize , scaledDrawSize)
        end
    
        local current = game.player.head
        while current.next ~= nil do
            drawSegment(current)
            current = current.next
        end
        drawSegment(current)
    end

    local p = {}
    p.color = { r = 1, g = 1, b = 1 }
    p.head = newBody()
    p.direction = "right"
    p.update = update
    p.draw = draw
    return p
end

local newGame = function()
    local input = function(game, k)
        if k == "q" or k == "escape" then love.event.quit() end
        if k == "up" or k == "down" or k == "left" or k == "right" then
            if game.player ~= nil then
                game.player.direction = k 
            end
        end
        if k == "space" then Game.isOver = not Game.isOver end
    end

    local update = function(game)
        if game.isOver then
            game.player = nil
        else
            if game.player == nil then 
                game.player = newPlayer()
            end
            game.player.update(game)
        end
    end

    local drawGameOver = function(game)
        love.graphics.origin()
        love.graphics.print(game.strings.gameOver, cellSize, cellSize)
        love.graphics.print(game.strings.score,
            love.graphics.getWidth()-#game.strings.score * cellSize, cellSize)
        love.graphics.print(game.strings.start, cellSize, 552)
    end

    local draw = function(game)
        if game.isOver then
            drawGameOver(game)
        else
            game.player.draw(game)
        end
    end

    local g = {}
    g.isOver = true
    g.player = newPlayer()
    g.score = 0
    g.strings = {
        gameOver = "Game Over",
        score = string.format("Score: %04d", tostring(g.score)),
        start = "Press <SPACE> to Begin",
    }
    g.input = input
    g.update = update
    g.draw = draw
    return g
end

-- LÖVE --
function love.load()
    local loveSetup = function()
        local setFont = function()
            local fontSize = cellSize
            local font = love.graphics.newFont("nes.otf", fontSize)
            love.graphics.setFont(font)
        end
    
        setFont()    
    end

    loveSetup()
    Game = newGame()
end

function love.keypressed(k)
    Game.input(Game, k)
end

function love.update(dt)
    Game.update(Game)
end

function love.draw()
    Game.draw(Game)
end