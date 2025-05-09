local waypoints = {
    Vector3.new(-3655, 1154, 38),    -- WP0 (primero)
    Vector3.new(-3701, 1142, -46),   -- WP1
    Vector3.new(-3691, 1137, -177),  -- WP2
    Vector3.new(-3557, 1109, -179),  -- WP3
    Vector3.new(-3513, 1111, -126),  -- WP4
    Vector3.new(-3474, 1131, 113),   -- WP5
    Vector3.new(-3603, 1111, 70),    -- WP6
    Vector3.new(-3658, 1152, -71),   -- WP7
    Vector3.new(-3753, 1142, 77),    -- WP8
    Vector3.new(-3929, 1111, -5),    -- WP9
    Vector3.new(-4051, 1111, 59)     -- WP10 (último)
}

local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

local function holdKey(keyCode, duration)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[keyCode], false, game)
    task.wait(duration)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[keyCode], false, game)
end

local function setFirstPersonView()
    -- Establecer la cámara en primera persona y mirar hacia abajo
    camera.CameraType = Enum.CameraType.Custom
    camera.FieldOfView = 70  -- Ajusta el FOV si es necesario
    player.Character:WaitForChild("Humanoid").CameraOffset = Vector3.new(0, 0, 0) -- Asegura que la vista esté centrada
    -- Coloca la cámara mirando hacia abajo
    camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + Vector3.new(0, -1, 0))
end

while true do
    -- Esperar a que el personaje exista (tras rejoin)
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    
    -- Activar primera persona y mirar hacia abajo
    setFirstPersonView()
    
    -- Recorrer waypoints (WP0 primero -> WP10 último)
    for _, pos in ipairs(waypoints) do
        hrp.CFrame = CFrame.new(pos)
        task.wait(0.05)  -- Reducir tiempo de espera entre teletransportes
        holdKey("E", 4)  -- Reducir la duración de la tecla E a 2 segundos
    end

    -- Presionar R para rejoin y continuar
    holdKey("R", 0.5)
    task.wait(1)  -- Tiempo para completar el rejoin
end
