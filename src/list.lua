local new = function(x, y)
    local initHead = function(list)
        if not(x and y) then
            list.head = {}
        else
            list.head = { x=x, y=y }
        end
    end

    list = {}
        initHead(list)
    return list
end

return {
    new = new
}