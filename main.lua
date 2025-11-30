
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "W5Uk Cheats",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by w5uk",
   ShowText = "Rayfiel", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "Q", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Paid Key",
      Subtitle = "Key System",
      Note = "Join The Discord To Purchase a Key!", -- Use this to tell the user how to get a key
      FileName = "W5UKKey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"X7K9P2Q4A8L3","M4D8ZK2R7QW9","9A7QPL4ZX2M8","W2R8K4MZ9LQP","KZ4P2W9MA8RQ","Q7R4XZ9MKA2P","8ZMP4RKA9XQ2","2Q9XK7W4ZPMA","A9M2QX7ZPR4K","W4Q7PZ8AKM2R","4P2AKMW79XZQ","XW7P2K9MZQRA","M7X9QP2ZA4RK","A4ZQK9R7XMP2","K7PZQXRM24A9","ZQ9K27XAPMR4","9XRQK4Z2WAMP","MP4Z7QWX29KA","QK729PZ4XRMA","XZ9PQM4AK2R7","KQWZ2MX9A47P","RZQ9KPX4A72M","W9X2K4RZQMAP","72A4PMZQKRX9","QPZ4MX29K7AR","KMX2Q9R4AZ7P","X9A2QZK4MR7P","R4ZP29AMQXK7","2X9ZQ7W4KMAP","K7XQZP9MR2A4","ZM4Q29XPK7AR","R9X42PZQ7KM","QA72Z4KMRXP9","4A9XQMZ2RK7P","PZK9W72X4QMA","9MZKA24XRP7Q","Q2M7AZ4PXK9R","29QXPMZKRA74","XPA7QM9KZ4R2","K2XPZ9A7QM4R","WM7XQPZ29AK4","9KXAQM4P2RZ7","XRM9K4P2AZ7Q","7Q9MKXPZA24R","KP4QZ7X9MA2R","2AZ9QM4XK7RP","9PZ4AKXR2MQ7","XZ4RQM9KP2A7","Q9XZKMP47AR2","4QK7A9XPZ2MR"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Tab = Window:CreateTab("Player Mods", 4483362458) -- Title, Image

local SpeedSlider = Tab:CreateSlider({
   Name = "Speed",
   Range = {0, 100},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      -- Update your speed here
      -- Example for Roblox:
      local player = game.Players.LocalPlayer
      if player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

local JumpPowerSlider = Tab:CreateSlider({
   Name = "Jump Power",
   Range = {0, 100},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      -- Update your jump power here
      local player = game.Players.LocalPlayer
      if player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid.JumpPower = Value
      end
   end,
})

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
