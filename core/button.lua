local _, ns = ...
local fonts = ns.media.fonts
local FormatTime = ns.util.FormatTime
local isMainline = ns.client.isMainline

-- Blizzard
local CreateFrame = _G.CreateFrame
local C_StringUtil = _G.C_StringUtil
local C_CurveUtil = _G.C_CurveUtil
local C_DurationUtil = _G.C_DurationUtil
local Enum = _G.Enum

--------------------------------------------------
-- BUTTONS
--------------------------------------------------
do
    local button_proto = {}

    local timeFormatter, timeColorCurve, timeTextOptions

    -- secret durations (Mainline): text and color like OnUpdate ("2m", "45s", "4.3"; red under 5s);
    -- Classic bindings have no SetTextColorCurve
    if isMainline then
        timeFormatter = C_StringUtil.CreateSecondsFormatter()
        timeFormatter:SetDefaultAbbreviation(Enum.SecondsFormatterAbbreviation.OneLetter)
        timeFormatter:SetStripIntervalWhitespace(Enum.SecondsFormatterIntervalWhitespace.StripIgnoreLocale)
        timeFormatter:SetDesiredUnitCount(1)
        timeFormatter:SetCanRoundUpLastUnit(true)
        timeFormatter:SetMillisecondsThreshold(5)

        timeColorCurve = C_CurveUtil.CreateColorCurve()
        timeColorCurve:SetType(Enum.LuaCurveType.Step)
        timeColorCurve:AddPoint(0, CreateColor(0.99, 0.31, 0.31))
        timeColorCurve:AddPoint(5, CreateColor(0.84, 0.75, 0.65))

        -- aura container duration text
        timeTextOptions = {
            textFormatter = timeFormatter,
            textColor = { curve = timeColorCurve, property = Enum.DurationTextBindingProperty.RemainingDuration }
        }
    end

    function button_proto:OnEnter()
        if (GameTooltip:IsForbidden() and not self:IsVisible()) then return end

        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

        if self.auraInstanceID and GameTooltip.SetUnitDebuffByAuraInstanceID then
            if self.isHarmful then
                GameTooltip:SetUnitDebuffByAuraInstanceID(self.unit, self.auraInstanceID)
            else
                GameTooltip:SetUnitBuffByAuraInstanceID(self.unit, self.auraInstanceID)
            end
        elseif self.itemId then
            GameTooltip:SetItemByID(self.itemId)
        elseif self.slotId then
            GameTooltip:SetInventoryItem(self.unit, self.slotId)
        elseif self.spellId then
            GameTooltip:SetSpellByID(self.spellId)
        end
    end

    -- secret durations can't drive the OnUpdate timer text, the duration text binding is used instead
    function button_proto:SetSecret(isSecret)
        if self.isSecret == isSecret then return end
        self.isSecret = isSecret
        if self.TimeBinding then
            self.TimeBinding:SetEnabled(isSecret)
        end
        self.Time:SetText("")
        if isSecret then
            self:SetScript("OnUpdate", nil)
        end
    end

    function button_proto:OnLeave()
        if GameTooltip:IsForbidden() then return end
        GameTooltip:Hide()
    end

    function button_proto:OnUpdate(elapsed)
        self.elapsed = (self.elapsed or 0) + elapsed
        if self.elapsed >= 0.1 then
            local remaining = (self.expirationTime or 0) - GetTime()
            if self.Time then
                if remaining > 0 then
                    self.Time:SetText(FormatTime(remaining))
                    if remaining <= 5 then
                        self.Time:SetTextColor(0.99, 0.31, 0.31)
                    else
                        self.Time:SetTextColor(0.84, 0.75, 0.65)
                    end
                else
                    self.Time:SetText("")
                    self:SetScript("OnUpdate", nil)
                    self:Hide()
                end
            end
            self.elapsed = 0
        end
    end

    --[[ StyleButton(button)
    Creates the button's visual regions (backdrop, cooldown, icon, count, time text).
    Shared by Filger buttons and aura container buttons.
    --]]
    local function StyleButton(button)
        -- resources
        local font, fontSize, fontStyle = fonts.normal, 12, "OUTLINE"
        -- aura container buttons are unnamed; "$parent" would create globals like "Icon"
        local name = button:GetName()

        button:CreateBackdrop()
        -- ElvUI stores its backdrop as `backdrop`
        button.Backdrop = button.Backdrop or button.backdrop

        local cooldown = CreateFrame("Cooldown", name and name .. "CD", button, "CooldownFrameTemplate")
        cooldown:SetAllPoints()
        cooldown:SetReverse(true)
        cooldown:SetDrawEdge(false)
        cooldown:SetHideCountdownNumbers(true)
        -- cooldown.noOCC = true
        -- cooldown.noCooldownCount = true
        button.Cooldown = cooldown

        local icon = button:CreateTexture(name and name .. "Icon", "ARTWORK")
        icon:SetAllPoints()
        icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        button.Icon = icon

        local overlay = CreateFrame("Frame", name and name .. "Overlay", button, nil)
        overlay:SetAllPoints(button)
        overlay:SetFrameLevel(cooldown:GetFrameLevel() + 1)
        button.Overlay = overlay

        local count = overlay:CreateFontString(name and name .. "OverlayCount", "OVERLAY")
        count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
        count:SetFont(font, fontSize, fontStyle)
        count:SetJustifyH("RIGHT")
        count:SetTextColor(0.84, 0.75, 0.65)
        button.Count = count

        local time = overlay:CreateFontString(name and name .. "OverlayTime", "OVERLAY")
        time:SetPoint("CENTER", button, "CENTER", 0, 0)
        time:SetFont(font, 20, fontStyle)
        time:SetJustifyH("CENTER")
        time:SetTextColor(0.84, 0.75, 0.65)
        button.Time = time
    end

    --[[ CreateButton(element, index)
	Creates an aura/cooldown button at a given position.

    * self     - the widget holding the aura buttons
    * index    - the position at which the aura button is to be created (number)

    ## Returns
	* button - the button used to represent the aura (Button)
    --]]
    local function CreateButton(element, index)
        local button = Mixin(CreateFrame("Frame", element:GetName() .. "Aura" .. index, element), button_proto)
        button:SetWidth(element.size)
        button:SetHeight(element.size)
        StyleButton(button)

        local time = button.Time

        -- only secret cooldowns (Mainline) need it; Classic bindings have no SetTextColorCurve
        if isMainline then
            local timeBinding = C_DurationUtil.CreateDurationTextBinding()
            timeBinding:SetFontString(time)
            timeBinding:SetFormatter(timeFormatter)
            timeBinding:SetTextColorCurve(timeColorCurve, Enum.DurationTextBindingProperty.RemainingDuration)
            timeBinding:SetExpiredText("")
            timeBinding:SetZeroDurationText("")
            timeBinding:SetEnabled(false)
            button.TimeBinding = timeBinding
        end

        local animation = button:CreateAnimationGroup()
        animation:SetLooping("BOUNCE")
        button.Animation = animation

        local fadeout = animation:CreateAnimation("Alpha")
        fadeout:SetFromAlpha(1)
        fadeout:SetToAlpha(0.10)
        fadeout:SetDuration(0.50)
        fadeout:SetSmoothing("IN_OUT")
        animation.Fadeout = fadeout

        if ns.config.general.gametooltip then
            button:SetScript("OnEnter", button.OnEnter)
            button:SetScript("OnLeave", button.OnLeave)
        end

        return button
    end

    ns.button = {
        Style = StyleButton,
        Create = CreateButton,
        timeTextOptions = timeTextOptions
    }
end
