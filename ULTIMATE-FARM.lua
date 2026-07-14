-- Script: ULTIMATE FARM v8.0
-- Creador: Rivalsteam73
-- Juego: Speed for Crowns

-- ============================================================
-- CONFIGURACIÓN INICIAL
-- ============================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- CONFIGURACIÓN DEL SCRIPT
-- ============================================================
local scriptConfig = {
    version = "v8.0",
    versionDate = "14/07/2026",
    changelogs = {
        {version = "v8.0", date = "14/07/2026", changes = {
            "🎨 GUI COMPLETAMENTE REDISEÑADA",
            "✨ EFECTOS DE BRILLO Y SOMBRA",
            "🌈 COLORES GRADIENTE EN BOTONES",
            "📱 OPTIMIZADO PARA MÓVIL",
            "⚡ ANIMACIONES SUAVES",
            "🎯 BOTONES CON EFECTO HOVER Y CLICK"
        }}
    }
}

local isOwner = (LocalPlayer.Name == "Rivalsteam73")

-- ============================================================
-- REFERENCIAS DEL JUGADOR
-- ============================================================
local leaderstats = LocalPlayer:WaitForChild("leaderstats")
local coronas = leaderstats:WaitForChild("Coronas")
local wins = leaderstats:FindFirstChild("Wins") or leaderstats:GetChildren()[1]
local progresoSpeed = LocalPlayer:FindFirstChild("ProgresoSpeed")
local metaSpeed = LocalPlayer:FindFirstChild("MetaSpeed")
local levelValue = LocalPlayer:FindFirstChild("LevelValue")
local rebirths = LocalPlayer:FindFirstChild("Rebirths")
local level = leaderstats:FindFirstChild("Level")

-- ============================================================
-- VARIABLES DE ESTADO
-- ============================================================
local state = {
    teleport = false,
    invisible = false,
    treadmill = false,
    clon = false,
    antiAFK = false,
    autoSpeed = false,
    autoCrowns = false,
    auraActive = false,
    farmAll = false,
    autoRebirth = false,
    autoWalk = false
}

local connections = {}
local savedProps = {}
local clones = {}
local auraParts = {}
local elements = {}
local autoRebirthActive = false
local autoRebirthConn = nil

-- ============================================================
-- BUSCAR ELEMENTOS
-- ============================================================
local function findElements()
    elements = {winPads = {}, treadmills = {}, stages = {}, partCorona = nil, treadmillPart = nil}
    
    local zonas = Workspace:FindFirstChild("Zonas")
    local zona12 = zonas and zonas:FindFirstChild("Zona-12")
    
    if zona12 then
        elements.partCorona = zona12:FindFirstChild("Part") or zona12:FindFirstChildWhichIsA("BasePart")
        for _, child in ipairs(zona12:GetDescendants()) do
            if child:IsA("BasePart") and child.Name:lower():find("tread") then
                elements.treadmillPart = child
                break
            end
        end
    end
    
    local winPadsFolder = Workspace:FindFirstChild("WinPads") or Workspace:FindFirstChild("Worlds")
    if winPadsFolder then
        for _, child in ipairs(winPadsFolder:GetDescendants()) do
            if child:IsA("Model") and child.Name:match("Stage%d+WinPad") then
                table.insert(elements.winPads, child)
            end
        end
    end
    
    local treadmillsFolder = Workspace:FindFirstChild("Treadmills") or Workspace:FindFirstChild("Worlds")
    if treadmillsFolder then
        for _, child in ipairs(treadmillsFolder:GetDescendants()) do
            if child:IsA("Model") and child.Name:match("Treadmill") then
                table.insert(elements.treadmills, child)
            end
        end
    end
end

findElements()

-- ============================================================
-- FUNCIONES PRINCIPALES
-- ============================================================

local function toggleState(name, onFunc, offFunc)
    state[name] = not state[name]
    if state[name] then onFunc() else offFunc() end
    return state[name]
end

-- TELEPORT
local function teleportToZona12()
    if not elements.partCorona then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    root.CFrame = CFrame.new(elements.partCorona.Position + Vector3.new(0, 3, 0))
    return true
end

local function toggleTeleport()
    toggleState("teleport",
        function()
            teleportToZona12()
            local conn = RunService.Heartbeat:Connect(function()
                if state.teleport then teleportToZona12() end
            end)
            table.insert(connections, conn)
            print("Teleport activado")
        end,
        function()
            for i, conn in ipairs(connections) do
                conn:Disconnect()
            end
            connections = {}
            print("Teleport desactivado")
        end
    )
end

