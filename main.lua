function love.load()
    local game = require("game")
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    Game = game.new(w, h)
end

function love.keypressed(k)
    Game:processInput(k)
    
    if Game.quit == true then love.event.quit() end
end

function love.update(dt)
    Game:processUpdate(dt)
end

function love.draw()
    if Game.gameOver then
        Draw.gameOver()
    else
        Draw.play()
    end

    ---[[
    Draw.debug()
    --]]
end

Draw = {}
    function Draw.debug()
        love.graphics.origin()
        love.graphics.setColor(0, 1, 0)

        love.graphics.print(string.format("FPS: %g", love.timer.getFPS()), 20, 20)
        love.graphics.print(string.format("Game.score: %d", Game.score), 20, 40)
        love.graphics.print(string.format("Game.cellSize: %d", Game.cellSize), 20, 60)
        love.graphics.print(string.format("Game.columns: %d", Game.columns), 20, 80)
        love.graphics.print(string.format("Game.rows: %d", Game.rows), 20, 100)
        love.graphics.print(string.format("Game.gameOver: %s", Game.gameOver), 20, 120)
        love.graphics.print(string.format("Game.quit: %s", Game.quit), 20, 140)
        love.graphics.print(string.format("Game.refreshRate: %g", Game.refreshRate), 20, 160)
        love.graphics.print(string.format("Game.sumDT: %g", Game.sumDT), 20, 180)


        love.graphics.print(string.format("Game.player.color: { r=%d, g=%d, b=%d }",
            Game.player.color.r, Game.player.color.g, Game.player.color.b), 240, 20)
        love.graphics.print(string.format("Game.player.bodySegmentCount: %d",
            Game.player.bodySegmentCount), 240, 40)
        love.graphics.print(string.format("Game.player.body.head: { x=%d, y=%d }",
            Game.player.body.head.x, Game.player.body.head.y), 240, 60)
        love.graphics.print(string.format("Game.player.direction: %s", 
            Game.player.direction), 240, 80)
        love.graphics.print(string.format("Game.player.updated: %s",
            Game.player.updated), 240, 100)

        love.graphics.print(string.format("Game.food.color: { r=%d, g=%d, b=%d }",
            Game.food.color.r, Game.food.color.g, Game.food.color.b), 240, 120)
        if Game.food.location then
            love.graphics.print(string.format("Game.food.location: { x=%d, y=%d }",
                Game.food.location.x, Game.food.location.y), 240, 140)
        end

    end

    function Draw.play()
        love.graphics.scale(Game.cellSize, Game.cellSize)
        love.graphics.setColor(Game.player.color.r, Game.player.color.g,
            Game.player.color.b)

        local drawSegment = function(current)
            love.graphics.rectangle("fill", current.x, current.y, 1, 1)
        end

        local current = Game.player.body.head
        drawSegment(current)
        while current.next ~= nil do
            current = current.next
            drawSegment(current)
        end

        if Game.food.location then
            love.graphics.setColor(Game.food.color.r, Game.food.color.g,
                Game.food.color.b)
            love.graphics.rectangle("fill", Game.food.location.x,
                Game.food.location.y, 1, 1)
        end
    end

    function Draw.gameOver()
        local defaultFont = love.graphics.getFont()
        love.graphics.setFont(love.graphics.newFont("nes.otf", 20))
        love.graphics.origin()
        love.graphics.setColor(1, 1, 1)

        love.graphics.print("GAME OVER", 20, 20)
        love.graphics.print(string.format("SCORE: %04d", Game.score), 
            580, 20)
        love.graphics.print("<SPACE> TO START", 250, 500)
        love.graphics.print("<ESC> TO QUIT", 280, 540)

        love.graphics.setFont(defaultFont)
    end
-- end draw table