BentoUI = BentoUI or {}




local function ConfigUpdate()
    SetCVar("ffxGlow", 0)
    SetCVar("ffxDeath", 0)
    SetCVar("ffxNether", 0)

    SetCVar("WorldTextScale", 1.5)
    SetCVar("cameraDistanceMaxZoomFactor", 3)

    SetCVar("rawMouseEnable", 1)
end

local ConfigEvents = CreateFrame("Frame")
ConfigEvents:RegisterEvent("PLAYER_LOGIN")
ConfigEvents:SetScript("OnEvent", ConfigUpdate)




local function SoundUpdate()
    MuteSoundFile(555124) -- Mechastrider Loop
    MuteSoundFile(567677) -- Bow Pullback 1
    MuteSoundFile(567675) -- Bow Pullback 2
    MuteSoundFile(567676) -- Bow Pullback 3
    MuteSoundFile(567719) -- Gun Loading 1
    MuteSoundFile(567720) -- Gun Loading 2
    MuteSoundFile(567723) -- Gun Loading 3

    MuteSoundFile(548067) -- Core Hound Fire
end

local SoundEvents = CreateFrame("Frame")
SoundEvents:RegisterEvent("PLAYER_LOGIN")
SoundEvents:SetScript("OnEvent", SoundUpdate)




local function FramerateUpdate()
    FramerateLabel:SetAlpha(0)
    FramerateText:ClearAllPoints()
    FramerateText:SetPoint("LEFT", MainMenuMicroButton, "RIGHT", 8, -8)
end

local FramerateEvents = CreateFrame("Frame")
FramerateEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
FramerateEvents:SetScript("OnEvent", FramerateUpdate)




local function QuestieSupport()
    if IsAddOnLoaded("Questie") then
        Questie.db.profile.nameplateTargetFrameScale = 1.5
        Questie.db.profile.nameplateTargetFrameX = -180
        Questie.db.profile.nameplateTargetFrameY = 0

        Questie.db.profile.nameplateScale = 1.2
        Questie.db.profile.nameplateX = -24
        Questie.db.profile.nameplateY = 0
    end
end

local QuestieSupportEvents = CreateFrame("Frame")
QuestieSupportEvents:RegisterEvent("PLAYER_LOGIN")
QuestieSupportEvents:SetScript("OnEvent", QuestieSupport)