-- INVISIBLE
local function toggleInvisible()
    local char = LocalPlayer.Character
    if not char then return end
    
    toggleState("invisible",
        function()
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    savedProps[part] = {
                        Transparency = part.Transparency,
                        CanCollide = part.CanCollide,
                        CanTouch = part.CanTouch,
                        CanQuery = part.CanQuery
                    }
                    part.Transparency = 1
                    part.CanTouch = true
                    part.CanQuery = true
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
                    child.CanTouch = true
                    child.CanQuery = true
                end
            end)
            table.insert(connections, conn)
            print("Invisibilidad activada")
        end,
        function()
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
                    pcall(function()
                        acc.Enabled = true
                    end)
                end
            end
            local nameDisplay = char:FindFirstChild("NameDisplay")
            if nameDisplay then
                nameDisplay.Visible = true
            end
            print("Invisibilidad desactivada")
        end
    )
end

-- TREADMILL
local function teleportToTreadmill()
    if elements.treadmillPart then
        local char = LocalPlayer.Character
        if not char then return false end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return false end
        root.CFrame = CFrame.new(elements.treadmillPart.Position + Vector3.new(0, 2, 0))
        return true
    end
    return teleportToZona12()
end

local function toggleTreadmill()
    toggleState("treadmill",
        function()
            teleportToTreadmill()
            local conn = RunService.Heartbeat:Connect(function()
                if not state.treadmill then return end
                local char = LocalPlayer.Character
                if not char then return end
                local root = char:FindFirstChild("HumanoidRootPart")
                local humanoid = char:FindFirstChild("Humanoid")
                if not root or not humanoid then return end
                local pos = elements.treadmillPart and elements.treadmillPart.Position or root.Position
                root.CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))
                root.Velocity = Vector3.new(math.sin(tick() * 8) * 0.5, 0, 8)
                humanoid.WalkSpeed = 16
                humanoid:MoveTo(root.Position + Vector3.new(0, 0, 10))
            end)
            table.insert(connections, conn)
            print("Treadmill activado")
        end,
        function()
            print("Treadmill desactivado")
        end
    )
end

-- CLON FARM
local function toggleClon()
    toggleState("clon",
        function()
            if not elements.partCorona then
                print("Zona-12 no encontrada")
                state.clon = false
                return
            end
            local char = LocalPlayer.Character
            if not char then
                print("No hay personaje")
                state.clon = false
                return
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
            end
            local clonRoot = clon:FindFirstChild("HumanoidRootPart")
            if clonRoot then
                clonRoot.CFrame = CFrame.new(elements.partCorona.Position + Vector3.new(0, 2.5, 0))
            end
            
            local touchPart = Instance.new("Part")
            touchPart.Name = "TouchPart"
            touchPart.Size = Vector3.new(2, 2, 2)
            touchPart.Transparency = 1
            touchPart.CanCollide = true
            touchPart.CanTouch = true
            touchPart.Anchored = true
            touchPart.Position = elements.partCorona.Position + Vector3.new(0, 2.5, 0)
            touchPart.Parent = clon
            
            local clickDetector = Instance.new("ClickDetector")
            clickDetector.Parent = touchPart
            clickDetector.MouseClick:Connect(function(player)
                if player == LocalPlayer then
                    pcall(function()
                        coronas.Value = coronas.Value + 1
                    end)
                end
            end)
            
            local stayConn = RunService.Heartbeat:Connect(function()
                if not clon.Parent then return end
                if clonRoot and elements.partCorona then
                    clonRoot.CFrame = CFrame.new(elements.partCorona.Position + Vector3.new(0, 2.5, 0))
                    clonRoot.Velocity = Vector3.new(0, 0, 0)
                end
                if touchPart and elements.partCorona then
                    touchPart.Position = elements.partCorona.Position + Vector3.new(0, 2.5, 0)
                end
            end)
            
            local touchConn = RunService.Heartbeat:Connect(function()
                if not clon.Parent then return end
                if elements.partCorona then
                    pcall(function()
                        clickDetector:FireServer()
                    end)
                    pcall(function()
                        coronas.Value = coronas.Value + 1
                    end)
                end
            end)
            
            clones = {
                clon = clon,
                root = clonRoot,
                touchPart = touchPart,
                clickDetector = clickDetector,
                connections = {stayConn, touchConn}
            }
            print("Clones activos farmeando coronas")
        end,
        function()
            for _, clonData in ipairs(clones) do
                if clonData.clon and clonData.clon.Parent then
                    clonData.clon:Destroy()
                end
                for _, conn in ipairs(clonData.connections or {}) do
                    if conn then
                        conn:Disconnect()
                    end
                end
            end
            clones = {}
            print("Clones eliminados")
        end
    )
end

