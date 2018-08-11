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
        game.score = 0
        game.cellSize = cellSize
        game.scaleFactor = scaleFactor
        game.columns = width/cellSize - 1
        game.rows = height/cellSize - 1
        game.player = initPlayer(game.columns, game.rows)
        game.gameOver = true
        game.quit = false

        function game:keypressed(key)
            if self.gameOver then
                if key == "space" then
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
    return game
end

return {
    new = new
}