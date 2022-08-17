util.AddNetworkString("Nebula.Damage:Broadcast")
util.AddNetworkString("Nebula.Damage:CreateRagdoll")
util.AddNetworkString("Nebula.Damage:SendHitmark")
util.AddNetworkString("Nebula.Damage:ArmorBroken")

for k = 1, 6 do
    util.PrecacheModel("models/mosi/fnv/props/gore/gorehead0" .. k .. ".mdl")
end

NebulaDamage = {}
NebulaDamage.History = {}
NebulaDamage.TimestampDuration = 20

function NebulaDamage:HandleDamage(ent, dmg)
    local att = dmg:GetAttacker()
    if (!att:IsPlayer()) then return end
    if (att == ent) then return end

    net.Start("Nebula.Damage:SendHitmark")
    net.WriteEntity(ent)
    net.WriteUInt(dmg:GetDamage(), 16)
    net.WriteVector(dmg:GetDamagePosition())
    net.WriteUInt(dmg:GetDamageType(), 32)
    net.WriteUInt(ent:LastHitGroup(), 4)
    net.Send(att)

    if (!ent.AttackerHistory) then
        ent.AttackerHistory = {}
    end

    ent.AttackerHistory[att] = CurTime() + 15

    if (att:Ping() < 150) then
        if (dmg:GetDamage() >= ent:GetMaxHealth() / 2 and ent:EyePos():Distance(att:GetShootPos()) < 128) then
            local fov = att:GetFOV()
            att:SetFOV(fov - fov * .4, 0)
            timer.Simple(att:Ping() / 1000, function()
                att:SetFOV(0, .3)
            end)
        end
    end

    if (self.History[att]) then
        self.History[att].Damage = self.History[att].Damage + dmg:GetDamage()
        self.History[att].Hits = self.History[att].Hits + 1
        if not self.History[att].Targets[ent] then
            self.History[att].Targets[ent] = {
                Damage = dmg:GetDamage(),
                Hits = 1,
            }
        else
            self.History[att].Targets[ent].Damage = self.History[att].Targets[ent].Damage + dmg:GetDamage()
            self.History[att].Targets[ent].Hits = self.History[att].Targets[ent].Hits + 1
        end

        timer.Create("Nebula.Damage_" .. att:SteamID64() .. "_" .. ent:SteamID64(), self.TimestampDuration, 1, function()
            if (not IsValid(att) or not IsValid(ent)) then
                self.History[att] = nil
                return
            end
            
            NebulaDamage:Broadcast(att)
        end)
    end
end

function NebulaDamage:Broadcast(ply)
    local history = self.History[ply]
    if not history then return end
    net.Start("Nebula.Damage:Broadcast")
    net.WriteFloat(CurTime() - history.Timestamp)
    net.WriteUInt(history.Damage, 16)
    net.WriteUInt(history.Hits, 12)
    net.WriteUInt(history.Bullets, 16)
    //Write targets
    net.WriteUInt(table.Count(history.Targets), 6)
    for k, v in pairs(history.Targets) do
        net.WriteEntity(k)
        net.WriteUInt(v.Damage, 16)
        net.WriteUInt(v.Hits, 12)
    end
    net.Send(ply)

    if (history.Damage > 500) then
        ply:playSoundBank("godlike", true)
    end

    self.History[ply] = nil
end

hook.Add("PlayerDeathThink", "Gonzo", function(ply)
    if (ply:IsBot() and ply.fl_DeathTime < CurTime()) then
        ply:Spawn()
    end
    //return ply.fl_DeathTime < CurTime()
end)

hook.Add("PlayerDeath", "Nebula.Damage:Catcher", function(ply, inf, att)

    ply.fl_DeathTime = CurTime() + 60
    if NebulaDamage.History[ply] then
        NebulaDamage:Broadcast(ply)
    end

    for k, v in pairs(ply.AttackerHistory or {}) do
        if (IsValid(k) and v > CurTime()) then
            k:SetNWInt("Assists", k:GetNWInt("Assists") + 1)
        end
    end

    ply.AttackerHistory = {}

    if not att:IsPlayer() then return end
    if (ply == att) then return end

    att.lifeKills = (att.lifeKills or 0) + 1
    if (att.lifeKills == 3) then
        att:playSoundBank("triple")
    else
        att:playSoundBank("kill")
    end

    timer.Create(att:SteamID() .. "_restartKillspread", 10, 1, function()
        if IsValid(att) then
            att.lifeKills = 0
        end
    end)

    ply:playSoundBank("death")
    ply.lifeKills = 0
end)

hook.Add("EntityTakeDamage", "Nebula.Damage.Armor", function(ent)
    if (ent:IsPlayer()) then
        ent.has_armor = ent:Armor() > 0
    end
end)

hook.Add("PostEntityTakeDamage", "Nebula.Damage:Main", function(ent, dmg, took)
    if (!took or !ent:IsPlayer()) then return end
    if not IsValid(dmg:GetAttacker()) then return end
    NebulaDamage:HandleDamage(ent, dmg)
    ent:playSoundBank("damage")
    if (took and ent.has_armor and ent:Armor() <= 0) then
        net.Start("Nebula.Damage:ArmorBroken")
        net.Send(ent)
    end
end)

hook.Add("EntityFireBullets", "Nebula.Damage:HitRate", function(ent, data)
    if (!ent:IsPlayer()) then return end

    if not NebulaDamage.History[ent] then
        NebulaDamage.History[ent] = {
            Bullets = 1,
            Hits = 0,
            Damage = 0,
            Timestamp = CurTime(),
            Targets = {}
        }
    else
        NebulaDamage.History[ent].Bullets = NebulaDamage.History[ent].Bullets + 1
    end
end)