--Made by Xeavin
local codePointers = {
0x00281B85,
0x00281BB8,
0x00281BDC,
0x00281C00,
0x00281C2D,
0x00281C69,
0x00253DD6,
0x002540B4}

local originalBytes = {
{0x85, 0xC9},
{0x85, 0xC9},
{0x85, 0xC9},
{0x85, 0xC9},
{0x85, 0xD2},
{0x85, 0xD2},
{0x66, 0x83, 0xF8, 0x10},
{0x85, 0xC0}}

local codes = {
[[
  test esp,esp
]],
[[
  test esp,esp
]],
[[
  test esp,esp
]],
[[
  test esp,esp
]],
[[
  test esp,esp
]],
[[
  test esp,esp
]],
[[
  cmp eax,eax
  nop 0x02
]],
[[
  test esp,esp
]]}

print("Lift Story Restrictions (LSR): Applying patch.")
for i = 1, #codePointers do
  local readBytes = memory.readArray(codePointers[i], #originalBytes[i])
  if (#readBytes ~= #originalBytes[i]) then
    print("LSR: Couldn't read from memory.")
    return
  elseif (table.concat(readBytes) ~= table.concat(originalBytes[i])) then
    print("LSR: Unexpected values, aborting.")
    return
  end
end

for i = 1, #codePointers do
  if not (memory.assemble(codes[i], codePointers[i])) then
    print("LSR: Couldn't write to memory.")
    return
  end
end

local function onExit()
  collectgarbage()
end
event.registerEventAsync("exit", onExit)
