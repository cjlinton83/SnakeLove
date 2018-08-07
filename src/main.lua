function love.load()
    local game = require("game")
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local cellSize = 20
    local scaleFactor = 0.8

    Game = game.new(w, h, cellSize, scaleFactor)
end

function love.keypressed(k)
    if k == "escape" then love.event.quit() end

    Game:setInput(k)
end

function love.update(dt)
    Game:update()
end

function love.draw()
    Draw.player()
    Draw.debug()
end

Draw = {}
    function Draw.debug()
        love.graphics.origin()
        love.graphics.setColor(0, 1, 0)

        love.graphics.print(string.format("Game.gameOver: %s", Game.gameOver), 20, 20)
        love.graphics.print(string.format("Game.score: %d", Game.score), 20, 40)
        love.graphics.print(string.format("Game.cellSize: %d", Game.cellSize), 20, 60)
        love.graphics.print(string.format("Game.scaleFactor: %g", Game.scaleFactor), 20, 80)
        love.graphics.print(string.format("Game.columns: %d", Game.columns), 20, 100)
        love.graphics.print(string.format("Game.rows: %d", Game.rows), 20, 120)
        love.graphics.print(string.format("Game.directon: %s", Game.direction), 20, 140)

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