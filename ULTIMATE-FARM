--[[
  ULTIMATE FARM v5.1 - FULL GUI PARA MÓVIL
  Script optimizado para Delta móvil
  Funciones: Teleport, Invisible, Treadmill, Clon Farm, Anti-AFK
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- BUSCAR ZONA-12
-- ============================================================
local zonas = Workspace:FindFirstChild("Zonas")
local zona12 = zonas and zonas:FindFirstChild("Zona-12")
local partCorona = nil
local treadmillPart = nil

if zona12 then
    partCorona = zona12:FindFirstChild("Part")
    if not partCorona then
        for _, child in ipairs(zona12:GetChildren()) do
            if child:IsA("BasePart") then
                partCorona = child
                break
            end
        end
    end
    if not partCorona then
        local parts = zona12:FindFirstChild("Parts")
        if parts then
            for _, child in ipairs(parts:GetChildren()) do
                if child:IsA("BasePart") then
                    partCorona = child
                    break
                end
            end
        end
    end
    
    for _, child in ipairs(zona12:GetDescendants()) do
        if child:IsA("BasePart") then
            local name = child.Name:lower()
            if name:find("tread") or name:find("cinta") or name:find("runner") or name:find("speed") or name:find("camin") then
                treadmillPart = child
                break
            end
        end
    end
end

-- ============================================================
-- REFERENCIAS DEL JUGADOR
-- ============================================================
local leaderstats = LocalPlayer:WaitForChild("leaderstats")
local coronas = leaderstats:WaitForChild("Coronas")
local progresoSpeed = LocalPlayer:FindFirstChild("ProgresoSpeed")
local metaSpeed = LocalPlayer:FindFirstChild("MetaSpeed")

-- ============================================================
-- VARIABLES DE ESTADO
-- ============================================================
local state = {
    teleport = false,
    invisible = false,
    treadmill = false,
    clon = false,
    antiAFK = false
}

local connections = {}
local savedProps = {}
local clones = {}

-- ============================================================
-- FUNCIONES PRINCIPALES
-- ============================================================

local function teleportToZona12()
    if not partCorona then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    root.CFrame = CFrame.new(partCorona.Position + Vector3.new(0, 3, 0))
    return true
end

local function teleportToTreadmill()
    if treadmillPart then
        local char = LocalPlayer.Character
        if not char then return false end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return false end
        root.CFrame = CFrame.new(treadmillPart.Position + Vector3.new(0, 2, 0))
        return true
    end
    return teleportToZona12()
end

-- TOGGLES
local function toggleTeleport()
    state.teleport = not state.teleport
    if state.teleport then
        teleportToZona12()
        local conn = RunService.Heartbeat:Connect(function()
            if state.teleport then teleportToZona12() end
        end)
        table.insert(connections, conn)
        print("✅ Teleport activado")
    else
        for i, conn in ipairs(connections) do
            if conn then conn:Disconnect() end
        end
        connections = {}
        print("❌ Teleport desactivado")
    end
end

local function toggleInvisible()
    local char = LocalPlayer.Character
    if not char then return end
    
    state.invisible = not state.invisible
    
    if state.invisible then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                savedProps[part] = {
                    Transparency = part.Transparency,
                    CanCollide = part.CanCollide,
                    CanTouch = part.CanTouch,
                    CanQuery = part.CanQuery
                }
                part.Transparency = 1
                part.CanCollide = false
                part.CanTouch = false
                part.CanQuery = false
            end
        end
        
        for _, acc in ipairs(char:GetChildren()) do
            if acc:IsA("Accessory") or acc:IsA("Hat") or acc:IsA("Clothing") then
                savedProps[acc] = acc.Enabled
                acc.Enabled = false
            end
        end
        
        local nameDisplay = char:FindFirstChild("NameDisplay")
        if nameDisplay then
            savedProps[nameDisplay] = nameDisplay.Visible
            nameDisplay.Visible = false
        end
        
        local conn = char.ChildAdded:Connect(function(child)
            task.wait(0.1)
            if child:IsA("BasePart") then
                savedProps[child] = {
                    Transparency = child.Transparency,
                    CanCollide = child.CanCollide,
                    CanTouch = child.CanTouch,
                    CanQuery = child.CanQuery
                }
                child.Transparency = 1
                child.CanCollide = false
                child.CanTouch = false
                child.CanQuery = false
            end
        end)
        table.insert(connections, conn)
        print("✅ Invisibilidad TOTAL activada")
    else
        for obj, props in pairs(savedProps) do
            if obj and obj.Parent then
                if typeof(props) == "table" then
                    for prop, val in pairs(props) do
                        obj[prop] = val
                    end
                else
                    obj.Transparency = props
                end
            end
        end
        savedProps = {}
        
        for _, acc in ipairs(char:GetChildren()) do
            if acc:IsA("Accessory") or acc:IsA("Hat") or acc:IsA("Clothing") then
                acc.Enabled = true
            end
        end
        
        local nameDisplay = char:FindFirstChild("NameDisplay")
        if nameDisplay then
            nameDisplay.Visible = true
        end
        
        print("❌ Invisibilidad desactivada")
    end
end

local function toggleTreadmill()
    state.treadmill = not state.treadmill
    
    if state.treadmill then
        teleportToTreadmill()
        local conn = RunService.Heartbeat:Connect(function()
            if not state.treadmill then return end
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            local humanoid = char:FindFirstChild("Humanoid")
            if not root or not humanoid then return end
            
            if treadmillPart then
                local pos = treadmillPart.Position
                root.CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))
                root.Velocity = Vector3.new(math.sin(tick() * 8) * 0.5, 0, 8)
                humanoid.WalkSpeed = 16
                humanoid:MoveTo(root.Position + Vector3.new(0, 0, 10))
            else
                local cam = Workspace.CurrentCamera
                if cam then
                    local dir = cam.CFrame.LookVector * Vector3.new(1, 0, 1)
                    root.Velocity = Vector3.new(dir.X * 16, root.Velocity.Y, dir.Z * 16)
                end
            end
        end)
        table.insert(connections, conn)
        print("✅ Auto-Treadmill activado")
    else
        print("❌ Auto-Treadmill desactivado")
    end
