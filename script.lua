local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local function hitEnemyHead()
    local target = Mouse.Target
    if target and target:IsA("Player") and target.Team ~= LocalPlayer.Team then
        -- Lógica para atingir a cabeça do inimigo
    end
end

local function seeEnemiesBehindWall()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Team ~= LocalPlayer.Team then
            -- Lógica para ver inimigos atrás da parede
        end
    end
end

local function checkTeam()
    return LocalPlayer.Team
end

local hitKey = Enum.KeyCode.O
local seeKey = Enum.KeyCode.Ç

local hitActive = false
local seeActive = false

Mouse.KeyDown:Connect(function(key)
    if key == hitKey.Name then
        hitActive = not hitActive
        if hitActive then
            hitEnemyHead()
        end
    elseif key == seeKey.Name then
        seeActive = not seeActive
        if seeActive then
            seeEnemiesBehindWall()
        end
    end
end)
