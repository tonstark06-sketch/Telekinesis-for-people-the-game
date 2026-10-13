-- T-F Telekinesis HUB для people the game
-- E = схватить / отпустить
-- G = отпустить всё
-- Q = бросить (держать = заряд)
-- T = вернуть всё
-- X = взрыв
-- Z = телепорт к последнему брошенному
-- Y = лицо из предметов
-- Num/ = физический щит
-- Num0 = freeze
-- N = no-collide
-- End = авто-возврат
-- Del = хитбоксы
-- L = stick mode (сфера)
-- Num1 = orbit mode
-- Num3 = multi-select
-- B = формация (column/wall/ring/cube/multi/face)
-- K = target-lock
-- J = сменить цель
-- Num+ = ракета
-- RAlt = панель
-- [ = отдалить | ] = приблизить
-- Insert = выгрузить

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LP = Players.LocalPlayer

-- ============================================================
-- ЗАСТАВКА
-- ============================================================
do
    local playerGui = LP:WaitForChild("PlayerGui")
    local Lighting = game:GetService("Lighting")

    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = Lighting

    local gui = Instance.new("ScreenGui")
    gui.Name = "TOTEM_INTRO"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 999999
    gui.Parent = playerGui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 1
    bg.BorderSizePixel = 0
    bg.Parent = gui

    local scanlines = Instance.new("Frame")
    scanlines.Size = UDim2.new(1, 0, 1, 0)
    scanlines.BackgroundTransparency = 1
    scanlines.BorderSizePixel = 0
    scanlines.Parent = gui

    for i = 0, 60 do
        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, 0, 0, 1)
        line.Position = UDim2.new(0, 0, i / 60, 0)
        line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        line.BackgroundTransparency = 0.95
        line.BorderSizePixel = 0
        line.Parent = scanlines
    end

    local reflection = Instance.new("TextLabel")
    reflection.Size = UDim2.new(1, 0, 0.4, 0)
    reflection.Position = UDim2.new(0, 0, 0.72, 0)
    reflection.BackgroundTransparency = 1
    reflection.BorderSizePixel = 0
    reflection.Text = ""
    reflection.TextScaled = true
    reflection.Font = Enum.Font.GothamBlack
    reflection.TextColor3 = Color3.fromRGB(255, 255, 255)
    reflection.TextTransparency = 0.85
    reflection.TextStrokeTransparency = 1
    reflection.Rotation = 180
    reflection.Parent = gui

    local reflGradient = Instance.new("UIGradient")
    reflGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 150, 255)),
    })
    reflGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1),
    })
    reflGradient.Parent = reflection

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.4, 0)
    label.Position = UDim2.new(0, 0, 0.3, 0)
    label.BackgroundTransparency = 1
    label.BorderSizePixel = 0
    label.Text = ""
    label.TextScaled = true
    label.Font = Enum.Font.GothamBlack
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 1
    label.Parent = gui

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 165, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 255)),
    })
    gradient.Parent = label

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 4
    stroke.Transparency = 0.3
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local strokeGradient = Instance.new("UIGradient")
    strokeGradient.Color = gradient.Color
    strokeGradient.Parent = stroke
    stroke.Parent = label

    local sub2 = Instance.new("TextLabel")
    sub2.Size = UDim2.new(1, 0, 0, 24)
    sub2.Position = UDim2.new(0, 0, 0.66, 0)
    sub2.BackgroundTransparency = 1
    sub2.Text = ""
    sub2.TextSize = 18
    sub2.Font = Enum.Font.GothamBold
    sub2.TextColor3 = Color3.fromRGB(150, 150, 200)
    sub2.TextTransparency = 1
    sub2.Parent = gui

    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(0.6, 0, 0, 6)
    barBg.Position = UDim2.new(0.2, 0, 0.82, 0)
    barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    barBg.BackgroundTransparency = 0.5
    barBg.BorderSizePixel = 0
    barBg.Parent = gui

    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg

    local barGradient = Instance.new("UIGradient")
    barGradient.Color = gradient.Color
    barGradient.Parent = barFill

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = barBg
    local barCornerFill = Instance.new("UICorner")
    barCornerFill.CornerRadius = UDim.new(1, 0)
    barCornerFill.Parent = barFill

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.new(0, 0, 0.86, 0)
    sub.BackgroundTransparency = 1
    sub.Text = ""
    sub.TextSize = 14
    sub.Font = Enum.Font.Gotham
    sub.TextColor3 = Color3.fromRGB(180, 180, 180)
    sub.Parent = gui

    task.spawn(function()
        local full_text = "MADE BY KIRESHKA_8"

        task.spawn(function()
            for i = 0, 20 do
                blur.Size = i * 1.5
                bg.BackgroundTransparency = 1 - (i / 20) * 0.6
                task.wait(0.02)
            end
        end)

        task.spawn(function()
            while gui.Parent do
                gradient.Rotation = (tick() * 200) % 360
                strokeGradient.Rotation = (tick() * 200) % 360
                barGradient.Rotation = (tick() * 200) % 360
                reflGradient.Rotation = (tick() * 180) % 360
                task.wait()
            end
        end)

        task.spawn(function()
            while gui.Parent do
                local s = 1 + math.sin(tick() * 4) * 0.02
                label.Size = UDim2.new(s, 0, 0.4 * s, 0)
                task.wait()
            end
        end)

        for i = 1, #full_text do
            label.Text = full_text:sub(1, i)
            reflection.Text = full_text:sub(1, i)
            task.wait(0.05)
        end

        task.wait(0.2)
        local sub2_text = "CREDITS:DEEPSEEK(TOTEM-GENIUS)"
        for i = 1, #sub2_text do
            sub2.Text = sub2_text:sub(1, i)
            sub2.TextTransparency = 0
            task.wait(0.03)
        end

        for i = 0, 40 do
            barFill.Size = UDim2.new(i / 40, 0, 1, 0)
            sub.Text = "loading" .. string.rep(".", i % 4)
            task.wait(0.025)
        end

        task.wait(0.3)

        for i = 0, 30 do
            local a = i / 30
            label.TextTransparency = a
            stroke.Transparency = 0.3 + a * 0.7
            reflection.TextTransparency = 0.85 + a * 0.15
            sub2.TextTransparency = a
            barBg.BackgroundTransparency = 0.5 + a * 0.5
            barFill.BackgroundTransparency = a
            sub.TextTransparency = a
            bg.BackgroundTransparency = 0.4 + a * 0.6
            for _, l in ipairs(scanlines:GetChildren()) do
                l.BackgroundTransparency = 0.95 + a * 0.05
            end
            blur.Size = 30 - i
            task.wait(0.02)
        end

        pcall(function() gui:Destroy() end)
        pcall(function() blur:Destroy() end)
    end)
end

-- ============================================================
-- СОСТОЯНИЕ
-- ============================================================
local T = {
    conns = {},
    grabbed_list = {},
    last_thrown_list = {},
    auto_return = false,
    auto_return_delay = 1.5,
    return_in_progress = false,
    hold_distance = 8,
    pull_speed = 15,
    throw_speed = 200,
    return_speed = 250,
    grab_deadzone = 2,
    hitbox_scale = 4,
    unloaded = false,
    aim_on_item = false,
    hitbox_wrappers = {},
    show_hitboxes = false,
    hitbox_visuals = {},
    orbit_mode = false,
    stick_mode = false,
    multi_select = false,
    orbit_radius = 10,
    orbit_speed = 0.05,
    orbit_angle = 0,
    original_massless = {},
    original_density = {},
    freeze_mode = false,
    no_collide = false,
    grabbed_noclip = true,
    grabbed_assembly = {},
    original_collide = {},
    original_anchored = {},
    original_velocity = {},
    action_log = {},
    fps = 0,
    frame_count = 0,
    fps_time = 0,

    formation = "column",
    formation_ring_radius = 6,
    formation_wall_w = 5,
    formation_wall_h = 3,

    target_lock = false,
    target_player = nil,

    rocket_speed = 1500,
    rocket_cooldown = 0,

    charge_start = 0,
    charge_active = false,
    charge_max_time = 1.5,
    charge_min_mult = 1.0,
    charge_max_mult = 4.0,

    anchor_strikes = {},
    anchor_strike_limit = 5,
    anchor_skip_list = {},

    face_mode = false,
    shield_mode = false,
    shield_radius = 4,
    shield_speed = 3,
}

local function bind(sig, fn)
    local c = sig:Connect(fn)
    table.insert(T.conns, c)
    return c
end

local function get_char()
    return LP.Character
end

local release_all
local get_target_head
local update_trajectory
local get_formation_offset
local throw

-- ============================================================
-- MATRIX THEME
-- ============================================================
local MATRIX_GREEN = Color3.fromRGB(0, 255, 70)
local MATRIX_GREEN_DIM = Color3.fromRGB(0, 160, 45)
local MATRIX_BG = Color3.fromRGB(0, 0, 0)
local MATRIX_FONT = Enum.Font.Code

local function apply_matrix_theme(frame, opts)
    opts = opts or {}
    local pad = opts.padding or 10
    local corner = opts.corner or 4

    frame.BackgroundColor3 = MATRIX_BG
    frame.BackgroundTransparency = 0.12
    frame.BorderSizePixel = 0

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, corner)
    c.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = MATRIX_GREEN
    stroke.Thickness = 1
    stroke.Transparency = 0.35
    stroke.Parent = frame

    local strokeGlow = Instance.new("UIStroke")
    strokeGlow.Color = MATRIX_GREEN
    strokeGlow.Thickness = 3
    strokeGlow.Transparency = 0.92
    strokeGlow.Parent = frame

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, pad)
    padding.PaddingBottom = UDim.new(0, pad)
    padding.PaddingLeft = UDim.new(0, pad)
    padding.PaddingRight = UDim.new(0, pad)
    padding.Parent = frame

    local scan = Instance.new("Frame")
    scan.Name = "MATRIX_SCAN"
    scan.Size = UDim2.new(1, 0, 0, 2)
    scan.BackgroundColor3 = MATRIX_GREEN
    scan.BackgroundTransparency = 0.6
    scan.BorderSizePixel = 0
    scan.ZIndex = 5
    scan.Parent = frame

    task.spawn(function()
        local y = 0
        while scan.Parent and not T.unloaded do
            y = (y + 1) % 100
            scan.Position = UDim2.new(0, 0, y / 100, 0)
            task.wait(0.04)
        end
    end)

    for _, c in ipairs(frame:GetChildren()) do
        if c:IsA("GuiObject") and c.Name ~= "MATRIX_SCAN" then
            c.ZIndex = math.max(c.ZIndex, 2)
        end
    end

    return { stroke = stroke, glow = strokeGlow }
end

local function style_label(lbl, color, bold)
    lbl.Font = MATRIX_FONT
    lbl.TextColor3 = color or MATRIX_GREEN_DIM
    if bold then
        lbl.TextStrokeColor3 = MATRIX_GREEN
        lbl.TextStrokeTransparency = 0.7
    end
end

-- ============================================================
-- LOG
-- ============================================================
local function log_action(text)
    table.insert(T.action_log, {
        text = text,
        time = tick(),
    })
    while #T.action_log > 8 do
        table.remove(T.action_log, 1)
    end
end

-- ============================================================
-- TRAILS
-- ============================================================
local active_trails = {}

local TRAIL_COLORS = {
    rocket = { Color3.fromRGB(255, 120, 30), Color3.fromRGB(255, 60, 20) },
    throw  = { Color3.fromRGB(255, 60, 60), Color3.fromRGB(180, 30, 30) },
    recall = { Color3.fromRGB(0, 255, 120), Color3.fromRGB(0, 160, 60) },
    launch = { Color3.fromRGB(255, 220, 60), Color3.fromRGB(255, 160, 20) },
}

