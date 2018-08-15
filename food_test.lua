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

        -- test hasEmptySpace()
        gameOver = f:update(4, 2)
        lu.assertEquals(gameOver, false)

        gameOver = f:update(2, 4)
        lu.assertEquals(gameOver, true)

        gameOver = f:update(100, 100)
        lu.assertEquals(gameOver, true)
    end
-- endTestFoodMethods
os.exit(lu.LuaUnit.run())