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
    camera.CameraType = Enum.CameraType.Scriptable
    camera.CFrame = CFrame.new(
        character.Head.Position,
        character.Head.Position - Vector3.new(0, 1, 0)
    camera.FieldOfView = 70
end

-- Función para presionar teclas
local function holdKey(key, duration)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[key], false, game)
    task.wait(duration)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[key], false, game)
end

-- Función principal
local function main()
    setFirstPerson()  -- Configurar cámara
    
    while true do
        for _, pos in ipairs(waypoints) do
            hrp.CFrame = CFrame.new(pos)
            task.wait(0.5)
            holdKey("E", 10)
        end
        
        holdKey("R", 0.5)  -- Rejoin
        task.wait(15)      -- Esperar para reconexión
    end
end

-- Sistema de autoreinicio (para exploits compatibles)
if not _G.antiDuplicate then
    _G.antiDuplicate = true
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function()
        queue_on_teleport([[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Mind-Bloow/PV2FARM/main/PV2FARM.lua"))()
        ]])
    end)
end

-- Iniciar script
main()
