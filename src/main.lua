function love.load()
    local game = require("game")
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local cellSize = 20
    local scaleFactor = 0.8

    Game = game.new(w, h, cellSize, scaleFactor)
end

function love.keypressed(k)
end

function love.update(dt)
end

function love.draw()
    Draw.debugData()
    Draw.player()
end

Draw = {}
    function Draw.debugData()
        love.graphics.origin()
        love.graphics.setColor(1, 1, 1)

        love.graphics.print(string.format("Game.columns: %d", Game.columns), 20, 20)
        love.graphics.print(string.format("Game.rows: %d", Game.rows), 20, 40)
        love.graphics.print(string.format("Game.gameOver: %s", Game.gameOver), 20, 60)
        love.graphics.print(string.format("Game.cellSize: %d", Game.cellSize), 20, 80)
        love.graphics.print(string.format("Game.score: %d", Game.score), 20, 100)

        love.graphics.print(string.format("Game.player.color: { r=%d, g=%d, b=%d }",
            Game.player.color.r, Game.player.color.g, Game.player.color.b), 240, 20)
        love.graphics.print(string.format("Game.player.bodySegmentCount: %d",
            Game.player.bodySegmentCount), 240, 40)
        love.graphics.print(string.format("Game.player.body.head: { x=%d, y=%d }",
            Game.player.body.head.x, Game.player.body.head.y), 240, 60)
    end

    function Draw.player()
        love.graphics.scale(Game.cellSize, Game.cellSize)
        love.graphics.setColor(Game.player.color.r, Game.player.color.g,
            Game.player.color.b)

        local drawSegment = function(current)
            love.graphics.rectangle("fill", current.x, current.y, Game.scaleFactor,
                Game.scaleFactor)
        end

        local current = Game.player.body.head
        drawSegment(current)
        while current.next ~= nil do
            current = current.next
            drawSegment(current)
        end
    end
-- end draw table