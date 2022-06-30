NebulaSound = NebulaSound or {}
NebulaSound.SoundBank = NebulaSound.SoundBank or {
    Hitmark = {},
    Vox = {}
}

if SERVER then
    util.AddNetworkString("NebulaSound.Play")
end

local causeDictionary = {
    damage = 10,
    kill = 5,
    death = 260,
    godlike = 60,
    melee = 200,
    weapon = 300,
    spawn = 400,
    triple = 0
}

function NebulaSound:FetchSound(ply, cause, force)
    if (not ply:hasSoundBank()) then
        return
    end

    local data = self.SoundBank[ply:getSoundBankID()]
    if not data then return end

    if not ply.soundCooldown then
        ply.soundCooldown = {
            cause = 0
        }
    end

    if (force or (ply.soundCooldown[cause] or 0) < CurTime()) then
        ply.soundCooldown[cause] = CurTime() + (data.Cooldown[cause] or 30)
        return data.Cues[cause]
    end
end

function NebulaSound:RegisterVOX(name)
    local cooldown = {}
    local sounds = {}
    local totalSounds = 0
    for k, v in pairs(file.Find("sound/nebularp/vox/" .. name .. "/*.mp3", "GAME")) do
        for cause, cd in pairs(causeDictionary) do
            if (!string.StartWith(v, cause)) then continue end
            if (!sounds[cause]) then
                sounds[cause] = {}
            end
            table.insert(sounds[cause], "nebularp/vox/" .. name .. "/" .. v)
            totalSounds = totalSounds + 1
            cooldown[cause] = cd
            break
        end
    end

    self.SoundBank[name] = {
        Cues = {},
        Cooldown = cooldown
    }

    for cause, soundTable in pairs(sounds) do
        self.SoundBank[name].Cues[cause] = name .. "." .. cause
        sound.Add({
            channel = CHAN_VOICE,
            volume = 1,
            name = name .. "." .. cause,
            level = 110,
            sound = soundTable,
        })
    end
    
    MsgC("\tAdded ", color_white, name, Color(212, 96, 96), " VOX (" .. totalSounds .. " sounds)\n")
end

local meta = FindMetaTable("Player")

function meta:Assists()
    return self:GetNWInt("Assists", 0)
end

function meta:hasSoundBank()
    return self:GetNWString("Soundtrack.ID", "") ~= ""
end

function meta:getSoundBankID()
    return self:GetNWString("Soundtrack.ID", "")
end

function meta:getSoundBank()
    if (!self:hasSoundBank()) then
        return {}
    end
    return NebulaSound.SoundBank[self:getSoundBankID()]
end

function meta:playSoundBank(cause, ui, force)
    if (!self:hasSoundBank()) then
        return
    end

    local snd = NebulaSound:FetchSound(self, cause, force)
    if (not snd) then return end
    if (self.isPlayingSound) then
        self:StopSound(self.isPlayingSound)
    end

    self.isPlayingSound = snd
    if (SERVER and ui) then
        net.Start("NebulaSound.Play")
            net.WriteString(snd)
        net.Send(self)
    else
        self:EmitSound(snd, 110)
    end
end

net.Receive("NebulaSound.Play", function()
    local snd = net.ReadString()
    local ply = LocalPlayer()
    if (ply.isPlayingSound) then
        ply:StopSound(ply.isPlayingSound)
    end

    ply.isPlayingSound = snd
    ply:EmitSound(snd, 110)
end)

hook.Add("PlayerSpawn", "NebulaSound.Spawns", function(ply)
    if (ply:hasSoundBank()) then
        ply:playSoundBank("spawn", true)
    end
end)

hook.Add( "PlayerSwitchWeapon", "NebulaSound.Spawns", function( ply, oldWeapon, newWeapon )
	if (newWeapon.IsMelee) then
        ply:playSoundBank("melee", true)
    elseif (newWeapon.Primary and (newWeapon.Primary.Damage or 0) > 50) then
        ply:playSoundBank("weapon", true)
    end
end )

local start = SysTime()
MsgC(Color(100, 255, 50), "[NebulaSound]", color_white," Loading VOXs\n", Color(100, 100, 100))
NebulaSound:RegisterVOX("mlg")
NebulaSound:RegisterVOX("DOW2fc")
NebulaSound:RegisterVOX("mylittlepony")
NebulaSound:RegisterVOX("Quake")
NebulaSound:RegisterVOX("rick_morty")
NebulaSound:RegisterVOX("scout_tf2")
NebulaSound:RegisterVOX("Simpsons")
NebulaSound:RegisterVOX("south_park")
MsgC(Color(100, 255, 50), "[NebulaSound]", color_white," Finished loading VOXs (" .. math.Round((SysTime() - start) * 1000) .. "ms)\n")
