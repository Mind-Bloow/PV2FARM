local waypoints = {
    Vector3.new(-3655, 1154, 38),    -- WP0 (primero)
    Vector3.new(-3701, 1142, -46),   -- WP1
    Vector3.new(-3691, 1137, -177),  -- WP2
    Vector3.new(-3557, 1111, -177),  -- WP3
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

local function holdKey(key, duration)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[key], false, game)
    task.wait(duration)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[key], false, game)
end

local function main()
    while true do
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")

        -- Recorrer waypoints
        for _, pos in ipairs(waypoints) do
            hrp.CFrame = CFrame.new(pos)
            task.wait(0.5)
            holdKey("E", 10)  -- Recolectar
        end

        -- Rejoin y reinicio forzado (solución universal)
        holdKey("R", 0.5)  -- Presiona R para rejoin
        task.wait(25)  -- Espera 25 segundos (ajustable)
        
        -- Fuerza la re-ejecución (funciona incluso en exploits gratuitos)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Mind-Bloow/PV2FARM/main/PV2FARM.lua"))()
        break  -- Rompe el bucle para reiniciar limpio
    end
end

-- Sistema de autoreinicio mejorado (opcional para exploits pagados)
if not _G.antiDuplicate then
    _G.antiDuplicate = true
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(teleportState)
        if teleportState == Enum.TeleportState.Started then
            queue_on_teleport([[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Mind-Bloow/PV2FARM/main/PV2FARM.lua"))()
            ]])
        end
    end)
end

-- Iniciar
main()
