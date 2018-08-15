local new = function(width, height)
    local initPlayer = function(columns, rows)
        local player = require("player")
        local x = math.floor(columns/2)
        local y = math.floor(rows/2)
        local color = { r = 1, g = 1, b = 1 }
        local bodySegmentCount = 3
        local direction = "right"
        return player.new(color, bodySegmentCount, x, y, direction)
    end

    local game = {}
        game.cellSize = 20
        game.columns = width/game.cellSize - 1
        game.rows = height/game.cellSize - 1
        game.cellCount = game.columns * game.rows
        game.gameOver = true
        game.quit = false
        game.refreshRate = 0.05 -- refresh every 3 frames, 20 times a second

        function game:initPlayState()
            self.score = 0
            self.sumDT = 0
            self.player = initPlayer(self.columns, self.rows)
            self.food = require("food").new({ r=1, g=0, b=0 })
        end
        game:initPlayState()

        function game:keypressed(key)
            if self.gameOver then
                if key == "space" then
                    self:initPlayState()
                    self.gameOver = false
                end
            else
                if key == "up" or key == "down" or
                   key == "left" or key == "right" then
                       self.player.direction = key
                end
            end

            if key == "escape" then self.quit = true end
        end

        function game:update(dt)
            if not self.gameOver then
                self.sumDT = self.sumDT + dt

                if self.sumDT >= self.refreshRate then
                    self.gameOver = self.player:update(self.columns, self.rows)
                    self.food:update(self)
                    self.sumDT = self.sumDT - self.refreshRate
                end
            end
        end

        function game:hasEmptySpace()
            if self.player.bodySegmentCount >= self.cellCount then
                return false
            end
            return true
        end

        function game:getEmptyLocation()
            local getLocation = function()
                local x = math.random(0, self.columns)
                local y = math.random(0, self.rows)
                return { x=x, y=y }
            end

            local location = getLocation()
            while self.player:containsLocation(location) do
                location = getLocation()
            end

            return location
        end

        function game:incrementScore()
            self.score = self.score + 1
        end
    return game
end

return {
    new = new
}