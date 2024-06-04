local function DialogUpdate()
    if event == "CONFIRM_LOOT_ROLL" then
        local id, rollType = ...
        ConfirmLootRoll(id, rollType)
    elseif event == "LOOT_BIND_CONFIRM" then
        local slot = ...
        ConfirmLootSlot(slot)
    elseif event == "EQUIP_BIND_CONFIRM" then
        local slot = ...
        EquipPendingItem(slot)
    elseif event == "MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL" then
        local slot = ...
        SellCursorItem()
    elseif event == "DELETE_ITEM_CONFIRM" then
        StaticPopupDialogs["DELETE_ITEM"].OnAccept()
    end
end)

StaticPopupDialogs["DELETE_ITEM"].OnShow = function(self)
    self.editBox:SetText(DELETE_ITEM_CONFIRM_STRING)
end

local DialogEvents = CreateFrame("Frame")
DialogEvents:RegisterEvent("CONFIRM_LOOT_ROLL")
DialogEvents:RegisterEvent("LOOT_BIND_CONFIRM")
DialogEvents:RegisterEvent("EQUIP_BIND_CONFIRM")
DialogEvents:RegisterEvent("MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL")
DialogEvents:RegisterEvent("DELETE_ITEM_CONFIRM")
DialogEvents:SetScript("OnEvent", DialogUpdate)