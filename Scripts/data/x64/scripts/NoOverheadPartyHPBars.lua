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

local function applyPatch()
  for i = 1, #codePointers do
    local readBytes = memory.readArray(codePointers[i], #originalBytes[i])
    if table.concat(readBytes) ~= table.concat(originalBytes[i]) then
      print("NOPHPB: Couldn't apply patch, executable is unexpectedly modified.")
      return
    end
  end

  for i = 1, #codePointers do
    memory.assemble(codes[i], codePointers[i])
  end
end

print("No Overhead Party HP Bars (NOPHPB): Applying patch.")
local minVer = {1, 7, 1}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("NOPHPB: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()
