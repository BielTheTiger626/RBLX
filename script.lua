-- Serviços necessários
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
-- Variáveis globais
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local teamColor = player.TeamColor
local isEnabled = false -- Variável para controlar se o script está ativado ou não
-- Função para verificar se o alvo é um inimigo
local function isEnemy(target)
local targetPlayer = Players:GetPlayerFromCharacter(target)
if targetPlayer and targetPlayer.TeamColor ~= teamColor then
return true
end
return false
end
-- Função para atirar
local function onShoot()
if not isEnabled then return end -- Se o script estiver desativado, não faz nada
local target = mouse.Target
if target and target.Parent then
local character = target.Parent
if character:FindFirstChild("Humanoid") and character:FindFirstChild("Head") then
if isEnemy(character) then
-- Ajusta o tiro para acertar na cabeça
local head = character:FindFirstChild("Head")
if head then
-- Simula o tiro acertando a cabeça
local hitPosition = head.Position
print("Tiro acertou na cabeça do inimigo em:", hitPosition)
-- Aqui você pode adicionar efeitos visuais, sonoros ou dano ao inimigo
-- Exemplo: Causar dano ao Humanoid do inimigo
local humanoid = character:FindFirstChild("Humanoid")
if humanoid then
humanoid:TakeDamage(50) -- Causa 50 de dano
end
end
else
print("Aliado ou objeto não inimigo, tiro ignorado.")
end
end
end
end
-- Função para ativar/desativar o script
local function toggleScript()
isEnabled = not isEnabled -- Alterna entre true e false
if isEnabled then
print("Script de tiro automático ATIVADO.")
else
print("Script de tiro automático DESATIVADO.")
end
end
-- Conecta o evento de tiro ao clique do mouse
UserInputService.InputBegan:Connect(function(input, gameProcessed)
if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed
then
onShoot()
end
-- Tecla "E" para ativar/desativar o script
if input.KeyCode == Enum.KeyCode.E then
toggleScript()
end
end)
-- Loop para verificar se o mouse está sobre um inimigo (opcional)
RunService.RenderStepped:Connect(function()
if not isEnabled then return end -- Se o script estiver desativado, não faz nada
local target = mouse.Target
if target and target.Parent then
local character = target.Parent
if character:FindFirstChild("Humanoid") and character:FindFirstChild("Head") then
if isEnemy(character) then
-- Destaca o inimigo (opcional)
print("Mouse sobre um inimigo:", character.Name)
end
end
end
end)
