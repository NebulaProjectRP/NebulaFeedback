NebulaDamage = {}
NebulaDamage.History = {}

GibsPieces = {
}

GibsPieces[HITGROUP_HEAD] = {
    Bone = "ValveBiped.Bip01_Head1",
    Driver = "ValveBiped.Bip01_Spine4",
    Models = {},
    Gore = "models/mosi/fnv/props/character/headcap.mdl",
    Resolve = function(ragdoll, bone)
        if not IsValid(ragdoll) then return end
        local bone = ragdoll:LookupBone("ValveBiped.Bip01_Neck1")
        local pos, ang = ragdoll:GetBonePosition(bone)
        debugoverlay.Axis(pos, ang, 8, FrameTime() * 2, true)

    ang:RotateAroundAxis(ang:Right(), 40)
        //ang:RotateAroundAxis(ang:Forward(), 10)
        //ang:RotateAroundAxis(ang:Up(), 180)
        //debugoverlay.Axis(pos, ang, 4, FrameTime() * 2, true)
        pos = pos + ang:Up() * -3 + ang:Forward() * -2 + ang:Up() * 2
        return pos, ang
    end,
    DisableBones = {
        "ValveBiped.Bip01_Neck1",
        "ValveBiped.Bip01_Head1",
        "ValveBiped.Bip01_Spine4",
    }
}
for k = 1, 6 do
    GibsPieces[HITGROUP_HEAD].Models[k] = Model("models/mosi/fnv/props/gore/gorehead0" .. k .. ".mdl")
end

GibsPieces[HITGROUP_LEFTARM] = {
    Bone = "ValveBiped.Bip01_L_UpperArm",
    Driver = "ValveBiped.Bip01_L_UpperArm",
    Gore = "models/mosi/fnv/props/character/armcap.mdl",
    Models = {
        Model("models/mosi/fnv/props/gore/gorearm01.mdl"),
        Model("models/mosi/fnv/props/gore/gorearm02.mdl"),
        Model("models/mosi/fnv/props/gore/gorearm03.mdl"),
    },
    Resolve = function(ragdoll, bone)
        if not IsValid(ragdoll) then return end
        local pos, ang = ragdoll:GetBonePosition(bone)
        ang:RotateAroundAxis(ang:Forward(), 90)
        ang:RotateAroundAxis(ang:Right(), -90)
        return pos, ang
    end,
    DisableBones = {
        "ValveBiped.Bip01_L_Clavicle",
        "ValveBiped.Bip01_L_UpperArm",
        "ValveBiped.Bip01_L_Forearm",
        "ValveBiped.Bip01_L_Hand",
        "ValveBiped.Anim_Attachment_LH",
        "ValveBiped.Bip01_L_Elbow",
        "ValveBiped.Bip01_L_Ulna",
        "ValveBiped.Bip01_L_Shoulder",
        "ValveBiped.Bip01_L_Wrist"
    }
}

GibsPieces[HITGROUP_RIGHTARM] = {
    Bone = "ValveBiped.Bip01_R_UpperArm",
    Driver = "ValveBiped.Bip01_R_UpperArm",
    Gore = "models/mosi/fnv/props/character/armcap.mdl",
    Models = {
        Model("models/mosi/fnv/props/gore/gorearm01.mdl"),
        Model("models/mosi/fnv/props/gore/gorearm02.mdl"),
        Model("models/mosi/fnv/props/gore/gorearm03.mdl"),
    },
    Resolve = function(ragdoll, bone)
        if not IsValid(ragdoll) then return end
        local pos, ang = ragdoll:GetBonePosition(bone)
        ang:RotateAroundAxis(ang:Forward(), 90)
        ang:RotateAroundAxis(ang:Right(), -90)
        return pos, ang
    end,
    DisableBones = {
        "ValveBiped.Bip01_R_Clavicle",
        "ValveBiped.Bip01_R_UpperArm",
        "ValveBiped.Bip01_R_Forearm",
        "ValveBiped.Bip01_R_Hand",
        "ValveBiped.Anim_Attachment_RH",
        "ValveBiped.Bip01_R_Elbow",
        "ValveBiped.Bip01_R_Ulna",
        "ValveBiped.Bip01_R_Shoulder",
        "ValveBiped.Bip01_R_Wrist"
    }
}

