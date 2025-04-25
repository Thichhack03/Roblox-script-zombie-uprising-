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
