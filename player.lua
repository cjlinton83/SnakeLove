local new = function(x, y, count)
    local initBody = function()
        local body = require("list").new(x, y)

        for i=1, count-1 do
            local segment = body:newNode(x-i, y)
            body:pushTail(segment)
        end
        
        return body
    end

    local player = {}
        player.bodySegmentCount = count
        player.direction = "right"
        player.score = 0
        player.body = initBody()
        player.hasMoved = true

        function player:containsLocation(location)
            local current = self.body.head

            if current.x == location.x and current.y == location.y then
                return true
            end

            while current.next do
                if current.next.x == location.x and current.next.y == location.y then
                    return true
                end
                current = current.next
            end
            
            return false
        end

        function player:changeDirection(direction)
            self.direction = direction
            self.moved = false
        end

        function player:updatePosition(columns, rows)
            local dx = self.body.head.x
            local dy = self.body.head.y

            if self.direction == "right" then
                dx = dx + 1
                if dx == columns+1 then dx = 0 end
            end
            if self.direction == "left" then
                dx = dx - 1
                if dx == -1 then dx = columns end
            end
            if self.direction == "up" then
                dy = dy - 1
                if dy == 1 then dy = rows end
            end
            if self.direction == "down" then
                dy = dy + 1
                if dy == rows+1 then dy = 2 end
            end

            local tail = self.body:popTail()
            self.body:updateNode(tail, dx, dy)
            self.body:pushHead(tail)
            self.hasMoved = true
        end

        function player:incrementScore()
            self.score = self.score + 1
        end

        function player:addNewHead(location)
            self.body:pushHead(location)
            self.bodySegmentCount = self.bodySegmentCount + 1
        end

        function player:checkSelfCollision()
            local collided = false
            local current = self.body.head

            while current.next do
                if current.next.x == self.body.head.x and current.next.y == self.body.head.y then
                    collided = true
                end
                current = current.next
            end

            return collided
        end
    -- end player table

    return player
end

return {
    new = new
}