-- ANTI-AFK
local function toggleAntiAFK()
    toggleState("antiAFK",
        function()
            local conn = RunService.Heartbeat:Connect(function()
                if not state.antiAFK then return end
                local char = LocalPlayer.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        root.Velocity = Vector3.new(math.random(-1, 1) * 0.01, 0, math.random(-1, 1) * 0.01)
                    end
                end
            end)
            table.insert(connections, conn)
            print("Anti-AFK activado")
        end,
        function()
            print("Anti-AFK desactivado")
        end
    )
end

-- AUTO-SPEED
local function toggleAutoSpeed()
    toggleState("autoSpeed",
        function()
            local conn = RunService.Heartbeat:Connect(function()
                if not state.autoSpeed then return end
                if progresoSpeed and metaSpeed then
                    progresoSpeed.Value = progresoSpeed.Value + 1000
                    if progresoSpeed.Value > metaSpeed.Value then
                        metaSpeed.Value = progresoSpeed.Value + 10000
                    end
                end
            end)
            table.insert(connections, conn)
            print("Auto-Speed activado")
        end,
        function()
            print("Auto-Speed desactivado")
        end
    )
end

-- AUTO-CROWNS
local function toggleAutoCrowns()
    toggleState("autoCrowns",
        function()
            local conn = RunService.Heartbeat:Connect(function()
                if not state.autoCrowns then return end
                pcall(function()
                    coronas.Value = coronas.Value + 100
                end)
            end)
            table.insert(connections, conn)
            print("Auto-Crowns activado")
        end,
        function()
            print("Auto-Crowns desactivado")
        end
    )
end

-- AURA
local function toggleAura()
    if state.auraActive then
        for _, part in ipairs(auraParts) do
            if part then
                if type(part) == "RBXScriptConnection" then
                    pcall(function()
                        part:Disconnect()
                    end)
                elseif part:IsA("BasePart") or part:IsA("SelectionBox") then
                    pcall(function()
                        part:Destroy()
                    end)
                end
            end
        end
        auraParts = {}
        state.auraActive = false
        print("Aura desactivada")
        return
    end
    
    local char = LocalPlayer.Character
    if not char then
        print("No hay personaje")
        return
    end
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        print("No hay HumanoidRootPart")
        return
    end
    
    state.auraActive = true
    
    local aura = Instance.new("Part")
    aura.Name = "AuraProximidad"
    aura.Size = Vector3.new(100, 100, 100)
    aura.Transparency = 0.95
    aura.CanCollide = false
    aura.CanTouch = true
    aura.Anchored = false
    aura.Material = Enum.Material.SmoothPlastic
    aura.Color = Color3.fromRGB(255, 215, 0)
    aura.Parent = rootPart
    
    local auraEffect = Instance.new("SelectionBox")
    auraEffect.Parent = aura
    auraEffect.Color3 = Color3.fromRGB(255, 215, 0)
    auraEffect.Transparency = 0.9
    auraEffect.LineThickness = 0.1
    
    local touchConn = aura.Touched:Connect(function(hit)
        if not state.auraActive then return end
        for _, pad in ipairs(elements.winPads) do
            if hit == pad or hit.Parent == pad then
                pcall(function()
                    local click = pad:FindFirstChildOfClass("ClickDetector")
                    if click then
                        click:FireServer()
                    end
                    local touchPart = pad:FindFirstChild("Touch")
                    if touchPart then
                        touchPart.Touched:Fire(hit)
                    end
                end)
            end
        end
        for _, tm in ipairs(elements.treadmills) do
            if hit == tm or hit.Parent == tm then
                pcall(function()
                    local click = tm:FindFirstChildOfClass("ClickDetector")
                    if click then
                        click:FireServer()
                    end
                end)
            end
        end
    end)
    
    local stayConn = RunService.Heartbeat:Connect(function()
        if not state.auraActive then return end
        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        if aura and aura.Parent then
            aura.CFrame = root.CFrame
        end
    end)
    
    auraParts = {aura, auraEffect, touchConn, stayConn}
    print("Aura activada")
end

-- AUTO-WALK
local function toggleAutoWalk()
    toggleState("autoWalk",
        function()
            local conn = RunService.Heartbeat:Connect(function()
                if not state.autoWalk then return end
                local char = LocalPlayer.Character
                if not char then return end
                local root = char:FindFirstChild("HumanoidRootPart")
                local humanoid = char:FindFirstChild("Humanoid")
                if not root or not humanoid then return end
                local cam = Workspace.CurrentCamera
                if cam then
                    local forward = cam.CFrame.LookVector * Vector3.new(1, 0, 1)
                    if forward.Magnitude < 0.1 then
                        forward = Vector3.new(0, 0, -1)
                    end
                    forward = forward.Unit
                    root.Velocity = Vector3.new(forward.X * 16, root.Velocity.Y, forward.Z * 16)
                    humanoid.WalkSpeed = 16
                    humanoid:MoveTo(root.Position + forward * 10)
                end
            end)
            table.insert(connections, conn)
            print("Auto-Walk activado")
        end,
        function()
            print("Auto-Walk desactivado")
        end
    )
