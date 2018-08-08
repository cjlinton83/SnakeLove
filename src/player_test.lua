lu = require("luaunit")
player = require("player")

testPlayerNew = {}
    testPlayerNew.p1 = player.new({ r=1, g=1, b=1 }, 3, 5, 5)
    testPlayerNew.p2 = player.new({ r=1, g=0, b=0 }, 2, 10, 10)

    function testPlayerNew:testMulti()
        lu.assertEquals(self.p1.color, { r=1, g=1, b=1 })
        lu.assertEquals(self.p1.bodySegmentCount, 3)
        lu.assertEquals(self.p1.body.head, { x=5, y=5,
            next={ x=4, y=5, next={ x=3, y=5 }}})

        lu.assertEquals(self.p2.color, { r=1, g=0, b=0 })
        lu.assertEquals(self.p2.bodySegmentCount, 2)
        lu.assertEquals(self.p2.body.head, { x=10, y=10,
            next={ x=9, y=10 }})
    end
-- end testPlayerNew

os.exit(lu.LuaUnit.run())