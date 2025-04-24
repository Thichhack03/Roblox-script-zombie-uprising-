while wait(1) do
    for _, zombie in pairs(game:GetService("Workspace").Zombies:GetChildren()) do
        if zombie:FindFirstChild("Head") and not zombie.Head:FindFirstChild("ESP") then
            local esp = Instance.new("BillboardGui", zombie.Head)
            esp.Name = "ESP"
            esp.Size = UDim2.new(0, 100, 0, 20)
            esp.AlwaysOnTop = true
            esp.StudsOffset = Vector3.new(0, 3, 0)

            local text = Instance.new("TextLabel", esp)
            text.Size = UDim2.new(1, 0, 1, 0)
            text.BackgroundTransparency = 1
            text.Text = "ZOMBIE"
            text.TextColor3 = Color3.new(1, 0, 0)
            text.TextStrokeTransparency = 0
            text.Font = Enum.Font.SourceSansBold
            text.TextScaled = true
        end
    end
end