end

-- AUTO-REBIRTH
local rebirthEvent = ReplicatedStorage:FindFirstChild("RebirthEvent")
local rebirthRequirements = {
    [0] = {Nivel = 30, Coronas = 20000},
    [1] = {Nivel = 40, Coronas = 50000},
    [2] = {Nivel = 100, Coronas = 1000000},
    [3] = {Nivel = 200, Coronas = 20000000}
}

local function canRebirth()
    if not levelValue or not rebirths or not coronas then return false end
    local req = rebirthRequirements[rebirths.Value]
    return req and levelValue.Value >= req.Nivel and coronas.Value >= req.Coronas
end

local function doRebirth()
    if rebirthEvent and canRebirth() then
        pcall(function()
            rebirthEvent:FireServer()
            print("Rebirth ejecutado!")
        end)
    end
end

local function toggleAutoRebirth()
    autoRebirthActive = not autoRebirthActive
    if autoRebirthActive then
        doRebirth()
        autoRebirthConn = RunService.Heartbeat:Connect(function()
            if autoRebirthActive and canRebirth() then
                doRebirth()
            end
        end)
        print("Auto-Rebirth activado")
    else
        if autoRebirthConn then
            autoRebirthConn:Disconnect()
            autoRebirthConn = nil
        end
        print("Auto-Rebirth desactivado")
    end
    state.autoRebirth = autoRebirthActive
end

-- FARM ALL
local function toggleFarmAll()
    state.farmAll = not state.farmAll
    
    if state.farmAll then
        local allFunctions = {
            {name = "teleport", func = toggleTeleport, active = state.teleport},
            {name = "treadmill", func = toggleTreadmill, active = state.treadmill},
            {name = "clon", func = toggleClon, active = state.clon},
            {name = "antiAFK", func = toggleAntiAFK, active = state.antiAFK},
            {name = "autoSpeed", func = toggleAutoSpeed, active = state.autoSpeed},
            {name = "autoCrowns", func = toggleAutoCrowns, active = state.autoCrowns},
            {name = "auraActive", func = toggleAura, active = state.auraActive},
            {name = "autoRebirth", func = toggleAutoRebirth, active = state.autoRebirth},
            {name = "autoWalk", func = toggleAutoWalk, active = state.autoWalk}
        }
        for _, f in ipairs(allFunctions) do
            if not f.active then
                f.func()
                task.wait(0.1)
            end
        end
        print("Farm All activado")
    else
        local allFunctions = {
            {name = "teleport", func = toggleTeleport, active = state.teleport},
            {name = "treadmill", func = toggleTreadmill, active = state.treadmill},
            {name = "clon", func = toggleClon, active = state.clon},
            {name = "antiAFK", func = toggleAntiAFK, active = state.antiAFK},
            {name = "autoSpeed", func = toggleAutoSpeed, active = state.autoSpeed},
            {name = "autoCrowns", func = toggleAutoCrowns, active = state.autoCrowns},
            {name = "auraActive", func = toggleAura, active = state.auraActive},
            {name = "autoRebirth", func = toggleAutoRebirth, active = state.autoRebirth},
            {name = "autoWalk", func = toggleAutoWalk, active = state.autoWalk}
        }
        for _, f in ipairs(allFunctions) do
            if f.active then
                f.func()
                task.wait(0.1)
            end
        end
        print("Farm All desactivado")
    end
end

-- ============================================================
-- FUNCIONES DE GUI MEJORADAS
-- ============================================================

-- Función para crear botones con efectos visuales
local function createStyledButton(parent, text, color, callback, position, size)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.85
    btn.BorderSizePixel = 0
    btn.Position = position
    btn.Size = size
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.AutoButtonColor = false
    
    -- Efecto de brillo
    local glow = Instance.new("Frame")
    glow.Parent = btn
    glow.BackgroundColor3 = color
    glow.BackgroundTransparency = 0.7
    glow.BorderSizePixel = 0
    glow.Size = UDim2.new(1, 0, 1, 0)
    glow.ZIndex = 0
    
    local glowCorner = Instance.new("UICorner")
    glowCorner.Parent = glow
    glowCorner.CornerRadius = UDim.new(0, 6)
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = btn
    btnCorner.CornerRadius = UDim.new(0, 6)
    
    -- Hover effect
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.5
        }):Play()
        TweenService:Create(glow, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.4
        }):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.85
        }):Play()
        TweenService:Create(glow, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.7
        }):Play()
    end)
    
    btn.MouseButton1Click:Connect(function()
        callback()
        -- Efecto click
        TweenService:Create(btn, TweenInfo.new(0.1), {
            BackgroundTransparency = 0.3
        }):Play()
        task.wait(0.1)
        TweenService:Create(btn, TweenInfo.new(0.1), {
            BackgroundTransparency = 0.85
        }):Play()
    end)
    
    return btn
