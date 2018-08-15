local new = function(color)
    local food = {}
        food.color = color

        function food:update(game)
            if game:hasEmptySpace() then
                if self.location == nil then
                    self.location = game:getEmptyLocation()
                else
                    if game.player:containsLocation(self.location) then
                        game:incrementScore()
                        game.player.body:pushHead(self.location)
                        game.player.bodySegmentCount = game.player.bodySegmentCount + 1
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