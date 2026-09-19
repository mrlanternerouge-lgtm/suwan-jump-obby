local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ObbyHUD"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")
local label = Instance.new("TextLabel")
label.AnchorPoint = Vector2.new(0.5, 0)
label.Position = UDim2.new(0.5, 0, 0, 12)
label.Size = UDim2.new(0.9, 0, 0, 74)
label.BackgroundColor3 = Color3.fromRGB(18, 25, 46)
label.BackgroundTransparency = 0.12
label.TextColor3 = Color3.new(1,1,1)
label.Font = Enum.Font.GothamBold
label.TextSize = 18
label.TextWrapped = true
label.Parent = gui
Instance.new("UICorner", label).CornerRadius = UDim.new(0, 14)
local function update()
 if player:GetAttribute("Won") then
  label.BackgroundColor3 = Color3.fromRGB(27, 117, 83)
  label.Text = "YOU DID IT!  Suwan Jump Obby complete!\nCongratulations!"
 else
  local cp = player:GetAttribute("Checkpoint") or 0
  label.Text = "SUWAN JUMP OBBY   |   Checkpoint " .. math.floor(cp / 4) .. " / 3\nJump to the next platform. Avoid red! Progress lasts this session."
 end
end
player:GetAttributeChangedSignal("Checkpoint"):Connect(update)
player:GetAttributeChangedSignal("Won"):Connect(update)
update()
