local  hasEmptySpace = function(cellCount, bodySegmentCount)
    if bodySegmentCount >= cellCount then
        return false
    end
    return true
end

local new = function(color)
    local food = {}
        food.color = color

        function food:update(cellCount, bodySegmentCount)
            local gameOver = false

            if hasEmptySpace(cellCount, bodySegmentCount) then
            -- find a location that isn't occupied
                -- when self.location == nil
                -- getLocation()
                -- player:hasLocation(location)
            -- check for collision
                -- when self.location ~= nil
            else
                gameOver = true
            end

            return gameOver
        end
    return food
end

return {
    new = new
}