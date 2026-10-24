--Made by Xeavin
local codePointer = 0x002F9146
local originalBytes = {0x48, 0x85, 0xDB, 0x74, 0x0E}
local code =
[[
  jmp %llp_code%
]]

local assemblies =
[[
llp_code:
  test rbx,rbx
  je 0x002F9159

  mov r8,[rdi+0x00000698]
  movzx eax,byte ptr [r8+0x000001C2]
  movzx ecx,byte ptr [rbx+0x000001C2]

  movsx r9d,byte ptr [llp_offset]
  add ecx,r9d

  cmp eax,ecx
  jl 0x002F9166

  jmp 0x002F914B


  .align 0x10
llp_offset:
  .db 0x00
]]

local symbols = {
  "llp_code",
  "llp_offset"
}

local function getConfigEnv()
  return setmetatable({}, {__index = _G})
end

local offset = 0
local configPath = config.path .. "/LevelboundLPConfig.lua"
local function loadConfig()
  local file, err = loadfile(configPath, "t", getConfigEnv())
  if not file then
    print("LLP: Couldn't load settings from config file: " .. err)
    return false
  end

  local status, res = pcall(file)
  if not status then
    print("LLP: Couldn't load settings from config file: "  .. res)
    return false
  end

  offset = res
  print("LLP: Loaded settings from config file.")
  return true
end

local function enablePatch()
  memory.assemble(assemblies, symbols)
  memory.assemble(code, codePointer)

  local offsetMem = memory.getSymbol("llp_offset")
  memory.s8[offsetMem] = offset
end

local function disablePatch()
  memory.writeArray(codePointer, originalBytes)
  memory.deallocExe(memory.getSymbol(symbols[1]))
  memory.unregisterSymbol(symbols)
end

local function onConfigChange(filepath, stats, created, deleted)
  if deleted then
    return
  end

  if loadConfig() then
    disablePatch()
    enablePatch()
  end
end

local function applyPatch()
local readBytes = memory.readArray(codePointer, #originalBytes)
  if table.concat(readBytes) ~= table.concat(originalBytes) then
    print("LLP: Couldn't apply patch, executable is unexpectedly modified.")
    return
  end

  loadConfig()
  enablePatch()
  event.registerFileChangeHandler(configPath, onConfigChange)
end

print("Levelbound LP (LLP): Applying patch.")
local minVer = {1, 7, 2}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("LLP: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()
