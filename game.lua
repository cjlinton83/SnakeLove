local new = function(width, height)
    local game = {}
        -- game_model
        game.data = require("game_data").new(width, height)
        game.state = require("game_state")
        game.input = require("game_input")
        game.update = require("game_update")

        game.state:set("select", game.data) -- starts at player select screen

        -- game_methods
        function game:handleInput(key)
            self.input.handler(self.data, self.state, key)
        end

        function game:handleUpdate(dt)
            self.update.handler(self.data, self.state, dt)
        end
    -- end game table

    return game
end

return {
    new = new
}