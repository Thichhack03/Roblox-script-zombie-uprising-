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

-- God mode --
local Players = game:GetService("Players")
local player = Players.LocalPlayer

spawn(function()
    while true do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
            player.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
            end)
        end
        wait(1)
    end
end)

-- Noclip --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local noclip = true -- Đặt true để luôn bật noclip

RunService.Stepped:Connect(function()
    if noclip and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Velocity = Vector3.new(0, 0, 0) -- Giảm đẩy ngược
            end
        end
        -- Di chuyển nhẹ để tránh stuck
        player.Character:Move(Vector3.new(0, 0.001, 0), false)
    end
end)