local function attach_trail(part, mode, lifetime)
    if not part or not part.Parent then return end
    if active_trails[part] then return end

    local cols = TRAIL_COLORS[mode] or TRAIL_COLORS.throw

    local trail = Instance.new("Trail")
    local a0 = Instance.new("Attachment")
    local a1 = Instance.new("Attachment")
    a0.Position = Vector3.new(0, part.Size.Y / 2, 0)
    a1.Position = Vector3.new(0, -part.Size.Y / 2, 0)
    a0.Parent = part
    a1.Parent = part
    trail.Attachment0 = a0
    trail.Attachment1 = a1
    trail.Lifetime = lifetime or 0.4
    trail.Color = ColorSequence.new(cols[1], cols[2])
    trail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.15),
        NumberSequenceKeypoint.new(1, 1),
    })
    trail.LightEmission = 0.6
    trail.Parent = part

    active_trails[part] = { trail = trail, a0 = a0, a1 = a1 }
end

local function detach_trail(part, delay)
    if not part then return end
    local data = active_trails[part]
    if not data then return end
    active_trails[part] = nil

    local function cleanup()
        pcall(function() data.trail:Destroy() end)
        pcall(function() data.a0:Destroy() end)
        pcall(function() data.a1:Destroy() end)
    end

    if delay and delay > 0 then
        task.delay(delay, cleanup)
    else
        cleanup()
    end
end

local function detach_all_trails()
    for part, data in pairs(active_trails) do
        pcall(function() data.trail:Destroy() end)
        pcall(function() data.a0:Destroy() end)
        pcall(function() data.a1:Destroy() end)
    end
    active_trails = {}
end

-- ============================================================
-- ПОДСВЕТКА
-- ============================================================
local highlights = {}

local function classify_item(model)
    local n = model.Name:lower()
    if n:find("pistol") or n:find("gun") or n:find("rifle")
       or n:find("shotgun") or n:find("revolver") or n:find("smg") then
        return Color3.fromRGB(255, 60, 60)
    elseif n:find("ammo") or n:find("shell") or n:find("bullet") or n:find("mag") then
        return Color3.fromRGB(60, 130, 255)
    elseif n:find("box") or n:find("crate") or n:find("loot") or n:find("bag") then
        return Color3.fromRGB(255, 210, 60)
    elseif n:find("knife") or n:find("shovel") or n:find("axe") or n:find("bat") then
        return Color3.fromRGB(255, 130, 30)
    elseif n:find("can") or n:find("food") or n:find("radio") or n:find("med") then
        return Color3.fromRGB(120, 255, 120)
    else
        return Color3.fromRGB(0, 255, 120)
    end
end

local function add_highlight(model)
    if not model then return end
    if highlights[model] then return end

    local col = classify_item(model)

    local h = Instance.new("Highlight")
    h.Name = "TOTEM_HIGHLIGHT"
    h.FillColor = col
    h.FillTransparency = 0.5
    h.OutlineColor = col
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Adornee = model
    h.Parent = LP.PlayerGui
    highlights[model] = h
end

local function remove_highlight(model)
    if highlights[model] then
        pcall(function() highlights[model]:Destroy() end)
        highlights[model] = nil
    end
end

local function clear_highlight()
    for _, h in pairs(highlights) do
        pcall(function() h:Destroy() end)
    end
    highlights = {}
end

-- ============================================================
-- ФИЗИКА
-- ============================================================
local function apply_item_physics(part)
    if not part then return end
    if T.original_massless[part] ~= nil then return end

    T.original_massless[part] = part.Massless
    T.original_density[part] = part.CustomPhysicalProperties

    local bf = part:FindFirstChild("TOTEM_ANTIGRAV")
    if not bf then
        bf = Instance.new("BodyForce")
        bf.Name = "TOTEM_ANTIGRAV"
        bf.Parent = part
    end

    local orig = part.CustomPhysicalProperties
    if orig then
        pcall(function()
            part.CustomPhysicalProperties = PhysicalProperties.new(
                orig.Density * 0.1,
                orig.Friction,
                orig.Elasticity
            )
        end)
    else
        pcall(function()
            part.CustomPhysicalProperties = PhysicalProperties.new(0.07, 0.3, 0.5)
        end)
    end
end

local function restore_item_physics(part)
    if not part then return end
    if T.original_massless[part] == nil then return end

    pcall(function()
        part.Massless = T.original_massless[part]
    end)

    pcall(function()
        part.CustomPhysicalProperties = T.original_density[part]
    end)

    local bf = part:FindFirstChild("TOTEM_ANTIGRAV")
    if bf then
        pcall(function() bf:Destroy() end)
    end

    T.original_massless[part] = nil
    T.original_density[part] = nil
end

task.spawn(function()
    while not T.unloaded do
        for _, item in ipairs(T.grabbed_list) do
            local part = item.part
            if part and part.Parent then
                local bf = part:FindFirstChild("TOTEM_ANTIGRAV")
                if bf then
                    local mass = part:GetMass()
                    local gravity = Workspace.Gravity
                    pcall(function()
                        bf.Force = Vector3.new(0, mass * gravity, 0)
                    end)
                end
            end
        end
        task.wait(0.03)
    end
end)

-- ============================================================
-- NO-COLLIDE
-- ============================================================
local function restore_one_collide(part)
    if not part then return end

    local root = T.grabbed_assembly and T.grabbed_assembly[part]
    if root then
        local parts = {}
        pcall(function()
            for _, p in ipairs(root:GetConnectedParts(true)) do
                if p:IsA("BasePart") then parts[p] = true end
            end
        end)
        parts[root] = true
        parts[part] = true
        for p in pairs(parts) do
            local orig = T.original_collide[p]
            if orig ~= nil and p.Parent then
                pcall(function() p.CanCollide = orig end)
            end
            T.original_collide[p] = nil
        end
        T.grabbed_assembly[part] = nil
    end

    local orig = T.original_collide[part]
    if orig ~= nil and part.Parent then
        pcall(function() part.CanCollide = orig end)
    end
    T.original_collide[part] = nil
end

local function apply_no_collide()
    for _, item in ipairs(T.grabbed_list) do
        local part = item.part
        if part and part.Parent then
            if T.original_collide[part] == nil then
                T.original_collide[part] = part.CanCollide
            end
            part.CanCollide = false
        end
    end
end

local function restore_collide()
    for part, orig in pairs(T.original_collide) do
        if part and part.Parent then
            pcall(function() part.CanCollide = orig end)
        end
    end
    T.original_collide = {}
    T.grabbed_assembly = {}
end

-- ============================================================
-- АНТИ-ФРИЗ
-- ============================================================
task.spawn(function()
    while not T.unloaded do
        for i = #T.grabbed_list, 1, -1 do
            local item = T.grabbed_list[i]
            local part = item.part
            if part and part.Parent then
                if part.Anchored and not T.freeze_mode then
                    T.anchor_strikes[part] = (T.anchor_strikes[part] or 0) + 1

                    if T.anchor_strikes[part] >= T.anchor_strike_limit then
                        print("[T-F] anchor-protected, releasing:", part:GetFullName())
                        T.anchor_skip_list[part] = tick()
                        restore_item_physics(part)
                        remove_highlight(item.model)
                        table.remove(T.grabbed_list, i)
                        T.anchor_strikes[part] = nil
                    else
                        pcall(function() part.Anchored = false end)
                    end
                else
                    T.anchor_strikes[part] = nil
                end
            else
                T.anchor_strikes[part] = nil
            end
        end
        task.wait(0.15)
    end
end)

-- ============================================================
-- FREEZE
-- ============================================================
local function apply_freeze()
    for _, item in ipairs(T.grabbed_list) do
        local part = item.part
        if part and part.Parent then
            if T.original_anchored[part] == nil then
                T.original_anchored[part] = part.Anchored
            end
            T.original_velocity[part] = {
                linear = part.AssemblyLinearVelocity,
                angular = part.AssemblyAngularVelocity,
            }
            part.Anchored = true
        end
    end
end

local function restore_freeze()
    for part, orig in pairs(T.original_anchored) do
        if part and part.Parent then
            pcall(function() part.Anchored = orig end)
        end
    end
    T.original_anchored = {}
    T.original_velocity = {}
end

-- ============================================================
-- ПРИЦЕЛ
-- ============================================================
local playerGui = LP:WaitForChild("PlayerGui")

local crosshairGui = Instance.new("ScreenGui")
crosshairGui.Name = "TOTEM_CROSSHAIR"
crosshairGui.ResetOnSpawn = false
crosshairGui.IgnoreGuiInset = true
crosshairGui.DisplayOrder = 999999
crosshairGui.Parent = playerGui

local CH_COLOR_HIT = Color3.fromRGB(0, 255, 120)
local CH_COLOR_STROKE = Color3.fromRGB(0, 0, 0)

local ch_dot = Instance.new("Frame")
ch_dot.Size = UDim2.new(0, 3, 0, 3)
ch_dot.BackgroundColor3 = CH_COLOR_HIT
ch_dot.BorderSizePixel = 0
ch_dot.AnchorPoint = Vector2.new(0.5, 0.5)
ch_dot.Visible = false
ch_dot.ZIndex = 10
ch_dot.Parent = crosshairGui
local ch_dot_corner = Instance.new("UICorner")
ch_dot_corner.CornerRadius = UDim.new(1, 0)
ch_dot_corner.Parent = ch_dot
local ch_dot_stroke = Instance.new("UIStroke")
ch_dot_stroke.Color = CH_COLOR_STROKE
ch_dot_stroke.Thickness = 1
ch_dot_stroke.Transparency = 0.5
ch_dot_stroke.Parent = ch_dot

local ch_ring_outer = Instance.new("Frame")
ch_ring_outer.Size = UDim2.new(0, 26, 0, 26)
ch_ring_outer.BackgroundTransparency = 1
ch_ring_outer.BorderSizePixel = 0
ch_ring_outer.AnchorPoint = Vector2.new(0.5, 0.5)
ch_ring_outer.Visible = false
ch_ring_outer.ZIndex = 5
ch_ring_outer.Parent = crosshairGui
local ch_ring_outer_corner = Instance.new("UICorner")
ch_ring_outer_corner.CornerRadius = UDim.new(1, 0)
ch_ring_outer_corner.Parent = ch_ring_outer
local ch_ring_outer_stroke = Instance.new("UIStroke")
ch_ring_outer_stroke.Color = CH_COLOR_HIT
ch_ring_outer_stroke.Thickness = 1
ch_ring_outer_stroke.Transparency = 0.3
ch_ring_outer_stroke.Parent = ch_ring_outer

local ch_ring_inner = Instance.new("Frame")
ch_ring_inner.Size = UDim2.new(0, 14, 0, 14)
ch_ring_inner.BackgroundTransparency = 1
ch_ring_inner.BorderSizePixel = 0
ch_ring_inner.AnchorPoint = Vector2.new(0.5, 0.5)
ch_ring_inner.Visible = false
ch_ring_inner.ZIndex = 5
ch_ring_inner.Parent = crosshairGui
local ch_ring_inner_corner = Instance.new("UICorner")
ch_ring_inner_corner.CornerRadius = UDim.new(1, 0)
ch_ring_inner_corner.Parent = ch_ring_inner
local ch_ring_inner_stroke = Instance.new("UIStroke")
ch_ring_inner_stroke.Color = CH_COLOR_HIT
ch_ring_inner_stroke.Thickness = 1
ch_ring_inner_stroke.Transparency = 0.5
ch_ring_inner_stroke.Parent = ch_ring_inner

local ch_lines = {}
for _, name in ipairs({"up", "down", "left", "right"}) do
    local line = Instance.new("Frame")
    line.Name = name
    line.BackgroundColor3 = CH_COLOR_HIT
    line.BorderSizePixel = 0
    line.AnchorPoint = Vector2.new(0.5, 0.5)
    line.Visible = false
    line.ZIndex = 8
    line.Parent = crosshairGui
    local l_stroke = Instance.new("UIStroke")
    l_stroke.Color = CH_COLOR_STROKE
    l_stroke.Thickness = 1
    l_stroke.Transparency = 0.6
    l_stroke.Parent = line
    ch_lines[name] = line
