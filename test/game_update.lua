local game_update = {}
    function game_update.handler(data, state, dt)        
        if state.play then
            data:incrementSumDT(dt)

            if data.sumDT >= data.refreshRate then
                -- update player position
                data.player:updatePosition(data.columns, data.rows)
                data.sumDT = 0
            end
            
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
                        game_update:switchPlayerOrOver()
                    else
                        data.food.location = data:getEmptyLocation()
                    end
            end

            -- check for collision with self
                -- if collision with self (OVER)
            if data.player.checkSelfCollision() then
                game_update:switchPlayerOrOver()
            end
        end 
    end

    function game_update:switchPlayerOrOver()
        -- out of free space on board
        -- self collision
    end
-- end game_update table

return game_update