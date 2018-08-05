local lu = require("luaunit")
local list = require("list")

function testListIsTable()
    lu.assertIsTable(list)
end

function testNewHead()
    local l = list.new()
    lu.assertEquals(l.head, {})

    l = list.new(1, 1)
    lu.assertEquals(l.head, { x=1, y=1 })
end

function testNewInstances()
    local l1 = list.new()
    lu.assertEquals(l1.head, {})

    local l2 = list.new(2, 2)
    lu.assertEquals(l2.head, { x=2, y=2 })
end

os.exit(lu.LuaUnit.run())