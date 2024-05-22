local function BagSlotUpdate()
    MainMenuBarBackpackButton:ClearAllPoints()
    MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -24, 24)
    MainMenuBarBackpackButton:SetScale(0.8)

    CharacterBag0Slot:ClearAllPoints()
    CharacterBag0Slot:SetPoint("RIGHT", MainMenuBarBackpackButton, "LEFT", -4, 0)
    CharacterBag0Slot:SetScale(0.8)
    CharacterBag0Slot:SetParent(ContainerFrame1)

    CharacterBag1Slot:ClearAllPoints()
    CharacterBag1Slot:SetPoint("RIGHT", CharacterBag0Slot, "LEFT", -4, 0)
    CharacterBag1Slot:SetScale(0.8)
    CharacterBag1Slot:SetParent(ContainerFrame1)

    CharacterBag2Slot:ClearAllPoints()
    CharacterBag2Slot:SetPoint("RIGHT", CharacterBag1Slot, "LEFT", -4, 0)
    CharacterBag2Slot:SetScale(0.8)
    CharacterBag2Slot:SetParent(ContainerFrame1)

    CharacterBag3Slot:ClearAllPoints()
    CharacterBag3Slot:SetPoint("RIGHT", CharacterBag2Slot, "LEFT", -4, 0)
    CharacterBag3Slot:SetScale(0.8)
    CharacterBag3Slot:SetParent(ContainerFrame1)

    KeyRingButton:ClearAllPoints()
    KeyRingButton:SetPoint("RIGHT", CharacterBag3Slot, "LEFT", -4, -1)
    KeyRingButton:SetScale(0.8)
    KeyRingButton:SetParent(ContainerFrame1)
end

local BagSlotEvents = CreateFrame("Frame")
BagSlotEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
BagSlotEvents:RegisterEvent("BAG_UPDATE")
BagSlotEvents:SetScript("OnEvent", BagSlotUpdate)




local function BagContainerUpdate()    
    local OpenContainer = {}
    local LastContainer = MainMenuBarBackpackButton
    
    for i = 0, NUM_BAG_FRAMES + NUM_BANKBAGSLOTS do
        local ContainerFrame = _G["ContainerFrame"..(i+1)]
        if ContainerFrame and ContainerFrame:IsShown() then
            table.insert(OpenContainer, ContainerFrame)
        end
    end
    
    for i, ContainerFrame in ipairs(OpenContainer) do
        ContainerFrame:ClearAllPoints()
        if i == 1 then
            ContainerFrame:SetPoint("BOTTOMRIGHT", LastContainer, "TOPRIGHT", 4, 4)
        elseif i == 2 then
            ContainerFrame:SetPoint("BOTTOM", OpenContainer[1], "TOP", 0, 8)
        elseif i == 3 then
            ContainerFrame:SetPoint("BOTTOM", OpenContainer[2], "TOP", 0, 8)
        elseif i == 4 then
            ContainerFrame:SetPoint("BOTTOMRIGHT", OpenContainer[2], "BOTTOMLEFT", -8, 0)
        elseif i == 5 then
            ContainerFrame:SetPoint("BOTTOM", OpenContainer[4], "TOP", 0, 8)
        elseif i == 6 then
            ContainerFrame:SetPoint("TOPRIGHT", OpenContainer[5], "TOPLEFT", -8, 0)
        else
            ContainerFrame:SetPoint("TOPRIGHT", OpenContainer[i-1], "TOPLEFT", -8, 0)
        end
    end
    
    if not IsBagOpen(0) then
        if IsBagOpen(KEYRING_CONTAINER) then
            ToggleBag(KEYRING_CONTAINER)
        end
    end
end

hooksecurefunc("UpdateContainerFrameAnchors", BagContainerUpdate)

local BagContainerEvents = CreateFrame("Frame")
BagContainerEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
BagContainerEvents:RegisterEvent("BAG_UPDATE")
BagContainerEvents:RegisterEvent("BANKFRAME_OPENED")
BagContainerEvents:RegisterEvent("BANKFRAME_CLOSED")
BagContainerEvents:RegisterEvent("MERCHANT_SHOW")
BagContainerEvents:RegisterEvent("MERCHANT_CLOSED")
BagContainerEvents:SetScript("OnEvent", BagContainerUpdate)






local function TogglePlayerBags()
    if IsBagOpen(0) then
        CloseAllBags()
    else
        OpenAllBags()
    end
end

MainMenuBarBackpackButton:SetScript("OnClick", TogglePlayerBags)




local function OpenBankBags()
    for bagID = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
        OpenBag(bagID)
    end
end

local function CloseBankBags()
    for bagID = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
        CloseBag(bagID)
    end
end

local BagToggleEvents = CreateFrame("Frame")
BagToggleEvents:RegisterEvent("BANKFRAME_OPENED")
BagToggleEvents:RegisterEvent("BANKFRAME_CLOSED")
BagToggleEvents:SetScript("OnEvent", function(self, event)
    if event == "BANKFRAME_OPENED" then
        OpenBankBags()
    elseif event == "BANKFRAME_CLOSED" then
        CloseBankBags()
    end
end)