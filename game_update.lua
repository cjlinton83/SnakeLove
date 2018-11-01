local game_update = {}
    function game_update.handler(data, state, dt)
        if state.play then
            game_update.handlePlay(data, state, dt)
        end
    end

    function game_update.handlePlay(data, state, dt)
        data:incrementSumDT(dt)

        if data.sumDT >= data.refreshRate then
            -- update player
            data.player:updatePosition(data.columns, data.rows)

            -- check for collision with self
                -- if collision with self (OVER)
            if data.player:checkSelfCollision() then
                love.audio.play(SFX.over)

                game_update:changePlayerOrOver(data, state)
            end

            data.sumDT = 0
        end

        -- check for collision with food
            -- increase score
            -- add to head
            -- new food location
                -- if no more free locations (OVER)
        if data.player.body.head.x == data.food.location.x and
            data.player.body.head.y == data.food.location.y then
                love.audio.play(SFX.score)

                data.player:incrementScore()
                data.player:addNewHead(data.food.location)
                if data.player.bodySegmentCount >= data.cellCount then
                    game_update:changePlayerOrOver(data, state)
                else
                    data.food.location = data:getEmptyLocation()
                end
        end
    end

    function game_update:changePlayerOrOver(data, state)
        if data.playerCount == 2 and data.currentPlayer == 1 then
            data:changePlayer()
            state:set("ready")
        else
            state:set("over")
        end
    end
-- end game_update table

return game_update