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

            local tail = self.body:popTail()
            self.body:updateNode(tail, dx, dy)
            self.body:pushHead(tail)
        end
    return player
end

return {
    new = new
}