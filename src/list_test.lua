local lu = require("luaunit")
local list = require("list")

function testListIsTable()
    lu.assertIsTable(list)
end

testNew = {}
    -- Main data of list is head plus associated methods
    function testNewListInstances()
        local l1 = list.new()
        local l2 = list.new(2, 2)

        lu.assertEquals(l1.head, nil)
        lu.assertEquals(l2.head, { x=2, y=2 })

        l1 = list.new(3, 3)
        l2 = list.new(4, 4)

        lu.assertEquals(l1.head, { x=3, y=3 })
        lu.assertEquals(l2.head, { x=4, y=4 })
    end

    function testNewNode()
        local l = list.new()
        local node = l:newNode(3, 3)

        lu.assertEquals(l.head, nil)
        lu.assertEquals(node, { x=3, y=3 })
        lu.assertEquals(l.head, nil)
    end
-- end testNew

testListMethods = {}
    function testFindTail()
        local l = list.new(1, 1)
        local tail = l:findTail()
     
        lu.assertEquals(tail, { x=1, y=1 })

        l = list.new()
        tail = l:findTail()
     
        lu.assertEquals(tail, nil)
    end

    testPopTail = {}
        function testPopHeadless()
            local l = list.new()
            local tail = l:popTail()

            lu.assertEquals(tail, nil)
        end

        function testPopSingle()
            local l = list.new(1, 1)
            local tail = l:popTail()

            lu.assertEquals(tail, { x=1, y=1 })
            lu.assertEquals(l.head, nil)
        end

        function testPopMulti()
            local l = list.new(1, 1)
            l:pushTail(l:newNode(2, 2))

            lu.assertEquals(l.head, { x=1, y=1, next={ x=2, y=2 }})

            local tail = l:popTail()
            lu.assertEquals(tail, { x=2, y=2 })

            -- assert head doesn't have a next
            lu.assertEquals(l.head, { x=1, y=1 })

            tail = l:popTail()
            lu.assertEquals(tail, { x=1, y=1 })

            -- assert head is empty
            lu.assertEquals(l.head, nil)
        end
    -- end testPopTail

    function testPushTail()
        local l = list.new()
        l:pushTail(l:newNode(1, 1))

        lu.assertEquals(l.head, { x=1, y=1 })

        l:pushTail(l:newNode(2, 2))
        lu.assertEquals(l.head, { x=1, y=1, next={ x=2, y=2 }})
    end

    testUpdateNode = {}
        function testUpdateSingleUnattachedNode()
            local l = list.new()
            local n = l:newNode(1, 1)

            lu.assertEquals(n, { x=1, y=1 })

            l:updateNode(n, 2, 2)
            lu.assertEquals(n, { x=2, y=2 })
        end

        function testUpdateSingleAttachedNode()
            local l = list.new(3, 3)
            
            l:updateNode(l.head, 4, 4)
            lu.assertEquals(l.head, { x=4, y=4 })

            l:updateNode(l:findTail(), 5, 5)
            lu.assertEquals(l.head, { x=5, y=5 })
        end

        function testUpdateMultipleAttachedNodes()
            local l = list.new(6, 6)
            l:pushTail(l:newNode(7, 7))

            lu.assertEquals(l.head, { x=6, y=6, next={ x=7, y=7 }})

            l:updateNode(l.head, 8, 8)
            l:updateNode(l:findTail(), 9, 9)

            lu.assertEquals(l.head, { x=8, y=8, next={ x=9, y=9 }})
        end
    -- end testUpdateNode
-- end testListMethods

os.exit(lu.LuaUnit.run())