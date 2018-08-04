local list = require("list")

l = list.new(1, 1)

print("l:findTail()")
local tail = l:findTail()
print("tail.x == 1, tail.y == 1:", tail.x == 1 and tail.y == 1)

print("\nl:popTail()")
tail = l:popTail()
print("tail.x == 1, tail.y == 1:", tail.x == 1 and tail.y == 1)

print("\nl.head == nil:", l.head == nil)

e = list.new()
print("\ne.head == nil", e.head == nil)