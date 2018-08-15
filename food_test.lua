lu = require("luaunit")
food = require("food")

lu.isFunction(food.new)

testFoodNew = {}
    function testFoodNew.testSingle()
        f = food.new({})
        lu.assertEquals(f.color, {})
    end
-- endTestFoodNew

testFoodMethods = {}
    function testFoodMethods.testUpdate()
        f = food.new({})

        gameOver = f:update()

        lu.assertEquals(gameOver, nil)
    end
-- endTestFoodMethods
os.exit(lu.LuaUnit.run())