end

-- ============================================================
-- CREAR GUI REDISEÑADA
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltimateFarm"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Frame principal con efecto glass
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.Position = UDim2.new(0.5, -320, 0.05, 0)
mainFrame.Size = UDim2.new(0, 640, 0, 520)
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.Parent = mainFrame
mainCorner.CornerRadius = UDim.new(0, 16)

-- Sombra mejorada
local shadow = Instance.new("Frame")
shadow.Parent = mainFrame
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.6
shadow.BorderSizePixel = 0
shadow.Position = UDim2.new(0, 8, 0, 8)
shadow.Size = UDim2.new(1, 16, 1, 16)
shadow.ZIndex = 0

local shadowCorner = Instance.new("UICorner")
shadowCorner.Parent = shadow
shadowCorner.CornerRadius = UDim.new(0, 16)

-- Borde brillante superior
local glowBorder = Instance.new("Frame")
glowBorder.Parent = mainFrame
glowBorder.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
glowBorder.BackgroundTransparency = 0.8
glowBorder.BorderSizePixel = 0
glowBorder.Position = UDim2.new(0, 10, 0, 0)
glowBorder.Size = UDim2.new(1, -20, 0, 2)

-- ============================================================
-- BARRA SUPERIOR
-- ============================================================
local topBar = Instance.new("Frame")
topBar.Parent = mainFrame
topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
topBar.BackgroundTransparency = 0.3
topBar.BorderSizePixel = 0
topBar.Size = UDim2.new(1, 0, 0, 85)

local topCorner = Instance.new("UICorner")
topCorner.Parent = topBar
topCorner.CornerRadius = UDim.new(0, 16)

-- Título con efecto
local title = Instance.new("TextLabel")
title.Parent = topBar
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 15, 0, 5)
title.Size = UDim2.new(1, -30, 0, 28)
title.Font = Enum.Font.GothamBold
title.Text = "✨ ULTIMATE FARM v8.0"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left

-- Subtítulo
local subtitle = Instance.new("TextLabel")
subtitle.Parent = topBar
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 15, 0, 33)
subtitle.Size = UDim2.new(1, -30, 0, 16)
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "by Rivalsteam73"
subtitle.TextColor3 = Color3.fromRGB(150, 150, 200)
subtitle.TextSize = 12
subtitle.TextXAlignment = Enum.TextXAlignment.Left

-- Stats
local statsFrame = Instance.new("Frame")
statsFrame.Parent = topBar
statsFrame.BackgroundTransparency = 1
statsFrame.Position = UDim2.new(0, 15, 0, 52)
statsFrame.Size = UDim2.new(1, -30, 0, 28)

local function createStat(text, color, posX)
    local label = Instance.new("TextLabel")
    label.Parent = statsFrame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(posX, 0, 0, 0)
    label.Size = UDim2.new(0, 120, 1, 0)
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextColor3 = color
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    return label
end

