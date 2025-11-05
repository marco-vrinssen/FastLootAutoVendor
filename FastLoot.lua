-- Makes looting instant with no delay when auto loot is enabled

SetCVar("autoLootRate", "0")

local function loot()
	if GetCVarBool("autoLootDefault") and not IsModifiedClick("AUTOLOOTTOGGLE") then
		for slot = GetNumLootItems(), 1, -1 do
			LootSlot(slot)
		end
		
		C_Timer.After(0.5, function()
			if GetNumLootItems() == 0 then
				CloseLoot()
			end
		end)
	end
end

local lootEventFrame = CreateFrame("Frame")
lootEventFrame:RegisterEvent("LOOT_READY")
lootEventFrame:SetScript("OnEvent", loot)