local _, ns = ...
local Filger = ns.Filger

local blacklist = ns.Filger.blacklist or {}

--------------------------------------------------
-- AURA CONTAINERS
--------------------------------------------------
-- Blizzard's secure container filters, sorts and displays auras that are secret to Filger.
local container_proto = {}

do
    local AnchorUtil = _G.AnchorUtil
    local AuraContainerSortMethod = _G.AuraContainerSortMethod
    local C_XMLUtil = _G.C_XMLUtil

    local TEMPLATE = "CustomAuraContainerTemplate"

    -- container buttons can only be styled here: once auras are secret, tainted code can't touch them
    local function CreateInitializer(element)
        local size = element.size
        local tooltip = Filger.config.general.gametooltip

        return function(button)
            button:SetSize(size, size)
            Filger:StyleButton(button)

            button:SetIcon(button.Icon)
            button:SetDurationCooldown(button.Cooldown)
            button:SetApplicationCount(button.Count)
            button:SetDurationText(button.Time, Filger.timeTextOptions)

            if tooltip then
                button:SetTooltipAnchorPoint("ANCHOR_RIGHT")
            else
                button:SetMouseMotionEnabled(false)
            end
        end
    end

    function container_proto:CreateContainer(data)
        if not C_XMLUtil.GetTemplateInfo(TEMPLATE) then
            Filger:warn(TEMPLATE .. " not found, " .. self:GetName() .. " is disabled.")
            return
        end

        local container = CreateFrame("AuraContainer", self:GetName() .. "Container", self, TEMPLATE)
        container:SetPoint(self.initialAnchor, self, self.initialAnchor)
        container:SetFlowLayoutAnchorPoint(self.initialAnchor)
        container:SetFlowLayoutGrowthDirection(
            (self["growth-x"] == "LEFT") and AnchorUtil.FlowDirection.Left or AnchorUtil.FlowDirection.Right,
            (self["growth-y"] == "DOWN") and AnchorUtil.FlowDirection.Down or AnchorUtil.FlowDirection.Up)
        container:SetUnit(self.unit)

        local initializeFrame = CreateInitializer(self)
        local layout = {
            elementSpacing = self.spacing,
            lineSpacing = self.spacing,
            elementWidth = self.size,
            elementHeight = self.size
        }

        for i, group in ipairs(data.groups) do
            local key = self:GetName() .. "Group" .. i
            container:AddAuraGroup(key, group.filter, {
                maxFrameCount = self.limit,
                candidateFilters = group.candidateFilters,
                sortMethod = AuraContainerSortMethod.ExpirationOnly,
                layout = layout,
                initializeFrame = initializeFrame
            })

            -- groups with `hostile` are only enabled while the unit's reaction matches
            if group.hostile ~= nil then
                self.reactionGroups = self.reactionGroups or {}
                self.reactionGroups[key] = group.hostile
            end
        end

        -- private auras (boss mechanics) never reach C_UnitAuras; Blizzard draws them into these anchors
        local growthx = (self["growth-x"] == "LEFT") and -1 or 1
        for i = 1, data.privateAuras or 0 do
            local anchor = CreateFrame("Frame", nil, self)
            anchor:SetSize(self.size, self.size)
            anchor:SetPoint(self.initialAnchor, self, self.initialAnchor, (self.limit + i - 1) * (self.size + self.spacing) * growthx, 0)
            C_UnitAuras.AddPrivateAuraAnchor({
                unitToken = self.unit,
                auraIndex = i,
                parent = anchor,
                showCooldownFrame = true,
                showCountdownNumbers = true,
                iconInfo = {
                    iconAnchor = { point = "CENTER", relativeTo = anchor, relativePoint = "CENTER", offsetX = 0, offsetY = 0 },
                    iconWidth = self.size,
                    iconHeight = self.size
                }
            })
        end

        self.container = container

        -- the container doesn't follow unit token changes by itself
        if (self.unit == "target") then
            self:RegisterEvent("PLAYER_TARGET_CHANGED")
        elseif (self.unit == "focus") then
            self:RegisterEvent("PLAYER_FOCUS_CHANGED")
        end
    end

    function container_proto:ForceUpdate()
        local container = self.container
        if not container then return end

        if self.reactionGroups then
            local hostile = UnitCanAttack(self.unit, "player")
            for key, groupHostile in next, self.reactionGroups do
                container:SetAuraGroupEnabled(key, groupHostile == hostile)
            end
        end

        container:UpdateAllAuras()
    end

    function container_proto:PLAYER_TARGET_CHANGED()
        self:ForceUpdate()
    end

    function container_proto:PLAYER_FOCUS_CHANGED()
        self:ForceUpdate()
    end
end

ns.container_proto = container_proto

--------------------------------------------------
-- FRAMES
--------------------------------------------------
local class = Filger.class
local spells = Filger.spells or {}

-- container candidate filters take { [spellId] = true }; name keys can't be matched
local function ToSpellIDs(list)
    local ids = {}
    for spellId, value in next, list do
        if type(spellId) == "number" and (value == true or (type(value) == "table" and value.enabled)) then
            ids[spellId] = true
        end
    end
    return ids
end

-- adds what each frame shows to its layout in config.lua
for key, data in next, {
    -- LEFT
    ["PLAYER_DEBUFFS"] = {
        type = "container",
        -- debuffs on the player can't be filtered by spell ID (Stagger is contextually secret);
        -- only the important ones, one group each
        groups = {
            { filter = "HARMFUL|RAID_PLAYER_DISPELLABLE" },
            { filter = "HARMFUL|CROWD_CONTROL" },
            {
                filter = "HARMFUL",
                candidateFilters = { isBossAura = true }
            }
        }
    },
    ["PLAYER_AURAS"] = {
        type = "container",
        groups = {
            {
                filter = "HELPFUL|PLAYER",
                candidateFilters = {
                    includeSpellIDs = ToSpellIDs(Mixin(spells[class] or {}, spells["ALL"] or {}))
                }
            }
        }
    },
    ["PLAYER_BUFFS"] = {
        type = "container",
        groups = {
            {
                filter = "HELPFUL|!PLAYER",
                candidateFilters = {
                    excludeSpellIDs = ToSpellIDs(blacklist)
                }
            }
        }
    },
    -- RIGHT
    ["TARGET_DEBUFFS"] = {
        type = "container",
        groups = {
            { filter = "HARMFUL|PLAYER", hostile = true },
            { filter = "HARMFUL|!PLAYER", hostile = false }
        }
    },
    ["TARGET_AURAS"] = {
        type = "container",
        groups = {
            {
                filter = "HELPFUL",
                hostile = false,
                candidateFilters = {
                    excludeSpellIDs = ToSpellIDs(blacklist)
                }
            },
            -- buffs on hostile units can't be filtered by spell ID; keep the groups to show
            { filter = "HELPFUL|IMPORTANT", hostile = true },
            { filter = "HELPFUL|DISPELLABLE", hostile = true },
            -- { filter = "HELPFUL", hostile = true, candidateFilters = { isStealable = true } },
            -- { filter = "HELPFUL", hostile = true },
        }
    },
    ["FOCUS_DEBUFFS"] = {
        type = "container",
        groups = {
            {
                filter = "HARMFUL",
                candidateFilters = { isBossAura = true }
            }
        }
    },
    -- CENTER
    ["BOSS_DEBUFFS"] = {
        type = "container",
        groups = {
            {
                filter = "HARMFUL",
                candidateFilters = { isBossAura = true }
            }
        },
        privateAuras = 2
    },
} do
    Mixin(Filger.config.frames[key], data)
end
