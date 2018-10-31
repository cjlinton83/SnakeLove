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
    -- end player table

    return player
end

return {
    new = new
}