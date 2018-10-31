function love.load()
    love.mouse.setVisible(false)
    math.randomseed(os.time())

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    Game = require("game").new(w, h)

    HeadGFX = love.graphics.newImage("head.png")
end

function love.keypressed(k)
    if k == "escape" then love.event.quit() end

    Game:handleInput(k)
end

function love.update(dt)
    Game:handleUpdate(dt)
end

function love.draw()
    Draw.background()

    if Game.state.select then
        Draw.select()
    end

    if Game.state.ready then
        Draw.ready()
    end

    if Game.state.play then
        Draw.play()
    end

    if Game.state.over then
    end

    Draw.debug() 
end

Draw = {}
    function Draw.text(text, x, y)
        local defaultFont = love.graphics.getFont()
        love.graphics.setFont(love.graphics.newFont("nes.otf", 20))
        love.graphics.print(text, x, y)
        love.graphics.setFont(defaultFont)
    end

    function Draw.background()
        love.graphics.origin()
        love.graphics.scale(Game.data.cellSize, Game.data.cellSize)

        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", 0, 2, Game.data.columns+1, Game.data.rows-1)

        love.graphics.setColor(0, 0, 0, 0.8)
        love.graphics.rectangle("fill", 0, 2, Game.data.columns+1, Game.data.rows-1)  
    end

    function Draw.select()
        love.graphics.origin()

        love.graphics.setColor(1, 1, 1)
        Draw.text("SNAKE LÖVE", 307, 4)

        if Game.data.playerCount == 1 then
            love.graphics.rectangle("fill", 309, 225, 180, 30)
            love.graphics.setColor(0, 0, 0)
            Draw.text("1 PLAYER", 326, 225)
            love.graphics.setColor(1, 1, 1)
            Draw.text("2 PLAYER", 322, 275)
        else
            love.graphics.rectangle("fill", 309, 275, 180, 30)
            love.graphics.setColor(1, 1, 1)
            Draw.text("1 PLAYER", 326, 225)
            love.graphics.setColor(0, 0, 0)
            Draw.text("2 PLAYER", 322, 275)
        end

        love.graphics.setColor(1, 1, 1)
        Draw.text("<ENTER> TO START", 259, 500)
        Draw.text("<ESC> TO QUIT", 293, 540)
    end

    function Draw.ready()
        love.graphics.origin()
        love.graphics.setColor(1, 1, 1)

        Draw.text(string.format("READY PLAYER %d", Game.data.currentPlayer), 275, 264)
        Draw.text("PRESS ANY KEY TO CONTINUE", 175, 304)          
    end

    function Draw.play()
        local drawPlayer = function()
            local drawSegment = function(current)
                love.graphics.rectangle("fill", current.x, current.y, 1, 1)
            end

            local drawHead = function(current)
                love.graphics.draw(HeadGFX, current.x, current.y, 0, 0.05, 0.05)
            end

            local current = Game.data.player.body.head
            drawHead(current)
            while current.next do
                current = current.next
                drawSegment(current)
            end
        end

        local drawFood = function()
            love.graphics.setColor(1, 0, 0)

            if Game.data.food.location then
                love.graphics.rectangle("fill", Game.data.food.location.x,
                    Game.data.food.location.y, 1, 1)
            end
        end
        
        love.graphics.origin()
        love.graphics.setColor(1, 1, 1)

        Draw.text(string.format("PLAYER 1: %04d", Game.data.playerTable[1].score or 0), 10, 4)
        if Game.data.playerCount == 2 then
            Draw.text(string.format("PLAYER 2: %04d", Game.data.playerTable[2].score or 0), 546, 4)
        end

        love.graphics.scale(Game.data.cellSize, Game.data.cellSize)
        
        drawPlayer()
        drawFood()
    end

    function Draw.debug()
        love.graphics.origin()
        love.graphics.setColor(0, 1, 0)

        love.graphics.line(love.graphics.getWidth()/2, 0,
            love.graphics.getWidth()/2, love.graphics.getHeight())

        love.graphics.line(0, love.graphics.getHeight()/2,
            love.graphics.getWidth(), love.graphics.getHeight()/2)
        
        love.graphics.print(string.format("Game.data.playerCount: %d", Game.data.playerCount), 10, 40)
        love.graphics.print(string.format("Game.data.currentPlayer: %d", Game.data.currentPlayer), 10, 60)
        if Game.data.playerTable then
            love.graphics.print(string.format("Game.data.playerTable[1]: %s", Game.data.playerTable[1]), 10, 80)
            love.graphics.print(string.format("Game.data.playerTable[2]: %s", Game.data.playerTable[2]), 10, 100)
        end
        love.graphics.print(string.format("Game.data.player: %s", Game.data.player), 10, 120)
        if Game.data.player then
            love.graphics.print(string.format("Game.data.player.direction: %s", Game.data.player.direction), 10, 140)
            love.graphics.print(string.format("Game.data.player.moved: %s", Game.data.player.moved), 10, 160)
        end
        if Game.data.food then
            love.graphics.print(string.format("Game.data.food.location: { x=%d, y=%d }",
                Game.data.food.location.x, Game.data.food.location.y), 10, 180)
        end

        love.graphics.print(string.format("Game.state.current: %s", Game.state.current), 410, 40)
    end
-- end Draw table