require("ComfySleeping_InitComfyClothes")

--  +-----------------------------------------------+
--  |				GLOBALS & OPTIONS				|
--  +-----------------------------------------------+
local options = {}

local currentComfort = 100

-- Hours until player forced awake at poor/very poor comfort
local hoursTillWakeup = 0

-- Two flags for tracking when OnTick events are added & removed to avoid adding it twice
local wakeupWasAdded = false
local correctStatsAdded = false

-- Master table that holds all key/value pairs {ClothingName : ComfortModifier} for all detected clothing
-- and their comfort modifiers
local comfyClothes = {}


--  +---------------------------------------+
--  |			HELPER FUNCTIONS			|
--  +---------------------------------------+
-- Checks if given key exists in given table
function keyInTable(table, key)
  return table[key] ~= nil
end

-- Calculated length of given table by counting all key/val pairs
local function getLen(table)
	local count = 0
	for _ in pairs(table) do count = count + 1 end
	
	return count
end


--  +---------------------------------------+
--  |				FUNCTIONS				|
--  +---------------------------------------+
-- For the given player object, check the moodle level (value from 0 - 4) and add the level * modifierPerLevel
-- to the total moodleComfortModifier, and return the sum.
local function getMoodleComfortModifier(p)
	local modifier = 0
	local moodles = p:getMoodles()
	
	 modifier = modifier + (moodles:getMoodleLevel(MoodleType.Hungry) * options.hungerComfyMod) -- Hunger
	 modifier = modifier + (moodles:getMoodleLevel(MoodleType.Sick) * options.sickComfyMod) -- Sick
	 modifier = modifier + (moodles:getMoodleLevel(MoodleType.HasACold) * options.hasColdComfyMod) -- HasACold
	 modifier = modifier + (moodles:getMoodleLevel(MoodleType.Wet) * options.wetComfyMod) -- Wet
	 modifier = modifier + (moodles:getMoodleLevel(MoodleType.Stress) * options.stressComfyMod) -- Stress
	 modifier = modifier + (moodles:getMoodleLevel(MoodleType.Thirst) * options.thirstComfyMod) -- Thirst
	 modifier = modifier + (moodles:getMoodleLevel(MoodleType.HeavyLoad) * options.heavyLoadComfyMod) -- HeavyLoad
	 modifier = modifier + (moodles:getMoodleLevel(MoodleType.Hyperthermia) * options.hyperthermiaComfyMod) -- Hyperthermia
	 modifier = modifier + (moodles:getMoodleLevel(MoodleType.Hypothermia) * options.hypothermiaComfyMod) -- Hypothermia
	 modifier = modifier + (moodles:getMoodleLevel(MoodleType.FoodEaten) * options.foodComfyMod) -- FoodEaten
	 
	 return modifier
end


-- Same as above, but for Weapons equipped onto the player.
-- Anything tagged with item:IsWeapon() = true and not equipped (slot num = -1) are considiered equipped weaponsAffectComfort
-- with slot 1 being treated as the back, and any other non -1 slot being belt/additional weapons.
-- Note: Equipped slot might just be the hotbar num, and prove to be problematic/unpredictable when a mod like
-- "Reorder the hotbar" is used, as this *might* change slot numbers.
function getWeaponComfortModifier(p)
	if not (options.weaponsAffectComfort) then return 0 end

	local inventoryItems = p:getInventory():getItems()
	local weaponComfortModifier = 0
	
	for i = 0, inventoryItems:size() - 1, 1 do
		local item = inventoryItems:get(i)
		if (item:IsWeapon()) and (item:getAttachedSlot() ~= -1) then
			if (item:getAttachedSlot() ~= 1) then -- attached but not on back
				weaponComfortModifier = weaponComfortModifier + options.beltWeaponComfyMod
			
			elseif (item:getAttachedSlot() == 1) then -- attached on back
				weaponComfortModifier = weaponComfortModifier + options.backWeaponComfyMod
				
			end
			
		end
	end
	
	return weaponComfortModifier
end


