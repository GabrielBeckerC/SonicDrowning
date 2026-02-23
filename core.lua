local threshold = 14
local musicPath = "Interface\\AddOns\\SonicDrowning\\Sounds\\sonic-1-music-drownings.mp3"
local musicPlaying = false

local frame = CreateFrame("Frame")
frame:SetScript("OnUpdate", function(self, elapsed)
    if MirrorTimer1:IsShown() and MirrorTimer1.timer == "BREATH" then
        
        local secondsLeft = MirrorTimer1.value 

        if secondsLeft < 1 then
            secondsLeft = secondsLeft * (MirrorTimer1.maxvalue or 60)
        end

        -- Trigger
        if secondsLeft <= threshold and secondsLeft > 0 then
            if not musicPlaying then
                PlayMusic(musicPath)
                musicPlaying = true
            end
        elseif secondsLeft > threshold and musicPlaying then
            StopMusic()
            musicPlaying = false
        end
    else
        if musicPlaying then
            StopMusic()
            musicPlaying = false
        end
    end
end)

SLASH_SONIC1 = "/sonic"
SlashCmdList["SONIC"] = function()
    PlayMusic(musicPath)
    C_Timer.After(5, function() StopMusic() end)
end
