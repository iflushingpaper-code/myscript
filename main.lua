local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "W5Uk Cheats",
   Icon = 0,
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by w5uk",
   ShowText = "Rayfiel",
   Theme = "Default",

   ToggleUIKeybind = "Q",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },

   KeySystem = true,
   KeySettings = {
      Title = "Paid Key",
      Subtitle = "Key System",
      Note = "Join The Discord To Purchase a Key!",
      FileName = "W5UKKey",
      SaveKey = true,

      -- ✅ SECURED KEY SYSTEM
      GrabKeyFromSite = true,
      Key = "https://raw.githubusercontent.com/w5uk/W5UK/main/keys.txt"
   }
})

-- ==============================
-- PLAYER MODS TAB
-- ==============================
local Tab = Window:CreateTab("Player Mods", 4483362458)

-- SPEED SLIDER
local SpeedSlider = Tab:CreateSlider({
   Name = "Speed",
   Range = {0, 100},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      if player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

-- JUMP POWER SLIDER
local JumpPowerSlider = Tab:CreateSlider({
   Name = "Jump Power",
   Range = {0, 100},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      if player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid.JumpPower = Value
      end
   end,
})

-- NOCLIP
local NoClip = false

local Button = Tab:CreateButton({
   Name = "Toggle No Clip",
   Callback = function()
      NoClip = not NoClip

      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()

      while NoClip do
         for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
               part.CanCollide = false
            end
         end
         task.wait()
      end
   end,
})

-- FLY
local Fly = false
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer

local FlyButton = Tab:CreateButton({
   Name = "Toggle Fly",
   Callback = function()
      Fly = not Fly

      local character = player.Character or player.CharacterAdded:Wait()
      local humanoid = character:FindFirstChild("Humanoid")
      local rootPart = character:FindFirstChild("HumanoidRootPart")

      if Fly then
         humanoid.PlatformStand = true

         local bodyVelocity = Instance.new("BodyVelocity")
         bodyVelocity.Velocity = Vector3.new(0, 0, 0)
         bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
         bodyVelocity.Parent = rootPart

         local bodyGyro = Instance.new("BodyGyro")
         bodyGyro.CFrame = rootPart.CFrame
         bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
         bodyGyro.Parent = rootPart

         RunService:BindToRenderStep("FlyMovement", 0, function()
            if Fly then
               local cam = workspace.CurrentCamera
               local moveVec = Vector3.new(0, 0, 0)

               if UIS:IsKeyDown(Enum.KeyCode.W) then moveVec += cam.CFrame.LookVector end
               if UIS:IsKeyDown(Enum.KeyCode.S) then moveVec -= cam.CFrame.LookVector end
               if UIS:IsKeyDown(Enum.KeyCode.A) then moveVec -= cam.CFrame.RightVector end
               if UIS:IsKeyDown(Enum.KeyCode.D) then moveVec += cam.CFrame.RightVector end
               if UIS:IsKeyDown(Enum.KeyCode.Space) then moveVec += Vector3.new(0, 1, 0) end
               if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveVec -= Vector3.new(0, 1, 0) end

               bodyVelocity.Velocity = moveVec * 50
               bodyGyro.CFrame = cam.CFrame
            end
         end)
      else
         humanoid.PlatformStand = false
         RunService:UnbindFromRenderStep("FlyMovement")

         for _, v in pairs(rootPart:GetChildren()) do
            if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
               v:Destroy()
            end
         end
      end
   end,
})
