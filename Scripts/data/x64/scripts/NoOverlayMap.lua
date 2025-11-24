--Made by Xeavin
local codePointer = 0x00253E2F
local originalBytes = {0x80, 0x3D, 0x1A, 0xE9, 0xE3, 0x01, 0x03}
local code =
[[
  cmp eax,eax
  nop 0x05
]]

local function applyPatch()
  local readBytes = memory.readArray(codePointer, #originalBytes)
  if table.concat(readBytes) ~= table.concat(originalBytes) then
    print("NOM: Couldn't apply patch, executable is unexpectedly modified.")
    return
  end

  memory.assemble(code, codePointer)
end

print("No Overlay Map (NOM): Applying patch.")
local minVer = {1, 7, 1}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("NOM: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()
