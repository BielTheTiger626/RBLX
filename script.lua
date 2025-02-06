# Improved Automatic Shooting Script

-- Required Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Global Variables
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local teamColor = player.TeamColor
local isEnabled = false -- Variable to control if the script is enabled or not

-- Function to check if the target is an enemy
local function isEnemy(target)
    local targetPlayer = Players:GetPlayerFromCharacter(target)
    return targetPlayer and targetPlayer.TeamColor ~= teamColor
end

-- Function to shoot
local function onShoot()
    if not isEnabled then return end -- If the script is disabled, do nothing
    local target = mouse.Target
    if target and target.Parent then
        local character = target.Parent
        if character:FindFirstChild("Humanoid") and character:FindFirstChild("Head") then
            if isEnemy(character) then
                -- Adjust the shot to hit the head
                local head = character:FindFirstChild("Head")
                if head then
                    -- Simulate the shot hitting the head
                    local hitPosition = head.Position
                    print("Shot hit enemy's head at:", hitPosition)
                    -- Here you can add visual effects, sounds, or damage to the enemy
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:TakeDamage(50) -- Inflict 50 damage
                    end
                end
            else
                print("Ally or non-enemy object, shot ignored.")
            end
        end
    end
end

-- Function to toggle the script
local function toggleScript()
    isEnabled = not isEnabled -- Toggle between true and false
    print("Automatic shooting script " .. (isEnabled and "ENABLED." or "DISABLED."))
end

-- Connect the shooting event to mouse click
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed then
        onShoot()
    end
    -- Key "E" to toggle the script
    if input.KeyCode == Enum.KeyCode.E then
        toggleScript()
    end
end)

-- Loop to check if the mouse is over an enemy (optional)
RunService.RenderStepped:Connect(function()
    if not isEnabled then return end -- If the script is disabled, do nothing
    local target = mouse.Target
    if target and target.Parent then
        local character = target.Parent
        if character:FindFirstChild("Humanoid") and character:FindFirstChild("Head") then
            if isEnemy(character) then
                -- Highlight the enemy (optional)
                print("Mouse over an enemy:", character.Name)
            end
        end
    end
end)
