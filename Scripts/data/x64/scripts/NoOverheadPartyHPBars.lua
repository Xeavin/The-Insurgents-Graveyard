--Made by Xeavin
local codePointers = {
0x002C60DA,
0x002C610C}

local originalBytes = {
{0x8B, 0x05, 0x34, 0x6E, 0xB4, 0x01, 0x2B, 0x05, 0x1E, 0x6E, 0xB4, 0x01},
{0x03, 0x15, 0xF2, 0x6D, 0xB4, 0x01}}

local codes = {
[[
  xor eax,eax
  nop 0x0A
]],
[[
  nop 0x06
]]}

print("No Overhead Party HP Bars (NOPHPB): Applying patch.")
for i = 1, #codePointers do
  local readBytes = memory.readArray(codePointers[i], #originalBytes[i])
  if (#readBytes ~= #originalBytes[i]) then
    print("NOPHPB: Couldn't read from memory.")
    return
  elseif (table.concat(readBytes) ~= table.concat(originalBytes[i])) then
    print("NOPHPB: Unexpected values, aborting.")
    return
  end
end

for i = 1, #codePointers do
  if not (memory.assemble(codes[i], codePointers[i])) then
    print("NOPHPB: Couldn't write to memory.")
    return
  end
end

local function onExit()
  collectgarbage()
end

event.registerEventAsync("exit", onExit)