end

local ch_charge = Instance.new("Frame")
ch_charge.Size = UDim2.new(0, 0, 0, 2)
ch_charge.AnchorPoint = Vector2.new(0.5, 1)
ch_charge.Position = UDim2.new(0.5, 0, 0.5, -30)
ch_charge.BackgroundColor3 = Color3.fromRGB(255, 200, 60)
ch_charge.BorderSizePixel = 0
ch_charge.Visible = false
ch_charge.ZIndex = 12
ch_charge.Parent = crosshairGui
local ch_charge_max = 80

local function update_crosshair()
    if not T.aim_on_item then
        ch_dot.Visible = false
        ch_ring_outer.Visible = false
        ch_ring_inner.Visible = false
        for _, l in pairs(ch_lines) do l.Visible = false end
    else
        local mouse = UIS:GetMouseLocation()
        local vp = Camera.ViewportSize
        local relX = mouse.X / vp.X
        local relY = mouse.Y / vp.Y

        local col = CH_COLOR_HIT
        local pulse = 1 + math.sin(tick() * 6) * 0.08

        ch_ring_outer.Position = UDim2.new(relX, 0, relY, 0)
        ch_ring_outer.Size = UDim2.new(0, 26 * pulse, 0, 26 * pulse)
        ch_ring_outer_stroke.Color = col
        ch_ring_outer.Visible = true

        ch_ring_inner.Position = UDim2.new(relX, 0, relY, 0)
        ch_ring_inner.Size = UDim2.new(0, 14 * pulse, 0, 14 * pulse)
        ch_ring_inner_stroke.Color = col
        ch_ring_inner.Visible = true

        ch_dot.Position = UDim2.new(relX, 0, relY, 0)
        ch_dot.Size = UDim2.new(0, 3 * pulse, 0, 3 * pulse)
        ch_dot.BackgroundColor3 = col
        ch_dot.Visible = true

        local gap = 16
        local len = 7

        ch_lines.up.Size = UDim2.new(0, 1, 0, len)
        ch_lines.up.Position = UDim2.new(relX, 0, relY, -(gap + len/2))
        ch_lines.up.BackgroundColor3 = col
        ch_lines.up.Visible = true

        ch_lines.down.Size = UDim2.new(0, 1, 0, len)
        ch_lines.down.Position = UDim2.new(relX, 0, relY, (gap + len/2))
        ch_lines.down.BackgroundColor3 = col
        ch_lines.down.Visible = true

        ch_lines.left.Size = UDim2.new(0, len, 0, 1)
        ch_lines.left.Position = UDim2.new(relX, -(gap + len/2), relY, 0)
        ch_lines.left.BackgroundColor3 = col
        ch_lines.left.Visible = true

        ch_lines.right.Size = UDim2.new(0, len, 0, 1)
        ch_lines.right.Position = UDim2.new(relX, (gap + len/2), relY, 0)
        ch_lines.right.BackgroundColor3 = col
        ch_lines.right.Visible = true
    end

    if T.charge_active then
        local mouse = UIS:GetMouseLocation()
        local vp = Camera.ViewportSize
        local relX = mouse.X / vp.X
        local relY = mouse.Y / vp.Y
        ch_charge.Visible = true
        ch_charge.Position = UDim2.new(relX, 0, relY, -30)
        local t = math.clamp((tick() - T.charge_start) / T.charge_max_time, 0, 1)
        ch_charge.Size = UDim2.new(0, ch_charge_max * t, 0, 2)
        ch_charge.BackgroundColor3 = Color3.fromRGB(255, 100 + 100 * t, 60 - 40 * t)
    else
        ch_charge.Visible = false
    end
end

local function hide_crosshair()
    ch_dot.Visible = false
    ch_ring_outer.Visible = false
    ch_ring_inner.Visible = false
    ch_charge.Visible = false
    for _, l in pairs(ch_lines) do l.Visible = false end
end

-- ============================================================
-- HIT MARKER (3 варианта)
-- ============================================================
local hitMarkerGui = Instance.new("ScreenGui")
hitMarkerGui.Name = "TOTEM_HITMARKER"
hitMarkerGui.ResetOnSpawn = false
hitMarkerGui.IgnoreGuiInset = true
hitMarkerGui.DisplayOrder = 1000000
hitMarkerGui.Parent = playerGui

local hitSound = Instance.new("Sound")
hitSound.SoundId = "rbxassetid://9125402735"
hitSound.Volume = 0.5
hitSound.Parent = hitMarkerGui

local hit_marker_root = Instance.new("Frame")
hit_marker_root.Size = UDim2.new(0, 60, 0, 60)
hit_marker_root.AnchorPoint = Vector2.new(0.5, 0.5)
hit_marker_root.Position = UDim2.new(0.5, 0, 0.5, 0)
hit_marker_root.BackgroundTransparency = 1
hit_marker_root.Visible = false
hit_marker_root.Parent = hitMarkerGui

-- THROW
local hm_throw = Instance.new("Frame")
hm_throw.Size = UDim2.new(1, 0, 1, 0)
hm_throw.BackgroundTransparency = 1
hm_throw.Parent = hit_marker_root

local throw_lines = {}
for i, ang in ipairs({45, -45}) do
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, 2, 0, 16)
    line.AnchorPoint = Vector2.new(0.5, 0.5)
    line.Position = UDim2.new(0.5, 0, 0.5, 0)
    line.Rotation = ang
    line.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    line.BorderSizePixel = 0
    line.Parent = hm_throw
    throw_lines[i] = line
end

-- ROCKET
local hm_rocket = Instance.new("Frame")
hm_rocket.Size = UDim2.new(1, 0, 1, 0)
hm_rocket.BackgroundTransparency = 1
hm_rocket.Parent = hit_marker_root

local rocket_core = Instance.new("Frame")
rocket_core.Size = UDim2.new(0, 10, 0, 10)
rocket_core.AnchorPoint = Vector2.new(0.5, 0.5)
rocket_core.Position = UDim2.new(0.5, 0, 0.5, 0)
rocket_core.BackgroundColor3 = Color3.fromRGB(255, 120, 30)
rocket_core.BorderSizePixel = 0
rocket_core.Parent = hm_rocket
local rocket_core_c = Instance.new("UICorner")
rocket_core_c.CornerRadius = UDim.new(1, 0)
rocket_core_c.Parent = rocket_core

local rocket_ring = Instance.new("Frame")
rocket_ring.Size = UDim2.new(0, 14, 0, 14)
rocket_ring.AnchorPoint = Vector2.new(0.5, 0.5)
rocket_ring.Position = UDim2.new(0.5, 0, 0.5, 0)
rocket_ring.BackgroundTransparency = 1
rocket_ring.Parent = hm_rocket
local rocket_ring_c = Instance.new("UICorner")
rocket_ring_c.CornerRadius = UDim.new(1, 0)
rocket_ring_c.Parent = rocket_ring
local rocket_ring_s = Instance.new("UIStroke")
rocket_ring_s.Color = Color3.fromRGB(255, 160, 60)
rocket_ring_s.Thickness = 2
rocket_ring_s.Parent = rocket_ring

-- ORBIT
local hm_orbit = Instance.new("Frame")
hm_orbit.Size = UDim2.new(1, 0, 1, 0)
hm_orbit.BackgroundTransparency = 1
hm_orbit.Parent = hit_marker_root

local orbit_lines = {}
for _, name in ipairs({"up", "down", "left", "right"}) do
    local line = Instance.new("Frame")
    line.Name = name
    line.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
    line.BorderSizePixel = 0
    line.AnchorPoint = Vector2.new(0.5, 0.5)
    line.Parent = hm_orbit
    orbit_lines[name] = line
end

local hit_mode = "throw"
local hit_time = 0
local hit_visible = false

local function show_hit_marker(mode)
    hit_mode = mode or "throw"
    hit_time = tick()
    hit_visible = true
    hit_marker_root.Visible = true

    hm_throw.Visible = (hit_mode == "throw")
    hm_rocket.Visible = (hit_mode == "rocket")
    hm_orbit.Visible = (hit_mode == "orbit")

    pcall(function()
        hitSound:Stop()
        hitSound:Play()
    end)
end

local function update_hit_marker()
    if not hit_visible then return end

    local elapsed = tick() - hit_time
    local dur = 0.35
    if elapsed > dur then
        hit_visible = false
        hit_marker_root.Visible = false
        return
    end

    local t = elapsed / dur

    if hit_mode == "throw" then
        local spread = 4 + t * 14
        local len = 14 + t * 6

        throw_lines[1].Size = UDim2.new(0, 2, 0, len)
        throw_lines[1].Position = UDim2.new(0.5, spread, 0.5, spread)
        throw_lines[1].BackgroundTransparency = t

        throw_lines[2].Size = UDim2.new(0, 2, 0, len)
        throw_lines[2].Position = UDim2.new(0.5, spread, 0.5, -spread)
        throw_lines[2].BackgroundTransparency = t

    elseif hit_mode == "rocket" then
        local core_size = 10 + t * 12
        rocket_core.Size = UDim2.new(0, core_size, 0, core_size)
        rocket_core.BackgroundTransparency = t * 0.6

        local ring_size = 14 + t * 40
        rocket_ring.Size = UDim2.new(0, ring_size, 0, ring_size)
        rocket_ring_s.Transparency = t

    elseif hit_mode == "orbit" then
        local spread = 5 + t * 18
        local len = 8

        orbit_lines.up.Size = UDim2.new(0, 2, 0, len)
        orbit_lines.up.Position = UDim2.new(0.5, 0, 0.5, -(spread + len/2))
        orbit_lines.up.BackgroundTransparency = t

        orbit_lines.down.Size = UDim2.new(0, 2, 0, len)
        orbit_lines.down.Position = UDim2.new(0.5, 0, 0.5, (spread + len/2))
        orbit_lines.down.BackgroundTransparency = t

        orbit_lines.left.Size = UDim2.new(0, len, 0, 2)
        orbit_lines.left.Position = UDim2.new(0.5, -(spread + len/2), 0.5, 0)
        orbit_lines.left.BackgroundTransparency = t

        orbit_lines.right.Size = UDim2.new(0, len, 0, 2)
        orbit_lines.right.Position = UDim2.new(0.5, (spread + len/2), 0.5, 0)
        orbit_lines.right.BackgroundTransparency = t
    end
end

-- ============================================================
-- ТРАЕКТОРИЯ
-- ============================================================
local trajGui = Instance.new("ScreenGui")
trajGui.Name = "TOTEM_TRAJ"
trajGui.ResetOnSpawn = false
trajGui.IgnoreGuiInset = true
trajGui.DisplayOrder = 999997
trajGui.Parent = playerGui

local trajDots = {}
for i = 1, 24 do
    local d = Instance.new("Frame")
    d.Size = UDim2.new(0, 4, 0, 4)
    d.AnchorPoint = Vector2.new(0.5, 0.5)
    d.BackgroundColor3 = MATRIX_GREEN
    d.BorderSizePixel = 0
    d.Visible = false
    d.ZIndex = 5
    d.Parent = trajGui
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = d
    trajDots[i] = d
end

local function hide_trajectory()
    for _, d in ipairs(trajDots) do d.Visible = false end
end

