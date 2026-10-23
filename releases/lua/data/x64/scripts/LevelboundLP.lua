--Made by Xeavin
local patches = {
  {
    blockCode = [[
    llp_offset:
      .db 0x00
    ]],
    symbols = {"llp_offset"}
  },
  {
    target = 0x002F9146,
    originalBytes = {0x48, 0x85, 0xDB, 0x74, 0x0E},
    patchCode = [[
      jmp %llp_code%
    ]],
    blockCode = [[
    llp_code:
      test rbx,rbx
      je 0x002F9159

      mov r8,[rdi+0x00000698]
      movzx eax,byte ptr [r8+0x000001C2]
      movzx ecx,byte ptr [rbx+0x000001C2]

      movsx r9d,byte ptr [%llp_offset%]
      add ecx,r9d

      cmp eax,ecx
      jl 0x002F9166

      jmp 0x002F914B
    ]],
    symbols = {"llp_code"}
  }
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

local function checkOriginalBytes(target, originalBytes)
  local currentBytes = memory.readArray(target, #originalBytes)
  for i = 1, #originalBytes do
    if currentBytes[i] ~= originalBytes[i] then
      return false
    end
  end

  return true
end

local function enablePatch()
  for _, entry in ipairs(patches) do
    if entry.target and entry.originalBytes and
       not checkOriginalBytes(entry.target, entry.originalBytes) then
      print("LLP: Couldn't apply patch, executable is unexpectedly modified.")
      return false
    end
  end

  for i, entry in ipairs(patches) do
    if entry.blockCode and entry.symbols then
      memory.assemble(entry.blockCode, entry.symbols)
    end

    if entry.target and entry.patchCode then
      memory.assemble(entry.patchCode, entry.target)
    end
  end

  return true
end

local function setLevelOffset()
  local offsetMem = memory.getSymbol("llp_offset")
  memory.s8[offsetMem] = offset
end

local function onConfigChange(filepath, stats, created, deleted)
  if deleted then
    return
  end

  if loadConfig() then
    setLevelOffset()
  end
end

local function applyPatch()
  if not enablePatch() then
    return
  end

  loadConfig()
  setLevelOffset()
  event.registerFileChangeHandler(configPath, onConfigChange)
end

print("Levelbound LP (LLP): Applying patch.")
local minVer = {1, 7, 2}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("LLP: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()
