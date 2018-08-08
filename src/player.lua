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
    return player
end

return {
    new = new
}