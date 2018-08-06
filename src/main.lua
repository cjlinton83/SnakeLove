function love.load()
    local game = require("game")
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local cellSize = 20

    Game = game.new(w, h, cellSize)
end

function love.draw()
    ---[[ DEBUG DATA
    love.graphics.print(string.format("Game.columns: %d", Game.columns), 20, 20)
    love.graphics.print(string.format("Game.rows: %d", Game.rows), 20, 40)
    love.graphics.print(string.format("Game.gameOver: %s", Game.gameOver), 20, 60)
    love.graphics.print(string.format("Game.cellSize: %d", Game.cellSize), 20, 80)
    love.graphics.print(string.format("Game.score: %d", Game.score), 20, 100)
    --]]
end