update_trajectory = function()
    if #T.grabbed_list == 0 then
        hide_trajectory()
        return
    end

    local tgt_head = get_target_head and get_target_head() or nil
    local start_part = T.grabbed_list[1].part
    if not start_part or not start_part.Parent then
        hide_trajectory()
        return
    end

    local pos = start_part.Position
    local charge_mult = 1.0
    if T.charge_active then
        charge_mult = T.charge_min_mult
            + (T.charge_max_mult - T.charge_min_mult)
            * math.clamp((tick() - T.charge_start) / T.charge_max_time, 0, 1)
    end
    local speed = T.throw_speed * charge_mult

    local vel
    if tgt_head then
        vel = (tgt_head.Position - pos).Unit * speed
    else
        vel = Camera.CFrame.LookVector * speed
    end

    local g = Workspace.Gravity
    local dt = 0.05
    local t = 0

    for i = 1, #trajDots do
        t = t + dt
        local p = pos + vel * t + Vector3.new(0, -0.5 * g * t * t, 0)

        local screen, onscreen = Camera:WorldToViewportPoint(p)
        local dot = trajDots[i]

        if onscreen and screen.Z > 0 then
            dot.Position = UDim2.new(0, screen.X, 0, screen.Y)
            dot.Visible = true
            dot.BackgroundTransparency = (i / #trajDots) * 0.7
            dot.Size = UDim2.new(0, math.max(2, 5 - i * 0.15), 0, math.max(2, 5 - i * 0.15))
        else
            dot.Visible = false
        end
    end
end

-- ============================================================
-- ИНФО-ПАНЕЛЬ
-- ============================================================
local infoGui = Instance.new("ScreenGui")
infoGui.Name = "TOTEM_INFO"
infoGui.ResetOnSpawn = false
infoGui.IgnoreGuiInset = true
infoGui.DisplayOrder = 999998
infoGui.Parent = playerGui

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(0, 230, 0, 290)
infoFrame.Position = UDim2.new(1, -245, 0, 15)
infoFrame.Parent = infoGui
apply_matrix_theme(infoFrame, { padding = 10, corner = 4 })

local infoTitle = Instance.new("TextLabel")
infoTitle.Size = UDim2.new(1, 0, 0, 18)
infoTitle.Position = UDim2.new(0, 0, 0, 0)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = "> TOTEM_HUB"
infoTitle.TextSize = 12
infoTitle.TextXAlignment = Enum.TextXAlignment.Left
infoTitle.ZIndex = 3
infoTitle.Parent = infoFrame
style_label(infoTitle, MATRIX_GREEN, true)

local infoSub = Instance.new("TextLabel")
infoSub.Size = UDim2.new(1, 0, 0, 12)
infoSub.Position = UDim2.new(0, 0, 0, 18)
infoSub.BackgroundTransparency = 1
infoSub.Text = "// people the game"
infoSub.TextSize = 10
infoSub.TextXAlignment = Enum.TextXAlignment.Left
infoSub.ZIndex = 3
infoSub.Parent = infoFrame
style_label(infoSub, MATRIX_GREEN_DIM, false)

local infoSep = Instance.new("Frame")
infoSep.Size = UDim2.new(1, 0, 0, 1)
infoSep.Position = UDim2.new(0, 0, 0, 34)
infoSep.BackgroundColor3 = MATRIX_GREEN
infoSep.BackgroundTransparency = 0.6
infoSep.BorderSizePixel = 0
infoSep.ZIndex = 3
infoSep.Parent = infoFrame

local function createInfoLine(y, labelText)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 14)
    label.Position = UDim2.new(0, 0, 0, y)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 3
    label.Parent = infoFrame
    style_label(label, MATRIX_GREEN_DIM, false)
    return label
end

local infoGrabbed = createInfoLine(42, "grabbed:  —")
local infoCount   = createInfoLine(56, "count: 0")
local infoDist    = createInfoLine(70, "distance: —")
local infoFps     = createInfoLine(84, "fps: —")
local infoMulti   = createInfoLine(98, "multi-select: OFF")
local infoMode    = createInfoLine(112, "auto-return: OFF")
local infoHitbox  = createInfoLine(126, "hitboxes: OFF")
local infoOrbit   = createInfoLine(140, "orbit: OFF")
local infoStick   = createInfoLine(154, "stick: OFF")
local infoFreeze  = createInfoLine(168, "freeze: OFF")
local infoNoclip  = createInfoLine(182, "no-collide: OFF")
local infoForm    = createInfoLine(196, "formation: column")
local infoTarget  = createInfoLine(210, "target: —")
local infoFace    = createInfoLine(224, "face: OFF")
local infoShield  = createInfoLine(238, "shield: OFF")

-- ============================================================
-- LOG ПАНЕЛЬ
-- ============================================================
local logGui = Instance.new("ScreenGui")
logGui.Name = "TOTEM_LOG"
logGui.ResetOnSpawn = false
logGui.IgnoreGuiInset = true
logGui.DisplayOrder = 999996
logGui.Parent = playerGui

local logFrame = Instance.new("Frame")
logFrame.Size = UDim2.new(0, 260, 0, 130)
logFrame.Position = UDim2.new(0, 15, 1, -145)
logFrame.Parent = logGui
apply_matrix_theme(logFrame, { padding = 10, corner = 4 })

local logTitle = Instance.new("TextLabel")
logTitle.Size = UDim2.new(1, 0, 0, 14)
logTitle.Position = UDim2.new(0, 0, 0, 0)
logTitle.BackgroundTransparency = 1
logTitle.Text = "> LOG"
logTitle.TextSize = 11
logTitle.TextXAlignment = Enum.TextXAlignment.Left
logTitle.ZIndex = 3
logTitle.Parent = logFrame
style_label(logTitle, MATRIX_GREEN, true)

local logLabels = {}
for i = 1, 7 do
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 13)
    label.Position = UDim2.new(0, 0, 0, 18 + (i - 1) * 13)
    label.BackgroundTransparency = 1
    label.Text = ""
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 3
    label.Parent = logFrame
    style_label(label, MATRIX_GREEN_DIM, false)
    logLabels[i] = label
end

task.spawn(function()
    while not T.unloaded do
        local count = #T.action_log
        for i = 1, 7 do
            local entry = T.action_log[count - 7 + i]
            if entry then
                local age = tick() - entry.time
                logLabels[i].Text = "> " .. entry.text
                logLabels[i].TextTransparency = math.min(age / 8, 0.8)
            else
                logLabels[i].Text = ""
            end
        end
        task.wait(0.1)
    end
end)

-- ============================================================
-- ПАНЕЛЬ БИНДОВ
-- ============================================================
local bindsGui = Instance.new("ScreenGui")
bindsGui.Name = "TOTEM_BINDS"
bindsGui.ResetOnSpawn = false
bindsGui.IgnoreGuiInset = true
bindsGui.DisplayOrder = 999997
bindsGui.Parent = playerGui

local bindsFrame = Instance.new("Frame")
bindsFrame.Size = UDim2.new(0, 230, 0, 460)
bindsFrame.Position = UDim2.new(1, -245, 0, 320)
bindsFrame.Parent = bindsGui
apply_matrix_theme(bindsFrame, { padding = 10, corner = 4 })

local bindsTitle = Instance.new("TextLabel")
bindsTitle.Size = UDim2.new(1, 0, 0, 16)
bindsTitle.Position = UDim2.new(0, 0, 0, 0)
bindsTitle.BackgroundTransparency = 1
bindsTitle.Text = "> BINDS"
bindsTitle.TextSize = 11
bindsTitle.TextXAlignment = Enum.TextXAlignment.Left
bindsTitle.ZIndex = 3
bindsTitle.Parent = bindsFrame
style_label(bindsTitle, MATRIX_GREEN, true)

local BIND_LIST = {
    {"E", "grab / release"},
    {"G", "release all"},
    {"Q", "throw (hold=charge)"},
    {"T", "recall all"},
    {"X", "explode"},
    {"Z", "teleport to item"},
    {"Y", "face mode"},
    {"Num/", "shield mode"},
    {"Num0", "freeze"},
    {"N", "no-collide"},
    {"End", "auto-return"},
    {"Del", "hitboxes"},
    {"L", "stick mode (sphere)"},
    {"Num1", "orbit mode"},
    {"Num3", "multi-select"},
    {"B", "formation cycle"},
    {"K", "target-lock"},
    {"J", "cycle target"},
    {"Num+", "rocket launch"},
    {"RAlt", "panel toggle"},
    {"[", "distance -"},
    {"]", "distance +"},
    {"Insert", "unload"},
}

for i, bind_info in ipairs(BIND_LIST) do
    local key = bind_info[1]
    local desc = bind_info[2]
    local y = 22 + (i - 1) * 15

    local keyLabel = Instance.new("TextLabel")
    keyLabel.Size = UDim2.new(0, 60, 0, 14)
    keyLabel.Position = UDim2.new(0, 0, 0, y)
    keyLabel.BackgroundTransparency = 1
    keyLabel.Text = key
    keyLabel.TextSize = 10
    keyLabel.TextXAlignment = Enum.TextXAlignment.Left
    keyLabel.ZIndex = 3
    keyLabel.Parent = bindsFrame
    style_label(keyLabel, MATRIX_GREEN, true)

    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -65, 0, 14)
    descLabel.Position = UDim2.new(0, 65, 0, y)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextSize = 10
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.ZIndex = 3
    descLabel.Parent = bindsFrame
    style_label(descLabel, MATRIX_GREEN_DIM, false)
end

-- ============================================================
-- ИНФО ЦИКЛ
-- ============================================================
task.spawn(function()
    while not T.unloaded do
        local count = #T.grabbed_list

        if count > 0 then
            infoCount.Text = "count: " .. count
            infoCount.TextColor3 = MATRIX_GREEN

            if count == 1 then
                infoGrabbed.Text = "grabbed: " .. T.grabbed_list[1].model.Name
            else
                infoGrabbed.Text = "grabbed: " .. count .. " items"
            end
            infoGrabbed.TextColor3 = MATRIX_GREEN

            local char = get_char()
            local my_head = char and char:FindFirstChild("Head")
            if my_head and T.grabbed_list[1].part and T.grabbed_list[1].part.Parent then
                local dist = math.floor((my_head.Position - T.grabbed_list[1].part.Position).Magnitude)
                infoDist.Text = "distance: " .. dist .. " studs"
            else
                infoDist.Text = "distance: —"
            end
            infoDist.TextColor3 = MATRIX_GREEN
        else
            infoGrabbed.Text = "grabbed: —"
            infoCount.Text = "count: 0"
            infoDist.Text = "distance: —"
            infoGrabbed.TextColor3 = MATRIX_GREEN_DIM
            infoCount.TextColor3 = MATRIX_GREEN_DIM
            infoDist.TextColor3 = MATRIX_GREEN_DIM
        end

        infoFps.Text = "fps: " .. math.floor(T.fps)
        infoFps.TextColor3 = T.fps >= 50 and MATRIX_GREEN or MATRIX_GREEN_DIM

        local function bool_line(lbl, name, on)
            lbl.Text = name .. ": " .. (on and "ON" or "OFF")
            lbl.TextColor3 = on and MATRIX_GREEN or MATRIX_GREEN_DIM
        end

        bool_line(infoMulti,  "multi-select", T.multi_select)
        bool_line(infoMode,   "auto-return",  T.auto_return)
        bool_line(infoHitbox, "hitboxes",     T.show_hitboxes)
        bool_line(infoOrbit,  "orbit",        T.orbit_mode)
        bool_line(infoStick,  "stick",        T.stick_mode)
        bool_line(infoFreeze, "freeze",       T.freeze_mode)
        bool_line(infoNoclip, "no-collide",   T.no_collide)
        bool_line(infoFace,   "face",         T.face_mode)
        bool_line(infoShield, "shield",       T.shield_mode)

        infoForm.Text = "formation: " .. T.formation
        infoForm.TextColor3 = MATRIX_GREEN

        if T.target_lock and T.target_player then
            infoTarget.Text = "target: " .. T.target_player.Name
            infoTarget.TextColor3 = MATRIX_GREEN
        else
            infoTarget.Text = "target: —"
            infoTarget.TextColor3 = MATRIX_GREEN_DIM
        end

        task.wait(0.1)
    end
end)

