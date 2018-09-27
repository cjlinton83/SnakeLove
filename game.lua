local new = function(width, height)
    local game = {}
        game.cellSize = 20
        game.columns = width/game.cellSize - 1
        game.rows = height/game.cellSize - 1
        game.cellCount = game.columns * game.rows - (2 * game.columns)  -- minus header cells
        game.gameOver = true
        game.quit = false
        game.refreshRate = 0.07

        function game:initPlayState()
            local initPlayer = function(columns, rows)
                local player = require("player")
                local x = math.floor(columns/2)
                local y = math.floor(rows/2)
                local color = { r = 1, g = 1, b = 1 }
                local bodySegmentCount = 3
                local direction = "right"
                return player.new(color, bodySegmentCount, x, y, direction)
            end

            local initFood = function()
                local food = require("food")
                local color = { r=1, g=0, b=0 }
                return food.new(color)
            end

            self.score = 0
            self.sumDT = 0
            self.player = initPlayer(self.columns, self.rows)
            self.food = initFood()
        end
        game:initPlayState()

        function game:processInput(key)
            local processInputGameOver = function(key)
                if key == "return" then
                    self:initPlayState()
                    self.gameOver = false
                end
            end

            local processInputPlayState = function(key)
                local direction = self.player.direction

                if self.player.updated then
                    self.player.updated = false
                    
                    if key == "up" or key == "down" then
                        if direction == "right" or direction == "left" then
                            self.player.direction = key
                        end
                    end
                    if key == "left" or key == "right" then
                        if direction == "up" or direction == "down" then
                            self.player.direction = key
                        end
                    end
                end
            end
 
            if self.gameOver then
                processInputGameOver(key)
            else
                processInputPlayState(key)
            end

            if key == "escape" then self.quit = true end
        end

        function game:processUpdate(dt)
            local processUpdatePlayState = function(dt)
                self.sumDT = self.sumDT + dt
    
                if self.sumDT >= self.refreshRate then
                    self.gameOver = self.player:update(self.columns, self.rows)
                    self.food:update(self)
                    self.sumDT = self.sumDT - self.refreshRate
                end
            end

            if not self.gameOver then
                processUpdatePlayState(dt)
            end
        end

        function game:hasEmptyLocation()
            if self.player.bodySegmentCount >= self.cellCount then
                return false
            end
            return true
        end

        function game:getEmptyLocation()
            local getLocation = function()
                local x = math.random(0, self.columns)
                local y = math.random(2, self.rows)
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