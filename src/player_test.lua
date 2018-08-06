local lu = require("luaunit")
local player = require("player")

function testPlayerIsTable()
    lu.assertTable(player)
end

function testPlayerNewMultiIstance()
    local p1 = player.new({ r=1, g=1, b=1 }, 3, 5, 5)
    local p2 = player.new({ r=1, g=0, b=0 }, 2, 10, 10)

    lu.assertEquals(p1.color, { r=1, g=1, b=1 })
    lu.assertEquals(p1.count, 3)
    lu.assertEquals(p1.body.head, { x=5, y=5, next={ x=4, y=5, next={ x=3, y=5 }}})

    lu.assertEquals(p2.color, { r=1, g=0, b=0 })
    lu.assertEquals(p2.count, 2)
    lu.assertEquals(p2.body.head, { x=10, y=10, next={ x=9, y=10 }})
end

os.exit(lu.LuaUnit.run())