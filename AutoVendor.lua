-- Auto sell junk and repair gear when merchant window opens

local function processMerchantWindow()
    C_Timer.After(0, function()
        if MerchantSellAllJunkButton and MerchantSellAllJunkButton:IsShown() then
            MerchantSellAllJunkButton:Click()
        end
        
        if MerchantRepairAllButton and MerchantRepairAllButton:IsShown() then
            MerchantRepairAllButton:Click()
        end
    end)
    
    C_Timer.After(0, function()
        if StaticPopup1Button1 and StaticPopup1Button1:IsShown() then
            StaticPopup1Button1:Click()
        end
    end)
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("MERCHANT_SHOW")
eventFrame:SetScript("OnEvent", processMerchantWindow)



-- Makes looting instant with no delay when auto loot is enabled

local lastLootTime = 0
local lootDelay = 0.025

local function lootAllSlots()
    local autoLootEnabled = GetCVarBool("autoLootDefault")
    local shiftPressed = IsModifiedClick("AUTOLOOTTOGGLE")
    
    if autoLootEnabled ~= shiftPressed then
        if (GetTime() - lastLootTime) >= lootDelay then
            for slotIndex = GetNumLootItems(), 1, -1 do
                LootSlot(slotIndex)
            end
            
            lastLootTime = GetTime()
        end
    end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("LOOT_READY")
eventFrame:SetScript("OnEvent", lootAllSlots)