local coronaStat = createStat("👑 " .. tostring(coronas.Value), Color3.fromRGB(255, 215, 0), 0)
local speedStat = createStat("⚡ " .. (progresoSpeed and tostring(progresoSpeed.Value) or "N/A"), Color3.fromRGB(100, 200, 255), 0.22)
local clonesStat = createStat("👥 " .. tostring(#clones), Color3.fromRGB(100, 255, 200), 0.44)
local statusStat = createStat(elements.partCorona and "✅" or "❌", elements.partCorona and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100), 0.66)

local function updateStats()
    coronaStat.Text = "👑 " .. tostring(coronas.Value)
    if progresoSpeed then speedStat.Text = "⚡ " .. tostring(progresoSpeed.Value) end
    clonesStat.Text = "👥 " .. tostring(#clones)
end

coronas.Changed:Connect(updateStats)
if progresoSpeed then progresoSpeed.Changed:Connect(updateStats) end

-- Botón Cerrar
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = topBar
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
closeBtn.BackgroundTransparency = 0.7
closeBtn.BorderSizePixel = 0
closeBtn.Position = UDim2.new(1, -38, 0, 6)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 16
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local closeCorner = Instance.new("UICorner")
closeCorner.Parent = closeBtn
closeCorner.CornerRadius = UDim.new(1, 0)

-- ============================================================
-- CATEGORÍA: PRINCIPAL
-- ============================================================
local mainCategory = Instance.new("Frame")
mainCategory.Parent = mainFrame
mainCategory.BackgroundTransparency = 1
mainCategory.Position = UDim2.new(0, 15, 0, 95)
mainCategory.Size = UDim2.new(1, -30, 0, 60)

local catTitle = Instance.new("TextLabel")
catTitle.Parent = mainCategory
catTitle.BackgroundTransparency = 1
catTitle.Position = UDim2.new(0, 5, 0, 0)
catTitle.Size = UDim2.new(0, 150, 0, 22)
catTitle.Font = Enum.Font.GothamBold
catTitle.Text = "⭐ PRINCIPAL"
catTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
catTitle.TextSize = 14
catTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Línea decorativa
local line = Instance.new("Frame")
line.Parent = mainCategory
line.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
line.BackgroundTransparency = 0.8
line.BorderSizePixel = 0
line.Position = UDim2.new(0, 160, 0, 10)
line.Size = UDim2.new(1, -170, 0, 1)

-- Botones principales
local btnFrame1 = Instance.new("Frame")
btnFrame1.Parent = mainCategory
btnFrame1.BackgroundTransparency = 1
btnFrame1.Position = UDim2.new(0, 0, 0, 28)
btnFrame1.Size = UDim2.new(1, 0, 0, 28)

local mainButtons1 = {
    {text = "🛸 TELEPORT", color = Color3.fromRGB(0, 150, 255), toggle = "teleport", func = toggleTeleport},
    {text = "👻 INVISIBLE", color = Color3.fromRGB(180, 50, 220), toggle = "invisible", func = toggleInvisible},
    {text = "🏃 TREADMILL", color = Color3.fromRGB(0, 200, 150), toggle = "treadmill", func = toggleTreadmill},
    {text = "🧬 CLON FARM", color = Color3.fromRGB(0, 200, 100), toggle = "clon", func = toggleClon},
    {text = "🛡️ ANTI-AFK", color = Color3.fromRGB(100, 100, 200), toggle = "antiAFK", func = toggleAntiAFK}
}

local btnObjects = {}

for i, btnData in ipairs(mainButtons1) do
    local btn = createStyledButton(
        btnFrame1,
        btnData.text .. " [OFF]",
        btnData.color,
        function()
            btnData.func()
            local st = state[btnData.toggle]
            btn.Text = btnData.text .. (st and " [ON]" or " [OFF]")
            btn.BackgroundColor3 = st and Color3.fromRGB(200, 50, 50) or btnData.color
            updateStats()
        end,
        UDim2.new((i-1) * 0.2, 2, 0, 0),
        UDim2.new(0.19, -2, 1, 0)
    )
    btnObjects[btnData.toggle] = btn
end

-- ============================================================
-- CATEGORÍA: UTILIDADES
-- ============================================================
local utilsCategory = Instance.new("Frame")
utilsCategory.Parent = mainFrame
utilsCategory.BackgroundTransparency = 1
utilsCategory.Position = UDim2.new(0, 15, 0, 165)
utilsCategory.Size = UDim2.new(1, -30, 0, 60)

local catTitle2 = Instance.new("TextLabel")
catTitle2.Parent = utilsCategory
catTitle2.BackgroundTransparency = 1
catTitle2.Position = UDim2.new(0, 5, 0, 0)
catTitle2.Size = UDim2.new(0, 150, 0, 22)
catTitle2.Font = Enum.Font.GothamBold
catTitle2.Text = "⚡ UTILIDADES"
catTitle2.TextColor3 = Color3.fromRGB(100, 200, 255)
catTitle2.TextSize = 14
catTitle2.TextXAlignment = Enum.TextXAlignment.Left

local line2 = Instance.new("Frame")
line2.Parent = utilsCategory
line2.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
line2.BackgroundTransparency = 0.8
line2.BorderSizePixel = 0
line2.Position = UDim2.new(0, 160, 0, 10)
line2.Size = UDim2.new(1, -170, 0, 1)

local btnFrame2 = Instance.new("Frame")
btnFrame2.Parent = utilsCategory
btnFrame2.BackgroundTransparency = 1
btnFrame2.Position = UDim2.new(0, 0, 0, 28)
btnFrame2.Size = UDim2.new(1, 0, 0, 28)

local utilsButtons = {
    {text = "⚡ AUTO-SPEED", color = Color3.fromRGB(255, 150, 0), toggle = "autoSpeed", func = toggleAutoSpeed},
    {text = "👑 AUTO-CROWNS", color = Color3.fromRGB(255, 215, 0), toggle = "autoCrowns", func = toggleAutoCrowns},
    {text = "🌀 AURA", color = Color3.fromRGB(200, 100, 255), toggle = "auraActive", func = toggleAura},
    {text = "🚶 AUTO-WALK", color = Color3.fromRGB(0, 255, 200), toggle = "autoWalk", func = toggleAutoWalk},
    {text = "🔄 AUTO-REBIRTH", color = Color3.fromRGB(255, 100, 200), toggle = "autoRebirth", func = toggleAutoRebirth}
}

for i, btnData in ipairs(utilsButtons) do
    local btn = createStyledButton(
        btnFrame2,
        btnData.text .. " [OFF]",
        btnData.color,
        function()
            btnData.func()
            local st = state[btnData.toggle]
            if btnData.toggle == "autoRebirth" then
                st = autoRebirthActive
            end
            btn.Text = btnData.text .. (st and " [ON]" or " [OFF]")
            btn.BackgroundColor3 = st and Color3.fromRGB(200, 50, 50) or btnData.color
            updateStats()
        end,
        UDim2.new((i-1) * 0.2, 2, 0, 0),
        UDim2.new(0.19, -2, 1, 0)
    )
    btnObjects[btnData.toggle] = btn
end

-- ============================================================
-- CATEGORÍA: EXTRAS
-- ============================================================
local extraCategory = Instance.new("Frame")
extraCategory.Parent = mainFrame
extraCategory.BackgroundTransparency = 1
extraCategory.Position = UDim2.new(0, 15, 0, 235)
extraCategory.Size = UDim2.new(1, -30, 0, 60)

local catTitle3 = Instance.new("TextLabel")
catTitle3.Parent = extraCategory
catTitle3.BackgroundTransparency = 1
catTitle3.Position = UDim2.new(0, 5, 0, 0)
catTitle3.Size = UDim2.new(0, 150, 0, 22)
catTitle3.Font = Enum.Font.GothamBold
catTitle3.Text = "🔥 EXTRAS"
catTitle3.TextColor3 = Color3.fromRGB(255, 150, 100)
catTitle3.TextSize = 14
catTitle3.TextXAlignment = Enum.TextXAlignment.Left

local line3 = Instance.new("Frame")
line3.Parent = extraCategory
line3.BackgroundColor3 = Color3.fromRGB(255, 150, 100)
line3.BackgroundTransparency = 0.8
line3.BorderSizePixel = 0
line3.Position = UDim2.new(0, 160, 0, 10)
line3.Size = UDim2.new(1, -170, 0, 1)

local btnFrame3 = Instance.new("Frame")
btnFrame3.Parent = extraCategory
btnFrame3.BackgroundTransparency = 1
btnFrame3.Position = UDim2.new(0, 0, 0, 28)
btnFrame3.Size = UDim2.new(1, 0, 0, 28)

local extraButtons = {
    {text = "🔥 FARM ALL", color = Color3.fromRGB(255, 50, 50), toggle = "farmAll", func = toggleFarmAll}
}

for i, btnData in ipairs(extraButtons) do
    local btn = createStyledButton(
        btnFrame3,
        btnData.text .. " [OFF]",
        btnData.color,
        function()
            btnData.func()
            local st = state[btnData.toggle]
            btn.Text = btnData.text .. (st and " [ON]" or " [OFF]")
            btn.BackgroundColor3 = st and Color3.fromRGB(200, 50, 50) or btnData.color
            updateStats()
        end,
        UDim2.new((i-1) * 0.2, 2, 0, 0),
        UDim2.new(0.19, -2, 1, 0)
    )
    btnObjects[btnData.toggle] = btn
end

-- ============================================================
-- CATEGORÍA: ADMIN (SOLO Rivalsteam73)
-- ============================================================
if isOwner then
    local adminCategory = Instance.new("Frame")
    adminCategory.Parent = mainFrame
    adminCategory.BackgroundTransparency = 1
    adminCategory.Position = UDim2.new(0, 15, 0, 305)
    adminCategory.Size = UDim2.new(1, -30, 0, 60)
    
    local catTitle4 = Instance.new("TextLabel")
    catTitle4.Parent = adminCategory
    catTitle4.BackgroundTransparency = 1
    catTitle4.Position = UDim2.new(0, 5, 0, 0)
    catTitle4.Size = UDim2.new(0, 200, 0, 22)
    catTitle4.Font = Enum.Font.GothamBold
    catTitle4.Text = "👑 ADMIN (Rivalsteam73)"
    catTitle4.TextColor3 = Color3.fromRGB(255, 215, 0)
    catTitle4.TextSize = 14
    catTitle4.TextXAlignment = Enum.TextXAlignment.Left
    
    local line4 = Instance.new("Frame")
    line4.Parent = adminCategory
    line4.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    line4.BackgroundTransparency = 0.8
    line4.BorderSizePixel = 0
    line4.Position = UDim2.new(0, 210, 0, 10)
    line4.Size = UDim2.new(1, -220, 0, 1)
    
    local btnFrame4 = Instance.new("Frame")
    btnFrame4.Parent = adminCategory
    btnFrame4.BackgroundTransparency = 1
    btnFrame4.Position = UDim2.new(0, 0, 0, 28)
    btnFrame4.Size = UDim2.new(1, 0, 0, 28)
    
    local adminButtons = {
        {text = "💡 SUGERENCIAS", color = Color3.fromRGB(255, 215, 0), toggle = "sugerencias", func = function() print("Sugerencias") end}
    }
    
    for i, btnData in ipairs(adminButtons) do
        local btn = createStyledButton(
            btnFrame4,
            btnData.text .. " [OFF]",
            btnData.color,
            function()
                btnData.func()
                local st = state[btnData.toggle]
                btn.Text = btnData.text .. (st and " [ON]" or " [OFF]")
                btn.BackgroundColor3 = st and Color3.fromRGB(200, 50, 50) or btnData.color
            end,
            UDim2.new((i-1) * 0.2, 2, 0, 0),
            UDim2.new(0.19, -2, 1, 0)
        )
        btnObjects[btnData.toggle] = btn
    end
end

-- ============================================================
-- BOTÓN FLOTANTE
-- ============================================================
local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = screenGui
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
toggleBtn.BackgroundTransparency = 0.1
toggleBtn.BorderSizePixel = 2
toggleBtn.BorderColor3 = Color3.fromRGB(255, 215, 0)
toggleBtn.Position = UDim2.new(0.02, 0, 0.02, 0)
toggleBtn.Size = UDim2.new(0, 55, 0, 55)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Text = "👑"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 26

local toggleCorner = Instance.new("UICorner")
toggleCorner.Parent = toggleBtn
toggleCorner.CornerRadius = UDim.new(1, 0)

-- Efecto de brillo en el botón flotante
local floatGlow = Instance.new("Frame")
floatGlow.Parent = toggleBtn
floatGlow.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
floatGlow.BackgroundTransparency = 0.5
floatGlow.BorderSizePixel = 0
floatGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
floatGlow.Position = UDim2.new(-0.1, 0, -0.1, 0)
floatGlow.ZIndex = 0

local floatGlowCorner = Instance.new("UICorner")
floatGlowCorner.Parent = floatGlow
floatGlowCorner.CornerRadius = UDim.new(1, 0)

toggleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    if mainFrame.Visible then
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {
            BackgroundTransparency = 0.1
        }):Play()
    end
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
                    part.CanTouch = true
                    part.CanQuery = true
                end
            end
        end
    end
end)

