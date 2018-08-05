local lu = require("luaunit")
local list = require("list")

testNew = {}
    function testNew:testHeadlessList()
        l = list.new()
        lu.assertEquals(l.head, nil)
    end

    function testNew:testHeadInitList()
        l = list.new(1, 1)
        lu.assertEquals(l.head, { x=1, y=1 })
    end
-- end testNew

testListMethods = {}
    function testListMethods:testSetHead()
        l = list.new()
        l:setHead(1, 2)
        lu.assertEquals(l.head, { x=1, y=2 })

        l:setHead(2, 2)
        lu.assertEquals(l.head, { x=2, y=2 })

    end
-- end testListMethods

os.exit(lu.LuaUnit.run())