for i = 0, 2 do
    table.insert(GibsPieces[HITGROUP_LEFTARM].DisableBones, "ValveBiped.Bip01_L_Finger" .. i .. "1")
    table.insert(GibsPieces[HITGROUP_LEFTARM].DisableBones, "ValveBiped.Bip01_L_Finger" .. i .. "2")
    table.insert(GibsPieces[HITGROUP_LEFTARM].DisableBones, "ValveBiped.Bip01_L_Finger" .. i)

    table.insert(GibsPieces[HITGROUP_RIGHTARM].DisableBones, "ValveBiped.Bip01_R_Finger" .. i .. "1")
    table.insert(GibsPieces[HITGROUP_RIGHTARM].DisableBones, "ValveBiped.Bip01_R_Finger" .. i .. "2")
    table.insert(GibsPieces[HITGROUP_RIGHTARM].DisableBones, "ValveBiped.Bip01_R_Finger" .. i)
end 
GibsPieces[HITGROUP_RIGHTLEG] = {
    Bone = "ValveBiped.Bip01_R_Thigh",
    Driver = "ValveBiped.Bip01_R_Calf",
    Gore = "models/mosi/fnv/props/character/legcap01.mdl",
    Models = {
        Model("models/mosi/fnv/props/gore/goreleg01.mdl"),
        Model("models/mosi/fnv/props/gore/goreleg02.mdl"),
        Model("models/mosi/fnv/props/gore/goreleg03.mdl"),
    },
    Resolve = function(ragdoll, bone)
        if not IsValid(ragdoll) then return end
        local pos, ang = ragdoll:GetBonePosition(bone)
        ang:RotateAroundAxis(ang:Forward(), 90)
        ang:RotateAroundAxis(ang:Right(), -90)
        return pos, ang
    end,
    DisableBones = {
        "ValveBiped.Bip01_R_Thigh",
        "ValveBiped.Bip01_R_Calf",
        "ValveBiped.Bip01_R_Foot",
        "ValveBiped.Bip01_R_Toe0",
    }
}

GibsPieces[HITGROUP_LEFTLEG] = {
    Bone = "ValveBiped.Bip01_L_Thigh",
    Driver = "ValveBiped.Bip01_L_Thigh",
    Gore = "models/mosi/fnv/props/character/legcap01.mdl",
    Models = {
        Model("models/mosi/fnv/props/gore/goreleg01.mdl"),
        Model("models/mosi/fnv/props/gore/goreleg02.mdl"),
        Model("models/mosi/fnv/props/gore/goreleg03.mdl"),
    },
    Resolve = function(ragdoll, bone)
        if not IsValid(ragdoll) then return end
        if not bone then return end
        local pos, ang = ragdoll:GetBonePosition(bone)
        ang:RotateAroundAxis(ang:Forward(), 90)
        ang:RotateAroundAxis(ang:Right(), -90)
        return pos, ang
    end,
    DisableBones = {
        "ValveBiped.Bip01_L_Thigh",
        "ValveBiped.Bip01_L_Calf",
        "ValveBiped.Bip01_L_Foot",
        "ValveBiped.Bip01_L_Toe0",
    }
}

GibsPieces[HITGROUP_CHEST] = {
    Bone = "ValveBiped.Bip01_Spine2",
    Driver = "ValveBiped.Bip01_Spine2",
    Models = {
        Model("models/mosi/fnv/props/gore/goretorso03.mdl"),
        Model("models/mosi/fnv/props/gore/goretorso02.mdl"),
        Model("models/mosi/fnv/props/gore/meatbit01.mdl"),
        Model("models/mosi/fnv/props/gore/meatbit02.mdl"),
        Model("models/mosi/fnv/props/gore/meatbit03.mdl"),
    }
}

GibsPieces[HITGROUP_STOMACH] = {
    Bone = "ValveBiped.Bip01_Spine1",
    Driver = "ValveBiped.Bip01_Spine2",
    Models = {
        Model("models/mosi/fnv/props/gore/goretorso05.mdl"),
        Model("models/mosi/fnv/props/gore/goreintestine.mdl"),
        Model("models/mosi/fnv/props/gore/gorehead01.mdl"),
        Model("models/mosi/fnv/props/gore/meatbit01.mdl"),
        Model("models/mosi/fnv/props/gore/meatbit02.mdl"),
        Model("models/mosi/fnv/props/gore/meatbit03.mdl"),
    }
}

