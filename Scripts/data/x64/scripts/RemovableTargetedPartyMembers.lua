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

local function applyPatch()
  for i = 1, #codePointers do
    local readBytes = memory.readArray(codePointers[i], #originalBytes[i])
    if table.concat(readBytes) ~= table.concat(originalBytes[i]) then
      print("RTPM: Couldn't apply patch, executable is unexpectedly modified.")
      return
    end
  end

  for i = 1, #codePointers do
    memory.assemble(codes[i], codePointers[i])
  end
end

print("Removable Targeted Party Members (RTPM): Applying patch.")
local minVer = {1, 7, 1}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("RTPM: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()
