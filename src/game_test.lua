local lu = require("luaunit")
local game = require("game")

function testGameIsTable()
    lu.assertTable(game)
end

function testNewInstance()
    local width, height = 800, 600
    local cellSize = 20
    local scaleFactor = 0.8
    g = game.new(width, height, cellSize, scaleFactor)

    lu.assertEquals(g.gameOver, true)
    lu.assertEquals(g.score, 0)
    lu.assertEquals(g.cellSize, cellSize)
    lu.assertEquals(g.scaleFactor, scaleFactor)
    lu.assertEquals(g.columns, width/cellSize - 1)
    lu.assertEquals(g.rows, height/cellSize - 1)
    lu.assertEquals(g.direction, "right")

    lu.assertEquals(g.player.color, { r=1, g=1, b=1 })
    lu.assertEquals(g.player.bodySegmentCount, 3)
    lu.assertEquals(g.player.body.head.x, 19)
    lu.assertEquals(g.player.body.head.y, 14)
end

testGameMethods = {}
    function testGameMethods.testSetInput()
        g = game.new(800, 600, 20, 0.8)
        
        g:setInput("right")
        lu.assertEquals(g.direction, "right")

        g:setInput("left")
        lu.assertEquals(g.direction, "left")

        g:setInput("up")
        lu.assertEquals(g.direction, "up")

        g:setInput("down")
        lu.assertEquals(g.direction, "down")
    end
-- end testGameMethods

os.exit(lu.LuaUnit.run())