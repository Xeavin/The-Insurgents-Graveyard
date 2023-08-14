--Made by Xeavin
local codePointers = {
0x002C5FB6,
0x002C5FE8,
0x002C6048,
0x002C607A}

local originalBytes = {
{0x8B, 0x05, 0x78, 0x6F, 0xB4, 0x01, 0x2B, 0x05, 0x62, 0x6F, 0xB4, 0x01},
{0x03, 0x15, 0x36, 0x6F, 0xB4, 0x01},
{0x8B, 0x05, 0xA6, 0x6E, 0xB4, 0x01, 0x2B, 0x05, 0x90, 0x6E, 0xB4, 0x01},
{0x03, 0x15, 0x64, 0x6E, 0xB4, 0x01}}

local codes = {
[[
  xor eax,eax
  nop 0x0A
]],
[[
  nop 0x06
]],
[[
  xor eax,eax
  nop 0x0A
]],
[[
  nop 0x06
]]}

print("No Overhead Foe HP Bars (NOFHPB): Applying patch.")
for i = 1, #codePointers do
  local readBytes = memory.readArray(codePointers[i], #originalBytes[i])
  if (#readBytes ~= #originalBytes[i]) then
    print("NOFHPB: Couldn't read from memory.")
    return
  elseif (table.concat(readBytes) ~= table.concat(originalBytes[i])) then
    print("NOFHPB: Unexpected values, aborting.")
    return
  end
end

for i = 1, #codePointers do
  if not (memory.assemble(codes[i], codePointers[i])) then
    print("NOFHPB: Couldn't write to memory.")
    return
  end
end

local function onExit()
  collectgarbage()
end

event.registerEventAsync("exit", onExit)
