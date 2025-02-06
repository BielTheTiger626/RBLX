local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local Mouse = LocalPlayer:GetMouse()

local function hitEnemyHead()
    local target = Mouse.Target
    if target and target.Parent then
        local targetPlayer = Players:GetPlayerFromCharacter(target.Parent)
        if targetPlayer and targetPlayer.Team ~= LocalPlayer.Team then
            print("Atingindo a cabeça do inimigo:", targetPlayer.Name)
            -- Adicione aqui a lógica para acertar a cabeça do inimigo
        end
    end
end

local function seeEnemiesBehindWall()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            print("Inimigo detectado:", player.Name)
            -- Adicione aqui a lógica para tornar os inimigos visíveis
        end
    end
end

local hitActive = false
local seeActive = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.O then
        hitActive = not hitActive
        if hitActive then
            hitEnemyHead()
        end
    elseif input.KeyCode == Enum.KeyCode.Ç then
        seeActive = not seeActive
        if seeActive then
            seeEnemiesBehindWall()
        end
    end
end)
