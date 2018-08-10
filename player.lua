local new = function(color, count, x, y, direction)
    local initBody = function()
        local list = require("list")
        local body = list.new(x, y)

        for i=1, count-1 do
            local segment = body:newNode(x-i, y)
            body:pushTail(segment)
        end

        return body
    end

    local player = {}
        player.color = color
        player.bodySegmentCount = count
        player.direction = direction
        player.body = initBody()

        function player:update(columns, rows)
            local calculateDeltaValues = function()
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
                    if dy == -1 then dy = rows end
                end
                if self.direction == "down" then
                    dy = dy + 1
                    if dy == rows+1 then dy = 0 end
                end

                return { dx=dx, dy=dy }
            end

            local checkSelfCollision = function(deltaValues)
                local tail = self.body:findTail()
                local gameOver = false

                -- 2 segment collision on update
                -- tail == newHead, therefore regression on 2 segment body
                if tail.x == deltaValues.dx and tail.y == deltaValues.dy then
                    gameOver = true
                else -- 3+ segment collision
                    local current = self.body.head
                    while current.next ~= nil do
                        if current.next.x == deltaValues.dx and
                            current.next.y == deltaValues.dy then
                                gameOver = true
                        end
                        current = current.next
                    end
                end

                return gameOver
            end

            local deltaValues = calculateDeltaValues()
            local gameOver = checkSelfCollision(deltaValues)

            if not gameOver then
                local tail = self.body:popTail()
                self.body:updateNode(tail, deltaValues.dx, deltaValues.dy)
                self.body:pushHead(tail)
            end

            return gameOver
        end
    return player
end

return {
    new = new
}