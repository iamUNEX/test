local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("SNIFFLES CHEAT - Emergency Hamburg", "Midnight")

--Main
local Aimbot = Window:NewTab("PVP")
local AimbotSection = Aimbot:NewSection("PVP Section")
local Car = Window:NewTab("Car")
local MainSection = Car:NewSection("Mod")
local Player = Window:NewTab("Player")
local PlayerSection = Player:NewSection("Player Mods")
local Visual = Window:NewTab("Visual")
local VisualSection = Visual:NewSection("Visual Effects")
local Misc = Window:NewTab("Misc")
local MiscSection = Misc:NewSection("Misc Features")

MainSection:NewButton("Fix-Car", "Fixes your car from where you are. No need for ADAC!", function()
   game:GetService("ReplicatedStorage"):WaitForChild("events-MkO"):WaitForChild("1c4a2bea-db84-4601-bf7f-c4cc36f8fd90"):FireServer()
end)

MainSection:NewDropdown("Car Colour", "Change your cars colour", {"Black", "Blue", "Green", "Orange", "Purple", "Red", "White", "Yellow"}, function(currentOption)
  local args = {
  [1] = currentOption
}
   game:GetService("ReplicatedStorage"):WaitForChild("events-MkO"):WaitForChild("28f15023-ea6e-4399-a206-6b42978e8da4"):FireServer(unpack(args))
end)

MainSection:NewSlider("Car Speed", "Changes your car speed", 500, 0, function(s)
   game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

MainSection:NewToggle("Auto-Drive", "Automatically drives to waypoint", function(state)
   if state then
       -- Auto drive logic here
   else
       -- Disable auto drive
   end
end)

AimbotSection:NewButton("Aimbot", "Loads Aimbot GUI", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))();
end)

AimbotSection:NewButton("ESP", "Loads ESP GUI", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua"))()
end)

AimbotSection:NewToggle("Silent Aim", "Auto-aims at nearest player", function(state)
   if state then
       -- Silent aim logic
   else
       -- Disable silent aim
   end
end)

AimbotSection:NewSlider("Aim FOV", "Adjusts aimbot field of view", 360, 0, function(s)
   -- Adjust FOV logic
end)

PlayerSection:NewToggle("Infinite Jump", "Allows infinite jumping", function(state)
   if state then
       local InfiniteJumpEnabled = true
       game:GetService("UserInputService").JumpRequest:connect(function()
           if InfiniteJumpEnabled then
               game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
           end
       end)
   end
end)

PlayerSection:NewSlider("WalkSpeed", "Changes your walkspeed", 500, 16, function(s)
   game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewSlider("JumpPower", "Changes your jump power", 350, 50, function(s)
   game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

PlayerSection:NewToggle("Noclip", "Walk through walls", function(state)
   if state then
       local noclip = true
       game:GetService('RunService').Stepped:connect(function()
           if noclip then
               game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
           end
       end)
   end
end)

VisualSection:NewToggle("Fullbright", "Makes everything bright", function(state)
   if state then
       game:GetService("Lighting").Brightness = 2
       game:GetService("Lighting").ClockTime = 14
       game:GetService("Lighting").FogEnd = 100000
       game:GetService("Lighting").GlobalShadows = false
       game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
   else
       game:GetService("Lighting").Brightness = 1
       game:GetService("Lighting").ClockTime = 14
       game:GetService("Lighting").FogEnd = 100000
       game:GetService("Lighting").GlobalShadows = true
       game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
   end
end)

VisualSection:NewToggle("Rainbow Car", "Makes your car rainbow colored", function(state)
   if state then
       -- Rainbow car logic
   end
end)

MiscSection:NewButton("Reset Character", "Resets your character", function()
   game.Players.LocalPlayer.Character:BreakJoints()
end)

MiscSection:NewKeybind("Toggle UI", "Toggles the UI", Enum.KeyCode.RightShift, function()
   Library:ToggleUI()
end)

MiscSection:NewToggle("Anti AFK", "Prevents you from being kicked", function(state)
   if state then
       local vu = game:GetService("VirtualUser")
       game:GetService("Players").LocalPlayer.Idled:connect(function()
           vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
           wait(1)
           vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
       end)
   end
end)