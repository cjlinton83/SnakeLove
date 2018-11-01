local new = function(color)
    local food = {}
        food.color = color

        function food:update(game)
            if game:hasEmptyLocation() then
                if self.location == nil then
                    self.location = game:getEmptyLocation()
                else
                    if game.player:containsLocation(self.location) then
                        game.player:incrementScore()
                        game.player:pushNewHead(self.location)
                        self.location = nil
                    end
                end
            else
                game.gameOver = true
            end
        end
    return food
end

return {
    new = new
}