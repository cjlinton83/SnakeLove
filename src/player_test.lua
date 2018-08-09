lu = require("luaunit")
player = require("player")

testPlayerNew = {}
    function testPlayerNew.testNew()
        local p1 = player.new({ r=1, g=1, b=1 }, 3, 5, 5, "right")
        local p2 = player.new({ r=1, g=0, b=0 }, 1, 10, 10, "left")

        lu.assertEquals(p1.color, { r=1, g=1, b=1 })
        lu.assertEquals(p1.bodySegmentCount, 3)
        lu.assertEquals(p1.direction, "right")
        lu.assertEquals(p1.body.head, { x=5, y=5,
            next={ x=4, y=5, next={ x=3, y=5 }}})

        lu.assertEquals(p2.color, { r=1, g=0, b=0 })
        lu.assertEquals(p2.bodySegmentCount, 1)
        lu.assertEquals(p2.direction, "left")
        lu.assertEquals(p2.body.head, { x=10, y=10 })
    end
-- end testPlayerNew

columns = 39
rows = 29

testPlayerMethods = {}
    function testPlayerMethods.testUpdate_Right()
        -- single node
        -- in-bounds
        local p = player.new({}, 1, 5, 5, "right")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=6, y=5 })

        -- out-of-bounds
        p = player.new({}, 1, columns, 5, "right")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=0, y=5 })

        -- multi node
        -- in-bounds
        p = player.new({}, 2, 5, 5, "right")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=6, y=5, next={ x=5, y=5 }})

        -- out-of-bounds
        p = player.new({}, 2, columns, 5, "right")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=0, y=5, next={ x=columns, y=5}})
    end

    function testPlayerMethods.testUpdate_Left()
        -- single node
        -- in-bounds
        local p = player.new({}, 1, 5, 5, "left")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=4, y=5 })

        -- out-of-bounds
        p = player.new({}, 1, 0, 5, "left")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=columns, y=5 })

        -- multi node
        -- in-bounds
        p = player.new({}, 2, 5, 5, "left")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=4 , y=5, next={ x=5, y=5 }})

        -- out-of-bounds
        p = player.new({}, 2, 0, 5, "left")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=columns, y=5, next={ x=0, y=5 }})
    end

    function testPlayerMethods.testUpdate_Up()
        -- single node
        -- in-bounds
        local p = player.new({}, 1, 5, 5, "up")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=5, y=4 })
        
        -- out-of-bounds
        p = player.new({}, 1, 5, 0, "up")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=5, y=rows })

        -- multi node
        -- in-bounds
        p = player.new({}, 2, 5, 5, "up")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=5, y=4, next={ x=5, y=5 }})
        
        -- out-of-bounds
        p = player.new({}, 2, 5, 0, "up")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=5, y=rows, next={ x=5, y=0 }})
    end

    function testPlayerMethods.testUpdate_Down()
        -- single node
        -- in-bounds
        local p = player.new({}, 1, 5, 5, "down")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=5, y=6 })

        -- out-of-bounds
        p = player.new({}, 1, 5, rows, "down")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=5, y=0 })
        
        -- multi node
        -- in-bounds
        p = player.new({}, 2, 5, 5, "down")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=5, y=6, next={ x=5, y=5 }})

        -- out-of-bounds
        p = player.new({}, 2, 5, rows, "down")
        p:update(columns, rows)
        lu.assertEquals(p.body.head, { x=5, y=0, next={ x=5, y=rows }})
    end
-- end testPlayerMethods

os.exit(lu.LuaUnit.run())