end

local function toggleAntiAFK()
    state.antiAFK = not state.antiAFK
    
    if state.antiAFK then
        local conn = RunService.Heartbeat:Connect(function()
            if not state.antiAFK then return end
            local char = LocalPlayer.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    root.Velocity = Vector3.new(math.random(-1,1)*0.01, 0, math.random(-1,1)*0.01)
                end
            end
        end)
        table.insert(connections, conn)
        print("✅ Anti-AFK activado")
    else
        print("❌ Anti-AFK desactivado")
    end
end

-- ============================================================
-- CLON FARM
-- ============================================================

local function giveCoronas(cantidad)
    pcall(function()
        coronas.Value = coronas.Value + cantidad
    end)
end

local function createClon()
    if not partCorona then
        print("❌ Zona-12 no encontrada")
        return nil
    end
    
    local char = LocalPlayer.Character
    if not char then
        print("❌ No hay personaje")
        return nil
    end
    
    local clon = char:Clone()
    clon.Name = "ClonFarm"
    clon.Parent = Workspace
    
    for _, part in ipairs(clon:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
            part.CanCollide = true
            part.CanTouch = true
            part.Material = Enum.Material.SmoothPlastic
        end
        if part:IsA("Decal") or part:IsA("Texture") or part:IsA("Sound") then
            part:Destroy()
        end
    end
    
    local clonHumanoid = clon:FindFirstChild("Humanoid")
    if clonHumanoid then
        clonHumanoid.WalkSpeed = 0
        clonHumanoid.JumpPower = 0
        clonHumanoid.PlatformStand = true
        for _, anim in ipairs(clonHumanoid:GetChildren()) do
            if anim:IsA("Animator") then
                anim:Destroy()
            end
        end
    end
    
    local clonRoot = clon:FindFirstChild("HumanoidRootPart")
    if clonRoot then
        clonRoot.CFrame = CFrame.new(partCorona.Position + Vector3.new(0, 2.5, 0))
    end
    
    local touchPart = Instance.new("Part")
    touchPart.Name = "TouchPart"
    touchPart.Size = Vector3.new(2, 2, 2)
    touchPart.Transparency = 1
    touchPart.CanCollide = true
    touchPart.CanTouch = true
    touchPart.Anchored = true
    touchPart.Position = partCorona.Position + Vector3.new(0, 2.5, 0)
    touchPart.Parent = clon
    
    local clickDetector = Instance.new("ClickDetector")
    clickDetector.Parent = touchPart
    
    clickDetector.MouseClick:Connect(function(player)
        if player == LocalPlayer then
            giveCoronas(1)
        end
    end)
    
    local stayConn = RunService.Heartbeat:Connect(function()
        if not clon.Parent then return end
        if clonRoot and partCorona then
            clonRoot.CFrame = CFrame.new(partCorona.Position + Vector3.new(0, 2.5, 0))
            clonRoot.Velocity = Vector3.new(0, 0, 0)
        end
        if touchPart and partCorona then
            touchPart.Position = partCorona.Position + Vector3.new(0, 2.5, 0)
        end
    end)
    
    local touchConn = RunService.Heartbeat:Connect(function()
        if not clon.Parent then return end
        if partCorona then
            pcall(function()
                clickDetector:FireServer()
            end)
            giveCoronas(1)
        end
    end)
    
    local clonData = {
        clon = clon,
        root = clonRoot,
        touchPart = touchPart,
        clickDetector = clickDetector,
        connections = {stayConn, touchConn}
    }
    
    table.insert(clones, clonData)
    print("✅ Clon creado")
    return clonData
end

local function destroyAllClones()
    for _, clonData in ipairs(clones) do
        if clonData.clon and clonData.clon.Parent then
            clonData.clon:Destroy()
        end
        for _, conn in ipairs(clonData.connections or {}) do
            if conn then conn:Disconnect() end
        end
    end
    clones = {}
    print("❌ Clones eliminados")
end

local function toggleClon()
    state.clon = not state.clon
    
    if state.clon then
        createClon()
        task.wait(0.2)
        createClon()
        print("✅ 2 Clones activos farmeando coronas")
    else
        destroyAllClones()
    end
end

-- ============================================================
-- CREAR GUI COMPLETA PARA MÓVIL
-- ============================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltimateFarm"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- FRAME PRINCIPAL
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.5, -160, 0.1, 0)
mainFrame.Size = UDim2.new(0, 320, 0, 480)
mainFrame.ClipsDescendants = true

