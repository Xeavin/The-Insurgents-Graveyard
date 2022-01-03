--Made by Xeavin
local codePointer = 0x00354454
local originalBytes = {0xE8, 0x57, 0x38, 0xF1, 0xFF}
local code =
[[
  call %ast_code%
]]

local configPath = config.path .. "/AlwaysSpawnTreasuresConfig.lua"
local function loadConfig()
  local configEnv = {}
  local file, err = loadfile(configPath, "t", configEnv)
  if not file then
    print("AST: Couldn't load data from config file: " .. err)
    return false
  end

  local uniqueState = file()
  local ast_parameters = memory.allocExe(0x01)
  if(uniqueState) then memory.u8[ast_parameters] = 0x01 end

  memory.registerSymbol("ast_us", ast_parameters)

  print("AST: Loaded data from config file.")
  return true
end

print("Always Spawn Treasures (AST): Applying patch.")
if(loadConfig() == false) then return end
memory.assemble(
[[
ast_code:
  mov [rsp+0x08],rbx
  sub rsp,0x28
  mov rbx,rcx

  cmp byte ptr [%ast_us%],0x00
  je short ast_st

  movzx ecx,byte ptr [rbx+0x09]
  call 0x0032AA60
  test eax,eax
  je short ast_st

  xor eax,eax
  jmp short ast_return

ast_st:
  call 0x003148F0

  lea rcx,[0x02EC3E60]
  mov edx,eax
  movzx r8d,byte ptr [rbx]
  mov r9d,0x00000001
  call 0x002FB430

  mov eax,0x00000001

ast_return:
  mov rbx,[rsp+0x30]
  add rsp,0x28
  ret

]], {"ast_code"})

local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("AST: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("AST: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("AST: Couldn't write to memory.")
  return
end

local function onExit()
  memory.unregisterAllSymbols()
  collectgarbage()
end

event.registerEventAsync("exit", onExit)
