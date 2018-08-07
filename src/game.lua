local new = function(width, height, cellSize, scaleFactor)
    local initPlayer = function(columns, rows)
        local player = require("player")
        local x = math.floor(columns/2)
        local y = math.floor(rows/2)
        local color = { r = 1, g = 1, b = 1 }
        local bodySegmentCount = 3
        return player.new(color, bodySegmentCount, x, y)
    end

    local game = {}
        game.gameOver = true
        game.score = 0
        game.cellSize = cellSize
        game.scaleFactor = scaleFactor
        game.columns = width/cellSize - 1
        game.rows = height/cellSize - 1
        game.direction = "right"
        game.player = initPlayer(game.columns, game.rows)

        function game:setInput(key)
            if key == "up" or key == "right" or key == "down" or key == "left" then
                self.direction = key
            end
        end
    return game
end

return {
    new = new
}