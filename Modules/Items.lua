local function AutoLootUpdate()
    if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
        for i = GetNumLootItems(), 1, -1 do
            LootSlot(i)
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