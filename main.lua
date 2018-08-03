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
    local newBody = function()
        local bodySize = 3
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

    function p:update(game)
        local popTail = function()
            local previous = {}
            local current = self.head
            while current.next ~= nil do
                previous = current
                current = current.next
            end
            previous.next = nil
            return current
        end

        local updateSegment = function (segment)
            local dx = self.head.x
            local dy = self.head.y

            if self.direction == "right" then
                dx = dx + 1
                if dx == columns+1 then dx = 0 end
            end
            if self.direction == "left" then
                dx = dx - 1
                if dx == -1 then dx = columns end
            end
            if self.direction == "up" then
                dy = dy - 1
                if dy == -1 then dy = rows end
            end
            if self.direction == "down" then
                dy = dy + 1
                if dy == rows+1 then dy = 0 end
            end

            segment.x = dx
            segment.y = dy
        end

        local pushHead = function(segment)
            segment.next = self.head
            self.head = segment
        end

        local updatePosition = function()
            local segment = popTail()
            updateSegment(segment)
            pushHead(segment)
        end
    
        local checkCollision = function()
            local current = self.head
            local headX = current.x
            local headY = current.y

            -- check for collision with self
            while current.next ~= nil do
                if current.next.x == headX and current.next.y == headY then
                    game.isOver = true
                end
                current = current.next
            end
            if current.x == headX and current.y == headY then
                game.isOver = true
            end

            -- check for collision with food
        end
    
        updatePosition()
        checkCollision()    
    end

    function p:draw()
        love.graphics.scale(cellSize, cellSize)
        
        local drawSegment = function(current)
            love.graphics.rectangle("fill", current.x, current.y,
                scaledDrawSize , scaledDrawSize)
        end
    
        local current = self.head
        while current.next ~= nil do
            drawSegment(current)
            current = current.next
        end
        drawSegment(current)
    end

    return p
end

local newGame = function()
    local g = {}
    g.isOver = true
    g.player = newPlayer()
    g.score = 0
    g.strings = {
        gameOver = string.upper("game over"),
        score = string.upper(string.format("score: %04d", tostring(g.score))),
        start = string.upper("press <space> to begin"),
    }

    function g:input(k)
        if k == "q" or k == "escape" then love.event.quit() end
        if k == "up" or k == "down" or k == "left" or k == "right" then
            if self.player ~= nil then
                self.player.direction = k 
            end
        end
        if k == "space" then self.isOver = not self.isOver end
    end

    function g:update()
        if self.isOver then
            self.player = nil
        else
            if self.player == nil then 
                self.player = newPlayer()
            end
            self.player:update(self)
        end
    end

    function g:drawGameOver()
        love.graphics.origin()
        love.graphics.print(self.strings.gameOver, cellSize, cellSize)
        love.graphics.print(self.strings.score,
            love.graphics.getWidth()-#self.strings.score * cellSize, cellSize)
        love.graphics.print(self.strings.start, cellSize, 552)
    end

    function g:draw()
        if self.isOver then
            self:drawGameOver()
        else
            self.player:draw()
        end
    end

    return g
end

-- LÖVE --
function love.load()
    love.graphics.setFont(love.graphics.newFont("nes.otf", cellSize))
    Game = newGame()
end

function love.keypressed(k)
    Game:input(k)
end

function love.update(dt)
    Game:update()
end

function love.draw()
    Game:draw()
end