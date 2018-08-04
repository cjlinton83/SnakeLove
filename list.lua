local list = {}

function list.newNode(x, y)
    local node = {}
    node.x = x
    node.y = y
    return node
end

function list.popTail(head)
    local previous = head
    local current = previous
    while current.next ~= nil do
        previous = current
        current = current.next
    end
    previous.next = nil
    return current
end

function list.updateNode(node, dx, dy)
    node.x = dx
    node.y = dy
end

function list.pushHead(head, node)
    node.next = head
    head = node
end

function list.pushTail(tail, node)
    

return list