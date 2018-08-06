local new = function(color, count, x, y)
    local initBody = function()
        list = require("list")
        body = list.new(x, y)

        for i=1, count-1 do
            segment = body:newNode(x-i, y)
            body:pushTail(segment)
        end

        return body
    end
    
    player = {}
        player.color = color
        player.count = count
        player.body = initBody()
    return player
end

return {
    new = new
}