local new = function(x, y)
    local initHead = function(list)
        if not(x and y) then
            list.head = nil
        else
            list.head = list:newNode(x, y)
        end
    end

    list = {}
        function list:newNode(x, y)
            return { x=x, y=y }
        end

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

            if current == nil then 
                return nil
            end

            while current.next ~= nil do 
                previous = current
                current = current.next
            end

            if previous == current then
                self.head = nil
                return current
            end

            previous.next = nil

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
            local head = self.head

            if head == nil then
                self.head = node
            end

            node.next = head    -- needs local reference to head
            self.head = node
        end

        function list:updateNode(node, x, y)
            node.x = x
            node.y = y
        end

        initHead(list)
    return list
end

return {
    new = new
}