lu = require("luaunit")
game = require("game")

width, height = 800, 600

testGameNew = {}
    function testGameNew:testSingle()
        g = game.new(width, height)

        lu.assertEquals(g.cellSize, 20)
        lu.assertEquals(g.columns, width/g.cellSize - 1)
        lu.assertEquals(g.rows, height/g.cellSize - 1)
        lu.assertEquals(g.cellCount, 1131)
        lu.assertEquals(g.gameOver, true)
        lu.assertEquals(g.quit, false)
        lu.assertEquals(g.refreshRate, 0.050)

        -- game:initPlayState()
        lu.assertEquals(g.score, 0)
        lu.assertEquals(g.sumDT, 0)
        lu.assertEquals(g.player.color, { r=1, g=1, b=1 })
        lu.assertEquals(g.player.bodySegmentCount, 3)
        lu.assertEquals(g.player.body.head.x, 19)
        lu.assertEquals(g.player.body.head.y, 14)
        lu.assertEquals(g.player.direction, "right")
    end
-- end testGameNew

testGameMethods = {}
    function testGameMethods:testKeypressed_GameOver()
        g = game.new(width, height)

        g.gameOver = true
        g:keypressed("space")
        lu.assertEquals(g.gameOver, false)
        lu.assertEquals(g.score, 0)
        lu.assertEquals(g.player.body.head,
            { x=19, y=14, next={ x=18, y=14, next={ x=17, y=14 }}})

        lu.assertEquals(g.quit, false)
        g:keypressed("escape")
        lu.assertEquals(g.quit, true)

        g.gameOver = false
        g:keypressed("space")
        lu.assertEquals(g.gameOver, false)

        g.quit = false
        lu.assertEquals(g.quit, false)
        g:keypressed("escape")
        lu.assertEquals(g.quit, true)
    end

    function testGameMethods:testKeyPressed_GameNotOver()
        g = game.new(width, height)

        g.gameOver = false

        g:keypressed("up")
        lu.assertEquals(g.player.direction, "up")

        g:keypressed("down")
        lu.assertEquals(g.player.direction, "down")

        g:keypressed("left")
        lu.assertEquals(g.player.direction, "left")

        g:keypressed("right")
        lu.assertEquals(g.player.direction, "right")

        lu.assertEquals(g.quit, false)
        g:keypressed("escape")
        lu.assertEquals(g.quit, true)
    end
-- end testGameMethods

os.exit(lu.LuaUnit.run())