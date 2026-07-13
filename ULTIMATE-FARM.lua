--[[
  ULTIMATE FARM v5.5 - GUI HORIZONTAL PROFESIONAL
  Script completo para Speed for Crowns - Zona 12
  Diseño horizontal con stats en una línea y botones organizados
  ⚠️ Las opciones de Admin (Ver Sugerencias, Changelogs, Configuración) SOLO visibles para Rivalsteam73
--]]

-- ============================================================
-- 1. PANTALLA DE CARGA PROFESIONAL
-- ============================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Crear pantalla de carga
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "LoadingScreen"
loadingGui.ResetOnSpawn = false
loadingGui.Parent = PlayerGui
loadingGui.IgnoreGuiInset = true

-- Fondo
local background = Instance.new("Frame")
background.Parent = loadingGui
background.BackgroundColor3 = Color3.fromRGB(8, 8, 20)
background.BackgroundTransparency = 0
background.BorderSizePixel = 0
background.Size = UDim2.new(1, 0, 1, 0)

-- Logo
local logoContainer = Instance.new("Frame")
logoContainer.Parent = background
logoContainer.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
logoContainer.BackgroundTransparency = 0.9
logoContainer.BorderSizePixel = 2
logoContainer.BorderColor3 = Color3.fromRGB(255, 215, 0)
logoContainer.Position = UDim2.new(0.5, -50, 0.3, 0)
logoContainer.Size = UDim2.new(0, 100, 0, 100)
logoContainer.ClipsDescendants = true

local logoCorner = Instance.new("UICorner")
logoCorner.Parent = logoContainer
logoCorner.CornerRadius = UDim.new(1, 0)

local logoText = Instance.new("TextLabel")
logoText.Parent = logoContainer
logoText.BackgroundTransparency = 1
logoText.Position = UDim2.new(0, 0, 0.15, 0)
logoText.Size = UDim2.new(1, 0, 0.7, 0)
logoText.Font = Enum.Font.GothamBold
logoText.Text = "👑"
logoText.TextColor3 = Color3.fromRGB(255, 215, 0)
logoText.TextSize = 50
logoText.TextScaled = true

-- Título
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = background
titleLabel.BackgroundTransparency = 1
titleLabel.Position = UDim2.new(0.5, -150, 0.47, 0)
titleLabel.Size = UDim2.new(0, 300, 0, 40)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "ULTIMATE FARM"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.TextSize = 22
titleLabel.TextScaled = true

-- Versión
local versionLabel = Instance.new("TextLabel")
versionLabel.Parent = background
versionLabel.BackgroundTransparency = 1
versionLabel.Position = UDim2.new(0.5, -150, 0.52, 0)
versionLabel.Size = UDim2.new(0, 300, 0, 20)
versionLabel.Font = Enum.Font.Gotham
versionLabel.Text = "v5.5"
versionLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
versionLabel.TextSize = 14
versionLabel.TextScaled = true

-- Subtítulo
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Parent = background
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Position = UDim2.new(0.5, -150, 0.57, 0)
subtitleLabel.Size = UDim2.new(0, 300, 0, 25)
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.Text = "CARGANDO..."
subtitleLabel.TextColor3 = Color3.fromRGB(180, 180, 220)
subtitleLabel.TextSize = 14
subtitleLabel.TextScaled = true

-- Barra de progreso
local progressContainer = Instance.new("Frame")
progressContainer.Parent = background
progressContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
progressContainer.BackgroundTransparency = 0.5
progressContainer.BorderSizePixel = 1
progressContainer.BorderColor3 = Color3.fromRGB(50, 50, 100)
progressContainer.Position = UDim2.new(0.5, -150, 0.65, 0)
progressContainer.Size = UDim2.new(0, 300, 0, 8)

local progressCorner = Instance.new("UICorner")
progressCorner.Parent = progressContainer
progressCorner.CornerRadius = UDim.new(0, 4)

local progressBar = Instance.new("Frame")
progressBar.Parent = progressContainer
progressBar.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
progressBar.BorderSizePixel = 0
progressBar.Size = UDim2.new(0, 0, 1, 0)

local progressBarCorner = Instance.new("UICorner")
progressBarCorner.Parent = progressBar
progressBarCorner.CornerRadius = UDim.new(0, 4)

-- Porcentaje
local percentLabel = Instance.new("TextLabel")
percentLabel.Parent = background
percentLabel.BackgroundTransparency = 1
percentLabel.Position = UDim2.new(0.5, -150, 0.70, 0)
percentLabel.Size = UDim2.new(0, 300, 0, 20)
percentLabel.Font = Enum.Font.Gotham
percentLabel.Text = "0%"
percentLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
percentLabel.TextSize = 13

