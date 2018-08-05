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

            if not current then
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

            if not current then 
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
            if not self.head then
                self.head = node
            else
                local tail = self:findTail()
                tail.next = node
            end
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