--Made by Xeavin
local codePointer = 0x007E0E7C
local originalBytes = {0xF3, 0x44, 0x0F, 0x10, 0xA3, 0x00, 0x01, 0x00, 0x00}
local code =
[[
  xorps xmm12,xmm12
  nop 0x05
]]

local function applyPatch()
  local readBytes = memory.readArray(codePointer, #originalBytes)
  if table.concat(readBytes) ~= table.concat(originalBytes) then
    print("NS: Couldn't apply patch, executable is unexpectedly modified.")
    return
  end

  memory.assemble(code, codePointer)
end

print("No Sounds (NS): Applying patch.")
applyPatch()
