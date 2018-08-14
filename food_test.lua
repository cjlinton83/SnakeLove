lu = require("luaunit")
food = require("food")

function testNew()
    f = food.new()
    lu.assertEquals(f.location, nil)
end

os.exit(lu.LuaUnit.run())