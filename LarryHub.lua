--// SERVIÇOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

--// CHARACTER
local function getHumanoid()
	local char = player.Character
	if not char then return end
	return char:FindFirstChildOfClass("Humanoid")
end

local function getHRP()
	local char = player.Character
	if not char then return end
	return char:FindFirstChild("HumanoidRootPart")
end

--// GUI
local gui = Instance.new("ScreenGui")
gui.Name = "LarryHub"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- BOTÃO ☠️
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.fromOffset(40,40)
toggle.Position = UDim2.fromScale(0.9,0.05)
toggle.Text = "☠️"
toggle.TextSize = 22
toggle.Font = Enum.Font.GothamBlack
toggle.TextColor3 = Color3.new(1,1,1)
toggle.BackgroundColor3 = Color3.fromRGB(20,20,20)
toggle.Active = true
toggle.Draggable = true
toggle.Parent = gui
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,8)

-- FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(240,300)
frame.Position = UDim2.fromScale(0.35,0.35)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)

-- TÍTULO
local title = Instance.new("TextLabel")
title.Size = UDim2.fromOffset(240,30)
title.Text = "☠️LARRY HUB☠️FARM AND GUNS☠️"
title.Font = Enum.Font.GothamBlack
title.TextSize = 16
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Parent = frame

-- FUNÇÃO BOTÃO
local function mkBtn(txt,y,color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.fromOffset(220,30)
	b.Position = UDim2.fromOffset(10,y)
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 13
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = color
	b.Parent = frame
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

local speedBtn = mkBtn("",40,Color3.fromRGB(120,120,255))

-- TOGGLE MENU
toggle.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

--------------------------------------------------
-- SPEED (FORÇADO / INQUEBRÁVEL)
--------------------------------------------------
local speedLevel = 1
local baseSpeed = 16

local function updateSpeedText()
	local next = speedLevel + 1
	if next > 5 then next = 1 end
	speedBtn.Text = "SPEED "..speedLevel.."x (PRÓXIMO "..next.."x)"
end
updateSpeedText()

speedBtn.MouseButton1Click:Connect(function()
	speedLevel += 1
	if speedLevel > 5 then speedLevel = 1 end
	updateSpeedText()
end)

-- FORÇA SPEED SEMPRE
RunService.Heartbeat:Connect(function()
	local hum = getHumanoid()
	if hum then
		hum.WalkSpeed = baseSpeed * speedLevel
	end
end)

-- GARANTE APÓS RESPAWN
player.CharacterAdded:Connect(function()
	task.wait(0.5)
	updateSpeedText()
end)
