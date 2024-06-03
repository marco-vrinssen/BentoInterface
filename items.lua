local LootDelta = 0
local LootDelay = 0.05

local function AutoLootUpdate()
    if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
        local LootTime = GetTime()
        if (LootTime - LootDelta) >= LootDelay then
            for i = GetNumLootItems(), 1, -1 do
                LootSlot(i)
            end
            LootDelta = LootTime
        end
    end
end

local LootEvents = CreateFrame("Frame")
LootEvents:RegisterEvent("LOOT_READY")
LootEvents:SetScript("OnEvent", AutoLootUpdate)




local function AutoSellRepair()
    local RepairCost, TotalSold = 0, 0
    local CanMerchantRepair, RepairAllItems, GetRepairAllCost = CanMerchantRepair, RepairAllItems, GetRepairAllCost
    local GetContainerNumSlots, GetContainerItemLink, UseContainerItem = C_Container.GetContainerNumSlots, C_Container.GetContainerItemLink, C_Container.UseContainerItem
    local GetItemInfo = GetItemInfo

    if CanMerchantRepair() then
        RepairCost = GetRepairAllCost()
        if RepairCost > 0 then
            RepairAllItems()
            print("Items repaired for " .. GetCoinTextureString(RepairCost))
        end
    end

    for BagIndex = 0, 4 do
        for SlotIndex = 1, GetContainerNumSlots(BagIndex) do
            local ItemLink = GetContainerItemLink(BagIndex, SlotIndex)
            if ItemLink then
                local _, _, ItemRarity, _, _, _, _, _, _, _, ItemSellPrice = GetItemInfo(ItemLink)
                if ItemRarity == 0 and ItemSellPrice ~= 0 then
                    TotalSold = TotalSold + ItemSellPrice
                    UseContainerItem(BagIndex, SlotIndex)
                end
            end
        end
    end

    if TotalSold > 0 then
        print("Trash sold for " .. GetCoinTextureString(TotalSold))
    end
end

local MerchantEvents = CreateFrame("Frame")
MerchantEvents:RegisterEvent("MERCHANT_SHOW")
MerchantEvents:SetScript("OnEvent", AutoSellRepair)



local DialogEvents = CreateFrame("Frame")

DialogEvents:SetScript("OnEvent", function(self, event, ...)
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

DialogEvents:RegisterEvent("CONFIRM_LOOT_ROLL")
DialogEvents:RegisterEvent("LOOT_BIND_CONFIRM")
DialogEvents:RegisterEvent("EQUIP_BIND_CONFIRM")
DialogEvents:RegisterEvent("MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL")
DialogEvents:RegisterEvent("DELETE_ITEM_CONFIRM")