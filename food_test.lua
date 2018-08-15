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
    game = require("game").new(800, 600)

    function testFoodMethods.testUpdate()
        f = food.new({})

        -- test hasEmptySpace()
        gameOver = f:update(game)
        lu.assertEquals(gameOver, false)

        print(lu.prettystr(f.location))
    end
-- endTestFoodMethods
os.exit(lu.LuaUnit.run())