--Made by Xeavin
local codePointer = 0x002F9563
local originalBytes = {0x66, 0x0F, 0x6E, 0x30, 0x0F, 0x5B, 0xF6}
local code =
[[
  jmp %fmpr_code%
  nop 0x02
]]

local assemblies =
[[
fmpr_code:
  movd xmm6,[rax]
  cvtdq2ps xmm6,xmm6

  mulss xmm6,[0x02064AC4]
  jmp 0x002F956A
]]

local symbols = {
  "fmpr_code"
}

local function applyPatch()
  local readBytes = memory.readArray(codePointer, #originalBytes)
  if table.concat(readBytes) ~= table.concat(originalBytes) then
    print("FMPR: Couldn't apply patch, executable is unexpectedly modified.")
    return
  end

  memory.assemble(assemblies, symbols)
  memory.assemble(code, codePointer)
end

print("Fixed MP Regeneration (FMPR): Applying patch.")
applyPatch()
