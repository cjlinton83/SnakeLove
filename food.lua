local food = {}
    function food:setLocation(data)
        local getEmptyLocation = function()
            local getRandomLocation = function()
                local x = math.random(0, data.columns)
                local y = math.random(2, data.rows)
                return { x=x, y=y }
            end

            local location = getRandomLocation()
            while data.player:containsLocation(location) do
                location = getRandomLocation()
            end

            return location
        end

        if self.location == nil then
            self.location = getEmptyLocation()
        end
    end
-- end food table

return food