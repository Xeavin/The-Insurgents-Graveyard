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
applyPatch()
