local new = function(width, height)
    local game_data = {}
        game_data.cellSize = 20
        game_data.columns = width / game_data.cellSize - 1
        game_data.rows = height / game_data.cellSize - 1
        game_data.cellCount = game_data.columns * game_data.rows - (2 * game_data.columns)
        game_data.refreshRate = 0.07

        -- game_data methods
        function game_data:initSelect()
            self.playerCount = 1
            self.currentPlayer = 1
        end

        function game_data:initPlay()
            -- PLAYER
            local player = require("player")
            local x = math.floor(self.columns/2)
            local y = math.floor(self.rows/2)
            local count = 3

            self.playerTable = {}
                for i = 1, self.playerCount do
                    self.playerTable[i] = player.new(x, y, count)
                end
            -- end self.playerTable

            self.player = self.playerTable[self.currentPlayer]

            -- FOOD
            self.food = require("food")
            self.food:setLocation(self)

            self.sumDT = 0
        end

        function game_data:changePlayerCount()
            if self.playerCount == 1 then
                self.playerCount = 2
            else
                self.playerCount = 1
            end
        end

        function game_data:incrementSumDT(dt)
            self.sumDT = self.sumDT + dt
        end

        function game_data:resetSumDT()
            self.sumDT = 0
        end

        function game_data:getEmptyLocation()
            local getLocation = function()
                local x = math.random(0, self.columns)
                local y = math.random(2, self.rows)
                return { x=x, y=y }
            end

            local location = getLocation()
            while self.player:containsLocation(location) do
                location = getLocation()
            end

            return location
        end
    -- end game_data table

    return game_data
end

return {
    new = new
}