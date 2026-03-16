local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local KEY = "PmTbsiYAgaQJ18NaJU"

--================ KEY SYSTEM ================
local keyGui = Instance.new("ScreenGui")
keyGui.ResetOnSpawn = false
keyGui.Parent = player:WaitForChild("PlayerGui")

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0,250,0,120)
keyFrame.Position = UDim2.new(0.5,-125,0.5,-60)
keyFrame.BackgroundColor3 = Color3.fromRGB(35,0,60)
keyFrame.Parent = keyGui
Instance.new("UICorner",keyFrame)

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1,-20,0,40)
keyBox.Position = UDim2.new(0,10,0,20)
keyBox.PlaceholderText = "Enter Key"
keyBox.Text = ""
keyBox.Parent = keyFrame

local unlock = Instance.new("TextButton")
unlock.Size = UDim2.new(1,-20,0,35)
unlock.Position = UDim2.new(0,10,0,70)
unlock.Text = "Unlock"
unlock.Parent = keyFrame

--================ HUB =======================
local function startHub()

keyGui:Destroy()

local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local spawnPosition = hrp.Position

local instaMove=false
local speedEnabled=false
local autoKick=false
local espEnabled=false
local speed=140

-- GUI
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn=false
gui.Parent=player.PlayerGui

local frame = Instance.new("Frame")
frame.Size=UDim2.new(0,240,0,260)
frame.Position=UDim2.new(0.05,0,0.4,0)
frame.BackgroundColor3=Color3.fromRGB(35,0,60)
frame.Active=true
frame.Parent=gui
Instance.new("UICorner",frame)

local title = Instance.new("TextLabel")
title.Size=UDim2.new(1,0,0,35)
title.BackgroundColor3=Color3.fromRGB(60,0,110)
title.Text="IGORKA HUB"
title.TextColor3=Color3.new(1,1,1)
title.Parent=frame
Instance.new("UICorner",title)

local function makeButton(text,y)
local b=Instance.new("TextButton")
b.Size=UDim2.new(1,-20,0,35)
b.Position=UDim2.new(0,10,0,y)
b.Text=text
b.BackgroundColor3=Color3.fromRGB(85,0,150)
b.TextColor3=Color3.new(1,1,1)
b.Parent=frame
Instance.new("UICorner",b)
return b
end

local autoKickBtn=makeButton("Auto Kick OFF",45)
local instaBtn=makeButton("Insta Steal",90)
local speedBtn=makeButton("Speed OFF",135)
local espBtn=makeButton("ESP OFF",180)
local desyncBtn=makeButton("Desync",225)

--============= GUI DRAG (PC + PHONE) =========
local dragging=false
local dragStart
local startPos

title.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
dragging=true
dragStart=input.Position
startPos=frame.Position
end
end)

title.InputEnded:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
dragging=false
end
end)

UIS.InputChanged:Connect(function(input)
if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
local delta=input.Position-dragStart
frame.Position=UDim2.new(
startPos.X.Scale,
startPos.X.Offset+delta.X,
startPos.Y.Scale,
startPos.Y.Offset+delta.Y
)
end
end)

--================ ESP ========================
local espObjects={}

local function addESP(plr)
if plr==player then return end

local function create(char)

local root=char:WaitForChild("HumanoidRootPart",5)
local head=char:WaitForChild("Head",5)
if not root or not head then return end

local box=Instance.new("BoxHandleAdornment")
box.Size=Vector3.new(4,6,2)
box.Adornee=root
box.AlwaysOnTop=true
box.Transparency=0.3
box.Color3=Color3.fromRGB(180,0,255)
box.Parent=root

local bill=Instance.new("BillboardGui")
bill.Size=UDim2.new(0,120,0,20)
bill.StudsOffset=Vector3.new(0,3,0)
bill.AlwaysOnTop=true
bill.Parent=head

local name=Instance.new("TextLabel")
name.Size=UDim2.new(1,0,1,0)
name.BackgroundTransparency=1
name.Text=plr.Name
name.TextColor3=Color3.fromRGB(200,120,255)
name.TextScaled=true
name.Parent=bill

table.insert(espObjects,box)
table.insert(espObjects,bill)

end

if plr.Character then create(plr.Character) end
plr.CharacterAdded:Connect(create)

end

local function enableESP()
for _,p in pairs(Players:GetPlayers()) do
addESP(p)
end
end

--============= BUTTONS ======================

autoKickBtn.MouseButton1Click:Connect(function()
autoKick=not autoKick
autoKickBtn.Text=autoKick and "Auto Kick ON" or "Auto Kick OFF"
end)

instaBtn.MouseButton1Click:Connect(function()

instaMove=true

if autoKick then
task.delay(2.3,function()
player:Kick("EZZZ STEAL WITH IGORKA HUB")
end)
end

end)

speedBtn.MouseButton1Click:Connect(function()

speedEnabled=not speedEnabled
speedBtn.Text=speedEnabled and "Speed ON" or "Speed OFF"

local hum=char:FindFirstChildOfClass("Humanoid")
if hum then
hum.WalkSpeed=speedEnabled and 30 or 16
end

end)

espBtn.MouseButton1Click:Connect(function()

espEnabled=not espEnabled
espBtn.Text=espEnabled and "ESP ON" or "ESP OFF"

if espEnabled then
enableESP()
else
for _,v in pairs(espObjects) do
v:Destroy()
end
espObjects={}
end

end)

desyncBtn.MouseButton1Click:Connect(function()
char:BreakJoints()
end)

--============= INSTA STEAL ==================

RunService.RenderStepped:Connect(function(dt)

if instaMove and hrp then

local dir=spawnPosition-hrp.Position
local dist=dir.Magnitude

if dist<3 then
hrp.CFrame=CFrame.new(spawnPosition)
instaMove=false
return
end

hrp.CFrame=hrp.CFrame+dir.Unit*speed*dt

end

end)

player.CharacterAdded:Connect(function(c)
char=c
hrp=c:WaitForChild("HumanoidRootPart")
end)

end

--============= KEY CHECK ====================

unlock.MouseButton1Click:Connect(function()

if keyBox.Text==KEY then
startHub()
else
keyBox.Text="Wrong Key"
end

end)