-- ============================================================
-- FPS COUNTER
-- ============================================================
task.spawn(function()
    while not T.unloaded do
        T.frame_count = T.frame_count + 1
        local now = tick()
        if now - T.fps_time >= 1 then
            T.fps = T.frame_count / (now - T.fps_time)
            T.frame_count = 0
            T.fps_time = now
        end
        task.wait()
    end
end)

-- ============================================================
-- ОПРЕДЕЛЕНИЕ ПРЕДМЕТА
-- ============================================================
local function get_item_part(model)
    if not model then return nil end
    if model:IsA("Tool") then
        local h = model:FindFirstChild("Handle") or model:FindFirstChild("Primary")
        if h and h:IsA("BasePart") then return h end
    end
    local p = model:FindFirstChild("Primary") or model:FindFirstChild("Handle")
    if p and p:IsA("BasePart") then return p end
    for _, v in ipairs(model:GetChildren()) do
        if v:IsA("BasePart") then return v end
    end
    return nil
end

local function is_attached_to_character(model)
    if not model then return false end
    local parent = model.Parent
    while parent and parent ~= Workspace do
        if Players:GetPlayerFromCharacter(parent) then return true end
        if parent:IsA("Backpack") then return true end
        parent = parent.Parent
    end
    return false
end

local function is_item(model)
    if not model or not model:IsA("Model") then return false end
    if Players:GetPlayerFromCharacter(model) then return false end
    if model.Name:find("TOTEM_HITBOX") then return false end
    if is_attached_to_character(model) then return false end

    if model:FindFirstChild("Primary") or model:FindFirstChild("Handle") then return true end
    local name = model.Name:lower()
    if name:find("gun") or name:find("knife") or name:find("shotgun")
       or name:find("pistol") or name:find("rifle") or name:find("ammo")
       or name:find("shell") or name:find("box") or name:find("shovel")
       or name:find("can") or name:find("radio") then
        for _, v in ipairs(model:GetChildren()) do
            if v:IsA("BasePart") then return true end
        end
    end
    return false
end

local function is_weapon_model(model)
    if not model then return false end
    local handle = model:FindFirstChild("Handle") or model:FindFirstChild("Primary")
    if not handle then return false end
    if handle:FindFirstChild("FirePos") or handle:FindFirstChild("GripPosition")
       or handle:FindFirstChild("AimPosition") or handle:FindFirstChild("PointerPos")
       or handle:FindFirstChild("AdditionalGrip") then return true end
    return false
end

-- ============================================================
-- ХИТБОКСЫ
-- ============================================================
local function create_hitbox_wrapper(model)
    if not model then return end
    if is_attached_to_character(model) then return end

    local part = get_item_part(model)
    if not part then return end
    if T.hitbox_wrappers[part] then return end

    local wrapper = Instance.new("Part")
    wrapper.Name = "TOTEM_HITBOX"
    wrapper.Size = part.Size * T.hitbox_scale
    wrapper.CFrame = part.CFrame
    wrapper.Anchored = false
    wrapper.CanCollide = false
    wrapper.CanQuery = true
    wrapper.CanTouch = false
    wrapper.Transparency = 1
    wrapper.Massless = true
    wrapper.CastShadow = false
    wrapper.Material = Enum.Material.SmoothPlastic
    wrapper.Parent = Workspace

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = wrapper
    weld.Part1 = part
    weld.Parent = wrapper

    T.hitbox_wrappers[part] = wrapper
end

local function refresh_hitboxes()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model")
           and not Players:GetPlayerFromCharacter(obj)
           and not obj.Name:find("TOTEM_HITBOX") then

            local name_lower = obj.Name:lower()
            local is_map = name_lower:find("visual") or name_lower:find("clip")
                or name_lower:find("lightingfix") or name_lower:find("floorcollision")
                or name_lower:find("spawnpoint") or name_lower:find("spawn")
                or name_lower:find("fx") or name_lower:find("rain")
                or name_lower:find("dust") or name_lower:find("terrain")
                or name_lower:find("map") or name_lower:find("base")
                or name_lower:find("ground") or name_lower:find("wall")
                or name_lower:find("ceiling") or name_lower:find("itemzone")
                or name_lower:find("lootboxzone")

            if not is_map then
                if not is_attached_to_character(obj) then
                    local is_weapon = is_item(obj)
                    local has_primary = obj:FindFirstChild("Primary") ~= nil
                    local has_handle = obj:FindFirstChild("Handle") ~= nil
                    local weapon_marker = is_weapon_model(obj)

                    if is_weapon or has_primary or has_handle or weapon_marker then
                        local part = get_item_part(obj)
                        if part and part.Size.Magnitude < 30 then
                            create_hitbox_wrapper(obj)
                        end
                    end
                end
            end
        end
    end

    for part, wrapper in pairs(T.hitbox_wrappers) do
        if not part.Parent or not wrapper.Parent then
            pcall(function() wrapper:Destroy() end)
            T.hitbox_wrappers[part] = nil
        end
    end
end

-- ============================================================
-- ВИЗУАЛИЗАЦИЯ ХИТБОКСОВ
-- ============================================================
local function clear_hitbox_visuals()
    for part, data in pairs(T.hitbox_visuals) do
        if data.visual and data.visual.Parent then
            pcall(function() data.visual:Destroy() end)
        end
    end
    T.hitbox_visuals = {}
end

local function rebuild_hitbox_visuals()
    clear_hitbox_visuals()
    if not T.show_hitboxes then return end

    for part, wrapper in pairs(T.hitbox_wrappers) do
        if wrapper and wrapper.Parent then
            if not is_attached_to_character(part.Parent) then
                local visual = Instance.new("Part")
                visual.Name = "TOTEM_HITBOX_VIS"
                visual.Size = wrapper.Size
                visual.CFrame = wrapper.CFrame
                visual.Anchored = true
                visual.CanCollide = false
                visual.CanQuery = false
                visual.CanTouch = false
                visual.Material = Enum.Material.SmoothPlastic
                visual.Color = Color3.fromRGB(128, 128, 128)
                visual.Transparency = 0.6
                visual.CastShadow = false
                visual.Parent = Workspace

                T.hitbox_visuals[part] = { visual = visual }
            end
        end
    end
end

local function update_hitbox_visuals()
    if not T.show_hitboxes then return end
    for part, data in pairs(T.hitbox_visuals) do
        local wrapper = T.hitbox_wrappers[part]
        if wrapper and wrapper.Parent and data.visual and data.visual.Parent then
            data.visual.Size = wrapper.Size
            data.visual.CFrame = wrapper.CFrame
        else
            if data.visual and data.visual.Parent then
                pcall(function() data.visual:Destroy() end)
            end
            T.hitbox_visuals[part] = nil
        end
    end
end

-- ============================================================
-- ФОРМАЦИИ
-- ============================================================
local MULTIPOINT_OFFSETS = {
    Vector3.new( 0,  0, 0),
    Vector3.new( 1,  1, 1),
    Vector3.new(-1,  1, 1),
    Vector3.new( 1, -1, 1),
    Vector3.new(-1, -1, 1),
    Vector3.new( 2,  2, 2),
    Vector3.new(-2,  2, 2),
    Vector3.new( 2, -2, 2),
    Vector3.new(-2, -2, 2),
}

local FACE_POINTS = {
    Vector3.new(-2,  2, 0),
    Vector3.new( 2,  2, 0),
    Vector3.new(-2,  0, 0),
    Vector3.new(-1, -1, 0),
    Vector3.new( 0, -1.5, 0),
    Vector3.new( 1, -1, 0),
    Vector3.new( 2,  0, 0),
    Vector3.new( 0,  3.5, 0),
    Vector3.new(-3,  1.5, 0),
    Vector3.new( 3,  1.5, 0),
}

