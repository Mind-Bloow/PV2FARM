-- Configuración inicial
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local camera = game:GetService("Workspace").CurrentCamera

-- Waypoints
local waypoints = {
    Vector3.new(-3655, 1154, 38),    -- WP0
    Vector3.new(-3701, 1142, -46),   -- WP1
    Vector3.new(-3691, 1137, -177),  -- WP2
    Vector3.new(-3557, 1111, -177),  -- WP3
    Vector3.new(-3513, 1111, -126),  -- WP4
    Vector3.new(-3474, 1131, 113),   -- WP5
    Vector3.new(-3603, 1111, 70),    -- WP6
    Vector3.new(-3658, 1152, -71),   -- WP7
    Vector3.new(-3753, 1142, 77),    -- WP8
    Vector3.new(-3929, 1111, -5),    -- WP9
    Vector3.new(-4051, 1111, 59)     -- WP10
}

-- Función para configurar primera persona mirando al suelo
local function setFirstPerson()
    if character:FindFirstChild("Head") then
        camera.CameraType = Enum.CameraType.Scriptable
        camera.CFrame = CFrame.new(
            character.Head.Position,
            character.Head.Position - Vector3.new(0, 1, 0)
        )
        camera.FieldOfView = 70
    else
        warn("No se encontró la cabeza del personaje")
    end
end

-- Función para presionar teclas (mejorada)
local function holdKey(key, duration)
    local keyCode = Enum.KeyCode[key]
    if keyCode then
        for i = 1, math.floor(duration/0.1) do
            VirtualInputManager:SendKeyEvent(true, keyCode, false, nil)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, keyCode, false, nil)
        end
    end
end

-- Verificación de personaje
local function ensureCharacter()
    while not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") do
        character = player.CharacterAdded:Wait()
        task.wait(1)
    end
    return player.Character
end

-- Función principal mejorada
local function main()
    character = ensureCharacter()
    hrp = character:WaitForChild("HumanoidRootPart")
    setFirstPerson()
    
    while true do
        for i, pos in ipairs(waypoints) do
            -- Verificar personaje en cada iteración
            character = ensureCharacter()
            hrp = character:FindFirstChild("HumanoidRootPart")
            
            if hrp then
                -- Teleport con pequeña altura adicional
                hrp.CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))
                task.wait(0.5)
                
                -- Presionar E con verificación
                holdKey("E", 10)
                
                -- Espera adicional después del último waypoint
                if i == #waypoints then
                    task.wait(1)
                    holdKey("R", 0.5)
                    task.wait(15)  -- Tiempo para rejoin
                end
            end
        end
    end
end

-- Iniciar script con protección
local success, err = pcall(main)
if not success then
    warn("Error al iniciar el script:", err)
    -- Intentar reiniciar después de 5 segundos
    task.wait(5)
    main()
end
