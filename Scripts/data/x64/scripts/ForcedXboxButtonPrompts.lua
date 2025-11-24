--Made by Xeavin
local codePointer = 0x002AEC1F
local originalBytes = {0x83, 0xF8, 0x02}
local code =
[[
  test esp,esp
  nop
]]

local function applyPatch()
  local readBytes = memory.readArray(codePointer, #originalBytes)
  if table.concat(readBytes) ~= table.concat(originalBytes) then
    print("FXBBP: Couldn't apply patch, executable is unexpectedly modified.")
    return
  end

  memory.assemble(code, codePointer)
end

print("Forced XBox Button Prompts (FXBBP): Applying patch.")
applyPatch()
