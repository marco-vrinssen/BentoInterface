StaticPopupDialogs["PLAYER_LINK_URL"] = {
    text = "Copy and paste this URL into your browser.",
    button1 = "Close",
    OnAccept = function() end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnShow = function(self, data)
        self.editBox:SetText(data.PlayerURL)
        self.editBox:HighlightText()
        self.editBox:SetFocus()
        self.editBox:SetScript("OnKeyDown", function(_, key)
            if key == "ESCAPE" then
                self:Hide()
            elseif IsModifierKeyDown() and key == "C" then
                self:Hide()
            end
        end)
    end,
    hasEditBox = true
}

local AtlasforgeURL = "https://atlasforge.gg/wow-classic/armory/"
local WarcraftLogsURL = "https://vanilla.warcraftlogs.com/character/"
local ServerRegions = {'us', 'kr', 'eu', 'tw', 'cn'}

local function generateLink(self, prefix, value)
    local RealmSlug = GetRealmName():gsub("[%p%c]", ""):gsub("[%s]", "-"):lower()
    local CurrentRegion = ServerRegions[GetCurrentRegion()]

    if self.value == value then
        local DropdownMenu = _G["UIDROPDOWNMENU_INIT_MENU"]
        local PlayerURL = prefix .. CurrentRegion .. '/' .. RealmSlug .. '/' .. DropdownMenu.name:lower()
        local PopupDataFill = {PlayerURL = PlayerURL}

        StaticPopup_Show("PLAYER_LINK_URL", "", "", PopupDataFill)
    end
end

local function addMenuItem(text, PlayerURL, value)
    local MenuItem = UIDropDownMenu_CreateInfo()

    MenuItem.text = text
    MenuItem.owner = which
    MenuItem.notCheckable = 1
    MenuItem.func = function(self) generateLink(self, PlayerURL, value) end
    MenuItem.colorCode = "|cffFFD100"
    MenuItem.value = value

    UIDropDownMenu_AddButton(MenuItem)
end

hooksecurefunc("UnitPopup_ShowMenu", function()
    if (UIDROPDOWNMENU_MENU_LEVEL > 1) then
        return
    end

    addMenuItem("Armory", AtlasforgeURL, "AtlasforgeLink")
    addMenuItem("Logs", WarcraftLogsURL, "WarcraftlogsLink")
end)