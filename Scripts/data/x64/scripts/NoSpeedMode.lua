--Made by Xeavin
local codePointer = 0x0022AA3A
local originalBytes = {0x85, 0xC0}
local code =
[[
  cmp eax,eax
]]

local function applyPatch()
  local readBytes = memory.readArray(codePointer, #originalBytes)
  if table.concat(readBytes) ~= table.concat(originalBytes) then
    print("NSM: Couldn't apply patch, executable is unexpectedly modified.")
    return
  end

  memory.assemble(code, codePointer)
end

print("No Speed-Mode (NSM): Applying patch.")
local minVer = {1, 7, 1}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("NSM: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()
