lu = require("luaunit")
player = require("player")

testPlayerNew = {}
    function testPlayerNew:testMulti()
        local p1 = player.new({ r=1, g=1, b=1 }, 3, 5, 5, "right")
        local p2 = player.new({ r=1, g=0, b=0 }, 2, 10, 10, "left")

        lu.assertEquals(p1.color, { r=1, g=1, b=1 })
        lu.assertEquals(p1.bodySegmentCount, 3)
        lu.assertEquals(p1.direction, "right")
        lu.assertEquals(p1.body.head, { x=5, y=5,
            next={ x=4, y=5, next={ x=3, y=5 }}})

        lu.assertEquals(p2.color, { r=1, g=0, b=0 })
        lu.assertEquals(p2.bodySegmentCount, 2)
        lu.assertEquals(p2.direction, "left")
        lu.assertEquals(p2.body.head, { x=10, y=10,
            next={ x=9, y=10 }})
    end
-- end testPlayerNew

testPlayerMethods = {}
    testPlayerMethods.columns = 39
    testPlayerMethods.rows = 29

    function testPlayerMethods:testUpdate_Right()
        local p = player.new({ r=1, g=1, b=1 }, 3, 5, 5, "right")

        p:update(testPlayerMethods.columns, testPlayerMethods.rows)
        lu.assertEquals(p.body.head,
            { x=6, y=5, next={ x=5, y=5, next={ x=4, y=5 }}})
    end

    function testPlayerMethods:testUpdate_Left()
        local p = player.new({ r=1, g=1, b=1 }, 3, 5, 5, "left")

        p:update(testPlayerMethods.columns, testPlayerMethods.rows)
        lu.assertEquals(p.body.head,
            { x=4, y=5, next={ x=5, y=5, next={ x=4, y=5 }}}) -- collision
    end

    function testPlayerMethods:testUpdate_Up()
        local p = player.new({ r=1, g=1, b=1 }, 3, 5, 5, "up")

        p:update(testPlayerMethods.columns, testPlayerMethods.rows)
        lu.assertEquals(p.body.head,
            { x=5, y=4, next={ x=5, y=5, next={ x=4, y=5 }}})
    end

    function testPlayerMethods:testUpdate_Down()
        local p = player.new({ r=1, g=1, b=1 }, 3, 5, 5, "down")

        p:update(testPlayerMethods.columns, testPlayerMethods.rows)
        lu.assertEquals(p.body.head,
            { x=5, y=6, next={ x=5, y=5, next={ x=4, y=5 }}})
    end
-- end testPlayerMethods

os.exit(lu.LuaUnit.run())