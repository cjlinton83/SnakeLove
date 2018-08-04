local init = function()
    local list = {}

    function list:setHead(x, y)
        self.head = self:newNode(x, y)
    end

    function list:newNode(x, y)
        local node = {}
        node.x = x
        node.y = y
        return node
    end

    ---[[ DEBUG ONLY
    function list:print(node)
        local printNode = function(node)
            for k, v in pairs(node) do
                print(k, v)
            end
        end

        if node then
            printNode(node)
        else
            local current = self.head
            while current.next ~= nil do
                printNode(current)
                current = current.next
            end
            printNode(current)
        end
    end
    --]]

    function list:findTail()
        local current = self.head

        if current == nil then
            return nil
        end

        while current.next ~= nil do
            current = current.next
        end
        
        return current
    end

    function list:popTail()
        local previous = self.head
        local current = previous

        while current.next ~= nil do
            previous = current
            current = current.next
        end

        -- check that head is only node in list
        if previous == current then
            self.head = nil
        else
            previous.next = nil
        end

        return current
    end

    function list:pushTail(node)
        if self.head == nil then
            self.head = node
        else
            local tail = self:findTail()
            tail.next = node
        end
    end

    function list:pushHead(node)
        if self.head == nil then
            self.head = node
        else
            node.next = self.head
            self.head = node
        end
    end

    return list
end

local new = function(x, y)
    if not(x and y) then
        return init()
    end
    
    local list = init()
    list:setHead(x, y)
    return list
end

return {
    new = new
}