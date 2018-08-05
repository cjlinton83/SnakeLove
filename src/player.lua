local init = function()
    local player = {}
    return player
end

local new = function()
    return init()
end

return {
    new = new
}