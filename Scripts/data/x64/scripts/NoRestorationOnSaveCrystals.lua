--Made by Xeavin
local codePointer = 0x00359C8F
local originalBytes = {0xB8, 0x07, 0x00, 0x00, 0x00}
local code =
[[
  xor eax,eax
  nop 0x03
]]

local function applyPatch()
  local readBytes = memory.readArray(codePointer, #originalBytes)
  if table.concat(readBytes) ~= table.concat(originalBytes) then
    print("NROSC: Couldn't apply patch, executable is unexpectedly modified.")
    return
  end

  memory.assemble(code, codePointer)
end

print("No Restoration On Save Crystals (NROSC): Applying patch.")
local minVer = {1, 7, 1}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("NROSC: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()
