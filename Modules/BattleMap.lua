local function updateBattlefieldMap()
    BattlefieldMapFrame.BorderFrame:Hide()
    BattlefieldMapTab.Right:Hide()
    BattlefieldMapTab.Middle:Hide()
    BattlefieldMapTab.Left:Hide()
end

local BattlefieldMapEvents = CreateFrame("Frame")
BattlefieldMapEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
BattlefieldMapEvents:SetScript("OnEvent", updateBattlefieldMap)