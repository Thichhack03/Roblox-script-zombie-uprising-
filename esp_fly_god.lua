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

-- Noclip (giữ phím "N" để bật/tắt hoặc luôn bật nếu dùng mobile)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local noclipEnabled = true -- Đặt true để luôn bật, false nếu muốn nút bật/tắt

-- Nếu dùng PC và muốn toggle bằng phím N
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.N then
        noclipEnabled = not noclipEnabled
        print("Noclip: ", noclipEnabled)
    end
end)

-- Cập nhật trạng thái noclip liên tục
RunService.Stepped:Connect(function()
    if noclipEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide == true then
                part.CanCollide = false
            end
        end
    end
end)

-- Thêm tiền vào hệ thống có sẵn (giả sử tên là "Cash" hoặc "Money")
local player = game.Players.LocalPlayer

spawn(function()
    while true do
        local zombies = workspace:FindFirstChild("Zombies")
        if zombies then
            for _, z in pairs(zombies:GetChildren()) do
                local hum = z:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 and not z:FindFirstChild("CoinTag") then
                    -- Gắn tag để không xử lý lại
                    local tag = Instance.new("BoolValue", z)
                    tag.Name = "CoinTag"

                    hum.Died:Connect(function()
                        local stats = player:FindFirstChild("leaderstats")
                        if stats then
                            local cash = stats:FindFirstChild("Cash") or stats:FindFirstChild("Money") or stats:FindFirstChild("Coins")
                            if cash then
                                cash.Value = cash.Value + 1000 -- +$1000 vào hệ thống game
                                print("Nhận $1000! Tổng tiền: $"..cash.Value)
                            end
                        end
                    end)
                end
            end
        end
        wait(1)
    end
end)
