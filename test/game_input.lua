local game_input = {}
    function game_input.handler(data, state, key)
        if state.select then
            game_input.handleSelect(data, state, key)
            return
        end

        if state.ready then
            game_input.handleReady(data, state, key)
            return
        end

        if state.play then
            game_input.handlePlay(data, state, key)
            return
        end

        if state.over then
            game_input.handleOver(data, state, key)
            return
        end
    end
    
    function game_input.handleSelect(data, state, key)
        if key == "up" or key == "down" then
            data:changePlayerCount()
        end

        if key == "return" then
            state:set("ready", data)
        end
    end

    function game_input.handleReady(data, state, key)
        if key then state:set("play", data) end
    end

    function game_input.handlePlay(data, state, key)
    end

    function game_input.handleOver(data, state, key)
    end
-- end game_input table

return game_input