local game_state = {}
    function game_state:set(value, data)
        self.current = value
        
        if value == "select" then
            love.audio.play(SFX.select)

            self.select = true
            self.ready = false
            self.play = false
            self.over = false

            data:initSelect()
        end

        if value == "ready" then            
            self.ready = true
            self.select = false
            self.play = false
            self.over = false
        end

        if value == "play" then
            love.audio.play(SFX.play)

            self.play = true
            self.select = false
            self.ready = false
            self.over = false
        end

        if value == "over" then
            self.over = true
            self.select = false
            self.ready = false
            self.play = false
        end
    end
-- end game_state table

return game_state