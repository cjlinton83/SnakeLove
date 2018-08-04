local list = require("list")

l = list.new(1, 1)

print("l:findTail()")
local tail = l:findTail()
print("tail.x == 1, tail.y == 1:", tail.x == 1 and tail.y == 1)

print("\nl:popTail()")
tail = l:popTail()
print("tail.x == 1, tail.y == 1:", tail.x == 1 and tail.y == 1)

print("\nl.head == nil:", l.head == nil)

print("\nl:pushTail(l:newNode(1, 1))")
l:pushTail(l:newNode(1, 1))
print("l.head.x == 1 and l.head.y == 1", l.head.x == 1 and l.head.y == 1)

e = list.new()
print("\ne.head == nil", e.head == nil)