-- BORDE DORADO
local border = Instance.new("Frame")
border.Parent = mainFrame
border.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
border.BackgroundTransparency = 0.9
border.BorderSizePixel = 0
border.Size = UDim2.new(1, 0, 0, 2)

-- TÍTULO
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
title.BorderSizePixel = 0
title.Size = UDim2.new(1, 0, 0, 45)
title.Font = Enum.Font.GothamBold
title.Text = "👑 ULTIMATE FARM v5.1"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextSize = 18

-- SUBTÍTULO
local subtitle = Instance.new("TextLabel")
subtitle.Parent = mainFrame
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 0, 0, 40)
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "🔥 Toca los botones para activar"
subtitle.TextColor3 = Color3.fromRGB(150, 150, 200)
subtitle.TextSize = 12
subtitle.TextScaled = true

-- INFO PANEL
local infoFrame = Instance.new("Frame")
infoFrame.Parent = mainFrame
infoFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
infoFrame.BackgroundTransparency = 0.5
infoFrame.BorderSizePixel = 0
infoFrame.Position = UDim2.new(0, 10, 0, 60)
infoFrame.Size = UDim2.new(1, -20, 0, 85)

-- CORONAS
local coronaLabel = Instance.new("TextLabel")
coronaLabel.Parent = infoFrame
coronaLabel.BackgroundTransparency = 1
coronaLabel.Position = UDim2.new(0, 10, 0, 5)
coronaLabel.Size = UDim2.new(1, -20, 0, 25)
coronaLabel.Font = Enum.Font.GothamBold
coronaLabel.Text = "👑 " .. tostring(coronas.Value)
coronaLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
coronaLabel.TextSize = 18
coronaLabel.TextXAlignment = Enum.TextXAlignment.Left

coronas.Changed:Connect(function()
    coronaLabel.Text = "👑 " .. tostring(coronas.Value)
end)

-- SPEED
local speedLabel = Instance.new("TextLabel")
speedLabel.Parent = infoFrame
speedLabel.BackgroundTransparency = 1
speedLabel.Position = UDim2.new(0, 10, 0, 32)
speedLabel.Size = UDim2.new(1, -20, 0, 20)
speedLabel.Font = Enum.Font.Gotham
speedLabel.Text = progresoSpeed and ("⚡ " .. tostring(progresoSpeed.Value) .. "/" .. tostring(metaSpeed.Value)) or "⚡ N/A"
speedLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
speedLabel.TextSize = 14
speedLabel.TextXAlignment = Enum.TextXAlignment.Left

if progresoSpeed then
    progresoSpeed.Changed:Connect(function()
        speedLabel.Text = "⚡ " .. tostring(progresoSpeed.Value) .. "/" .. tostring(metaSpeed.Value)
    end)
    metaSpeed.Changed:Connect(function()
        speedLabel.Text = "⚡ " .. tostring(progresoSpeed.Value) .. "/" .. tostring(metaSpeed.Value)
    end)
end

