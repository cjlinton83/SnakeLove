local lu = require("luaunit")
local game = require("game")

function testGameIsTable()
    lu.assertTable(game)
end

os.exit(lu.LuaUnit.run())