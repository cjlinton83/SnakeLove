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
                if data.player.body.head.x == data.food.location.x and
                    data.player.body.head.y == data.food.location.y then
                        data.player:incrementScore()
                        data.player:addNewHead(data.food.location)
                        if data.player.bodySegmentCount >= data.cellCount then
                            game_update.setWin()
                        else
                            data.food.location = data:getEmptyLocation()
                        end
                end
                -- check for collision with self
                    -- if collision with self (OVER)
                -- handle turn over / game over
                    -- out of
                data:resetSumDT()
            end
        end 
    end

    function game_update.setWin()
    end
-- end game_update table

return game_update