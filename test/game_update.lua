local game_update = {}
    function game_update.handler(data, state, dt)
        if state.play then
            data:incrementSumDT(dt)

            if data.sumDT >= data.refreshRate then
                -- update player position
                data.player:updatePosition(data.columns, data.rows)
                -- check for collision with food
                    -- increase score
                    -- add to head
                    -- new food location
                        -- if no more free locations (OVER)
                -- check for collision with self
                    -- if collision with self (OVER)
                -- handle turn over / game over
                    -- out of
                data:resetSumDT()
            end
        end 
    end
-- end game_update table

return game_update