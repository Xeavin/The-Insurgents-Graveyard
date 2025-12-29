--Made by Xeavin
local codePointer = 0x00305B66
local originalBytes = {0x48, 0x8B, 0x83, 0x98, 0x06, 0x00, 0x00}
local codes =
[[
  jmp %pe_code%
  nop 0x02
]]

local assemblies =
[[
pe_code:
  mov rax,[rbx+0x00000698]
  xor ecx,ecx

  cmp byte ptr [rax+0x05],cl
  jne short pe_return

  cmp [0x01E0C2B8],ecx
  je 0x00305C61

pe_return:
  jmp 0x00305B6D
]]

local symbols = {
  "pe_code"
}

local function applyPatch()
  local readBytes = memory.readArray(codePointer, #originalBytes)
  if table.concat(readBytes) ~= table.concat(originalBytes) then
    print("PE: Couldn't apply patch, executable is unexpectedly modified.")
    return
  end

  memory.assemble(assemblies, symbols)
  memory.assemble(codes, codePointer)
end

print("Priority Escape (PE): Applying patch.")
local minVer = {1, 7, 1}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("PE: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()