get_formation_offset = function(i, count, base_cf)
    local f = T.formation

    if f == "column" then
        return Vector3.new(0, (i - 1) * 1.2, 0)

    elseif f == "wall" then
        local w = T.formation_wall_w
        local col = (i - 1) % w
        local row = math.floor((i - 1) / w)
        return Vector3.new(
            (col - (w - 1) / 2) * 2,
            row * 2,
            0
        )

    elseif f == "ring" then
        local r = T.formation_ring_radius
        local a = ((i - 1) / math.max(count, 1)) * math.pi * 2
        return Vector3.new(math.cos(a) * r, 0, math.sin(a) * r)

    elseif f == "cube" then
        local side = math.max(1, math.ceil(count ^ (1/3)))
        local x = (i - 1) % side
        local y = math.floor((i - 1) / side) % side
        local z = math.floor((i - 1) / (side * side))
        local c = (side - 1) / 2
        return Vector3.new((x - c) * 2, (y - c) * 2, (z - c) * 2)

    elseif f == "multi" then
        return MULTIPOINT_OFFSETS[((i - 1) % #MULTIPOINT_OFFSETS) + 1]

    elseif f == "face" then
        return FACE_POINTS[((i - 1) % #FACE_POINTS) + 1]

    else
        return Vector3.new(0, (i - 1) * 1.2, 0)
    end
end

-- ============================================================
-- ТОЧКА УДЕРЖАНИЯ
-- ============================================================
local function get_hold_target()
    local char = get_char()
    if char then
        local head = char:FindFirstChild("Head")
            or char:FindFirstChild("UpperTorso")
            or char:FindFirstChild("HumanoidRootPart")
        if head then
            local look = Camera.CFrame.LookVector
            look = Vector3.new(look.X, 0, look.Z)
            if look.Magnitude > 0.1 then
                look = look.Unit
            else
                look = head.CFrame.LookVector
            end
            return head.Position + look * T.hold_distance
        end
    end
    return Camera.CFrame.Position + Camera.CFrame.LookVector * T.hold_distance
end

-- ============================================================
-- ПОИСК ПОД ВЗГЛЯДОМ
-- ============================================================
local function find_item_under_crosshair(max_dist)
    max_dist = max_dist or 500
    local ray = Ray.new(Camera.CFrame.Position, Camera.CFrame.LookVector * max_dist)
    local ignore = {}
    if get_char() then table.insert(ignore, get_char()) end

    local hit = Workspace:FindPartOnRayWithIgnoreList(ray, ignore)
    if not hit then return nil end

    if hit.Name == "TOTEM_HITBOX" then
        for part, wrapper in pairs(T.hitbox_wrappers) do
            if wrapper == hit then
                if is_attached_to_character(part.Parent) then return nil end
                local model = part:FindFirstAncestorOfClass("Model")
                if model then return model end
                local tool = part:FindFirstAncestorOfClass("Tool")
                if tool then return tool end
            end
        end
    end

    if is_attached_to_character(hit) then
        return nil
    end

    local tool = hit:FindFirstAncestorOfClass("Tool")
    if tool then
        if is_attached_to_character(tool) then return nil end
        return tool
    end

    local model = hit:FindFirstAncestorOfClass("Model")
    while model and model ~= Workspace do
        if is_item(model) then return model end
        model = model:FindFirstAncestorOfClass("Model")
    end
    return nil
end

-- ============================================================
-- ЦЕЛЬ
-- ============================================================
get_target_head = function()
    if not T.target_lock then return nil end
    local plr = T.target_player
    if not plr or not plr.Character then return nil end
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if hum and hum.Health <= 0 then return nil end
    return plr.Character:FindFirstChild("Head")
end

-- ============================================================
-- ХИТ-МАРКЕР проверка (3 режима)
-- ============================================================
local function check_hit_marker()
    local grab_mode_active = T.orbit_mode or T.stick_mode or T.shield_mode or T.face_mode

    -- rocket
    for _, item in ipairs(T.last_thrown_list) do
        local part = item.part
        if part and part.Parent and item.rocket then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    for _, bp in ipairs(plr.Character:GetChildren()) do
                        if bp:IsA("BasePart") then
                            local d = (part.Position - bp.Position).Magnitude
                            if d < (part.Size.Magnitude / 2 + bp.Size.Magnitude / 2 + 1) then
                                show_hit_marker("rocket")
                                item.rocket = false
                                return
                            end
                        end
                    end
                end
            end
        end
    end

    -- orbit/stick/shield/face
    if grab_mode_active then
        for _, item in ipairs(T.grabbed_list) do
            local part = item.part
            if part and part.Parent then
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LP and plr.Character then
                        for _, bp in ipairs(plr.Character:GetChildren()) do
                            if bp:IsA("BasePart") then
                                local d = (part.Position - bp.Position).Magnitude
                                if d < (part.Size.Magnitude / 2 + bp.Size.Magnitude / 2 + 1) then
                                    show_hit_marker("orbit")
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    -- throw
    for _, item in ipairs(T.last_thrown_list) do
        local part = item.part
        if part and part.Parent and not item.rocket then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    for _, bp in ipairs(plr.Character:GetChildren()) do
                        if bp:IsA("BasePart") then
                            local d = (part.Position - bp.Position).Magnitude
                            if d < (part.Size.Magnitude / 2 + bp.Size.Magnitude / 2 + 1) then
                                show_hit_marker("throw")
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end

-- ============================================================
-- ЗАХВАТ
-- ============================================================
local function grab()
    T.return_in_progress = false

    if not T.multi_select and #T.grabbed_list == 1 and not T.orbit_mode then
        for _, item in ipairs(T.grabbed_list) do
            if item.part and item.part.Parent then
                item.part.AssemblyLinearVelocity = Vector3.zero
                item.part.AssemblyAngularVelocity = Vector3.zero

                local wrapper = T.hitbox_wrappers[item.part]
                if wrapper and wrapper.Parent then
                    wrapper.CanQuery = true
                end

                if T.freeze_mode then
                    local orig_anch = T.original_anchored[item.part]
                    if orig_anch ~= nil and item.part.Parent then
                        item.part.Anchored = orig_anch
                    end
                    T.original_anchored[item.part] = nil
                    T.original_velocity[item.part] = nil
                end

                if T.no_collide or T.grabbed_noclip then
                    restore_one_collide(item.part)
                end

                restore_item_physics(item.part)
                detach_trail(item.part)
            end
        end

        clear_highlight()
        T.grabbed_list = {}
        T.return_in_progress = false
        log_action("released (E)")
        print("[T-F] отпущено (E)")
        return
    end

    local model = find_item_under_crosshair()
    if not model then
        print("[T-F] предмет не найден")
        return
    end

    if is_attached_to_character(model) then
        print("[T-F] оружие в руках — пропуск")
        return
    end

    if not T.multi_select and #T.grabbed_list > 0 then
        for _, item in ipairs(T.grabbed_list) do
            if item.part and item.part.Parent then
                item.part.AssemblyLinearVelocity = Vector3.zero
                item.part.AssemblyAngularVelocity = Vector3.zero

                local wrapper = T.hitbox_wrappers[item.part]
                if wrapper and wrapper.Parent then
                    wrapper.CanQuery = true
                end

                if T.freeze_mode then
                    local orig_anch = T.original_anchored[item.part]
                    if orig_anch ~= nil and item.part.Parent then
                        item.part.Anchored = orig_anch
                    end
                    T.original_anchored[item.part] = nil
                    T.original_velocity[item.part] = nil
                end

                if T.no_collide or T.grabbed_noclip then
                    restore_one_collide(item.part)
                end

                restore_item_physics(item.part)
                detach_trail(item.part)
            end
        end
        clear_highlight()
        T.grabbed_list = {}
    end

    if T.multi_select then
        for _, item in ipairs(T.grabbed_list) do
            if item.model == model then
                print("[T-F] уже схвачено")
                return
            end
        end
    end

    local part = get_item_part(model)
    if not part then return end

    if T.anchor_skip_list[part] and tick() - T.anchor_skip_list[part] < 3 then
        print("[T-F] пропуск (недавно был anchor-protected)")
        return
    end

    table.insert(T.grabbed_list, {
        model = model,
        part = part,
    })

    local wrapper = T.hitbox_wrappers[part]
    if wrapper and wrapper.Parent then
        wrapper.CanQuery = false
    end

    apply_item_physics(part)

    if T.grabbed_noclip then
        local root = part.AssemblyRootPart or part
        local parts_to_disable = {}
        pcall(function()
            for _, p in ipairs(root:GetConnectedParts(true)) do
                if p:IsA("BasePart") then parts_to_disable[p] = true end
            end
        end)
        parts_to_disable[root] = true
        parts_to_disable[part] = true

        for p in pairs(parts_to_disable) do
            if T.original_collide[p] == nil then
                T.original_collide[p] = p.CanCollide
            end
            pcall(function() p.CanCollide = false end)
        end

        T.grabbed_assembly[part] = root
    end

    if T.no_collide then
        if T.original_collide[part] == nil then
            T.original_collide[part] = part.CanCollide
        end
        part.CanCollide = false
    end

    if T.freeze_mode then
        T.original_anchored[part] = part.Anchored
        T.original_velocity[part] = {
            linear = part.AssemblyLinearVelocity,
            angular = part.AssemblyAngularVelocity,
        }
        part.Anchored = true
    end

    add_highlight(model)
    log_action("grabbed " .. model.Name)
    print("[T-F] схвачен", model.Name, "| всего:", #T.grabbed_list)
end

release_all = function()
    if T.orbit_mode then
        print("[T-F] orbit mode активен — отпуск заблокирован")
        return
    end

    if #T.grabbed_list == 0 then
        print("[T-F] нечего отпускать")
        return
    end

    local cnt = #T.grabbed_list

    for _, item in ipairs(T.grabbed_list) do
        if item.part and item.part.Parent then
            item.part.AssemblyLinearVelocity = Vector3.zero
            item.part.AssemblyAngularVelocity = Vector3.zero

            local wrapper = T.hitbox_wrappers[item.part]
            if wrapper and wrapper.Parent then
                wrapper.CanQuery = true
            end

            if T.freeze_mode then
                local orig_anch = T.original_anchored[item.part]
                if orig_anch ~= nil and item.part.Parent then
                    item.part.Anchored = orig_anch
                end
                T.original_anchored[item.part] = nil
                T.original_velocity[item.part] = nil
            end

            if T.no_collide or T.grabbed_noclip then
                restore_one_collide(item.part)
            end

            restore_item_physics(item.part)
            detach_trail(item.part)
        end
    end

    clear_highlight()
    T.grabbed_list = {}
    T.return_in_progress = false
    log_action("released " .. cnt .. " items")
    print("[T-F] отпущено всё")
end

-- ============================================================
-- ВЗРЫВ
-- ============================================================
local function explode()
    if #T.grabbed_list == 0 then
        print("[T-F] нечего взрывать")
        return
    end

    local cnt = #T.grabbed_list
    for _, item in ipairs(T.grabbed_list) do
        if item.part and item.part.Parent then
            if T.freeze_mode then
                item.part.Anchored = false
            end

            if T.no_collide or T.grabbed_noclip then
                restore_one_collide(item.part)
            end

            restore_item_physics(item.part)

            attach_trail(item.part, "throw", 0.3)
            task.delay(0.8, function() detach_trail(item.part) end)

            local random_dir = Vector3.new(
                math.random(-100, 100),
                math.random(50, 150),
                math.random(-100, 100)
            ).Unit

            item.part.AssemblyLinearVelocity = random_dir * 300
            item.part.AssemblyAngularVelocity = Vector3.new(
                math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)
            )

            local wrapper = T.hitbox_wrappers[item.part]
            if wrapper and wrapper.Parent then
                wrapper.CanQuery = true
            end
        end
    end

    T.grabbed_list = {}
    clear_highlight()
    T.original_anchored = {}
    T.original_velocity = {}
    T.original_collide = {}
    T.grabbed_assembly = {}
    log_action("exploded " .. cnt .. " items")
    print("[T-F] взрыв:", cnt)
end

-- ============================================================
-- ТЕЛЕПОРТ К ПОСЛЕДНЕМУ БРОШЕННОМУ
-- ============================================================
local function teleport_to_last()
    if not T.last_thrown_list or #T.last_thrown_list == 0 then
        print("[T-F] нет брошенных предметов")
        return
    end

    local last = T.last_thrown_list[#T.last_thrown_list]
    if not last or not last.part or not last.part.Parent then
        print("[T-F] последний брошенный исчез")
        return
    end

    local char = get_char()
    if not char then return end

    pcall(function()
        char:PivotTo(CFrame.new(last.part.Position + Vector3.new(0, 3, 0)))
    end)

    log_action("teleported to item")
    print("[T-F] телепорт к предмету")
end

-- ============================================================
-- БРОСОК
-- ============================================================
throw = function(charge_mult)
    if #T.grabbed_list == 0 then return end
    charge_mult = charge_mult or 1.0
    local speed = T.throw_speed * charge_mult

    T.last_thrown_list = {}
    local cnt = #T.grabbed_list
    local tgt_head = get_target_head()

    for _, item in ipairs(T.grabbed_list) do
        if item.part and item.part.Parent then
            if T.freeze_mode then
                item.part.Anchored = false
                T.original_anchored[item.part] = nil
                T.original_velocity[item.part] = nil
            end

            restore_item_physics(item.part)

            if T.no_collide or T.grabbed_noclip then
                restore_one_collide(item.part)
            end

            local dir
            if tgt_head then
                dir = (tgt_head.Position - item.part.Position).Unit
            else
                dir = Camera.CFrame.LookVector
            end

            attach_trail(item.part, "throw", 0.5)
            task.delay(1.5, function() detach_trail(item.part) end)

            item.part.AssemblyLinearVelocity = dir * speed
            item.part.AssemblyAngularVelocity = Vector3.new(
                math.random(-50, 50), math.random(-50, 50), math.random(-50, 50)
            )

            local wrapper = T.hitbox_wrappers[item.part]
            if wrapper and wrapper.Parent then
                wrapper.CanQuery = true
            end

            table.insert(T.last_thrown_list, item)
        end
    end

    T.grabbed_list = {}
    clear_highlight()
    T.original_anchored = {}
    T.original_velocity = {}
    T.original_collide = {}
    T.grabbed_assembly = {}

    log_action("threw " .. cnt .. " x" .. string.format("%.2f", charge_mult) .. (tgt_head and " (locked)" or ""))
    print("[T-F] брошено:", cnt, "| множитель:", string.format("%.2f", charge_mult))

    if T.auto_return and #T.last_thrown_list > 0 then
        task.delay(T.auto_return_delay, function()
            if T.unloaded then return end
            if #T.grabbed_list == 0 and #T.last_thrown_list > 0 then
                T.return_in_progress = true
                log_action("auto-return start")
                print("[T-F] авто-возврат")
            end
        end)
    end
end

local function recall_last()
    if not T.last_thrown_list or #T.last_thrown_list == 0 then
        print("[T-F] нечего возвращать")
        return
    end
    T.return_in_progress = true
    log_action("recall " .. #T.last_thrown_list .. " items")
    print("[T-F] возврат")
end

-- ============================================================
-- CHARGE HELPERS
-- ============================================================
local function start_charge()
    T.charge_active = true
    T.charge_start = tick()
end

local function get_charge_mult()
    if not T.charge_active then return 1.0 end
    local t = math.clamp((tick() - T.charge_start) / T.charge_max_time, 0, 1)
    return T.charge_min_mult + (T.charge_max_mult - T.charge_min_mult) * t
end

local function release_charge()
    if not T.charge_active then return end
    local mult = get_charge_mult()
    T.charge_active = false
    throw(mult)
end

-- ============================================================
-- РАКЕТА
-- ============================================================
local function launch_rocket()
    if os.clock() < T.rocket_cooldown then
        print("[T-F] ракета на кд")
        return
    end

    if #T.grabbed_list == 0 then
        print("[T-F] возьми предмет для ракеты")
        return
    end

    local item = T.grabbed_list[1]
    local part = item.part
    if not part or not part.Parent then return end

    local tgt_head = get_target_head()
    local dir
    if tgt_head then
        dir = (tgt_head.Position - part.Position).Unit
    else
        dir = Camera.CFrame.LookVector
    end

    print("[T-F] rocket | part:", part:GetFullName())

    if T.freeze_mode then part.Anchored = false end
    part.Anchored = false
    restore_item_physics(part)
    part.CanCollide = true
    part.CanTouch = true
    part.CanQuery = true
    part.Massless = false

    part.AssemblyLinearVelocity = dir * T.rocket_speed
    part.AssemblyAngularVelocity = Vector3.zero

    local saved_auto_return = T.auto_return
    T.auto_return = false

    for i, it in ipairs(T.grabbed_list) do
        if it.part == part then
            table.remove(T.grabbed_list, i)
            it.rocket = true
            table.insert(T.last_thrown_list, it)
            break
        end
    end
    remove_highlight(item.model)

    attach_trail(part, "rocket", 0.4)

    local hb_conn
    local finished = false
    local elapsed = 0

    local function cleanup()
        if finished then return end
        finished = true
        if hb_conn then hb_conn:Disconnect() end
        detach_trail(part, 0.3)
        T.auto_return = saved_auto_return
    end

    local function do_hit(plr, hrp, hum)
        if finished then return end
        print("[T-F] rocket HIT:", plr.Name)

        show_hit_marker("rocket")

        pcall(function()
            hrp.AssemblyLinearVelocity = dir * 120 + Vector3.new(0, 60, 0)
        end)
        pcall(function()
            hum:ChangeState(Enum.HumanoidStateType.Physics)
        end)

        cleanup()
    end

    hb_conn = RunService.Heartbeat:Connect(function(dt)
        if finished then return end
        if not part or not part.Parent then
            cleanup()
            return
        end

        elapsed = elapsed + dt
        if elapsed > 5 then
            cleanup()
            return
        end

        local speed_now = part.AssemblyLinearVelocity.Magnitude
        local step = math.max(speed_now * dt, 5)

        local origin = part.Position
        local ray_dir = part.AssemblyLinearVelocity
        if ray_dir.Magnitude < 0.1 then
            ray_dir = dir
        else
            ray_dir = ray_dir.Unit
        end

        local ray_params = RaycastParams.new()
        ray_params.FilterType = Enum.RaycastFilterType.Exclude
        ray_params.FilterDescendantsInstances = { LP.Character, part }
        ray_params.IgnoreWater = true

        local result = Workspace:Raycast(origin, ray_dir * step, ray_params)
        if result and result.Instance then
            local hit_model = result.Instance:FindFirstAncestorOfClass("Model")
            if hit_model then
                local plr = Players:GetPlayerFromCharacter(hit_model)
                if plr and plr ~= LP then
                    local hum = hit_model:FindFirstChildOfClass("Humanoid")
                    local hrp = hit_model:FindFirstChild("HumanoidRootPart")
                    if hum and hrp then
                        do_hit(plr, hrp, hum)
                        return
                    end
                end
            end
        end

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                if hrp and hum then
                    local d = (part.Position - hrp.Position).Magnitude
                    if d < 4 then
                        do_hit(plr, hrp, hum)
                        return
                    end
                end
            end
        end
    end)

    table.insert(T.conns, hb_conn)
    task.delay(5, cleanup)

    T.rocket_cooldown = os.clock() + 1.0
    log_action("rocket launched")
    print("[T-F] ракета запущена | speed:", T.rocket_speed)
end

-- ============================================================
-- ЦИКЛ
-- ============================================================
bind(RunService.RenderStepped, function()
    if T.unloaded then return end

    T.aim_on_item = find_item_under_crosshair() ~= nil
    update_crosshair()
    update_hitbox_visuals()
    update_hit_marker()
    update_trajectory()
    check_hit_marker()

    if T.freeze_mode and #T.grabbed_list > 0 then
        for _, item in ipairs(T.grabbed_list) do
            if item.part and item.part.Parent and not item.part.Anchored then
                item.part.Anchored = true
            end
        end
    end

    -- grabbed_noclip: переприменяем на всю сборку каждый кадр
    if T.grabbed_noclip and #T.grabbed_list > 0 then
        for _, item in ipairs(T.grabbed_list) do
            local part = item.part
            if part and part.Parent then
                local root = T.grabbed_assembly[part] or part.AssemblyRootPart
                if root then
                    pcall(function()
                        for _, p in ipairs(root:GetConnectedParts(true)) do
                            if p:IsA("BasePart") and p.CanCollide then
                                p.CanCollide = false
                            end
                        end
                        if root.CanCollide then root.CanCollide = false end
                    end)
                end
                if part.CanCollide then part.CanCollide = false end
            end
        end
    end

    if T.no_collide and #T.grabbed_list > 0 then
        for _, item in ipairs(T.grabbed_list) do
            if item.part and item.part.Parent and item.part.CanCollide then
                item.part.CanCollide = false
            end
        end
    end

    if #T.grabbed_list > 0 then
        for i = #T.grabbed_list, 1, -1 do
            local item = T.grabbed_list[i]
            if not item.part or not item.part.Parent then
                restore_item_physics(item.part)
                remove_highlight(item.model)
                table.remove(T.grabbed_list, i)
            elseif is_attached_to_character(item.part.Parent) then
                restore_item_physics(item.part)
                remove_highlight(item.model)
                table.remove(T.grabbed_list, i)
            end
        end

        if #T.grabbed_list == 0 then
            clear_highlight()
            return
        end

        T.orbit_angle = T.orbit_angle + T.orbit_speed

        if T.shield_mode then
            local char = get_char()
            local my_hrp = char and char:FindFirstChild("HumanoidRootPart")
            if my_hrp then
                local count = #T.grabbed_list
                local shield_angle = tick() * T.shield_speed

                for i, item in ipairs(T.grabbed_list) do
                    if item.part and item.part.Parent and not item.part.Anchored then
                        local n = i
                        local total = math.max(count, 1)
                        local phi = math.acos(1 - 2 * (n - 0.5) / total)
                        local theta = math.pi * (1 + 5 ^ 0.5) * (n - 1) + shield_angle

                        local off = Vector3.new(
                            math.sin(phi) * math.cos(theta),
                            math.cos(phi),
                            math.sin(phi) * math.sin(theta)
                        ) * T.shield_radius

                        local shield_target = my_hrp.Position + off
                        local dir = shield_target - item.part.Position
                        local dist = dir.Magnitude

                        if dist > 0.5 then
                            local speed = math.min(dist * T.pull_speed * 2, 500)
                            item.part.AssemblyLinearVelocity = dir.Unit * speed
                        else
                            item.part.AssemblyLinearVelocity = Vector3.zero
                        end
                        item.part.AssemblyAngularVelocity = Vector3.zero
                    end
                end
            end
            return
        end

        if T.stick_mode then
            local target = get_hold_target()
            local leader = T.grabbed_list[1]
            local count = #T.grabbed_list

            if leader and leader.part and leader.part.Parent and not leader.part.Anchored then
                local dir = target - leader.part.Position
                local dist = dir.Magnitude
                if dist > T.grab_deadzone then
                    local speed = math.min(dist * T.pull_speed, 300)
                    leader.part.AssemblyLinearVelocity = dir.Unit * speed
                else
                    if leader.part.AssemblyLinearVelocity.Magnitude > 2 then
                        leader.part.AssemblyLinearVelocity = Vector3.zero
                    end
                end
                leader.part.AssemblyAngularVelocity = Vector3.zero

                local sphere_r = 2 + count * 0.35
                for i = 2, count do
                    local item = T.grabbed_list[i]
                    if item.part and item.part.Parent and not item.part.Anchored then
                        local n = i - 1
                        local total = math.max(count - 1, 1)
                        local phi = math.acos(1 - 2 * (n - 0.5) / total)
                        local theta = math.pi * (1 + 5 ^ 0.5) * (n - 1)

                        local off = Vector3.new(
                            math.sin(phi) * math.cos(theta),
                            math.cos(phi),
                            math.sin(phi) * math.sin(theta)
                        ) * sphere_r

                        local rot = CFrame.Angles(0, T.orbit_angle * 0.6, 0)
                        off = rot:VectorToWorldSpace(off)

                        local sphere_target = target + off
                        local ldir = sphere_target - item.part.Position
                        local ldist = ldir.Magnitude

                        if ldist > 1 then
                            local speed = math.min(ldist * T.pull_speed, 300)
                            item.part.AssemblyLinearVelocity = ldir.Unit * speed
                        else
                            if item.part.AssemblyLinearVelocity.Magnitude > 2 then
                                item.part.AssemblyLinearVelocity = Vector3.zero
                            end
                        end
                        item.part.AssemblyAngularVelocity = Vector3.zero
                    end
                end
            end

        elseif T.orbit_mode then
            local char = get_char()
            local my_head = char and char:FindFirstChild("Head")

            if my_head then
                local count = #T.grabbed_list
                for i, item in ipairs(T.grabbed_list) do
                    if item.part and item.part.Parent and not item.part.Anchored then
                        local angle = T.orbit_angle + (i / count) * math.pi * 2
                        local orbit_target = my_head.Position + Vector3.new(
                            math.cos(angle) * T.orbit_radius,
                            1 + math.sin(T.orbit_angle + i * 0.5) * 1.5,
                            math.sin(angle) * T.orbit_radius
                        )

                        local dir = orbit_target - item.part.Position
                        local dist = dir.Magnitude
                        if dist > 1 then
                            local speed = math.min(dist * T.pull_speed, 300)
                            item.part.AssemblyLinearVelocity = dir.Unit * speed
                        else
                            if item.part.AssemblyLinearVelocity.Magnitude > 2 then
                                item.part.AssemblyLinearVelocity = Vector3.zero
                            end
                        end
                        item.part.AssemblyAngularVelocity = Vector3.zero
                    end
                end
            end

        else
            local target = get_hold_target()

            for i, item in ipairs(T.grabbed_list) do
                if item.part and item.part.Parent and not item.part.Anchored then
                    local offset = get_formation_offset(i, #T.grabbed_list, Camera.CFrame)
                    local item_target = target + offset

                    local dir = item_target - item.part.Position
                    local dist = dir.Magnitude

                    if dist > T.grab_deadzone then
                        local speed = math.min(dist * T.pull_speed, 300)
                        item.part.AssemblyLinearVelocity = dir.Unit * speed
                        item.part.AssemblyAngularVelocity = Vector3.zero
                    else
                        if item.part.AssemblyLinearVelocity.Magnitude > 2 then
                            item.part.AssemblyLinearVelocity = Vector3.zero
                        end
                        if item.part.AssemblyAngularVelocity.Magnitude > 2 then
                            item.part.AssemblyAngularVelocity = Vector3.zero
                        end
                    end
                end
            end
        end

        return
    end

    if T.return_in_progress and T.last_thrown_list and #T.last_thrown_list > 0 then
        local target = get_hold_target()

        if #T.last_thrown_list >= 2 then
            local count = 0
            for i = #T.last_thrown_list, 1, -1 do
                local item = T.last_thrown_list[i]
                if not item.part or not item.part.Parent then
                    table.remove(T.last_thrown_list, i)
                else
                    pcall(function()
                        item.part.CFrame = CFrame.new(target + Vector3.new(
                            math.random(-1, 1) * 0.5,
                            count * 0.6,
                            math.random(-1, 1) * 0.5
                        ))
                    end)
                    item.part.AssemblyLinearVelocity = Vector3.zero
                    item.part.AssemblyAngularVelocity = Vector3.zero

                    local wrapper = T.hitbox_wrappers[item.part]
                    if wrapper and wrapper.Parent then
                        wrapper.CanQuery = false
                    end

                    apply_item_physics(item.part)

                    if T.grabbed_noclip or T.no_collide then
                        local root = item.part.AssemblyRootPart or item.part
                        local parts_to_disable = {}
                        pcall(function()
                            for _, p in ipairs(root:GetConnectedParts(true)) do
                                if p:IsA("BasePart") then parts_to_disable[p] = true end
                            end
                        end)
                        parts_to_disable[root] = true
                        parts_to_disable[item.part] = true
                        for p in pairs(parts_to_disable) do
                            if T.original_collide[p] == nil then
                                T.original_collide[p] = p.CanCollide
                            end
                            pcall(function() p.CanCollide = false end)
                        end
                        T.grabbed_assembly[item.part] = root
                    end

                    add_highlight(item.model)
                    detach_trail(item.part, 0.3)

                    table.insert(T.grabbed_list, item)
                    table.remove(T.last_thrown_list, i)
                    count = count + 1
                end
            end

            T.return_in_progress = false
            log_action("recalled " .. count .. " (instant)")
            print("[T-F] возврат (мгновенный):", count)
            return
        end

        for i = #T.last_thrown_list, 1, -1 do
            local item = T.last_thrown_list[i]
            if not item.part or not item.part.Parent then
                table.remove(T.last_thrown_list, i)
            else
                local dir = target - item.part.Position
                local dist = dir.Magnitude

                if dist < T.grab_deadzone then
                    table.insert(T.grabbed_list, item)
                    table.remove(T.last_thrown_list, i)

                    local wrapper = T.hitbox_wrappers[item.part]
                    if wrapper and wrapper.Parent then
                        wrapper.CanQuery = false
                    end

                    apply_item_physics(item.part)

                    if T.grabbed_noclip or T.no_collide then
                        local root = item.part.AssemblyRootPart or item.part
                        local parts_to_disable = {}
                        pcall(function()
                            for _, p in ipairs(root:GetConnectedParts(true)) do
                                if p:IsA("BasePart") then parts_to_disable[p] = true end
                            end
                        end)
                        parts_to_disable[root] = true
                        parts_to_disable[item.part] = true
                        for p in pairs(parts_to_disable) do
                            if T.original_collide[p] == nil then
                                T.original_collide[p] = p.CanCollide
                            end
                            pcall(function() p.CanCollide = false end)
                        end
                        T.grabbed_assembly[item.part] = root
                    end

                    add_highlight(item.model)
                    detach_trail(item.part, 0.3)
                else
                    if not active_trails[item.part] then
                        attach_trail(item.part, "recall", 0.3)
                    end
                    local speed = math.min(dist * T.pull_speed, T.return_speed)
                    item.part.AssemblyLinearVelocity = dir.Unit * speed
                    item.part.AssemblyAngularVelocity = Vector3.zero
                end
            end
        end

        if #T.last_thrown_list == 0 then
            T.return_in_progress = false
            log_action("recalled all")
            print("[T-F] всё возвращено")
        end
    end
end)

bind(RunService.Heartbeat, function()
    if T.unloaded then return end
    refresh_hitboxes()
    if T.show_hitboxes then
        rebuild_hitbox_visuals()
    end
end)

LP.CharacterRemoving:Connect(function()
    clear_highlight()
    detach_all_trails()

    for _, item in ipairs(T.grabbed_list) do
        if item.part then restore_item_physics(item.part) end
    end
    for _, item in ipairs(T.last_thrown_list) do
        if item.part then restore_item_physics(item.part) end
    end

    T.grabbed_list = {}
    T.last_thrown_list = {}
    T.return_in_progress = false
    T.original_anchored = {}
    T.original_velocity = {}
    T.original_collide = {}
    T.grabbed_assembly = {}
end)

-- ============================================================
-- ВЫГРУЗКА
-- ============================================================
local function unload()
    if T.unloaded then return end
    T.unloaded = true

    clear_highlight()
    detach_all_trails()

    for _, item in ipairs(T.grabbed_list) do
        if item.part then
            if T.freeze_mode and item.part.Parent then
                item.part.Anchored = T.original_anchored[item.part] or false
            end
            if (T.no_collide or T.grabbed_noclip) and item.part.Parent then
                restore_one_collide(item.part)
            end
            restore_item_physics(item.part)
        end
    end
    for _, item in ipairs(T.last_thrown_list) do
        if item.part then restore_item_physics(item.part) end
    end

    T.grabbed_list = {}
    T.last_thrown_list = {}
    T.return_in_progress = false

    clear_hitbox_visuals()

    for part, wrapper in pairs(T.hitbox_wrappers) do
        if wrapper and wrapper.Parent then
            pcall(function() wrapper:Destroy() end)
        end
    end
    T.hitbox_wrappers = {}

    hide_crosshair()
    hide_trajectory()
    pcall(function() crosshairGui:Destroy() end)
    pcall(function() trajGui:Destroy() end)
    pcall(function() hitMarkerGui:Destroy() end)
    pcall(function() infoGui:Destroy() end)
    pcall(function() logGui:Destroy() end)
    pcall(function() bindsGui:Destroy() end)

    for _, c in ipairs(T.conns) do
        pcall(function() c:Disconnect() end)
    end
    T.conns = {}

    print("[T-F] unloaded")
end

-- ============================================================
-- БИНДЫ
-- ============================================================
refresh_hitboxes()
T.fps_time = tick()

local input_conn = UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if T.unloaded then return end
    local k = input.KeyCode

    if k == Enum.KeyCode.E then
        grab()

    elseif k == Enum.KeyCode.G then
        release_all()

    elseif k == Enum.KeyCode.Q then
        start_charge()

    elseif k == Enum.KeyCode.End then
        T.auto_return = not T.auto_return
        print("[T-F] Auto-return:", T.auto_return and "ON" or "OFF")

    elseif k == Enum.KeyCode.T then
        recall_last()

    elseif k == Enum.KeyCode.X then
        explode()

    elseif k == Enum.KeyCode.Z then
        teleport_to_last()

    elseif k == Enum.KeyCode.Y then
        T.face_mode = not T.face_mode
        if T.face_mode then
            T.stick_mode = false
            T.orbit_mode = false
            T.shield_mode = false
            T.formation = "face"
        end
        log_action("face " .. (T.face_mode and "ON" or "OFF"))
        print("[T-F] Face:", T.face_mode and "ON" or "OFF")

    elseif k == Enum.KeyCode.KeypadDivide then
        T.shield_mode = not T.shield_mode
        if T.shield_mode then
            T.stick_mode = false
            T.orbit_mode = false
            T.face_mode = false
        end
        log_action("shield " .. (T.shield_mode and "ON" or "OFF"))
        print("[T-F] Shield:", T.shield_mode and "ON" or "OFF")

    elseif k == Enum.KeyCode.KeypadZero then
        T.freeze_mode = not T.freeze_mode
        if T.freeze_mode then
            apply_freeze()
            log_action("freeze ON")
        else
            restore_freeze()
            log_action("freeze OFF")
        end
        print("[T-F] Freeze:", T.freeze_mode and "ON" or "OFF")

    elseif k == Enum.KeyCode.N then
        T.no_collide = not T.no_collide
        if T.no_collide then
            apply_no_collide()
            log_action("no-collide ON")
        else
            restore_collide()
            log_action("no-collide OFF")
        end
        print("[T-F] No-collide:", T.no_collide and "ON" or "OFF")

    elseif k == Enum.KeyCode.Delete then
        T.show_hitboxes = not T.show_hitboxes
        if T.show_hitboxes then
            rebuild_hitbox_visuals()
            print("[T-F] Hitboxes: ON")
        else
            clear_hitbox_visuals()
            print("[T-F] Hitboxes: OFF")
        end

    elseif k == Enum.KeyCode.L then
        T.stick_mode = not T.stick_mode
        if T.stick_mode then
            T.orbit_mode = false
            T.face_mode = false
            T.shield_mode = false
        end
        print("[T-F] Stick:", T.stick_mode, "| Orbit:", T.orbit_mode)

    elseif k == Enum.KeyCode.KeypadOne then
        T.orbit_mode = not T.orbit_mode
        if T.orbit_mode then
            T.stick_mode = false
            T.face_mode = false
            T.shield_mode = false
        end
        print("[T-F] Orbit:", T.orbit_mode, "| Stick:", T.stick_mode)

    elseif k == Enum.KeyCode.KeypadThree then
        T.multi_select = not T.multi_select
        print("[T-F] Multi-select:", T.multi_select and "ON" or "OFF")
        if not T.multi_select then
            for _, item in ipairs(T.grabbed_list) do
                if item.part and item.part.Parent then
                    item.part.AssemblyLinearVelocity = Vector3.zero
                    item.part.AssemblyAngularVelocity = Vector3.zero
                    local wrapper = T.hitbox_wrappers[item.part]
                    if wrapper and wrapper.Parent then
                        wrapper.CanQuery = true
                    end
                    restore_item_physics(item.part)
                    if T.no_collide or T.grabbed_noclip then
                        restore_one_collide(item.part)
                    end
                    detach_trail(item.part)
                end
            end
            clear_highlight()
            T.grabbed_list = {}
        end

    elseif k == Enum.KeyCode.B then
        local order = {"column", "wall", "ring", "cube", "multi", "face"}
        local idx = 1
        for i, v in ipairs(order) do
            if v == T.formation then idx = i break end
        end
        T.formation = order[(idx % #order) + 1]
        if T.formation == "face" then
            T.face_mode = true
        else
            T.face_mode = false
        end
        log_action("formation: " .. T.formation)
        print("[T-F] Formation:", T.formation)

    elseif k == Enum.KeyCode.K then
        T.target_lock = not T.target_lock
        if not T.target_lock then T.target_player = nil end
        log_action("target-lock " .. (T.target_lock and "ON" or "OFF"))
        print("[T-F] Target lock:", T.target_lock and "ON" or "OFF")

    elseif k == Enum.KeyCode.J then
        local plist = {}
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character and plr.Character:FindFirstChild("Head") then
                table.insert(plist, plr)
            end
        end
        if #plist == 0 then
            T.target_player = nil
            print("[T-F] нет целей")
        else
            local idx = 1
            for i, p in ipairs(plist) do
                if p == T.target_player then idx = i break end
            end
            T.target_player = plist[(idx % #plist) + 1]
            log_action("target: " .. T.target_player.Name)
            print("[T-F] target:", T.target_player.Name)
        end

    elseif k == Enum.KeyCode.KeypadPlus then
        launch_rocket()

    elseif k == Enum.KeyCode.RightAlt then
        infoFrame.Visible = not infoFrame.Visible
        bindsFrame.Visible = not bindsFrame.Visible
        logFrame.Visible = not logFrame.Visible
        print("[T-F] Info panel:", infoFrame.Visible and "ON" or "OFF")

    elseif k == Enum.KeyCode.LeftBracket then
        T.hold_distance = math.min(T.hold_distance + 2, 30)
        print("[T-F] Hold distance:", T.hold_distance)

    elseif k == Enum.KeyCode.RightBracket then
        T.hold_distance = math.max(T.hold_distance - 2, 3)
        print("[T-F] Hold distance:", T.hold_distance)

    elseif k == Enum.KeyCode.Insert then
        unload()
    end
end)
table.insert(T.conns, input_conn)

local input_end_conn = UIS.InputEnded:Connect(function(input, gpe)
    if T.unloaded then return end
    if input.KeyCode == Enum.KeyCode.Q then
        release_charge()
    end
end)
table.insert(T.conns, input_end_conn)

print("[T-F] Telekinesis HUB loaded")
print("E:grab G:release Q:throw(hold=charge) X:explode Z:tp Y:face Num/:shield Num0:freeze N:noclip T:recall Del:hitbox L:stick Num1:orbit Num3:multi B:formation K:lock J:target Num+:rocket RAlt:panel")