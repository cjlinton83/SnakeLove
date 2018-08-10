local new = function(width, height, cellSize, scaleFactor)
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
        game.gameOver = true
        game.score = 0
        game.cellSize = cellSize
        game.scaleFactor = scaleFactor
        game.columns = width/cellSize - 1
        game.rows = height/cellSize - 1
        game.player = initPlayer(game.columns, game.rows)

        function game:setInput(key)
            if key == "up" or key == "right" or key == "down" or key == "left" then
                self.player.direction = key
            end
            if key == "space" and self.gameOver then
                self.gameOver = false
            end
        end

        function game:update()
            self.gameOver = self.player:update(self.columns, self.rows)
        end
    return game
end

return {
    new = new
}