-- Animación del logo
task.spawn(function()
    while loadingGui.Parent do
        for i = 0.8, 1.2, 0.05 do
            if not loadingGui.Parent then break end
            logoContainer.Size = UDim2.new(0, 100 * i, 0, 100 * i)
            task.wait(0.03)
        end
        for i = 1.2, 0.8, -0.05 do
            if not loadingGui.Parent then break end
            logoContainer.Size = UDim2.new(0, 100 * i, 0, 100 * i)
            task.wait(0.03)
        end
    end
end)

-- ============================================================
-- 2. CONFIGURACIÓN DEL SCRIPT
-- ============================================================
local scriptConfig = {
    version = "v5.5",
    versionDate = "13/07/2026",
    changelogs = {
        {version = "v5.5", date = "13/07/2026", changes = {
            "✅ GUI rediseñada en formato horizontal",
            "✅ Stats en una sola línea",
            "✅ Botones organizados en filas",
            "✅ Menú Principal y Utilidades separados",
            "✅ Sistema de sugerencias y changelogs",
            "✅ Opciones Admin ocultas para otros usuarios"
        }},
        {version = "v5.0", date = "12/07/2026", changes = {
            "✅ Clon Farm x2 agregado",
            "✅ Anti-AFK implementado"
        }}
    }
}

