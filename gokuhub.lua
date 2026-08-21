-- ==========================================================
--                   GOKU HUB - CLEAN & MINIMAL ORANGE
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

-- 1. BOTÓN FLOTANTE MINIMALISTA
FloatingBtn.Name = "GokuFloatingBtn"
FloatingBtn.Parent = ScreenGui
FloatingBtn.Position = UDim2.new(0.9, 0, 0.85, 0)
FloatingBtn.Size = UDim2.new(0, 60, 0, 60)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(255, 90, 0)
FloatingBtn.Text = "Goku"
FloatingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingBtn.Font = Enum.Font.SourceSansBold
FloatingBtn.TextSize = 14
FloatingBtn.ZIndex = 10

UICornerBtn.CornerRadius = UDim.new(1, 0)
UICornerBtn.Parent = FloatingBtn

-- 2. MENÚ PRINCIPAL INTERFAZ LIMPIA (Fondo oscuro puro y líneas finas)
MainMenu.Name = "GokuHubMenu"
MainMenu.Parent = ScreenGui
MainMenu.Position = UDim2.new(0.5, -300, 0.5, -200)
MainMenu.Size = UDim2.new(0, 600, 0, 400)
MainMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainMenu.BorderSizePixel = 0
MainMenu.Visible = false

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 90, 0)
MainStroke.Thickness = 1
MainStroke.Parent = MainMenu

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainMenu

-- Barra Lateral (Sidebar)
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainMenu
Sidebar.Size = UDim2.new(0, 140, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Sidebar.BorderSizePixel = 0

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = Sidebar

-- Separador visual interno oculto para esquinas derechas de la barra
local SidebarFix = Instance.new("Frame")
SidebarFix.Size = UDim2.new(0, 10, 1, 0)
SidebarFix.Position = UDim2.new(1, -10, 0, 0)
SidebarFix.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
SidebarFix.BorderSizePixel = 0
SidebarFix.Parent = Sidebar

HubTitle.Name = "HubTitle"
HubTitle.Parent = Sidebar
HubTitle.Size = UDim2.new(1, 0, 0, 50)
HubTitle.Text = "GOKU HUB"
HubTitle.TextColor3 = Color3.fromRGB(255, 90, 0)
HubTitle.Font = Enum.Font.SourceSansBold
HubTitle.TextSize = 16

-- Área de Contenido
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainMenu
ContentArea.Position = UDim2.new(0, 140, 0, 0)
ContentArea.Size = UDim2.new(1, -140, 1, 0)
ContentArea.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ContentArea.BorderSizePixel = 0

CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainMenu
CloseBtn.Position = UDim2.new(1, -30, 0, 12)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.SourceSans
CloseBtn.TextSize = 22

-- Estado global
local Config = {
    SpeedValue = 16,
    FovSizeValue = 50,
    SpeedEnabled = false,
    FovEnabled = false
}

-- 3. CREACIÓN DE PESTAÑAS MINIMALISTAS
local function createTabButton(name, posIndex)
    local Btn = Instance.new("TextButton")
    Btn.Parent = Sidebar
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.Position = UDim2.new(0, 0, 0, 55 + (posIndex * 35))
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(130, 130, 130)
    Btn.BackgroundTransparency = 1
    Btn.Font = Enum.Font.SourceSansSemibold
    Btn.TextSize = 14
    return Btn
end

local GeneralBtn = createTabButton("General", 0)
local CombatBtn = createTabButton("Combat", 1)
local PlayerBtn = createTabButton("Player", 2)
local SettingsBtn = createTabButton("Settings", 3)

GeneralBtn.TextColor3 = Color3.fromRGB(255, 90, 0)

-- 4. CONTENEDORES DE PÁGINAS
local Pages = {}
local function createPage(id)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = id .. "Page"
    Page.Parent = ContentArea
    Page.Size = UDim2.new(1, -24, 1, -24)
    Page.Position = UDim2.new(0, 12, 0, 12)
    Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Color3.fromRGB(255, 90, 0)
    Page.Visible = (id == "General")
    Pages[id] = Page
    
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Page
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 8)

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
    end)
    
    return Page
end

local GeneralPage = createPage("General")
local CombatPage = createPage("Combat")
local PlayerPage = createPage("Player")
local SettingsPage = createPage("Settings")

-- 5. BOTONES LIMPIOS (Fondo plano y bordes sutiles)
local function addCheatButton(page, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = page
    Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Btn.Size = UDim2.new(1, 0, 0, 36)
    Btn.Text = text .. " [OFF]"
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.SourceSansSemibold
    Btn.TextSize = 14
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Btn
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(35, 35, 35)
    Stroke.Thickness = 1
    Stroke.Parent = Btn

    local enabled = false
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            Btn.Text = text .. " [ON]"
            Btn.TextColor3 = Color3.fromRGB(255, 90, 0)
            Stroke.Color = Color3.fromRGB(255, 90, 0)
        else
            Btn.Text = text .. " [OFF]"
            Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            Stroke.Color = Color3.fromRGB(35, 35, 35)
        end
        callback(enabled)
    end)
    return Btn
end

