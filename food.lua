local new = function(color)
    local food = {}
        food.color = color

        function food:update()  -- returns boolean gameOver
            return nil
        end
    return food
end

return {
    new = new
}