-- ============================================================
-- 3. FUNCIÓN DE CARGA
-- ============================================================
local function loadMainScript()
    versionLabel.Text = scriptConfig.version

    TweenService:Create(background, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    }):Play()
    task.wait(0.5)
    loadingGui:Destroy()

    -- ============================================================
    -- 4. SCRIPT PRINCIPAL
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

    local leaderstats = LocalPlayer:WaitForChild("leaderstats")
    local coronas = leaderstats:WaitForChild("Coronas")
    local progresoSpeed = LocalPlayer:FindFirstChild("ProgresoSpeed")
    local metaSpeed = LocalPlayer:FindFirstChild("MetaSpeed")

    local state = {
        teleport = false,
        invisible = false,
        treadmill = false,
        clon = false,
        antiAFK = false,
        guiVisible = true
    }

    local connections = {}
    local savedProps = {}
    local clones = {}
    
    -- ✅ VERIFICACIÓN DE USUARIO (SOLO Rivalsteam73)
    local isOwner = (LocalPlayer.Name == "Rivalsteam73")
    
    local suggestions = {}
    local suggestionCount = 0

    -- FUNCIONES PRINCIPALES
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
    -- 5. GUI HORIZONTAL PROFESIONAL
    -- ============================================================

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UltimateFarm"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = PlayerGui

    -- Botón flotante para abrir/cerrar
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = screenGui
    toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    toggleBtn.BackgroundTransparency = 0.1
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Position = UDim2.new(0.02, 0, 0.02, 0)
    toggleBtn.Size = UDim2.new(0, 45, 0, 45)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Text = "👑"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextSize = 22

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.Parent = toggleBtn
    toggleCorner.CornerRadius = UDim.new(1, 0)

    -- FRAME PRINCIPAL (HORIZONTAL)
    local mainFrame = Instance.new("Frame")
    mainFrame.Parent = screenGui
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
    mainFrame.Position = UDim2.new(0.05, 0, 0.08, 0)
    mainFrame.Size = UDim2.new(0, 750, 0, 250)
    mainFrame.ClipsDescendants = true
    mainFrame.Active = true
    mainFrame.Draggable = true

    local mainCorner = Instance.new("UICorner")
    mainCorner.Parent = mainFrame
    mainCorner.CornerRadius = UDim.new(0, 10)

    -- ============================================================
    -- 6. BARRA DE TÍTULO
    -- ============================================================
    local titleBar = Instance.new("Frame")
    titleBar.Parent = mainFrame
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    titleBar.BorderSizePixel = 0
    titleBar.Size = UDim2.new(1, 0, 0, 35)

    local titleText = Instance.new("TextLabel")
    titleText.Parent = titleBar
    titleText.BackgroundTransparency = 1
    titleText.Position = UDim2.new(0, 10, 0, 0)
    titleText.Size = UDim2.new(0, 200, 1, 0)
    titleText.Font = Enum.Font.GothamBold
    titleText.Text = "👑 ULTIMATE FARM " .. scriptConfig.version
    titleText.TextColor3 = Color3.fromRGB(255, 215, 0)
    titleText.TextSize = 14
    titleText.TextXAlignment = Enum.TextXAlignment.Left

    -- Cerrar GUI
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = titleBar
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    closeBtn.BackgroundTransparency = 0.8
    closeBtn.BorderSizePixel = 0
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 14

    closeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        toggleBtn.Visible = true
        state.guiVisible = false
    end)

    toggleBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = true
        toggleBtn.Visible = false
        state.guiVisible = true
    end)

    -- ============================================================
    -- 7. STATS EN UNA SOLA LÍNEA (HORIZONTAL)
    -- ============================================================
    local statsFrame = Instance.new("Frame")
    statsFrame.Parent = mainFrame
    statsFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
    statsFrame.BackgroundTransparency = 0.3
    statsFrame.BorderSizePixel = 1
    statsFrame.BorderColor3 = Color3.fromRGB(40, 40, 70)
    statsFrame.Position = UDim2.new(0, 10, 0, 40)
    statsFrame.Size = UDim2.new(1, -20, 0, 28)

    local statsCorner = Instance.new("UICorner")
    statsCorner.Parent = statsFrame
    statsCorner.CornerRadius = UDim.new(0, 4)

    -- Coronas
    local coronaStat = Instance.new("TextLabel")
    coronaStat.Parent = statsFrame
    coronaStat.BackgroundTransparency = 1
    coronaStat.Position = UDim2.new(0, 10, 0, 0)
    coronaStat.Size = UDim2.new(0, 120, 1, 0)
    coronaStat.Font = Enum.Font.GothamBold
    coronaStat.Text = "👑 " .. tostring(coronas.Value)
    coronaStat.TextColor3 = Color3.fromRGB(255, 215, 0)
    coronaStat.TextSize = 13
    coronaStat.TextXAlignment = Enum.TextXAlignment.Left

    coronas.Changed:Connect(function()
        coronaStat.Text = "👑 " .. tostring(coronas.Value)
    end)

    -- Separador 1
    local sep1 = Instance.new("Frame")
    sep1.Parent = statsFrame
    sep1.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
    sep1.BorderSizePixel = 0
    sep1.Position = UDim2.new(0, 135, 0, 4)
    sep1.Size = UDim2.new(0, 1, 0, 20)

    -- Speed
    local speedStat = Instance.new("TextLabel")
    speedStat.Parent = statsFrame
    speedStat.BackgroundTransparency = 1
    speedStat.Position = UDim2.new(0, 145, 0, 0)
    speedStat.Size = UDim2.new(0, 180, 1, 0)
    speedStat.Font = Enum.Font.Gotham
    speedStat.Text = progresoSpeed and ("⚡ " .. tostring(progresoSpeed.Value) .. "/" .. tostring(metaSpeed.Value)) or "⚡ N/A"
    speedStat.TextColor3 = Color3.fromRGB(100, 200, 255)
    speedStat.TextSize = 12
    speedStat.TextXAlignment = Enum.TextXAlignment.Left

    if progresoSpeed then
        progresoSpeed.Changed:Connect(function()
            speedStat.Text = "⚡ " .. tostring(progresoSpeed.Value) .. "/" .. tostring(metaSpeed.Value)
        end)
        metaSpeed.Changed:Connect(function()
            speedStat.Text = "⚡ " .. tostring(progresoSpeed.Value) .. "/" .. tostring(metaSpeed.Value)
        end)
    end

    -- Separador 2
    local sep2 = Instance.new("Frame")
    sep2.Parent = statsFrame
    sep2.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
    sep2.BorderSizePixel = 0
    sep2.Position = UDim2.new(0, 330, 0, 4)
    sep2.Size = UDim2.new(0, 1, 0, 20)

    -- Estado Zona
    local statusStat = Instance.new("TextLabel")
    statusStat.Parent = statsFrame
    statusStat.BackgroundTransparency = 1
    statusStat.Position = UDim2.new(0, 340, 0, 0)
    statusStat.Size = UDim2.new(0, 120, 1, 0)
    statusStat.Font = Enum.Font.Gotham
    statusStat.Text = partCorona and "✅ Zona-12: OK" or "❌ Zona-12: NO"
    statusStat.TextColor3 = partCorona and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    statusStat.TextSize = 12
    statusStat.TextXAlignment = Enum.TextXAlignment.Left

    -- Separador 3
    local sep3 = Instance.new("Frame")
    sep3.Parent = statsFrame
    sep3.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
    sep3.BorderSizePixel = 0
    sep3.Position = UDim2.new(0, 465, 0, 4)
    sep3.Size = UDim2.new(0, 1, 0, 20)

    -- Clones
    local clonesStat = Instance.new("TextLabel")
    clonesStat.Parent = statsFrame
    clonesStat.BackgroundTransparency = 1
    clonesStat.Position = UDim2.new(0, 475, 0, 0)
    clonesStat.Size = UDim2.new(0, 100, 1, 0)
    clonesStat.Font = Enum.Font.Gotham
    clonesStat.Text = "👥 Clones: 0"
    clonesStat.TextColor3 = Color3.fromRGB(100, 255, 200)
    clonesStat.TextSize = 12
    clonesStat.TextXAlignment = Enum.TextXAlignment.Left

    local function updateClonesLabel()
        clonesStat.Text = "👥 Clones: " .. tostring(#clones)
    end

    -- ============================================================
    -- 8. MENÚ PRINCIPAL (BOTONES EN FILA)
    -- ============================================================
    local menuLabel = Instance.new("TextLabel")
    menuLabel.Parent = mainFrame
    menuLabel.BackgroundTransparency = 1
    menuLabel.Position = UDim2.new(0, 10, 0, 72)
    menuLabel.Size = UDim2.new(0, 120, 0, 18)
    menuLabel.Font = Enum.Font.GothamBold
    menuLabel.Text = "📌 MENÚ PRINCIPAL"
    menuLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    menuLabel.TextSize = 12
    menuLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Contenedor de botones principales (fila horizontal)
    local mainButtonsFrame = Instance.new("Frame")
    mainButtonsFrame.Parent = mainFrame
    mainButtonsFrame.BackgroundTransparency = 1
    mainButtonsFrame.Position = UDim2.new(0, 10, 0, 92)
    mainButtonsFrame.Size = UDim2.new(1, -20, 0, 32)

    local mainButtons = {
        {text = "🛰️ TELEPORT", key = "T", color = Color3.fromRGB(0, 150, 255), toggle = "teleport"},
        {text = "👻 INVISIBLE", key = "I", color = Color3.fromRGB(180, 50, 220), toggle = "invisible"},
        {text = "🏃 TREADMILL", key = "R", color = Color3.fromRGB(0, 200, 150), toggle = "treadmill"},
        {text = "👥 CLON FARM", key = "C", color = Color3.fromRGB(0, 200, 100), toggle = "clon"},
        {text = "🛡️ ANTI-AFK", key = "A", color = Color3.fromRGB(100, 100, 200), toggle = "antiAFK"}
    }

    local btnObjects = {}

    for i, btnData in ipairs(mainButtons) do
        local btn = Instance.new("TextButton")
        btn.Parent = mainButtonsFrame
        btn.BackgroundColor3 = btnData.color
        btn.BackgroundTransparency = 0.85
        btn.BorderSizePixel = 0
        btn.Position = UDim2.new((i-1) * 0.2, 0, 0, 0)
        btn.Size = UDim2.new(0.19, 0, 1, 0)
        btn.Font = Enum.Font.GothamBold
        btn.Text = btnData.text .. " [OFF]"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 11
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

    -- ============================================================
    -- 9. MENÚ UTILIDADES (CON VERIFICACIÓN DE USUARIO)
    -- ============================================================
    local utilsLabel = Instance.new("TextLabel")
    utilsLabel.Parent = mainFrame
    utilsLabel.BackgroundTransparency = 1
    utilsLabel.Position = UDim2.new(0, 10, 0, 130)
    utilsLabel.Size = UDim2.new(0, 120, 0, 18)
    utilsLabel.Font = Enum.Font.GothamBold
    utilsLabel.Text = "🔧 MENÚ UTILIDADES"
    utilsLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    utilsLabel.TextSize = 12
    utilsLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Contenedor de botones de utilidades
    local utilsButtonsFrame = Instance.new("Frame")
    utilsButtonsFrame.Parent = mainFrame
    utilsButtonsFrame.BackgroundTransparency = 1
    utilsButtonsFrame.Position = UDim2.new(0, 10, 0, 150)
    utilsButtonsFrame.Size = UDim2.new(1, -20, 0, 32)

    -- Botón Sugerencia (todos)
    local suggestBtn = Instance.new("TextButton")
    suggestBtn.Parent = utilsButtonsFrame
    suggestBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
    suggestBtn.BackgroundTransparency = 0.85
    suggestBtn.BorderSizePixel = 0
    suggestBtn.Position = UDim2.new(0, 0, 0, 0)
    suggestBtn.Size = UDim2.new(0.24, 0, 1, 0)
    suggestBtn.Font = Enum.Font.GothamBold
    suggestBtn.Text = "💡 ENVIAR SUGERENCIA"
    suggestBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    suggestBtn.TextSize = 11

    -- Frame para sugerencia (todos)
    local suggestFrame = Instance.new("Frame")
    suggestFrame.Parent = mainFrame
    suggestFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
    suggestFrame.BackgroundTransparency = 0.1
    suggestFrame.BorderSizePixel = 0
    suggestFrame.Position = UDim2.new(0, 10, 0, 185)
    suggestFrame.Size = UDim2.new(1, -20, 0, 55)
    suggestFrame.Visible = false
    suggestFrame.ClipsDescendants = true

    local suggestBox = Instance.new("TextBox")
    suggestBox.Parent = suggestFrame
    suggestBox.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    suggestBox.BorderSizePixel = 0
    suggestBox.Position = UDim2.new(0, 5, 0, 5)
    suggestBox.Size = UDim2.new(1, -80, 0, 22)
    suggestBox.Font = Enum.Font.Gotham
    suggestBox.PlaceholderText = "Escribe tu sugerencia aquí..."
    suggestBox.Text = ""
    suggestBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    suggestBox.TextSize = 11
    suggestBox.TextXAlignment = Enum.TextXAlignment.Left

    local sendBtn = Instance.new("TextButton")
    sendBtn.Parent = suggestFrame
    sendBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    sendBtn.BackgroundTransparency = 0.85
    sendBtn.BorderSizePixel = 0
    sendBtn.Position = UDim2.new(1, -70, 0, 5)
    sendBtn.Size = UDim2.new(0, 65, 0, 22)
    sendBtn.Font = Enum.Font.GothamBold
    sendBtn.Text = "📤 ENVIAR"
    sendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    sendBtn.TextSize = 11

    suggestBtn.MouseButton1Click:Connect(function()
        suggestFrame.Visible = not suggestFrame.Visible
        if suggestFrame.Visible then
            suggestBtn.Text = "💡 CERRAR SUGERENCIA"
        else
            suggestBtn.Text = "💡 ENVIAR SUGERENCIA"
        end
    end)

    sendBtn.MouseButton1Click:Connect(function()
        local text = suggestBox.Text
        if text == "" or text == "Escribe tu sugerencia aquí..." then
            print("❌ Escribe una sugerencia primero")
            return
        end

        suggestionCount = suggestionCount + 1
        table.insert(suggestions, {
            id = suggestionCount,
            player = LocalPlayer.Name,
            text = text,
            time = os.date("%H:%M:%S - %d/%m/%Y")
        })

        suggestBox.Text = ""
        suggestFrame.Visible = false
        suggestBtn.Text = "💡 ENVIAR SUGERENCIA"
        print("✅ Sugerencia enviada! ID: " .. suggestionCount)
        if isOwner then
            viewBtn.Text = "👑 VER SUGERENCIAS (" .. #suggestions .. ")"
        end
    end)

    -- ============================================================
    -- ⚠️ SOLO PARA Rivalsteam73 (Verificación de usuario)
    -- ============================================================
    if isOwner then
        -- Botón Ver Sugerencias (SOLO Rivalsteam73)
        local viewBtn = Instance.new("TextButton")
        viewBtn.Parent = utilsButtonsFrame
        viewBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        viewBtn.BackgroundTransparency = 0.85
        viewBtn.BorderSizePixel = 0
        viewBtn.Position = UDim2.new(0.25, 0, 0, 0)
        viewBtn.Size = UDim2.new(0.24, 0, 1, 0)
        viewBtn.Font = Enum.Font.GothamBold
        viewBtn.Text = "👑 VER SUGERENCIAS (0)"
        viewBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        viewBtn.TextSize = 11

        -- Botón Ver Changelogs (SOLO Rivalsteam73)
        local changelogBtn = Instance.new("TextButton")
        changelogBtn.Parent = utilsButtonsFrame
        changelogBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        changelogBtn.BackgroundTransparency = 0.85
        changelogBtn.BorderSizePixel = 0
        changelogBtn.Position = UDim2.new(0.50, 0, 0, 0)
        changelogBtn.Size = UDim2.new(0.24, 0, 1, 0)
        changelogBtn.Font = Enum.Font.GothamBold
        changelogBtn.Text = "📜 VER CHANGELOGS"
        changelogBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        changelogBtn.TextSize = 11

        -- Botón Configuración (SOLO Rivalsteam73)
        local configBtn = Instance.new("TextButton")
        configBtn.Parent = utilsButtonsFrame
        configBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 200)
        configBtn.BackgroundTransparency = 0.85
        configBtn.BorderSizePixel = 0
        configBtn.Position = UDim2.new(0.75, 0, 0, 0)
        configBtn.Size = UDim2.new(0.24, 0, 1, 0)
        configBtn.Font = Enum.Font.GothamBold
        configBtn.Text = "⚙️ CONFIGURACIÓN"
        configBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        configBtn.TextSize = 11

        -- Frame para sugerencias (SOLO Rivalsteam73)
        local viewFrame = Instance.new("Frame")
        viewFrame.Parent = mainFrame
        viewFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
        viewFrame.BackgroundTransparency = 0.1
        viewFrame.BorderSizePixel = 0
        viewFrame.Position = UDim2.new(0, 10, 0, 185)
        viewFrame.Size = UDim2.new(1, -20, 0, 55)
        viewFrame.Visible = false
        viewFrame.ClipsDescendants = true

        local viewTitle = Instance.new("TextLabel")
        viewTitle.Parent = viewFrame
        viewTitle.BackgroundTransparency = 1
        viewTitle.Position = UDim2.new(0, 10, 0, 2)
        viewTitle.Size = UDim2.new(1, -20, 0, 16)
        viewTitle.Font = Enum.Font.GothamBold
        viewTitle.Text = "📋 SUGERENCIAS"
        viewTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
        viewTitle.TextSize = 11
        viewTitle.TextXAlignment = Enum.TextXAlignment.Left

        local suggestionsList = Instance.new("ScrollingFrame")
        suggestionsList.Parent = viewFrame
        suggestionsList.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
        suggestionsList.BackgroundTransparency = 0.5
        suggestionsList.BorderSizePixel = 0
        suggestionsList.Position = UDim2.new(0, 5, 0, 20)
        suggestionsList.Size = UDim2.new(1, -10, 1, -25)
        suggestionsList.CanvasSize = UDim2.new(0, 0, 0, 0)
        suggestionsList.ScrollBarThickness = 3
        suggestionsList.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)

        -- Frame para changelogs (SOLO Rivalsteam73)
        local changelogFrame = Instance.new("Frame")
        changelogFrame.Parent = mainFrame
        changelogFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
        changelogFrame.BackgroundTransparency = 0.1
        changelogFrame.BorderSizePixel = 0
        changelogFrame.Position = UDim2.new(0, 10, 0, 185)
        changelogFrame.Size = UDim2.new(1, -20, 0, 55)
        changelogFrame.Visible = false
        changelogFrame.ClipsDescendants = true

        local changelogTitle = Instance.new("TextLabel")
        changelogTitle.Parent = changelogFrame
        changelogTitle.BackgroundTransparency = 1
        changelogTitle.Position = UDim2.new(0, 10, 0, 2)
        changelogTitle.Size = UDim2.new(1, -20, 0, 16)
        changelogTitle.Font = Enum.Font.GothamBold
        changelogTitle.Text = "📜 CHANGELOGS"
        changelogTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
        changelogTitle.TextSize = 11
        changelogTitle.TextXAlignment = Enum.TextXAlignment.Left

        local changelogList = Instance.new("ScrollingFrame")
        changelogList.Parent = changelogFrame
        changelogList.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
        changelogList.BackgroundTransparency = 0.5
        changelogList.BorderSizePixel = 0
        changelogList.Position = UDim2.new(0, 5, 0, 20)
        changelogList.Size = UDim2.new(1, -10, 1, -25)
        changelogList.CanvasSize = UDim2.new(0, 0, 0, 0)
        changelogList.ScrollBarThickness = 3
        changelogList.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)

        -- Frame de configuración (SOLO Rivalsteam73)
        local configFrame = Instance.new("Frame")
        configFrame.Parent = mainFrame
        configFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
        configFrame.BackgroundTransparency = 0.1
        configFrame.BorderSizePixel = 0
        configFrame.Position = UDim2.new(0, 10, 0, 185)
        configFrame.Size = UDim2.new(1, -20, 0, 55)
        configFrame.Visible = false
        configFrame.ClipsDescendants = true

        local configTitle = Instance.new("TextLabel")
        configTitle.Parent = configFrame
        configTitle.BackgroundTransparency = 1
        configTitle.Position = UDim2.new(0, 10, 0, 2)
        configTitle.Size = UDim2.new(1, -20, 0, 16)
        configTitle.Font = Enum.Font.GothamBold
        configTitle.Text = "⚙️ CONFIGURACIÓN"
        configTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
        configTitle.TextSize = 11
        configTitle.TextXAlignment = Enum.TextXAlignment.Left

        local versionBox = Instance.new("TextBox")
        versionBox.Parent = configFrame
        versionBox.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
        versionBox.BorderSizePixel = 0
        versionBox.Position = UDim2.new(0, 10, 0, 20)
        versionBox.Size = UDim2.new(0, 100, 0, 22)
        versionBox.Font = Enum.Font.Gotham
        versionBox.PlaceholderText = "Versión"
        versionBox.Text = scriptConfig.version
        versionBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        versionBox.TextSize = 11

        local dateBox = Instance.new("TextBox")
        dateBox.Parent = configFrame
        dateBox.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
        dateBox.BorderSizePixel = 0
        dateBox.Position = UDim2.new(0, 120, 0, 20)
        dateBox.Size = UDim2.new(0, 100, 0, 22)
        dateBox.Font = Enum.Font.Gotham
        dateBox.PlaceholderText = "Fecha"
        dateBox.Text = scriptConfig.versionDate
        dateBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        dateBox.TextSize = 11

        local saveConfigBtn = Instance.new("TextButton")
        saveConfigBtn.Parent = configFrame
        saveConfigBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        saveConfigBtn.BackgroundTransparency = 0.85
        saveConfigBtn.BorderSizePixel = 0
        saveConfigBtn.Position = UDim2.new(0, 230, 0, 20)
        saveConfigBtn.Size = UDim2.new(0, 80, 0, 22)
        saveConfigBtn.Font = Enum.Font.GothamBold
        saveConfigBtn.Text = "💾 GUARDAR"
        saveConfigBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        saveConfigBtn.TextSize = 11

        saveConfigBtn.MouseButton1Click:Connect(function()
            scriptConfig.version = versionBox.Text
            scriptConfig.versionDate = dateBox.Text
            titleText.Text = "👑 ULTIMATE FARM " .. scriptConfig.version
            print("✅ Configuración guardada: " .. scriptConfig.version .. " - " .. scriptConfig.versionDate)
            configFrame.Visible = false
            configBtn.Text = "⚙️ CONFIGURACIÓN"
        end)

        -- Funciones para actualizar listas
        local function updateSuggestionsList()
            for _, child in ipairs(suggestionsList:GetChildren()) do
                child:Destroy()
            end

            if #suggestions == 0 then
                local empty = Instance.new("TextLabel")
                empty.Parent = suggestionsList
                empty.BackgroundTransparency = 1
                empty.Size = UDim2.new(1, 0, 0, 30)
                empty.Font = Enum.Font.Gotham
                empty.Text = "📭 No hay sugerencias"
                empty.TextColor3 = Color3.fromRGB(150, 150, 200)
                empty.TextSize = 11
                suggestionsList.CanvasSize = UDim2.new(0, 0, 0, 30)
                return
            end

            local yPos = 0
            for _, sug in ipairs(suggestions) do
                local frame = Instance.new("Frame")
                frame.Parent = suggestionsList
                frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
                frame.BackgroundTransparency = 0.3
                frame.BorderSizePixel = 1
                frame.BorderColor3 = Color3.fromRGB(50, 50, 80)
                frame.Position = UDim2.new(0, 5, 0, yPos)
                frame.Size = UDim2.new(1, -10, 0, 35)

                local info = Instance.new("TextLabel")
                info.Parent = frame
                info.BackgroundTransparency = 1
                info.Position = UDim2.new(0, 8, 0, 2)
                info.Size = UDim2.new(1, -16, 0, 14)
                info.Font = Enum.Font.GothamBold
                info.Text = "👤 " .. sug.player .. "  |  🕐 " .. sug.time
                info.TextColor3 = Color3.fromRGB(200, 200, 255)
                info.TextSize = 10
                info.TextXAlignment = Enum.TextXAlignment.Left

                local text = Instance.new("TextLabel")
                text.Parent = frame
                text.BackgroundTransparency = 1
                text.Position = UDim2.new(0, 8, 0, 18)
                text.Size = UDim2.new(1, -16, 0, 16)
                text.Font = Enum.Font.Gotham
                text.Text = "💬 " .. sug.text
                text.TextColor3 = Color3.fromRGB(255, 255, 255)
                text.TextSize = 10
                text.TextXAlignment = Enum.TextXAlignment.Left
                text.TextWrapped = true

                yPos = yPos + 40
            end
            suggestionsList.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
        end

        local function updateChangelogList()
            for _, child in ipairs(changelogList:GetChildren()) do
                child:Destroy()
            end

            local yPos = 0
            for _, log in ipairs(scriptConfig.changelogs) do
                local frame = Instance.new("Frame")
                frame.Parent = changelogList
                frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
                frame.BackgroundTransparency = 0.3
                frame.BorderSizePixel = 1
                frame.BorderColor3 = Color3.fromRGB(50, 50, 80)
                frame.Position = UDim2.new(0, 5, 0, yPos)
                frame.Size = UDim2.new(1, -10, 0, 20 + #log.changes * 14)

                local header = Instance.new("TextLabel")
                header.Parent = frame
                header.BackgroundTransparency = 1
                header.Position = UDim2.new(0, 8, 0, 2)
                header.Size = UDim2.new(1, -16, 0, 16)
                header.Font = Enum.Font.GothamBold
                header.Text = "📌 " .. log.version .. "  |  📅 " .. log.date
                header.TextColor3 = Color3.fromRGB(255, 215, 0)
                header.TextSize = 10
                header.TextXAlignment = Enum.TextXAlignment.Left

                local y = 18
                for _, change in ipairs(log.changes) do
                    local changeLabel = Instance.new("TextLabel")
                    changeLabel.Parent = frame
                    changeLabel.BackgroundTransparency = 1
                    changeLabel.Position = UDim2.new(0, 16, 0, y)
                    changeLabel.Size = UDim2.new(1, -24, 0, 13)
                    changeLabel.Font = Enum.Font.Gotham
                    changeLabel.Text = change
                    changeLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
                    changeLabel.TextSize = 10
                    changeLabel.TextXAlignment = Enum.TextXAlignment.Left
                    y = y + 14
                end

                yPos = yPos + 20 + #log.changes * 14 + 8
            end
            changelogList.CanvasSize = UDim2.new(0, 0, 0, yPos + 10)
        end

        -- Conectar eventos de utilidades (SOLO Rivalsteam73)
        viewBtn.MouseButton1Click:Connect(function()
            viewFrame.Visible = not viewFrame.Visible
            changelogFrame.Visible = false
            configFrame.Visible = false
            suggestFrame.Visible = false
            if viewFrame.Visible then
                viewBtn.Text = "👑 OCULTAR SUGERENCIAS"
                updateSuggestionsList()
            else
                viewBtn.Text = "👑 VER SUGERENCIAS (" .. #suggestions .. ")"
            end
        end)

        changelogBtn.MouseButton1Click:Connect(function()
            changelogFrame.Visible = not changelogFrame.Visible
            viewFrame.Visible = false
            configFrame.Visible = false
            suggestFrame.Visible = false
            if changelogFrame.Visible then
                changelogBtn.Text = "📜 OCULTAR CHANGELOGS"
                updateChangelogList()
            else
                changelogBtn.Text = "📜 VER CHANGELOGS"
            end
        end)

        configBtn.MouseButton1Click:Connect(function()
            configFrame.Visible = not configFrame.Visible
            viewFrame.Visible = false
            changelogFrame.Visible = false
            suggestFrame.Visible = false
            if configFrame.Visible then
                configBtn.Text = "⚙️ OCULTAR CONFIGURACIÓN"
                versionBox.Text = scriptConfig.version
                dateBox.Text = scriptConfig.versionDate
            else
                configBtn.Text = "⚙️ CONFIGURACIÓN"
            end
        end)

        -- Actualizar contador
        local function updateSuggestionCount()
            viewBtn.Text = "👑 VER SUGERENCIAS (" .. #suggestions .. ")"
        end

        sendBtn.MouseButton1Click:Connect(function()
            task.wait(0.1)
            updateSuggestionCount()
        end)
    end

    -- ============================================================
    -- 10. ATAJOS DE TECLADO
    -- ============================================================
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.B then
            if state.guiVisible then
                mainFrame.Visible = false
                toggleBtn.Visible = true
                state.guiVisible = false
            else
                mainFrame.Visible = true
                toggleBtn.Visible = false
                state.guiVisible = true
            end
        end

        local map = {
            [Enum.KeyCode.T] = "teleport",
            [Enum.KeyCode.I] = "invisible",
            [Enum.KeyCode.R] = "treadmill",
            [Enum.KeyCode.C] = "clon",
            [Enum.KeyCode.A] = "antiAFK"
        }
        local toggle = map[input.KeyCode]
        if toggle and btnObjects[toggle] then
            btnObjects[toggle].MouseButton1Click:Fire()
        end
    end)

    -- ============================================================
    -- 11. ACTUALIZAR AL RESPAWN
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
    -- 12. INICIALIZACIÓN
    -- ============================================================
    print("╔════════════════════════════════════════════════════╗")
    print("║     👑 ULTIMATE FARM " .. scriptConfig.version .. " CARGADO 👑           ║")
    print("╠════════════════════════════════════════════════════╣")
    print("║  📌 GUI HORIZONTAL PROFESIONAL                    ║")
    print("║  📡 T = Teleport                                 ║")
    print("║  👻 I = Invisible Total                          ║")
    print("║  🏃 R = Auto-Treadmill                          ║")
    print("║  👥 C = Clon Farm x2                            ║")
    print("║  🛡️ A = Anti-AFK                                ║")
    print("║  🅱️ B = Abrir/Cerrar GUI                        ║")
    if isOwner then
        print("║  👑 Rivalsteam73: Panel Admin visible         ║")
    else
        print("║  👤 Usuario normal: Panel Admin oculto        ║")
    end
    print("║                                                 ║")
    print("║  👑 Coronas: " .. tostring(coronas.Value))
    if progresoSpeed then
        print("║  ⚡ Speed: " .. tostring(progresoSpeed.Value) .. "/" .. tostring(metaSpeed.Value))
    end
    print("║  📍 Zona-12: " .. (partCorona and "✅ OK" or "❌ NO"))
    print("╚════════════════════════════════════════════════════╝")
end

-- ============================================================
-- 13. INICIAR CARGA
-- ============================================================
task.spawn(function()
    local progress = 0

    local loadSteps = {
        {text = "Inicializando módulos...", progress = 10},
        {text = "Conectando al servidor...", progress = 25},
        {text = "Cargando configuración...", progress = 40},
        {text = "Buscando Zona-12...", progress = 55},
        {text = "Preparando GUI...", progress = 70},
        {text = "Cargando funciones...", progress = 85},
        {text = "¡Listo!", progress = 100}
    }

    for _, stepData in ipairs(loadSteps) do
        local targetProgress = stepData.progress
        subtitleLabel.Text = stepData.text

        while progress < targetProgress do
            progress = progress + 1
            if progress > 100 then progress = 100 end

            progressBar.Size = UDim2.new(progress / 100, 0, 1, 0)
            percentLabel.Text = math.floor(progress) .. "%"

            if progress < 30 then
                progressBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            elseif progress < 60 then
                progressBar.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
            else
                progressBar.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            end

            task.wait(0.05)
        end
    end

    task.wait(0.3)
    loadMainScript()
end)
