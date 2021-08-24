--Made by Xeavin
local codePointers = {
0x002F9AB2,
0x002F9B73}

local originalBytes = {
{0xF3, 0x0F, 0x10, 0x05, 0x2A, 0x96, 0x5F, 0x00},
{0xF3, 0x0F, 0x10, 0x05, 0x69, 0x95, 0x5F, 0x00}}

local codes = {
[[
  jmp %phpmpbg_code%
  nop 0x03
]],
[[
  jmp %phpmpbg2_code%
  nop 0x03
]]}

local phpmpbg_newmem = memory.assemble(
[[
phpmpbg_code:
  xor eax,eax
  test ebx,ebx
  je short phpmpbg_return

  lea eax,[rbx-0x01]
  xor edx,edx
  lea ecx,[rdx+0x05]
  div ecx

phpmpbg_return:
  jmp 0x002F9B03


phpmpbg2_code:
  xor eax,eax
  test ebx,ebx
  je short phpmpbg2_return

  lea eax,[rbx-0x01]

phpmpbg2_return:
  jmp 0x002F9BBC

]], {"phpmpbg_code", "phpmpbg2_code"})

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