function NebulaDamage:CreateEffect(ragdoll, hitgroup, explode)
    
    if (explode) then
        ragdoll:GetOwner().isExplode = nil
        for k, v in pairs(GibsPieces) do
            self:CreateEffect(ragdoll, k, false)
        end
        return
    end

    if not GibsPieces[hitgroup] then
        MsgN("[Gore] Invalid Hitgroup")
        return
    end

    local data = GibsPieces[hitgroup]

    if (data.DisableBones) then
        for k, v in pairs(data.DisableBones) do
            local boneID = ragdoll:LookupBone(v)
            if (!boneID) then continue end

            ragdoll:ManipulateBoneScale(boneID, Vector(0, 0, 0))
        end
        ragdoll:InvalidateBoneCache()

    end

    if (data.Gore) then
        local driverBone = ragdoll:LookupBone(data.Driver)
        if (not driverBone) then
            MsgN("[Gore] Missing driver bone")
            return
        end

        local goreModel = ClientsideModel(data.Gore)
        goreModel:SetParent(ragdoll)
        goreModel:SetLocalPos(Vector(0, 0, 0))
        goreModel.RenderOverride = function(s)
            local pos, ang = GibsPieces[hitgroup].Resolve(ragdoll, driverBone)
            if not pos then return end
            s:SetPos(pos)
            s:SetAngles(ang)
            s:DrawModel()
        end
    end

    local boneID = ragdoll:LookupBone(data.Bone)
    if (not boneID or boneID == -1) then return end
    local pos, ang = ragdoll:GetBonePosition(boneID)
    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), -60)

    for i = 1, #data.Models do
        local model = ents.CreateClientProp(GibsPieces[hitgroup].Models[i])
        model:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        model:SetPos(pos)
        model:SetAngles(ang)
        timer.Simple(0, function()
            if IsValid(model) and IsValid(model:GetPhysicsObject()) then
                model:GetPhysicsObject():Wake()
                model:GetPhysicsObject():SetMaterial("watermelon")
                model:GetPhysicsObject():ApplyForceCenter(VectorRand() * math.random(100, 200) + Vector(0, 0, 60))
            elseif IsValid(model) then
                model:Remove()
            end
        end)
        SafeRemoveEntityDelayed(model, math.random(4, 8))
    end
end

function NebulaDamage:DrawBodyPart(ent, ragdoll, neckBone)
    local pos, ang = ragdoll:GetBonePosition(neckBone)
    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), -90)
    pos = pos + ang:Up() * -1
    ent:SetPos(pos)
    ent:SetAngles(ang)
    ent:DrawModel()
end

hook.Add( "CreateClientsideRagdoll", "fade_out_corpses", function( entity, ragdoll )
    //NebulaDamage:CreateEffect(ragdoll, HITGROUP_LEFTARM)
    timer.Simple(0, function()
        if (entity.isExplode or (entity.lastHitGroup or 0) > 0) then
            NebulaDamage:CreateEffect(ragdoll, entity.lastHitGroup, entity.isExplode)
        end
    end)
end )