-- Calculations for player/clothing dirt & blood from vanilla PZ.
-- Gets each body parts visual blood (the severity of the blood/dirt overlay) and averages out each body parts
-- blood & dirt level, and applis the comfort modifier if it meets the threshold.
-- Note: Calculation method is the same 0-100 scale used in the Wash context option for clothing & bathing
function getPlayerBloodAndDirt()
	local p = getPlayer()
	
	local visual = p:getHumanVisual()
	local bodyBlood = 0
	local bodyDirt = 0
	
	-- Iterating through each BodyPartType object (each body segment/location)
	for i = 1, BloodBodyPartType.MAX:index() do
		local part = BloodBodyPartType.FromIndex(i - 1)
		bodyBlood = bodyBlood + visual:getBlood(part)
		bodyDirt = bodyDirt + visual:getDirt(part)
		
	end
	
	-- Calculate total player blood and dirt and divide by total body parts (got via BodyPartType.MAX:index())
	local playerBloodAndDirt = {
		bodyBlood = math.ceil(bodyBlood / BloodBodyPartType.MAX:index() * 100),
		bodyDirt = math.ceil(bodyDirt / BloodBodyPartType.MAX:index() * 100)
	}
	
	return playerBloodAndDirt
end


-- Calculates comfort modifier from moodles, clothing, dirt & blood for player, and nearby pillow
function getComfortModifier(p, wornItems)
	local modifier = 0
	
	local avgDirtiness = 0
	local avgBloodiness = 0
	
	if options.addPillowComfort then
		modifier = modifier + options.pillowComfortBonus
	end
	
	modifier = modifier + getMoodleComfortModifier(p)
	
	--Iterate through worn clothing, adding each pieces comfort modifier
	for i = 0, wornItems:size() - 1 do
		local item = wornItems:get(i):getItem()
		local itemName = getItemNameFromFullType(item:getFullType())
		
		if (keyInTable(comfyClothes, itemName)) then -- Sanity check if clothing item is somehow not caught during init
			modifier = modifier + comfyClothes[itemName]
		
		end
		
		if (item:IsClothing()) and (options.dirtAndBloodAffectComfort) then
			avgBloodiness = avgBloodiness + item:getBloodLevel()
			avgDirtiness = avgDirtiness + item:getDirtyness()
			
		end
	end
	
	-- Should blood & dirt affect comfort?
	if (options.dirtAndBloodAffectComfort) then
		local playerBloodAndDirt = getPlayerBloodAndDirt()
	
		avgBloodiness = avgBloodiness / wornItems:size()
		avgDirtiness = avgDirtiness / wornItems:size()
		
		if (avgBloodiness > options.bloodThreshold) or (playerBloodAndDirt.bodyBlood > options.bloodThreshold) then modifier = modifier + options.bloodComfyMod end
		if (avgDirtiness > options.dirtThreshold) or (playerBloodAndDirt.bodyDirt > options.dirtThreshold) then modifier = modifier + options.dirtComfyMod end
		
	end
	
	return modifier
end


-- Gets sum of all comfort modifiers, including defaultComfort, clothingComfort, moodleComfort, weaponComfort, and pillow.
-- Player comfort = defaultComfort - getCurrentComfort()
function getCurrentComfort()
	local p = getPlayer()

	local weaponModifier = getWeaponComfortModifier(p)
	local comfortModifier = options.defaultComfort + getComfortModifier(p, p:getWornItems())
	
	return comfortModifier + weaponModifier
end


-- Updates currentComfort variable so that other functions don't have to recalculate currentComfort individually
-- whenever a function needs it.
function updateCurrentComfort()
	currentComfort = getCurrentComfort()

end


