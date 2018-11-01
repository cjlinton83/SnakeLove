function love.load()
    local game = require("game")
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    love.mouse.setVisible(false)
    math.randomseed(os.time())

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
    Draw.background()

    if Game.gameOver then
        Draw.gameOver()
    else
        Draw.play()
    end
end

Draw = {}
    function Draw.text(text, x, y)
        local defaultFont = love.graphics.getFont()
        love.graphics.setFont(love.graphics.newFont("nes.otf", 20))
        love.graphics.print(text, x, y)
        love.graphics.setFont(defaultFont)
    end

    function Draw.background()
        local drawScore = function()
            love.graphics.setColor(1, 1, 1)
            local p1score = 0
            local p2score = 0

            if Game.playerTable then
                p1score = Game.playerTable[1].score
                if Game.playerTable[2] then
                    p2score = Game.playerTable[2].score
                end
            end

            Draw.text(string.format("PLAYER 1: %04d", p1score), 20, 8)
            if Game.playerCount == 2 then
                Draw.text(string.format("PLAYER 2: %04d", p2score), 540, 8)
            end
        end

        local drawPlayArea = function()
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("fill", 0, 2, Game.columns+1, Game.rows-1)
            
            love.graphics.setColor(0, 0, 0, 0.8)
            love.graphics.rectangle("fill", 0, 2, Game.columns+1, Game.rows-1)
        end

        love.graphics.origin()
        drawScore()

        love.graphics.scale(Game.cellSize, Game.cellSize)
        drawPlayArea()
    end

    function Draw.play()
        local drawPlayer = function()
            local drawSegment = function(current)
                love.graphics.rectangle("fill", current.x, current.y, 1, 1)
            end

            local drawHead = function(current)
                love.graphics.draw(love.graphics.newImage("head.png"), current.x, current.y, 0, 0.05, 0.05)
            end

            local drawPlayerOne = function()
                love.graphics.setColor(Game.player.color.r, Game.player.color.g,
                Game.player.color.b)
    
                local current = Game.player.body.head
                drawHead(current)
                while current.next ~= nil do
                    current = current.next
                    drawSegment(current)
                end
            end

            drawPlayerOne()
        end

        local drawFood = function()
            if Game.food.location then
                love.graphics.setColor(Game.food.color.r, Game.food.color.g,
                    Game.food.color.b)
                love.graphics.rectangle("fill", Game.food.location.x,
                    Game.food.location.y, 1, 1)
            end
        end

        love.graphics.origin()
        if Game.start then
            love.graphics.setColor(1, 1, 1)
            if Game.currentPlayer == 1 then
                Draw.text("READY PLAYER 1", 275, 260)
            else
                Draw.text("READY PLAYER 2", 275, 260)
            end
            Draw.text("PRESS ANY KEY TO CONTINUE", 175, 300)
        else
            love.graphics.scale(Game.cellSize, Game.cellSize)
            drawPlayer()
            drawFood()
        end
    end

    function Draw.gameOver()
        local drawPlayerSelect = function()
            if Game.playerCount == 1 then
                love.graphics.rectangle("fill", 307, 225, 180, 30)
                love.graphics.setColor(0, 0, 0)
                Draw.text("1  PLAYER", 320, 225)
                love.graphics.setColor(1, 1, 1)
                Draw.text("2  PLAYER", 318, 275)
            else
                love.graphics.rectangle("fill", 307, 275, 180, 30)
                love.graphics.setColor(1, 1, 1)
                Draw.text("1  PLAYER", 320, 225)
                love.graphics.setColor(0, 0, 0)
                Draw.text("2  PLAYER", 318, 275)
            end
        end

        love.graphics.origin()
        love.graphics.setColor(1, 1, 1)

        drawPlayerSelect()
    
        love.graphics.setColor(1, 1, 1)
        Draw.text("<ENTER> TO START", 250, 500)
        Draw.text("<ESC> TO QUIT", 280, 540)
    end

    function Draw.debug()
        love.graphics.origin()
        love.graphics.setColor(0, 1, 0)

        love.graphics.print(string.format("FPS: %g", love.timer.getFPS()), 20, 40)
        love.graphics.print(string.format("Game.cellSize: %d", Game.cellSize), 20, 60)
        love.graphics.print(string.format("Game.columns: %d", Game.columns), 20, 80)
        love.graphics.print(string.format("Game.rows: %d", Game.rows), 20, 100)
        love.graphics.print(string.format("Game.gameOver: %s", Game.gameOver), 20, 120)
        love.graphics.print(string.format("Game.quit: %s", Game.quit), 20, 140)
        love.graphics.print(string.format("Game.refreshRate: %g", Game.refreshRate), 20, 160)
        love.graphics.print(string.format("Game.sumDT: %g", Game.sumDT), 20, 180)
        love.graphics.print(string.format("Game.singlePlayer: %s", Game.singlePlayer), 20, 200)

        love.graphics.print(string.format("Game.player.bodySegmentCount: %d",
            Game.player.bodySegmentCount), 240, 40)
        love.graphics.print(string.format("Game.player.body.head: { x=%d, y=%d }",
            Game.player.body.head.x, Game.player.body.head.y), 240, 60)
        love.graphics.print(string.format("Game.player.direction: %s", 
            Game.player.direction), 240, 80)
        love.graphics.print(string.format("Game.player.updated: %s",
            Game.player.updated), 240, 100)
        love.graphics.print(string.format("Game.player.color: { r=%d, g=%d, b=%d }",
            Game.player.color.r, Game.player.color.g, Game.player.color.b), 240, 120)

        love.graphics.print(string.format("Game.food.color: { r=%d, g=%d, b=%d }",
            Game.food.color.r, Game.food.color.g, Game.food.color.b), 240, 140)
        if Game.food.location then
            love.graphics.print(string.format("Game.food.location: { x=%d, y=%d }",
                Game.food.location.x, Game.food.location.y), 240, 160)
        end
    end
-- end draw table