-- ============================================================
-- ATAJOS DE TECLADO (PC)
-- ============================================================
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.B then
        mainFrame.Visible = not mainFrame.Visible
    end
    
    local map = {
        [Enum.KeyCode.T] = "teleport",
        [Enum.KeyCode.I] = "invisible",
        [Enum.KeyCode.R] = "treadmill",
        [Enum.KeyCode.C] = "clon",
        [Enum.KeyCode.A] = "antiAFK",
        [Enum.KeyCode.S] = "autoSpeed",
        [Enum.KeyCode.K] = "autoCrowns",
        [Enum.KeyCode.U] = "auraActive",
        [Enum.KeyCode.V] = "autoRebirth",
        [Enum.KeyCode.W] = "autoWalk",
        [Enum.KeyCode.F] = "farmAll"
    }
    local toggle = map[input.KeyCode]
    if toggle and btnObjects[toggle] then
        btnObjects[toggle].MouseButton1Click:Fire()
    end
end)

-- ============================================================
-- INICIALIZACIÓN
-- ============================================================
print("═══════════════════════════════════════════════════════════")
print("   ✨ ULTIMATE FARM v8.0 CARGADO ✨")
print("   Creado por: Rivalsteam73")
print("═══════════════════════════════════════════════════════════")
print("")
print("  🎨 GUI COMPLETAMENTE REDISEÑADA")
print("  📱 OPTIMIZADO PARA MÓVIL Y PC")
print("  ⚡ EFECTOS VISUALES MEJORADOS")
print("")
print("  🎯 FUNCIONES DISPONIBLES:")
print("  🛸 Teleport    👻 Invisible    🏃 Treadmill")
print("  🧬 Clon Farm   🛡️ Anti-AFK    ⚡ Auto-Speed")
print("  👑 Auto-Crowns  🌀 Aura        🔄 Auto-Rebirth")
print("  🚶 Auto-Walk   🔥 Farm All")
print("")
print("  📌 Teclas PC: T I R C A S K U V W F B")
print("  📌 Móvil: Toca los botones en pantalla")
print("")
print("  👑 Coronas: " .. tostring(coronas.Value))
if progresoSpeed then
    print("  ⚡ Speed: " .. tostring(progresoSpeed.Value))
end
print("  📍 Zona-12: " .. (elements.partCorona and "✅ OK" or "❌ NO"))
print("═══════════════════════════════════════════════════════════")
