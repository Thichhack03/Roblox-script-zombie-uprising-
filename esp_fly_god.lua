-- ESP cho zombie
spawn(function()
    while wait(1) do
        for _, zombie in pairs(game:GetService("Workspace").Zombies:GetChildren()) do
            if zombie:FindFirstChild("Head") and not zombie.Head:FindFirstChild("ESP") then
                local esp = Instance.new("BillboardGui", zombie.Head)
                esp.Name = "ESP"
                esp.Size = UDim2.new(0, 100, 0, 40)
                esp.AlwaysOnTop = true
                esp.StudsOffset = Vector3.new(0, 2, 0) local label = Instance.new("TextLabel", esp)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = "ZOMBIE"
                label.TextColor3 = Color3.new(1, 0, 0)
                label.TextStrokeColor3 = Color3.new(0, 0, 0)
                label.TextStrokeTransparency = 0
                label.Font = Enum.Font.SourceSansBold
                label.TextScaled = true
            end
        end
    end
end) 
-- Bay khi giữ phím Space
local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local flying = false
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        flying = true
        while flying do
            root.Velocity = Vector3.new(0, 50, 0)
            wait()
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        flying = false
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