-- This MIGHT still be broken, but after about 2 rounds of testing this by sleeping twice then waiting a few hours, it seems that it might be fixed
-- Function handles forcing the player awake at poor & very poor comfort levels. Only runs when it's added to Events.EveryHours via correctStats() function
local function forcePlayerAwake()
	hoursTillWakeup = hoursTillWakeup - 1 -- -1 at beginning since Events isn't added for the current hour, and begins counting from the next hour
	print("HoursTillWakeup = " .. tostring(hoursTillWakeup))
	if hoursTillWakeup <= 0 then
		local p = getPlayer()
		p:forceAwake()
		
		if ZombRand(0, 100) < options.painChance then 
			local neckPain = ZombRand(options.painLowerBound, options.painUpperBound)
			p:getBodyDamage():getBodyPart(BodyPartType.Neck):setAdditionalPain(neckPain)
			
		end	
	end
end


-- Added to Events.OnTick and flags controlled via mainFunc, responsible for getting players current stats each tick
-- and adding the penaltyGainRate to the stat if it's outside the threshold specified in ComfySleeping's sandbox options.
local function correctStats()
	local p = getPlayer()
	local stats = p:getStats()
	
	local currFatigue = stats:getFatigue()
	local currEndurance = stats:getEndurance()
	
	local penaltyGainRate = 0.005
	
	-- Comfort is "Very Poor"
	if currentComfort <= 20 then
		
		-- Increment fatigue & endurnace if outside thresholds
		if currFatigue < options.uncomfy4Fatigue then stats:setFatigue(currFatigue + penaltyGainRate) end
		if currEndurance > options.uncomfy4Endurance then stats:setEndurance(currEndurance - penaltyGainRate) end
		
		-- Should forcePlayerAwake be added to Events.OnTick?
		if (wakeupWasAdded == false) and (p:isAsleep()) and (options.forceAwakeIfVeryUncomfy) then
			hoursTillWakeup = 3
			Events.EveryHours.Add(forcePlayerAwake)
			wakeupWasAdded = true
		
		-- Removing forcePlayerAwake from Events.OnTick and resetting flags
		elseif (wakeupWasAdded == true) and (p:isAsleep() ~= true) then
			wakeupWasAdded = false
			Events.EveryHours.Remove(forcePlayerAwake)
		
		end

	-- Comfort is "Poor"
	elseif currentComfort < 40 then
	
		-- Increment fatigue & endurance if outside thresholds
		if currFatigue < options.uncomfy3Fatigue then stats:setFatigue(currFatigue + penaltyGainRate) end
		if currEndurance > options.uncomfy3Endurance then stats:setEndurance(currEndurance - penaltyGainRate) end
		
		-- Should forcePlayerAwake be added?
		if (wakeupWasAdded == false) and (p:isAsleep()) and (options.forceAwakeIfVeryUncomfy) then
			hoursTillWakeup = 6
			Events.EveryHours.Add(forcePlayerAwake)
			wakeupWasAdded = true
		
		-- Removeing forcePlayerAwake from Events.OnTick and resetting flags
		elseif wakeupWasAdded == true and p:isAsleep() ~= true then
			wakeupWasAdded = false
			Events.EveryHours.Remove(forcePlayerAwake)
		
		end
	
	-- Comfort is "Bad"
	elseif currentComfort < 60 then
	
	-- Increment fatigue & endurance if outside thresholds
		if currFatigue < options.uncomfy2Fatigue then stats:setFatigue(currFatigue + penaltyGainRate) end
		if currEndurance > options.uncomfy2Endurance then stats:setEndurance(currEndurance - penaltyGainRate) end
	
	-- Comfort is "Tolerable"
	elseif currentComfort < 80 then
	
		-- Increment endurance only if outside threshold
		if currEndurance > options.uncomfy1Endurance then stats:setEndurance(currEndurance - penaltyGainRate) end
	
	-- Comfort is "Snug as a bug" (because it's funny)
	elseif currentComfort > 100 then

		-- Note on allPlayersAsleep(), since this is static, it cannot be called from an instance and must be called from the class itself, so IsoPlayer.allPlayersAsleep()
		-- Future note to me (01/06/2024): IsoPlayer.allPlayersAsleep() only checks if all LOCAL players are asleep, as in split screen. I need to figure out a way to get all online players
		-- asleep status before I can re-enable this setting, otherwise players wake up quite quickly, especially when used with other faster mp sleep mods.
		-- if (currFatigue > 0) and (IsoPlayer.allPlayersAsleep()) then stats:setFatigue(currFatigue - 0.00005) end
		-- if (currEndurance < 1) and (IsoPlayer.allPlayersAsleep()) then stats:setEndurance(currEndurance + 0.00005) end
		
		-- Don't increment anything, instead force player awake once their fatigue is close to 0
		if (currFatigue <= 0.01) and (options.forceAwakeIfSnug) then 
				p:forceAwake()
				stats:setFatigue(0)
				
		end
	end
end


-- Function controls updates to currentComfort variable every in game minute. Also ignores the player if the player object is nil or dead
-- to avoid some potential errors/edge cases. Function handles adding and removing correctStats and changing the flag responsible
-- for tracking it's status (added or removed).
local function mainFunc()
	local p = getPlayer()
	updateCurrentComfort()
	
	if (p == nil) or (not p:isAlive()) then return end -- Is the player real, if so, are they alive?
	
	-- Toggle statement to add or remove correctStats function when a player begins sleeping or wakes up
	if (p:isAsleep()) and (correctStatsAdded == false) then
		correctStatsAdded = true
		Events.OnTick.Add(correctStats)
	
	elseif (p:isAsleep() ~= true) and (correctStatsAdded == true) then
		correctStatsAdded = false
		Events.OnTick.Remove(correctStats)
		
	end
end


-- Function grabs player and vehicle objects and does the following:
-- If player is OUTSIDE a vehicle (v = nil), get their coordinates (X, Y, Z) and check all tiles within a radius
-- of 1 (including diagonals), then get the worldObjects (items on ground) on each tile. If an item of type
-- 'Base.Pillow' is found, then at least one pillow has been found.

-- If the player is INSIDE a vehicle (v ~= nil), get the total amount of pillows from ALL equipped inventories (should include hands & backpacks)
-- and return true if at least one pillow is found.
function findNearbyPillow()
	local p = getPlayer()
	local v = p:getVehicle()
	
	if (v == nil) then -- If player is out of a vehicle, check the ground
		local px, py, pz = p:getX(), p:getY(), p:getZ()
		
		-- Check within 1 tile of player for items on the ground.
		-- If the found items Base.Type is in ComfySleepings 'comfyPillowType' table, a valid pillow has been found
		for xMod=-1, 1, 1 do
			for yMod=-1, 1, 1 do
				worldObjects = getSquare(px - xMod, py - yMod, pz):getWorldObjects()
				
				for i = worldObjects:size() - 1, 0, -1 do
					local itemType = worldObjects:get(i):getItem():getFullType()
					local itemName = getItemNameFromFullType(itemType)
					
					if (ComfySleeping.getComfyPillowTypes()[itemType]) then return true end
				end
			end
		end
		
	elseif (v ~= nil) then -- If player is in vehicle, check their inventory & hand
		local inventoryItems = p:getInventory():getItems()
		local comfyPillowTypes = ComfySleeping.getComfyPillowTypes()
		
		for i = 0, inventoryItems:size() - 1 do
			local itemType = inventoryItems:get(i):getFullType()
			
			if (comfyPillowTypes[itemType]) then
				return true
			
			end
		
		end
	
	end
	
	return false
end


-- Return translated Comfort status string supplied from:
-- ComfySleeping\media\lua\shared\Translate
function getComfortString(currentComfort)
	if currentComfort <= 20 then return getText("Sandbox_ComfySleeping_VeryPoor")
	elseif currentComfort < 40 then return getText("Sandbox_ComfySleeping_Poor")
	elseif currentComfort < 60 then return getText("Sandbox_ComfySleeping_Bad")
	elseif currentComfort < 80 then return getText("Sandbox_ComfySleeping_Tolerable")
	elseif currentComfort < 100 then return getText("Sandbox_ComfySleeping_Ok")
	else return getText("Sandbox_ComfySleeping_SnugAsABug") end
end


-- Hooks into and overrides ISVehicleMenu.onSleep (slice of vehicle radial menu used to sleep, change radio, use AC, etc)
-- to overwrite the text in the sleep confirmation dialogue box to include Comfort and PillowNearby status'.
local old_ISVehicleMenu_onSleep = ISVehicleMenu.onSleep
function ISVehicleMenu.onSleep(playerObj, vehicle)
	if not vehicle:isStopped() then
		playerObj:Say(getText("IGUI_PlayerText_CanNotSleepInMovingCar"))
		return;
	end
	
	local playerNum = playerObj:getPlayerNum()
	
	-- Is a pillow nearby?
	options.addPillowComfort = findNearbyPillow()

	-- Formatting string for pillow status
	local pillowNearby = options.addPillowComfort and getText("Sandbox_ComfySleeping_Yes") or getText("Sandbox_ComfySleeping_No")
	
	-- Formatting string to include confirmation text, comfort, and pillow status.
	local formattedString = getText("IGUI_ConfirmSleep") .. "\n\n" .. getText("Sandbox_ComfySleeping_Comfort") .. " " .. getComfortString(currentComfort) .. "\n\n" .. getText("Sandbox_ComfySleeping_PillowNearby") .. " " .. pillowNearby
	
	local modal = ISModalDialog:new(0,0, 250, 150, formattedString, true, nil, ISVehicleMenu.onConfirmSleep, playerNum, playerNum, nil);
	
	modal:initialise()
	modal:addToUIManager()
	
	if JoypadState.players[playerNum+1] then
		setJoypadFocus(playerNum, modal)
	end
end


-- When context menu is filled, this handles adjusting the 'Sleep' options tooltip.
-- Checks through all valid context options supplied by Events.OnFillWorldObjectContextMenu
-- and updates the Sleep context options tooltip to include comfort and pillow status.
function contextMenuFilled(p, context, worldObjects)

	-- Is the translated name for "Sleep" present in the context options?
	local option = context:getOptionFromName(getText("ContextMenu_Sleep"))
	
	-- If it is then:
	if option ~= nil then 
		
		-- Is a pillow nearby?
		options.addPillowComfort = findNearbyPillow()
	
		-- Sets pillowNearby to a translated "Yes" or "No" string if options.addPillowComfort is true or false respectively.
		local pillowNearby = options.addPillowComfort and getText("Sandbox_ComfySleeping_Yes") or getText("Sandbox_ComfySleeping_No")
		
		-- Get the unmodified tooltip for the Sleep context option
		local tooltip = option.toolTip
		
		-- Gets translated string for comfort level (Snug, Ok, Tolerable, etc)
		local comfortLevel = getComfortString(currentComfort)
		
		-- Format the strings and include line breaks
		local comfortString = " <BR> " .. getText("Sandbox_ComfySleeping_Comfort") .. " " .. comfortLevel
		
		local pillowString = ""
		
		if (options.showPillowStatus) then 
			pillowString = " <BR> " .. getText("Sandbox_ComfySleeping_PillowNearby") .. " " .. pillowNearby
		end
		
		-- Set the tooltip to the old tooltip concatenated with the two formatted strings above
		tooltip["description"] = tooltip["description"] .. comfortString .. pillowString
		
	end
end


-- 99% of initialization is done in CS_InitComfyClothing.lua.
-- initMod here simply calls the get functions declared in that file to use them here, defaults addPillowComfort to false, and
-- adds the mainFunc to it's Event.
local function initComfySleepingCore()
	options = ComfySleeping.getOptions()
	comfyClothes = ComfySleeping.getComfyClothes()
	
	options.addPillowComfort = false
	
	Events.EveryOneMinute.Add(mainFunc)
	
	print("ComfySleeping Core Initialized Successfully! ")
end

-- Add initMod to be called when the game starts
Events.OnGameStart.Add(initComfySleepingCore)

-- Adds contextMenuFilled to be called when the context menu is filled with options
Events.OnFillWorldObjectContextMenu.Add(contextMenuFilled)