-- ZONA ESTADO
local statusLabel = Instance.new("TextLabel")
statusLabel.Parent = infoFrame
statusLabel.BackgroundTransparency = 1
statusLabel.Position = UDim2.new(0, 10, 0, 54)
statusLabel.Size = UDim2.new(1, -20, 0, 18)
statusLabel.Font = Enum.Font.Gotham
statusLabel.Text = partCorona and "✅ Zona-12: OK" or "❌ Zona-12: NO"
statusLabel.TextColor3 = partCorona and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
statusLabel.TextSize = 12
statusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- CLONES
local clonesLabel = Instance.new("TextLabel")
clonesLabel.Parent = infoFrame
clonesLabel.BackgroundTransparency = 1
clonesLabel.Position = UDim2.new(0, 10, 0, 72)
clonesLabel.Size = UDim2.new(1, -20, 0, 18)
clonesLabel.Font = Enum.Font.Gotham
clonesLabel.Text = "👥 Clones: 0"
clonesLabel.TextColor3 = Color3.fromRGB(100, 255, 200)
clonesLabel.TextSize = 12
clonesLabel.TextXAlignment = Enum.TextXAlignment.Left

local function updateClonesLabel()
    clonesLabel.Text = "👥 Clones: " .. tostring(#clones)
end

-- BOTONES
local buttons = {
    {text = "📡 TELEPORT", toggle = "teleport", color = Color3.fromRGB(0, 150, 255)},
    {text = "👻 INVISIBLE", toggle = "invisible", color = Color3.fromRGB(180, 50, 220)},
    {text = "🏃 TREADMILL", toggle = "treadmill", color = Color3.fromRGB(0, 200, 150)},
    {text = "👥 CLON FARM", toggle = "clon", color = Color3.fromRGB(0, 200, 100)},
    {text = "🛡️ ANTI-AFK", toggle = "antiAFK", color = Color3.fromRGB(100, 100, 200)}
}

local btnObjects = {}

for i, btnData in ipairs(buttons) do
    local btn = Instance.new("TextButton")
    btn.Parent = mainFrame
    btn.BackgroundColor3 = btnData.color
    btn.BackgroundTransparency = 0.85
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(0, 10, 0, 155 + (i-1) * 42)
    btn.Size = UDim2.new(1, -20, 0, 36)
    btn.Font = Enum.Font.GothamBold
    btn.Text = btnData.text .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btnObjects[btnData.toggle] = btn
    
    btn.MouseButton1Click:Connect(function()
        local funcs = {
            teleport = toggleTeleport,
            invisible = toggleInvisible,
            treadmill = toggleTreadmill,
            clon = toggleClon,
            antiAFK = toggleAntiAFK
        }
        funcs[btnData.toggle]()
        
        local st = state[btnData.toggle]
        btn.Text = btnData.text .. (st and " [ON]" or " [OFF]")
        btn.BackgroundColor3 = st and Color3.fromRGB(200, 50, 50) or btnData.color
        btn.BackgroundTransparency = 0.85
        
        updateClonesLabel()
    end)
end

-- BOTÓN CERRAR
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = mainFrame
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
closeBtn.BackgroundTransparency = 0.8
closeBtn.BorderSizePixel = 0
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 16

closeBtn.MouseButton1Click:Connect(function()
    for toggle, btn in pairs(btnObjects) do
        if state[toggle] then
            btn.MouseButton1Click:Fire()
        end
    end
    destroyAllClones()
    screenGui:Destroy()
end)

-- ============================================================
-- ACTUALIZAR AL RESPAWN
-- ============================================================
LocalPlayer.CharacterAdded:Connect(function()
    if state.invisible then
        task.wait(0.5)
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    savedProps[part] = {
                        Transparency = part.Transparency,
                        CanCollide = part.CanCollide,
                        CanTouch = part.CanTouch,
                        CanQuery = part.CanQuery
                    }
                    part.Transparency = 1
                    part.CanCollide = false
                    part.CanTouch = false
                    part.CanQuery = false
                end
            end
        end
    end
end)

-- ============================================================
-- INICIALIZACIÓN
-- ============================================================
print("╔════════════════════════════════════════════════════╗")
print("║     👑 ULTIMATE FARM v5.1 - MÓVIL CARGADO 👑      ║")
print("╠════════════════════════════════════════════════════╣")
print("║  📌 Toca los botones en pantalla                  ║")
print("║  📡 TELEPORT  |  👻 INVISIBLE                    ║")
print("║  🏃 TREADMILL |  👥 CLON FARM                   ║")
print("║  🛡️ ANTI-AFK                                    ║")
print("║                                                 ║")
print("║  👑 Coronas: " .. tostring(coronas.Value))
if progresoSpeed then
    print("║  ⚡ Speed: " .. tostring(progresoSpeed.Value) .. "/" .. tostring(metaSpeed.Value))
end
print("║  📍 Zona-12: " .. (partCorona and "✅ OK" or "❌ NO"))
print("╚════════════════════════════════════════════════════╝")
