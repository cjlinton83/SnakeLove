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
        game.gameOver = true
        game.quit = false
        game.refreshRate = 0.05 -- refresh every 3 frames, 20 times a second

        function game:initPlayState()
            self.score = 0
            self.sumDT = 0
            self.player = initPlayer(self.columns, self.rows)
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
                    self.sumDT = self.sumDT - self.refreshRate
                end
            end
        end
    return game
end

return {
    new = new
}