local shadow = Material("particle/particle_glow_04")
net.Receive("Nebula.Damage:Broadcast", function()
    local duration = net.ReadFloat()
    local totalDamage = net.ReadUInt(16)
    local hits = net.ReadUInt(12)
    local bullets = net.ReadUInt(16)

    local targets = {}
    local amount = net.ReadUInt(6)

    if IsValid(NebulaDamage.Panel) then
        NebulaDamage.Panel:Remove()
    end

    local pnl = vgui.Create("nebula.grid")
    NebulaDamage.Panel = pnl
    pnl:SetSize(math.max(256, 96 + amount * 64), 72)
    local x = ScrW() / 2 - pnl:GetWide() / 2
    pnl:SetPos(x, ScrH() - pnl:GetTall())
    pnl:SetAlpha(0)
    pnl:AlphaTo(255, .5, 0)
    pnl:MoveTo(x, ScrH() - 196, 0.5, 0, 0.5)
    pnl:MoveTo(x, ScrH(), 0.5, 5, 0.5, function()
        if IsValid(pnl) then
            pnl:Remove()
        end
    end)
    pnl:AlphaTo(0, .5, 5)
    pnl:SetGrid(amount, 3)

    for k = 1, amount do
        local ply = net.ReadEntity()
        local av = vgui.Create("DPanel", pnl)
        av:SetPosGrid(k - 1, 2, k, 3)
        av.Avatar = vgui.Create("AvatarImage", av)
        av.Avatar:SetPlayer(ply, 24)
        av.Avatar:SetSize(20, 20)
        av.Avatar:SetPos(0, 0)
        av.Damage = net.ReadUInt(16)
        av.Hits = net.ReadUInt(12)
        av.Paint = function(s, w, h)
            NebulaUI.Derma.TextEntry(0, 0, w, 48)
            local tx, _ = draw.SimpleText(s.Damage, NebulaUI:Font(16), 24, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText("(" .. (math.Round(s.Hits / hits, 2) * 100) .. "%)", NebulaUI:Font(16), 26 + tx, h / 2, Color(255, 255, 255, 50), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
    end

    pnl.Paint = function(s, w, h)
        NebulaUI.Derma.TextEntry(0, 0, w, 48)
        draw.SimpleText("Damage", NebulaUI:Font(16), w / 6, 2, Color(255, 255, 255, 100), 1, TEXT_ALIGN_TOP)
        draw.SimpleText(totalDamage, NebulaUI:Font(32), w / 6, 12, color_white, 1, TEXT_ALIGN_TOP)

        draw.SimpleText("Accuracy", NebulaUI:Font(16), w / 2, 2, Color(255, 255, 255, 100), 1, TEXT_ALIGN_TOP)
        draw.SimpleText(math.Round(hits / bullets, 2) * 100 .. "%", NebulaUI:Font(32), w / 2, 12, color_white, 1, TEXT_ALIGN_TOP)

        draw.SimpleText("Duration", NebulaUI:Font(16), w - w / 6, 2, Color(255, 255, 255, 100), 1, TEXT_ALIGN_TOP)
        draw.SimpleText(math.Round(duration, 1) .. "s", NebulaUI:Font(32), w - w / 6, 12, color_white, 1, TEXT_ALIGN_TOP)
    end

    pnl.OnRemove = function()
        if IsValid(NebulaUI.DeathPanel) then
            NebulaUI.DeathPanel:MoveTo(ScrW() / 2 - 128, ScrH() - 196, 0.5, 0)
        end
    end
    if IsValid(NebulaUI.DeathPanel) then
        NebulaUI.DeathPanel:MoveTo(ScrW() / 2 - 128, ScrH() - 196 - 72, 0.5, 0)
    end
    NebulaUI.DamageUI = pnl
end)

local handlers = 0
hook.Add("PostDrawTranslucentRenderables", "Nebula.Damage:ShowDamage", function()
    if (handlers <= 0) then return end
end)

local hitmark = Material("nebularp/ui/hitmark.vmt")
local skull = Material("nebularp/ui/skull.vmt")
local color_red = Color(255, 0, 0)
local dmgHistory = {}
hook.Add("HUDPaint", "Nebula.Damage:ShowDamage", function()
    if (handlers <= 0) then return end

    for target, dmginfos in pairs(NebulaDamage.History) do
        for i, data in pairs(dmginfos) do
            local exp = data.fatal and 1 or .3
            local life = (data.duration / data.max) * exp
            local power = data.max * (exp - life) * 200
            local origin = data.pos:ToScreen()
            surface.SetMaterial(hitmark)
            surface.SetDrawColor(ColorAlpha(data.fatal and color_red or color_white, 255 * life))
            surface.DrawTexturedRectRotated(origin.x - power - 8, origin.y - power - 8, 24, 24, 0)
            surface.DrawTexturedRectRotated(origin.x - power - 8, origin.y + power + 8, 24, 24, 90)
            surface.DrawTexturedRectRotated(origin.x + power + 8, origin.y + power + 8, 24, 24, 180)
            surface.DrawTexturedRectRotated(origin.x + power + 8, origin.y - power - 8, 24, 24, 270)

            draw.SimpleText(data.dmg, NebulaUI:Font(data.fatal and 28 or 16), origin.x + math.cos(RealTime() * 4 + data.step) * 8, origin.y - math.pow(data.step, 1.25) * 22, ColorAlpha(data.fatal and color_red or color_white, 255 * (data.duration / data.max)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            data.step = data.step + FrameTime() * (data.fatal and .5 or 2)
            data.duration = data.duration - FrameTime() * (data.fatal and .75 or 1)

            if (data.duration <= 0) then
                table.remove(dmginfos, i)
                handlers = handlers - 1
                if (table.Count(dmginfos) <= 0) then
                    NebulaDamage.History[target] = nil
                end
                continue
            end
        end
    end

    for target, amount in pairs(dmgHistory) do
        if not IsValid(target) then continue end
        if (amount <= 0 or not target:Alive()) then
            dmgHistory[target] = nil
            continue
        end

        local tr = util.TraceLine({
            start = LocalPlayer():EyePos(),
            endpos = target:EyePos(),
            filter = LocalPlayer()
        })

        if (tr.Entity == target) then
            local center = (target:GetPos() + target:OBBCenter()):ToScreen()
            draw.SimpleText(amount, NebulaUI:Font(32, true), center.x, center.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end)

sound.Add({
    name = "Body.Splash",
    sound = {"physics/flesh/flesh_bloody_break.wav",
    "physics/flesh/flesh_squishy_impact_hard3.wav",
    "physics/flesh/flesh_squishy_impact_hard2.wav",
    "physics/body/body_medium_break3.wav",
    "physics/body/body_medium_break4.wav",},
    volume = 1,
    level = 120,
})

net.Receive("Nebula.Damage:SendHitmark", function()
    EyePos()
    local ent = net.ReadEntity()
    local dmg = net.ReadUInt(16)
    local pos = net.ReadVector()
    local dmgType = net.ReadUInt(32)
    local hitgroup = net.ReadUInt(4)

    local hitSound = LocalPlayer():GetNWString("HitSound", "")

    handlers = handlers + 1
    local percent = math.Clamp(dmg / ent:GetMaxHealth(), 0, 1)
    local duration = .55 + 3 * percent

    if not NebulaDamage.History[ent] then
        NebulaDamage.History[ent] = {}
    end

    local isFatal = ent:Health() <= dmg

    local pl = LocalPlayer()
    if (dmg > ent:GetMaxHealth() / 2) then
        ent:EmitSound("Body.Splash")
        if (pl:Ping() > 150) then
            local dist = pl:GetPos():Distance(ent:GetPos()) < 128
            if (dist) then
                local baseFOV = pl:GetFOV()
                local extraFOV = baseFOV * -.3
                hook.Add("CalcView", "NebulaDamage.TempFOV", function(ply, ori, an, fov, zn)
                    if (extraFOV < 0) then
                        extraFOV = extraFOV + FrameTime() * 100
                        return {
                            origin = ori,
                            angles = an,
                            fov = baseFOV + extraFOV,
                            znear = zn
                        }
                    else
                        hook.Remove("CalcView", "NebulaDamage.TempFOV")
                    end
                end)
            end
        end
    end

    if (hitSound != "") then
        LocalPlayer():EmitSound("nebularp/hitsounds/" .. hitSound .. "_" .. (isFatal and 2 or 1) .. ".wav", 100, 100, .5, CHAN_AUTO)
    end
    if (isFatal) then
        LocalPlayer():EmitSound("physics/metal/metal_barrel_impact_hard6.wav")
        ent:EmitSound("Body.Splash")
        ent.lastHitGroup = hitgroup
        ent.isExplode = dmg >= 100
        if IsValid(NebulaDamage.KillPanel) then
            NebulaDamage.KillPanel.Kills = NebulaDamage.KillPanel.Kills + 1
            NebulaDamage.KillPanel.Name = ent:Nick()
            NebulaDamage.KillPanel.Health = 0
            NebulaDamage.KillPanel.Team = ent:Team()
            NebulaDamage.KillPanel:Stop()
            NebulaDamage.KillPanel:AlphaTo(0, .5, 2, function()
                NebulaDamage.KillPanel:Remove()
            end)
            return
        end
        local pnl = vgui.Create("DPanel")
        NebulaDamage.KillPanel = pnl
        pnl:SetSize(200, 56)
        pnl:SetPos(ScrW() / 2 - 100, ScrH() - 96)
        pnl:SetAlpha(0)
        pnl:AlphaTo(255, .5, 0)
        pnl.Name = ent:Nick()
        pnl.Health = 0
        pnl.Team = ent:Team()
        pnl.Kills = 1
        pnl.Paint = function(s, w, h)
            s.Health = math.Clamp(s.Health + 200 * FrameTime(), 0, 100)
            local per = s.Health / 100
            surface.SetMaterial(skull)
            surface.SetDrawColor(color_white)
            DisableClipping(true)
            local shift = w / 2 - (s.Kills / 2) * 32
            for k = 0, s.Kills - 1 do
                surface.DrawTexturedRectRotated(shift + k * 32 + 16 + 4 * (1 - per), 16 * (1 - per), 32, 32, 45 - 45 * per)
            end
            DisableClipping(false)

            surface.SetFont(NebulaUI:Font(24))
            local tx, ty = surface.GetTextSize("You've killed " .. s.Name)
            local ax, _ = draw.SimpleText("You've killed ", NebulaUI:Font(24), w / 2 - tx / 2, h - 8, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
            draw.SimpleText(s.Name, NebulaUI:Font(24), w / 2 - tx / 2 + ax, h - 8, team.GetColor(s.Team), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
            surface.SetDrawColor(color_white)
            surface.DrawRect(w / 2 - tx / 2 - 4, 22, tx + 8, 2)
        end
        pnl:MoveTo(ScrW() / 2 - 100, ScrH() - 256, .5, 0, -1, function()
            pnl:AlphaTo(0, .5, 2, function()
                pnl:Remove()
            end)
        end)
    end

    table.insert(NebulaDamage.History[ent], {
        dmg = dmg,
        fatal = isFatal,
        pos = pos,
        dmgType = dmgType,
        step = 0,
        duration = duration,
        max = duration,
    })

    dmgHistory[ent] = (dmgHistory[ent] or 0) + dmg
    timer.Create("DamageRestart" .. ent:SteamID64(), 5, 1, function()
        dmgHistory[ent] = 0
    end)
end)

net.Receive("Nebula.Damage:CreateRagdoll", function(l)
    local ply = net.ReadEntity()
    local vel = net.ReadVector()
    local hitgroup = net.ReadUInt(4)
    
    NebulaDamage:CreateRagdoll(ply, vel, hitgroup)
end)

net.Receive("Nebula.Damage:ArmorBroken", function(s)
    
    if IsValid(p_test) then
        if IsValid(p_test.mdl) then
            p_test.mdl:Remove()
        end
        if (p_test.particle) then
            p_test.particle:StopEmissionAndDestroyImmediately()
        end
        p_test:Remove()
    end

    p_test = vgui.Create("DPanel")
    p_test:ParentToHUD()
    p_test:SetSize(ScrW(), ScrH())
    p_test.mdl = ClientsideModel("models/hunter/blocks/cube025x025x025.mdl")
    p_test.mdl:SetNoDraw(true)
    p_test.particle = CreateParticleSystem(p_test.mdl, "suit_deplete_main", PATTACH_ABSORIGIN)
    p_test.particle:SetShouldDraw(false)
    p_test.Paint = function(s, w, h)
        cam.Start3D( Vector(-40, 0, 4), Angle(-0, 0, 0), 120, x, y, w, h, 5, 256 )
            if IsValid(s.particle) then
                DisableClipping(true)
                cam.IgnoreZ(true)
                s.particle:Render()
                cam.IgnoreZ(false)
                DisableClipping(false)
            end
        cam.End3D()
    end
    LocalPlayer():EmitSound("physics/glass/glass_largesheet_break" .. math.random(1, 3) .. ".wav", 60, 70, .4)
    timer.Simple(4, function()
        if IsValid(p_test) then
            p_test.particle:StopEmissionAndDestroyImmediately()
            p_test.mdl:Remove()
            p_test:Remove()
        end
    end)
end)