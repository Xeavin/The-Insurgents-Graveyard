--Made by Xeavin
local codePointers = {
0x00253C89,
0x00253D9E}

local originalBytes = {
{0x80, 0x3D, 0xC0, 0xEA, 0xE3, 0x01, 0x03},
{0x80, 0x3D, 0xAB, 0xE9, 0xE3, 0x01, 0x03}}

local codes = {
[[
  test esp,esp
  nop 0x05
]],
[[
  test esp,esp
  nop 0x05
]]}

print("No Overlay Map (NOM): Applying patch.")
for i = 1, #codePointers do
  local readBytes = memory.readArray(codePointers[i], #originalBytes[i])
  if (#readBytes ~= #originalBytes[i]) then
    print("NOM: Couldn't read from memory.")
    return
  elseif (table.concat(readBytes) ~= table.concat(originalBytes[i])) then
    print("NOM: Unexpected values, aborting.")
    return
  end
end

for i = 1, #codePointers do
  if not (memory.assemble(codes[i], codePointers[i])) then
    print("NOM: Couldn't write to memory.")
    return
  end
end

local function onExit()
  collectgarbage()
end
event.registerEventAsync("exit", onExit)
