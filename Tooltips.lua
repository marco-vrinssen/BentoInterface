local function UpdateStatusBarSize(self)
    GameTooltipStatusBar:SetSize(self:GetWidth() - 4, 12)
end

local function UnitTooltipUpdate(GameTooltip)
    if GameTooltip:GetAnchorType() ~= "ANCHOR_CURSOR" then
        GameTooltip:ClearAllPoints()
        GameTooltip:SetPoint("TOPLEFT", BentoUI.TargetPortraitBackdrop, "BOTTOMRIGHT", 0, 0)

        GameTooltipStatusBar:ClearAllPoints()
        GameTooltipStatusBar:SetPoint("TOP", GameTooltip, "BOTTOM", 0, 4)
        GameTooltipStatusBar:SetStatusBarTexture("Interface/RaidFrame/Raid-Bar-HP-Fill.blp")
        GameTooltipStatusBar:SetFrameLevel(GameTooltip:GetFrameLevel() -1)
    end
end

hooksecurefunc("GameTooltip_SetDefaultAnchor", UnitTooltipUpdate)
GameTooltip:HookScript("OnTooltipSetUnit", UnitTooltipUpdate)
GameTooltip:HookScript("OnSizeChanged", UpdateStatusBarSize)




local function ItemTooltipUpdate(ItemTooltip)
    local _, ItemLink = ItemTooltip:GetItem()
    if ItemLink then
        local _, _, _, ItemLevel = GetItemInfo(ItemLink)
        if ItemLevel and ItemLevel > 0 then
            ItemTooltip:AddLine("Item Level: " .. ItemLevel)
            ItemTooltip:Show()
        end
    end
end

GameTooltip:HookScript("OnTooltipSetItem", ItemTooltipUpdate)
ItemRefTooltip:HookScript("OnTooltipSetItem", ItemTooltipUpdate)
ShoppingTooltip1:HookScript("OnTooltipSetItem", ItemTooltipUpdate)
ShoppingTooltip2:HookScript("OnTooltipSetItem", ItemTooltipUpdate)