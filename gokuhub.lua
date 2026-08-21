-- ==========================================================
--                   GOKU HUB - SCRIPT UNIFICADO
-- ==========================================================

local ScreenGui = Instance.new("ScreenGui")
local FloatingBtn = Instance.new("TextButton")
local UICornerBtn = Instance.new("UICorner")
local MainMenu = Instance.new("Frame")
local Sidebar = Instance.new("Frame")
local HubTitle = Instance.new("TextLabel")
local ContentArea = Instance.new("Frame")
local CloseBtn = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- 1. CONFIGURACIÓN DEL BOTÓN FLOTANTE
FloatingBtn.Name = "GokuFloatingBtn"
FloatingBtn.Parent = ScreenGui
FloatingBtn.Position = UDim2.new(0.9, 0, 0.85, 0)
FloatingBtn.Size = UDim2.new(0, 70, 0, 70)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(255, 69, 0)
FloatingBtn.Text = "Goku\nHub"
FloatingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingBtn.Font = Enum.Font.SourceSansBold
FloatingBtn.TextSize = 14
FloatingBtn.ZIndex = 10

UICornerBtn.CornerRadius = UDim.new(1, 0)
UICornerBtn.Parent = FloatingBtn

-- 2. CONFIGURACIÓN DEL MENÚ PRINCIPAL
MainMenu.Name = "GokuHubMenu"
MainMenu.Parent = ScreenGui
MainMenu.Position = UDim2.new(0.5, -300, 0.5, -200)
MainMenu.Size = UDim2.new(0, 600, 0, 400)
MainMenu.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
MainMenu.BorderSizePixel = 2
MainMenu.BorderColor3 = Color3.fromRGB(255, 69, 0)
MainMenu.Visible = false

Sidebar.Name = "Sidebar"
Sidebar.Parent = MainMenu
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(17, 17, 17)

HubTitle.Name = "HubTitle"
HubTitle.Parent = Sidebar
HubTitle.Size = UDim2.new(1, 0, 0, 50)
HubTitle.Text = "GOKU HUB"
HubTitle.TextColor3 = Color3.fromRGB(255, 140, 0)
HubTitle.Font = Enum.Font.SourceSansBold
HubTitle.TextSize = 18

ContentArea.Name = "ContentArea"
ContentArea.Parent = MainMenu
ContentArea.Position = UDim2.new(0, 150, 0, 0)
ContentArea.Size = UDim2.new(1, -150, 1, 0)
ContentArea.BackgroundColor3 = Color3.fromRGB(22, 22, 22)

CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainMenu
CloseBtn.Position = UDim2.new(1, -30, 0, 10)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 69, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextSize = 18

-- 3. CREACIÓN DE PESTAÑAS LATERALES
local function createTabButton(name, posIndex)
    local Btn = Instance.new("TextButton")
    Btn.Parent = Sidebar
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.Position = UDim2.new(0, 0, 0, 50 + (posIndex * 40))
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(136, 136, 136)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Btn.BackgroundTransparency = 1
    Btn.Font = Enum.Font.SourceSans
    Btn.TextSize = 14
    return Btn
end

local GeneralBtn = createTabButton("General", 0)
local CombatBtn = createTabButton("Combat", 1)
local PlayerBtn = createTabButton("Player", 2)
local SettingsBtn = createTabButton("Settings", 3)

GeneralBtn.TextColor3 = Color3.fromRGB(255, 69, 0)

-- 4. CONTENEDORES PARA CADA APARTADO (PÁGINAS)
local Pages = {}
local function createPage(id)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = id .. "Page"
    Page.Parent = ContentArea
    Page.Size = UDim2.new(1, -20, 1, -20)
    Page.Position = UDim2.new(0, 10, 0, 10)
    Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 2, 0)
    Page.ScrollBarThickness = 4
    Page.Visible = (id == "General")
    Pages[id] = Page
    
    local Layout = Instance.new("UIGridLayout")
    Layout.Parent = Page
    Layout.CellSize = UDim2.new(0, 200, 0, 45)
    Layout.CellPadding = UDim2.new(0, 15, 0, 15)
    return Page
end

local GeneralPage = createPage("General")
local CombatPage = createPage("Combat")
local PlayerPage = createPage("Player")
local SettingsPage = createPage("Settings")

-- 5. FUNCIÓN CREADORA DE BOTONES INTERACTIVOS (ON/OFF)
local function addCheatButton(page, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = page
    Btn.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
    Btn.Text = text .. " [OFF]"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansSemibold
    Btn.TextSize = 14
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Btn
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(51, 51, 51)
    Stroke.Thickness = 1
    Stroke.Parent = Btn

    local enabled = false
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            Btn.Text = text .. " [ON]"
            Btn.TextColor3 = Color3.fromRGB(0, 255, 0)
            Stroke.Color = Color3.fromRGB(0, 255, 0)
        else
            Btn.Text = text .. " [OFF]"
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Stroke.Color = Color3.fromRGB(51, 51, 51)
        end
        callback(enabled)
    end)
end

-- 6. ASIGNACIÓN DE BOTONES POR APARTADO

-- Pestaña: General
addCheatButton(GeneralPage, "Speed Hack", function(state)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = state and 100 or 16
    end
end)

addCheatButton(GeneralPage, "Jump Fly", function(state)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = state and 150 or 50
    end
end)

addCheatButton(GeneralPage, "ESP Items", function(state) end)

-- Pestaña: Combat
addCheatButton(CombatPage, "Silent Aim", function(state) end)
addCheatButton(CombatPage, "FOV Circle", function(state) end)
addCheatButton(CombatPage, "Aimbot Head", function(state) end)

-- Pestaña: Player
addCheatButton(PlayerPage, "ESP Name", function(state) end)
addCheatButton(PlayerPage, "ESP Box", function(state) end)
addCheatButton(PlayerPage, "ESP Skeleton", function(state) end)

-- 7. LÓGICA DE NAVEGACIÓN LATERAL
local function showPage(tabName, activeBtn)
    for id, page in pairs(Pages) do
        page.Visible = (id == tabName)
    end
    GeneralBtn.TextColor3 = Color3.fromRGB(136, 136, 136)
    CombatBtn.TextColor3 = Color3.fromRGB(136, 136, 136)
    PlayerBtn.TextColor3 = Color3.fromRGB(136, 136, 136)
    SettingsBtn.TextColor3 = Color3.fromRGB(136, 136, 136)
    activeBtn.TextColor3 = Color3.fromRGB(255, 69, 0)
end

GeneralBtn.MouseButton1Click:Connect(function() showPage("General", GeneralBtn) end)
CombatBtn.MouseButton1Click:Connect(function() showPage("Combat", CombatBtn) end)
PlayerBtn.MouseButton1Click:Connect(function() showPage("Player", PlayerBtn) end)
SettingsBtn.MouseButton1Click:Connect(function() showPage("Settings", SettingsBtn) end)

-- 8. CONTROLES DEL MENÚ Y SISTEMA ARRASTRABLE
FloatingBtn.MouseButton1Click:Connect(function()
    MainMenu.Visible = not MainMenu.Visible
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainMenu.Visible = false
end)

local dragging, dragInput, dragStart, startPos
FloatingBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = FloatingBtn.Position
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        FloatingBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
