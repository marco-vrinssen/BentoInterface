local function HideChatElement(ChatElement)
    if ChatElement then
        ChatElement:Hide()
        ChatElement:SetScript("OnShow", ChatElement.Hide)
    end
end

local function HideChildElements(ParentFrame, ElementNames)
    for _, ElementName in ipairs(ElementNames) do
        HideChatElement(_G[ParentFrame:GetName() .. ElementName] or ParentFrame[ElementName])
    end
end

local function HideTextureRegions(ParentFrame)
    for _, Region in ipairs({ParentFrame:GetRegions()}) do
        if Region:IsObjectType("Texture") then
            HideChatElement(Region)
        end
    end
end

local function CustomizeChatTab(ChatTabFrame)
    local ChatTab = _G[ChatTabFrame:GetName() .. "Tab"]
    local ChatTabText = _G[ChatTabFrame:GetName() .. "TabText"]
    
    HideTextureRegions(ChatTab)
    if ChatTabText then
        ChatTabText:SetFont(STANDARD_TEXT_FONT, 14)
    end
end

local function CustomizeChatFrame(ChatFrame)
    HideTextureRegions(ChatFrame)
    
    local ElementsToHide = {
        "ButtonFrame",
        "EditBoxLeft",
        "EditBoxMid",
        "EditBoxRight",
        "EditBoxHeaderSuffix",
        "TabUpButton",
        "TabDownButton",
        "TabBottomButton",
        "TabMinimizeButton"
    }
    
    HideChildElements(ChatFrame, ElementsToHide)
    CustomizeChatTab(ChatFrame)
end

local function UpdateAllChatFrames()
    for i = 1, NUM_CHAT_WINDOWS do
        CustomizeChatFrame(_G["ChatFrame" .. i])
    end
    
    HideChatElement(ChatFrameMenuButton)
    HideChatElement(ChatFrameChannelButton)
    if CombatLogQuickButtonFrame_CustomTexture then
        CombatLogQuickButtonFrame_CustomTexture:SetAlpha(0)
    end
end

local ChatElementEvents = CreateFrame("Frame")
ChatElementEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
ChatElementEvents:RegisterEvent("UPDATE_FLOATING_CHAT_WINDOWS")
ChatElementEvents:RegisterEvent("CHAT_MSG_WHISPER")
ChatElementEvents:RegisterEvent("UI_SCALE_CHANGED")
ChatElementEvents:SetScript("OnEvent", UpdateAllChatFrames)

hooksecurefunc("FCF_OpenTemporaryWindow", function()
    CustomizeChatFrame(FCF_GetCurrentChatFrame())
end)




local function ChatScrollHook(ChatFrameID)
    local ChatFrameTab = _G["ChatFrame" .. ChatFrameID .. "Tab"]
    if not ChatFrameTab.scrollHooked then
        ChatFrameTab:HookScript("OnClick", function() _G["ChatFrame" .. ChatFrameID]:ScrollToBottom() end)
        ChatFrameTab.scrollHooked = true
    end
end

local function UpdateChatScroll()
    for i = 1, NUM_CHAT_WINDOWS do
        ChatScrollHook(i)
    end
end

local function UpdateScrollOnNewTab()
    local CurrentChatFrame = FCF_GetCurrentChatFrame()
    if CurrentChatFrame then
        ChatScrollHook(CurrentChatFrame:GetID())
    end
end

hooksecurefunc("FCF_OpenTemporaryWindow", UpdateScrollOnNewTab)

local ChatScrollEvents = CreateFrame("Frame")
ChatScrollEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
ChatScrollEvents:SetScript("OnEvent", UpdateChatScroll)