-- 5B. SLIDERS ESTILO CLEAN
local function addSlider(page, text, min, max, startVal, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Parent = page
    SliderFrame.Size = UDim2.new(1, 0, 0, 40)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    SliderFrame.BorderSizePixel = 0
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = SliderFrame

    local Label = Instance.new("TextLabel")
    Label.Parent = SliderFrame
    Label.Size = UDim2.new(1, -20, 0, 18)
    Label.Position = UDim2.new(0, 12, 0, 4)
    Label.Text = text .. ": " .. startVal .. "%"
    Label.TextColor3 = Color3.fromRGB(180, 180, 180)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local Container = Instance.new("Frame")
    Container.Parent = SliderFrame
    Container.Size = UDim2.new(1, -24, 0, 4)
    Container.Position = UDim2.new(0, 12, 0, 26)
    Container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Container.BorderSizePixel = 0
    
    local Fill = Instance.new("Frame")
    Fill.Parent = Container
    Fill.Size = UDim2.new((startVal-min)/(max-min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 90, 0)
    Fill.BorderSizePixel = 0

    local UIS = game:GetService("UserInputService")
    local moveCon
    
    local function update(input)
        local coords = input.Position.X - Container.AbsolutePosition.X
        local percent = math.clamp(coords / Container.AbsoluteSize.X, 0, 1)
        Fill.Size = UDim2.new(percent, 0, 1, 0)
        local value = math.floor(min + (max - min) * percent)
        Label.Text = text .. ": " .. value .. "%"
        callback(value)
    end

    Container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            update(input)
            moveCon = UIS.InputChanged:Connect(function(changedInput)
                if changedInput.UserInputType == Enum.UserInputType.MouseMovement or changedInput.UserInputType == Enum.UserInputType.Touch then
                    update(changedInput)
                end
            end)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if moveCon then moveCon:Disconnect() moveCon = nil end
        end
    end)
end

-- ==========================================================
-- 6. ASIGNACIÓN DE CONTROLES
-- ==========================================================

-- PESTAÑA: GENERAL
addCheatButton(GeneralPage, "Speed Hack", function(state)
    Config.SpeedEnabled = state
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = state and Config.SpeedValue or 16
    end
end)

addSlider(GeneralPage, "Porcentaje Velocidad", 1, 100, 50, function(value)
    Config.SpeedValue = value
    local player = game.Players.LocalPlayer
    if Config.SpeedEnabled and player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = value
    end
end)

addCheatButton(GeneralPage, "Jump Fly", function(state)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = state and 85 or 50
    end
end)

addCheatButton(GeneralPage, "ESP Items", function(state) end)

-- PESTAÑA: COMBAT
addCheatButton(CombatPage, "Silent Aim", function(state) end)

Usa el código con precaución.addCheatButton(CombatPage, "FOV Circle", function(state)Config.FovEnabled = stateend)addSlider(CombatPage, "Porcentaje Tamaño FOV", 1, 100, 50, function(value)Config.FovSizeValue = valueend)addCheatButton(CombatPage, "Aimbot Head", function(state) end)-- PESTAÑA: PLAYERaddCheatButton(PlayerPage, "ESP Name", function(state) end)addCheatButton(PlayerPage, "ESP Box", function(state) end)addCheatButton(PlayerPage, "ESP Skeleton", function(state) end)-- PESTAÑA: SETTINGSaddCheatButton(SettingsPage, "Destruir Hub", function(state)if state then ScreenGui:Destroy() endend)-- ==========================================================-- 7. SISTEMA DE NAVEGACIÓN Y ARRASTRE-- ==========================================================local function showPage(tabName, activeBtn)for id, page in pairs(Pages) do page.Visible = (id == tabName) endGeneralBtn.TextColor3 = Color3.fromRGB(130, 130, 130)CombatBtn.TextColor3 = Color3.fromRGB(130, 130, 130)PlayerBtn.TextColor3 = Color3.fromRGB(130, 130, 130)SettingsBtn.TextColor3 = Color3.fromRGB(130, 130, 130)activeBtn.TextColor3 = Color3.fromRGB(255, 90, 0)endGeneralBtn.MouseButton1Click:Connect(function() showPage("General", GeneralBtn) end)CombatBtn.MouseButton1Click:Connect(function() showPage("Combat", CombatBtn) end)PlayerBtn.MouseButton1Click:Connect(function() showPage("Player", PlayerBtn) end)SettingsBtn.MouseButton1Click:Connect(function() showPage("Settings", SettingsBtn) end)FloatingBtn.MouseButton1Click:Connect(function() MainMenu.Visible = not MainMenu.Visible end)CloseBtn.MouseButton1Click:Connect(function() MainMenu.Visible = false end)local function makeDraggable(guiObject)local dragging, dragStart, startPosguiObject.InputBegan:Connect(function(input)if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch thendragging = true; dragStart = input.Position; startPos = guiObject.Positionendend)game:GetService("UserInputService").InputChanged:Connect(function(input)if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) thenlocal delta = input.Position - dragStartguiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)endend)game:GetService("UserInputService").InputEnded:Connect(function(input)if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch thendragging = falseendend)endmakeDraggable(FloatingBtn)makeDraggable(MainMenu)
