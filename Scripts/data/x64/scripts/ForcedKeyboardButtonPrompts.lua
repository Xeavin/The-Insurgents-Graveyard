--Made by Xeavin
local codePointer = 0x00197780
local originalBytes = {0x0F, 0xB6, 0x41, 0x38}
local code =
[[
  xor eax,eax
  nop 0x02
]]

local function applyPatch()
  local readBytes = memory.readArray(codePointer, #originalBytes)
  if table.concat(readBytes) ~= table.concat(originalBytes) then
    print("FKBP: Couldn't apply patch, executable is unexpectedly modified.")
    return
  end

  memory.assemble(code, codePointer)
end

print("Forced Keyboard Button Prompts (FKBP): Applying patch.")
applyPatch()
