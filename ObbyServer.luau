local Players = game:GetService("Players")
local map = workspace:WaitForChild("Obby")
Players.RespawnTime = 2
for _, i in {4, 8, 12} do map["Stage"..i]:SetAttribute("Checkpoint", i) end
for _, name in {"Lava", "Hazard6", "Hazard10", "Hazard14"} do map[name]:SetAttribute("Hazard", true) end
local function playerFromHit(hit)
 local character = hit:FindFirstAncestorOfClass("Model")
 local humanoid = character and character:FindFirstChildOfClass("Humanoid")
 local player = character and Players:GetPlayerFromCharacter(character)
 if player and humanoid and humanoid.Health > 0 then return player, humanoid end
end
local function setup(player)
 player.RespawnLocation = map.Start
 player:SetAttribute("Checkpoint", 0)
 player:SetAttribute("Won", false)
 player.CharacterAdded:Connect(function(character)
  local root = character:WaitForChild("HumanoidRootPart")
  local humanoid = character:WaitForChild("Humanoid")
  humanoid.UseJumpPower = true
  humanoid.JumpPower = 50
  humanoid.WalkSpeed = 16
 end)
end
Players.PlayerAdded:Connect(setup)
for _, player in Players:GetPlayers() do setup(player) end
for _, part in map:GetChildren() do
 if part:GetAttribute("Hazard") then
  part.Touched:Connect(function(hit)
   local _, humanoid = playerFromHit(hit)
   if humanoid then humanoid.Health = 0 end
  end)
 end
 local checkpoint = part:GetAttribute("Checkpoint")
 if checkpoint then
  part.Touched:Connect(function(hit)
   local player = playerFromHit(hit)
   if player and checkpoint > (player:GetAttribute("Checkpoint") or 0) then
    player.RespawnLocation = part
    player:SetAttribute("Checkpoint", checkpoint)
   end
  end)
 end
end
map.Goal.Touched:Connect(function(hit)
 local player = playerFromHit(hit)
 if player and player:GetAttribute("Checkpoint") == 12 then player:SetAttribute("Won", true) end
end)
