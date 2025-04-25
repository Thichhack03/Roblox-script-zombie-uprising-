local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

function createHighlight(target, color)
    if target:FindFirstChild("Highlight") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "Highlight"
    highlight.FillColor = color
    highlight.OutlineColor = Color3.new(0, 0, 0)
    highlight.OutlineTransparency = 0
    highlight.FillTransparency = 0.3
    highlight.Adornee = target
    highlight.Parent = target
end

-- ESP Zombie (đỏ)
spawn(function()
    while true do
        local zombiesFolder = workspace:FindFirstChild("Zombies")
        if zombiesFolder then
            for _, zombie in pairs(zombiesFolder:GetChildren()) do
                if zombie:IsA("Model") and zombie:FindFirstChild("HumanoidRootPart") then
                    createHighlight(zombie, Color3.new(1, 0, 0)) -- màu đỏ
                end
            end
        end
        wait(1)
    end
end)

-- ESP đồng minh (xanh dương)
spawn(function()
    while true do
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= localPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                createHighlight(plr.Character, Color3.new(0, 0.5, 1)) -- màu xanh lam
            end
        end
        wait(1)
    end
end) 

-- God Mode
spawn(function()
    while wait(0.5) do
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.Health = char.Humanoid.MaxHealth
        end
    end
end)

-- Kill aura --
local killAuraRadius = 10 -- Tầm của Kill Aura
local player = game.Players.LocalPlayer -- Lấy người chơi
local character = player.Character or player.CharacterAdded:Wait() -- Lấy nhân vật của người chơi
local humanoid = character:WaitForChild("Humanoid") -- Lấy đối tượng Humanoid của nhân vật

-- Hàm kiểm tra quái vật trong phạm vi và tiêu diệt chúng
local function killNearbyZombies()
    -- Duyệt qua tất cả các đối tượng trong game
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("ZombieTag") then -- Kiểm tra nếu là quái vật
            local zombie = obj
            local distance = (zombie.HumanoidRootPart.Position - character.HumanoidRootPart.Position).magnitude -- Tính khoảng cách giữa người chơi và zombie
            if distance <= killAuraRadius then -- Nếu zombie trong phạm vi kill aura
                local zombieHumanoid = zombie:FindFirstChild("Humanoid")
                if zombieHumanoid then
                    zombieHumanoid.Health = 0 -- Giết zombie
                end
            end
        end
    end
end

-- Tạo một vòng lặp để kiểm tra liên tục
while true do
    wait(1) -- Mỗi giây kiểm tra
    killNearbyZombies()
end
