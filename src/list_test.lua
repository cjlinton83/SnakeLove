local lu = require("luaunit")
local list = require("list")

function testListIsTable()
    lu.assertIsTable(list)
end

os.exit(lu.LuaUnit.run())