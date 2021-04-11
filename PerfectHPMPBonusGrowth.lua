--Made by Xeavin
local codePointers = {
0x002F9AB2,
0x002F9B73}

local originalBytes = {
{0xF3, 0x0F, 0x10, 0x05, 0x2A, 0x96, 0x5F, 0x00, 0x66, 0x0F, 0x6E, 0xF3, 0x0F, 0x5B, 0xF6, 0xF3, 0x0F, 0x5E, 0x35, 0x1B, 0xAC, 0x61, 0x00},
{0xF3, 0x0F, 0x10, 0x05, 0x69, 0x95, 0x5F, 0x00, 0x66, 0x0F, 0x6E, 0xF3}}

local codes = {
[[
  xor eax,eax
  test ebx,ebx
  je 0x002F9B03
  
  lea eax,[rbx-0x01]
  xor edx,edx
  lea ecx,[rdx+0x05]
  div ecx
  
  jmp 0x002F9B03
  nop 0x05
]],
[[
  xor eax,eax
  test ebx,ebx
  je 0x002F9BBC
  
  lea eax,[rbx-0x01]
  jmp 0x002F9BBC
]]}

print("Perfect HP/MP Bonus Growth (PHPMPBG): Applying patch.")
for i = 1, #codePointers do
  local readBytes = memory.readArray(codePointers[i], #originalBytes[i])
  if (#readBytes ~= #originalBytes[i]) then
    print("PHPMPBG: Couldn't read from memory.")
    return
  elseif (table.concat(readBytes) ~= table.concat(originalBytes[i])) then
    print("PHPMPBG: Unexpected values, aborting.")
    return
  end
end

for i = 1, #codePointers do
  if not (memory.assemble(codes[i], codePointers[i])) then
    print("PHPMPBG: Couldn't write to memory.")
    return
  end
end

local function onExit()
  collectgarbage()
end

event.registerEventAsync("exit", onExit)
