--Made by Xeavin
local codePointers = {
0x00284CF2,
0x00285E12,
0x0028463A,
0x0028427C}

local originalBytes = {
{0xF7, 0x06, 0x00, 0x00, 0x02, 0x00},
{0xF7, 0x03, 0x00, 0x00, 0x02, 0x00},
{0xF7, 0x06, 0x00, 0x00, 0x02, 0x00},
{0x41, 0xF7, 0x06, 0x00, 0x00, 0x02, 0x00}}

local codes = {
[[
  cmp eax,eax
  nop 0x04
]],
[[
  cmp eax,eax
  nop 0x04
]],
[[
  cmp eax,eax
  nop 0x04
]],
[[
  cmp eax,eax
  nop 0x05
]]}

print("Removable Targeted Party Members (RTPM): Applying patch.")
for i = 1, #codePointers do
  local readBytes = memory.readArray(codePointers[i], #originalBytes[i])
  if (#readBytes ~= #originalBytes[i]) then
    print("RTPM: Couldn't read from memory.")
    return
  elseif (table.concat(readBytes) ~= table.concat(originalBytes[i])) then
    print("RTPM: Unexpected values, aborting.")
    return
  end
end

for i = 1, #codePointers do
  if not (memory.assemble(codes[i], codePointers[i])) then
    print("RTPM: Couldn't write to memory.")
    return
  end
end
