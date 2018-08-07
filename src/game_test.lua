lu = require("luaunit")
game = require("game")

width, height = 800, 600
cellSize = 20
scaleFactor = 0.8

testGameNew = {}
    testGameNew.g = game.new(width, height, cellSize, scaleFactor)

    function testGameNew:testSingle()
        lu.assertEquals(self.g.gameOver, true)
        lu.assertEquals(self.g.score, 0)
        lu.assertEquals(self.g.cellSize, cellSize)
        lu.assertEquals(self.g.scaleFactor, scaleFactor)
        lu.assertEquals(self.g.columns, width/cellSize - 1)
        lu.assertEquals(self.g.rows, height/cellSize - 1)
        lu.assertEquals(self.g.direction, "right")

        lu.assertEquals(self.g.player.color, { r=1, g=1, b=1 })
        lu.assertEquals(self.g.player.bodySegmentCount, 3)
        lu.assertEquals(self.g.player.body.head.x, 19)
        lu.assertEquals(self.g.player.body.head.y, 14)
    end
-- end testGameNew

testGameMethods = {}
    testGameMethods.g = game.new(width, height, cellSize, scaleFactor)

    function testGameMethods:testSetInput()
        self.g:setInput("right")
        lu.assertEquals(self.g.direction, "right")

        self.g:setInput("left")
        lu.assertEquals(self.g.direction, "left")

        self.g:setInput("up")
        lu.assertEquals(self.g.direction, "up")

        self.g:setInput("down")
        lu.assertEquals(self.g.direction, "down")
    end
-- end testGameMethods

os.exit(lu.LuaUnit.run())