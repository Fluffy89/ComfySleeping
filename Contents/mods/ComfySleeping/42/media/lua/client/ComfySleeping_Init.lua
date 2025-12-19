ComfySleeping = {}


----- Lists to init -----
ComfySleeping.comfortModMap = {}
ComfySleeping.comfyPillowTypes = {}
ComfySleeping.clothingList = {}
ComfySleeping.options = {}
-------------------------


-------------- Get Functions --------------
ComfySleeping.getComfyClothes = function()
	return ComfySleeping.clothingList
	
end


ComfySleeping.getComfyPillowTypes = function()
	return ComfySleeping.comfyPillowTypes

end


ComfySleeping.getOptions = function()
	return ComfySleeping.options
	
end
-------------------------------------------


-- Table key/value pairs are itemLocation & comfortModifier
local function initComfortModMap()
	ComfySleeping.comfortModMap = {
		[ItemBodyLocation.FULL_HAT] = ComfySleeping.options.hatComfyMod, -- "FullHat"
		[ItemBodyLocation.HAT] = ComfySleeping.options.hatComfyMod,
		[ItemBodyLocation.MASK_FULL] = ComfySleeping.options.maskComfyMod,
		[ItemBodyLocation.MASK_EYES] = ComfySleeping.options.maskComfyMod,
		[ItemBodyLocation.MASK] = ComfySleeping.options.maskComfyMod,
		[ItemBodyLocation.FULL_SUIT_HEAD] = ComfySleeping.options.fullSuitComfyMod,
		[ItemBodyLocation.FULL_SUIT] = ComfySleeping.options.fullSuitComfyMod,
		[ItemBodyLocation.FULL_SUIT_SCBA] = ComfySleeping.options.fullSuitComfyMod,
		[ItemBodyLocation.SCBA] = ComfySleeping.options.fullSuitComfyMod,
		[ItemBodyLocation.SCBANOTANK] = ComfySleeping.options.fullSuitComfyMod,
		[ItemBodyLocation.FULL_SUIT] = ComfySleeping.options.fullSuitComfyMod,
		[ItemBodyLocation.TORSO1LEGS1] = ComfySleeping.options.fullJohnsComfyMod,
		[ItemBodyLocation.EYES] = ComfySleeping.options.eyesComfyMod,
		[ItemBodyLocation.LEFT_EYE] = ComfySleeping.options.eyesComfyMod,
		[ItemBodyLocation.RIGHT_EYE] = ComfySleeping.options.eyesComfyMod,
		[ItemBodyLocation.NOSE] = ComfySleeping.options.noseComfyMod,
		[ItemBodyLocation.EARS] = ComfySleeping.options.earsComfyMod,
		[ItemBodyLocation.EAR_TOP] = ComfySleeping.options.earsComfyMod,
		[ItemBodyLocation.SCARF] = ComfySleeping.options.scarfComfyMod,
		[ItemBodyLocation.NECK] = ComfySleeping.options.neckComfyMod,
		[ItemBodyLocation.NECKLACE] = ComfySleeping.options.necklaceComfyMod,
		[ItemBodyLocation.NECKLACE_LONG] = ComfySleeping.options.necklaceLongComfyMod,
		[ItemBodyLocation.TANK_TOP] = ComfySleeping.options.shirtComfyMod,
		[ItemBodyLocation.TSHIRT] = ComfySleeping.options.shirtComfyMod,
		[ItemBodyLocation.SHORT_SLEEVE_SHIRT] = ComfySleeping.options.shirtComfyMod,
		[ItemBodyLocation.SKIRT] = ComfySleeping.options.shirtComfyMod,
		[ItemBodyLocation.LONG_SKIRT] = ComfySleeping.options.shirtComfyMod,
		[ItemBodyLocation.JACKET] = ComfySleeping.options.jacketComfyMod,
		[ItemBodyLocation.JACKET_DOWN] = ComfySleeping.options.ponchoComfyMod,
		[ItemBodyLocation.JACKET_HAT] = ComfySleeping.options.ponchoComfyMod,
		[ItemBodyLocation.JACKET_BULKY] = ComfySleeping.options.jacketBulkyComfyMod,
		[ItemBodyLocation.JACKET_HAT_BULKY] = ComfySleeping.options.jacketBulkyComfyMod,
		[ItemBodyLocation.BOILERSUIT] = ComfySleeping.options.boilerSuitComfyMod,
		[ItemBodyLocation.DRESS] = ComfySleeping.options.dressComfyMod,
		[ItemBodyLocation.LONG_DRESS] = ComfySleeping.options.dressComfyMod,
		[ItemBodyLocation.FULL_TOP] = ComfySleeping.options.fullTopComfyMod,
		[ItemBodyLocation.TORSO_EXTRA] = ComfySleeping.options.torsoExtraComfyMod,
		[ItemBodyLocation.TORSO_EXTRA_VEST] = ComfySleeping.options.vestComfyMod,
		[ItemBodyLocation.TORSO_EXTRA_VEST_BULLET] = ComfySleeping.options.vestComfyMod,
		[ItemBodyLocation.HANDS] = ComfySleeping.options.handComfyMod,
		[ItemBodyLocation.HANDS_LEFT] = ComfySleeping.options.handComfyMod,
		[ItemBodyLocation.HANDS_RIGHT] = ComfySleeping.options.handComfyMod,
		[ItemBodyLocation.RIGHT_WRIST] = ComfySleeping.options.wristComfyMod,
		[ItemBodyLocation.LEFT_WRIST] = ComfySleeping.options.wristComfyMod,
		[ItemBodyLocation.RIGHT_MIDDLE_FINGER] = ComfySleeping.options.handRingComfyMod,
		[ItemBodyLocation.LEFT_MIDDLE_FINGER] = ComfySleeping.options.handRingComfyMod,
		[ItemBodyLocation.RIGHT_RING_FINGER] = ComfySleeping.options.handRingComfyMod,
		[ItemBodyLocation.LEFT_RING_FINGER] = ComfySleeping.options.handRingComfyMod,
		[ItemBodyLocation.BELT] = ComfySleeping.options.beltComfyMod,
		[ItemBodyLocation.BELT_EXTRA] = ComfySleeping.options.beltExtraComfyMod,
		[ItemBodyLocation.ANKLE_HOLSTER] = ComfySleeping.options.beltExtraComfyMod,
		[ItemBodyLocation.SHOULDER_HOLSTER] = ComfySleeping.options.beltExtraComfyMod,
		[ItemBodyLocation.AMMO_STRAP] = ComfySleeping.options.ammoStrapComfyMod,
		[ItemBodyLocation.BELLY_BUTTON] = ComfySleeping.options.bellyRingComfyMod,
		[ItemBodyLocation.PANTS] = ComfySleeping.options.pantsComfyMod,
		[ItemBodyLocation.PANTS_SKINNY] = ComfySleeping.options.pantsComfyMod,
		[ItemBodyLocation.PANTS_EXTRA] = ComfySleeping.options.pantsComfyMod,
		[ItemBodyLocation.SHORT_PANTS] = ComfySleeping.options.pantsComfyMod,
		[ItemBodyLocation.UNDERWEAR] = ComfySleeping.options.underComfyMod,
		[ItemBodyLocation.UNDERWEAR_TOP] = ComfySleeping.options.underComfyMod,
		[ItemBodyLocation.UNDERWEAR_BOTTOM] = ComfySleeping.options.underComfyMod,
		[ItemBodyLocation.UNDERWEAR_EXTRA1] = ComfySleeping.options.underComfyMod,
		[ItemBodyLocation.UNDERWEAR_EXTRA2] = ComfySleeping.options.underComfyMod,
		[ItemBodyLocation.LEGS1] = ComfySleeping.options.halfJohnsComfyMod,
		[ItemBodyLocation.SHOES] = ComfySleeping.options.shoesComfyMod, -- "Shoes"
		[ItemBodyLocation.TAIL] = ComfySleeping.options.tailComfyMod,
		
		-- Scrap Armor Body Locations
		-- Scrap Armor hasn't been updated since 2023, will leave these here for now in case it's updated, but if not
		-- these are pointless to keep.
		["SwordSheath"] = ComfySleeping.options.swordSheathComfyMod,
		["Back"] = ComfySleeping.options.swordSheathComfyMod,
		["ShieldSlot"] = ComfySleeping.options.shieldSlotComfyMod,
		["TorsoRig"] = ComfySleeping.options.torsoRigComfyMod,
		["TorsoRig2"] = ComfySleeping.options.torsoRig2ComfyMod,
		["waistbags"] = ComfySleeping.options.waistBagsComfyMod,
		["UpperArmLeft"] = ComfySleeping.options.upperArmLeftComfyMod,
		["UpperArmRight"] = ComfySleeping.options.upperArmRightComfyMod,
		["ThighLeft"] = ComfySleeping.options.thighLeftComfyMod,
		["ThighRight"] = ComfySleeping.options.thighRightComfyMod,
		["LowerBody"] = ComfySleeping.options.lowerBodyComfyMod,
		["Pauldrons"] = ComfySleeping.options.pauldronsComfyMod,
		["HandPlateLeft"] = ComfySleeping.options.handPlateLeftComfyMod,
		["HandPlateRight"] = ComfySleeping.options.handPlateRightComfyMod,
		["ShinPlateLeft"] = ComfySleeping.options.shinPlateLeftComfyMod,
		["ShinPlateRight"] = ComfySleeping.options.shinPlateRightComfyMod,
		["SpecialMask"] = ComfySleeping.options.specialMaskComfyMod
	}
end


-- Allows multiple pillow base types to be added for compatibility with other mods such as "Standing Items"
local function initComfyPillowTypes()
	ComfySleeping.comfyPillowTypes = {
		["Base.Pillow"] = true,
		["Base.LyingPillow"] = true,
		["Base.HighPillow"] = true,
		["Base.Pillow_Crafted"] = true,
		["Base.Pillow_Happyface"] = true,
		["Base.Pillow_Heart"] = true,
		["Base.Pillow_Star"] = true,
		["Base.Pillow_Square"] = true,
		["Base.Pillow_Rabbit"] = true,
		["Base.Pillow_Flower"] = true,
		["Base.Pillow_Round"] = true
	}
	
end


-- Finds all clothing items in PZ, and matches them to their corresponding comfort modifier as specified above
-- in comfortModMap.
-- Item.getScriptObjectFullType() used instead of Item.getDisplayName() as fullType is defined by vanilla and mods
-- in English afaik, so this should avoid any potential linguistic bugs when assuming English names/characters.
local function initClothingList()
	-- Thanks to Collide in the PZ mod-dev channel for the help getting all clothing items
	local allItemsList = getScriptManager():getAllItems()

	for i = allItemsList:size() - 1, 0, -1 do
		local item = allItemsList:get(i)
		local itemCategory = item:getLootType() -- previously getTypeString(), getType() value changed to 'usertype'
		
		if (itemCategory == "Clothing") then
			local itemLocation = item:getBodyLocation()
			local itemName = item:getDisplayName() -- getDisplayName()
			local itemType = item:getScriptObjectFullType() -- getFullType() doesn't exist for Item objects
			local fabricType = item:getFabricType()
			
			-- Is items location in the comfort map?
			if (ComfySleeping.comfortModMap[itemLocation] ~= nil) then
				ComfySleeping.clothingList[itemType] = ComfySleeping.comfortModMap[itemLocation]
				
			end
			
			-- Fallback if location isn't recognized, fabric type is used and overrides body location (if present)
			if fabricType == "Cotton" then ComfySleeping.clothingList[itemType] = ComfySleeping.options.cottonComfyMod
			elseif fabricType == "Denim" then ComfySleeping.clothingList[itemType] = ComfySleeping.options.denimComfyMod
			elseif fabricType == "Leather" then ComfySleeping.clothingList[itemType] = ComfySleeping.options.leatherComfyMod end
		
		-- Same as above but for container items, meant for various backpacks, but apparently coolers also have a comfort modifier
		-- because of this :)
		elseif itemCategory == "Container" then
			local itemType = item:getScriptObjectFullType() -- getFullType() doesn't exist for Item objects
			ComfySleeping.clothingList[itemType] = ComfySleeping.options.bagComfyMod
		
		end
		
	end
	
end


-- The Ungodly Block of Sandbox Options
-- Simply gets sandbox option values from PZ as specified by the player
-- I now understand why this deep of customization is not very common, either in games or from mod configs. It's a lot
-- and gets even messier when translations come into play.
local function initComfySleeping()
	local sandboxOptions = getSandboxOptions()
	ComfySleeping.options.defaultComfort = sandboxOptions:getOptionByName("ComfySleeping.defaultComfort"):getValue() --100,
	ComfySleeping.options.pillowComfortBonus = sandboxOptions:getOptionByName("ComfySleeping.pillowComfortBonus"):getValue() --100,
	ComfySleeping.options.showPillowStatus = sandboxOptions:getOptionByName("ComfySleeping.showPillowStatus"):getValue() -- true
	ComfySleeping.options.forceAwakeIfVeryUncomfy = sandboxOptions:getOptionByName("ComfySleeping.forceAwakeIfVeryUncomfy"):getValue() -- true,
	ComfySleeping.options.forceAwakeIfSnug = sandboxOptions:getOptionByName("ComfySleeping.forceAwakeIfSnug"):getValue() -- true
	ComfySleeping.options.cottonComfyMod = sandboxOptions:getOptionByName("ComfySleeping.cottonComfyMod"):getValue() -- 5,
	ComfySleeping.options.denimComfyMod = sandboxOptions:getOptionByName("ComfySleeping.denimComfyMod"):getValue() -- -5,
	ComfySleeping.options.leatherComfyMod = sandboxOptions:getOptionByName("ComfySleeping.leatherComfyMod"):getValue() -- -10,
	ComfySleeping.options.painChance = sandboxOptions:getOptionByName("ComfySleeping.painChance"):getValue() -- 30,
	ComfySleeping.options.painLowerBound = sandboxOptions:getOptionByName("ComfySleeping.painLowerBound"):getValue() -- 20,
	ComfySleeping.options.painUpperBound = sandboxOptions:getOptionByName("ComfySleeping.painUpperBound"):getValue() -- 50,
	ComfySleeping.options.uncomfy1Endurance = sandboxOptions:getOptionByName("ComfySleeping.uncomfy1Endurance"):getValue() / 100 -- 0.9,
	ComfySleeping.options.uncomfy2Endurance = sandboxOptions:getOptionByName("ComfySleeping.uncomfy2Endurance"):getValue() / 100 -- 0.8,
	ComfySleeping.options.uncomfy2Fatigue = sandboxOptions:getOptionByName("ComfySleeping.uncomfy2Fatigue"):getValue() / 100 -- 0.3,
	ComfySleeping.options.uncomfy3Endurance = sandboxOptions:getOptionByName("ComfySleeping.uncomfy3Endurance"):getValue() / 100 -- 0.6,
	ComfySleeping.options.uncomfy3Fatigue = sandboxOptions:getOptionByName("ComfySleeping.uncomfy3Fatigue"):getValue() / 100 -- 0.5,
	ComfySleeping.options.uncomfy4Endurance = sandboxOptions:getOptionByName("ComfySleeping.uncomfy4Endurance"):getValue() / 100 -- 0.4,
	ComfySleeping.options.uncomfy4Fatigue = sandboxOptions:getOptionByName("ComfySleeping.uncomfy4Fatigue"):getValue() / 100 -- 0.7
	
	-- Weapons & Cleanliness
	ComfySleeping.options.weaponsAffectComfort = sandboxOptions:getOptionByName("ComfySleeping.weaponsAffectComfort"):getValue() -- true
	ComfySleeping.options.backWeaponComfyMod = sandboxOptions:getOptionByName("ComfySleeping.backWeaponComfyMod"):getValue() -- -10
	ComfySleeping.options.beltWeaponComfyMod = sandboxOptions:getOptionByName("ComfySleeping.beltWeaponComfyMod"):getValue() -- -5
	
	ComfySleeping.options.dirtAndBloodAffectComfort = sandboxOptions:getOptionByName("ComfySleeping.dirtAndBloodAffectComfort"):getValue() -- true
	ComfySleeping.options.bloodComfyMod = sandboxOptions:getOptionByName("ComfySleeping.bloodComfyMod"):getValue() -- -5
	ComfySleeping.options.bloodThreshold = sandboxOptions:getOptionByName("ComfySleeping.bloodThreshold"):getValue() -- 40
	ComfySleeping.options.dirtComfyMod = sandboxOptions:getOptionByName("ComfySleeping.dirtComfyMod"):getValue() -- -5
	ComfySleeping.options.dirtThreshold = sandboxOptions:getOptionByName("ComfySleeping.dirtThreshold"):getValue() -- 40
	
	-- Clothes --
	ComfySleeping.options.hatComfyMod= sandboxOptions:getOptionByName("ComfySleeping.hatComfyMod"):getValue() -- -20,
	ComfySleeping.options.maskComfyMod = sandboxOptions:getOptionByName("ComfySleeping.maskComfyMod"):getValue() -- -10,
	ComfySleeping.options.fullSuitComfyMod = sandboxOptions:getOptionByName("ComfySleeping.fullSuitComfyMod"):getValue() -- -15,
	ComfySleeping.options.fullJohnsComfyMod = sandboxOptions:getOptionByName("ComfySleeping.fullJohnsComfyMod"):getValue() -- 5,
	ComfySleeping.options.eyesComfyMod = sandboxOptions:getOptionByName("ComfySleeping.eyesComfyMod"):getValue() -- -3,
	ComfySleeping.options.scarfComfyMod = sandboxOptions:getOptionByName("ComfySleeping.scarfComfyMod"):getValue() -- 5,
	ComfySleeping.options.shirtComfyMod = sandboxOptions:getOptionByName("ComfySleeping.shirtComfyMod"):getValue() -- 5,
	ComfySleeping.options.jacketComfyMod = sandboxOptions:getOptionByName("ComfySleeping.jacketComfyMod"):getValue() -- -10,
	ComfySleeping.options.ponchoComfyMod = sandboxOptions:getOptionByName("ComfySleeping.ponchoComfyMod"):getValue() -- -10,
	ComfySleeping.options.jacketBulkyComfyMod = sandboxOptions:getOptionByName("ComfySleeping.jacketBulkyComfyMod"):getValue() -- -10,
	ComfySleeping.options.boilerSuitComfyMod = sandboxOptions:getOptionByName("ComfySleeping.boilerSuitComfyMod"):getValue() -- -10,
	ComfySleeping.options.dressComfyMod = sandboxOptions:getOptionByName("ComfySleeping.dressComfyMod"):getValue() -- -10,
	ComfySleeping.options.fullTopComfyMod = sandboxOptions:getOptionByName("ComfySleeping.fullTopComfyMod"):getValue() -- -10,
	ComfySleeping.options.torsoExtraComfyMod = sandboxOptions:getOptionByName("ComfySleeping.torsoExtraComfyMod"):getValue() -- -10,
	ComfySleeping.options.vestComfyMod = sandboxOptions:getOptionByName("ComfySleeping.vestComfyMod"):getValue() -- -10,
	ComfySleeping.options.handComfyMod = sandboxOptions:getOptionByName("ComfySleeping.handComfyMod"):getValue() -- -10,
	ComfySleeping.options.beltComfyMod = sandboxOptions:getOptionByName("ComfySleeping.beltComfyMod"):getValue() -- -5,
	ComfySleeping.options.beltExtraComfyMod = sandboxOptions:getOptionByName("ComfySleeping.beltExtraComfyMod"):getValue() -- -5,
	ComfySleeping.options.ammoStrapComfyMod = sandboxOptions:getOptionByName("ComfySleeping.ammoStrapComfyMod"):getValue() -- -5,
	ComfySleeping.options.pantsComfyMod = sandboxOptions:getOptionByName("ComfySleeping.pantsComfyMod"):getValue() -- -10,
	ComfySleeping.options.halfJohnsComfyMod = sandboxOptions:getOptionByName("ComfySleeping.halfJohnsComfyMod"):getValue() -- 5,
	ComfySleeping.options.shoesComfyMod = sandboxOptions:getOptionByName("ComfySleeping.shoesComfyMod"):getValue() -- -10,
	ComfySleeping.options.underComfyMod = sandboxOptions:getOptionByName("ComfySleeping.underComfyMod"):getValue() -- 2.5,
	ComfySleeping.options.tailComfyMod = sandboxOptions:getOptionByName("ComfySleeping.tailComfyMod"):getValue() -- 0,
	ComfySleeping.options.bagComfyMod = sandboxOptions:getOptionByName("ComfySleeping.bagComfyMod"):getValue() -- -20,
	
	-- Jewelry --
	ComfySleeping.options.wristComfyMod = sandboxOptions:getOptionByName("ComfySleeping.wristComfyMod"):getValue() -- -2,
	ComfySleeping.options.handRingComfyMod = sandboxOptions:getOptionByName("ComfySleeping.handRingComfyMod"):getValue() -- 0,
	ComfySleeping.options.noseComfyMod = sandboxOptions:getOptionByName("ComfySleeping.noseComfyMod"):getValue() -- 0,
	ComfySleeping.options.earsComfyMod = sandboxOptions:getOptionByName("ComfySleeping.earsComfyMod"):getValue() -- 0,
	ComfySleeping.options.neckComfyMod = sandboxOptions:getOptionByName("ComfySleeping.neckComfyMod"):getValue() -- 0,
	ComfySleeping.options.necklaceComfyMod = sandboxOptions:getOptionByName("ComfySleeping.necklaceComfyMod"):getValue() -- 0,
	ComfySleeping.options.necklaceLongComfyMod = sandboxOptions:getOptionByName("ComfySleeping.necklaceLongComfyMod"):getValue() -- 0,
	ComfySleeping.options.bellyRingComfyMod = sandboxOptions:getOptionByName("ComfySleeping.bellyRingComfyMod"):getValue() -- 0,
	
	-- Moodles --
	ComfySleeping.options.moodlesAffectComfort = sandboxOptions:getOptionByName("ComfySleeping.moodlesAffectComfort"):getValue() -- true,
	ComfySleeping.options.hungerComfyMod = sandboxOptions:getOptionByName("ComfySleeping.hungerComfyMod"):getValue() -- -2,
	ComfySleeping.options.sickComfyMod = sandboxOptions:getOptionByName("ComfySleeping.sickComfyMod"):getValue() -- -2,
	ComfySleeping.options.hasColdComfyMod = sandboxOptions:getOptionByName("ComfySleeping.hasColdComfyMod"):getValue() -- -2,
	ComfySleeping.options.wetComfyMod = sandboxOptions:getOptionByName("ComfySleeping.wetComfyMod"):getValue() -- -2,
	ComfySleeping.options.stressComfyMod = sandboxOptions:getOptionByName("ComfySleeping.stressComfyMod"):getValue() -- -2,
	ComfySleeping.options.thirstComfyMod = sandboxOptions:getOptionByName("ComfySleeping.thirstComfyMod"):getValue() -- -2,
	ComfySleeping.options.heavyLoadComfyMod = sandboxOptions:getOptionByName("ComfySleeping.heavyLoadComfyMod"):getValue() -- -2,
	ComfySleeping.options.hyperthermiaComfyMod = sandboxOptions:getOptionByName("ComfySleeping.hyperthermiaComfyMod"):getValue() -- -2,
	ComfySleeping.options.hypothermiaComfyMod = sandboxOptions:getOptionByName("ComfySleeping.hypothermiaComfyMod"):getValue() -- -2,
	ComfySleeping.options.foodComfyMod = sandboxOptions:getOptionByName("ComfySleeping.foodComfyMod"):getValue() -- 2,
	
	-- Scrap Armor Body Locations
	ComfySleeping.options.swordSheathComfyMod = sandboxOptions:getOptionByName("ComfySleeping.swordSheathComfyMod"):getValue()
	ComfySleeping.options.shieldSlotComfyMod = sandboxOptions:getOptionByName("ComfySleeping.shieldSlotComfyMod"):getValue()
	ComfySleeping.options.torsoRigComfyMod = sandboxOptions:getOptionByName("ComfySleeping.torsoRigComfyMod"):getValue()
	ComfySleeping.options.torsoRig2ComfyMod = sandboxOptions:getOptionByName("ComfySleeping.torsoRig2ComfyMod"):getValue()
	ComfySleeping.options.waistBagsComfyMod = sandboxOptions:getOptionByName("ComfySleeping.waistBagsComfyMod"):getValue()
	ComfySleeping.options.upperArmLeftComfyMod = sandboxOptions:getOptionByName("ComfySleeping.upperArmLeftComfyMod"):getValue()
	ComfySleeping.options.upperArmRightComfyMod = sandboxOptions:getOptionByName("ComfySleeping.upperArmRightComfyMod"):getValue()
	ComfySleeping.options.thighLeftComfyMod = sandboxOptions:getOptionByName("ComfySleeping.thighLeftComfyMod"):getValue()
	ComfySleeping.options.thighRightComfyMod = sandboxOptions:getOptionByName("ComfySleeping.thighRightComfyMod"):getValue()
	ComfySleeping.options.lowerBodyComfyMod = sandboxOptions:getOptionByName("ComfySleeping.lowerBodyComfyMod"):getValue()
	ComfySleeping.options.pauldronsComfyMod = sandboxOptions:getOptionByName("ComfySleeping.pauldronsComfyMod"):getValue()
	ComfySleeping.options.handPlateLeftComfyMod = sandboxOptions:getOptionByName("ComfySleeping.handPlateLeftComfyMod"):getValue()
	ComfySleeping.options.handPlateRightComfyMod = sandboxOptions:getOptionByName("ComfySleeping.handPlateRightComfyMod"):getValue()
	ComfySleeping.options.shinPlateLeftComfyMod = sandboxOptions:getOptionByName("ComfySleeping.shinPlateLeftComfyMod"):getValue()
	ComfySleeping.options.shinPlateRightComfyMod = sandboxOptions:getOptionByName("ComfySleeping.shinPlateRightComfyMod"):getValue()
	ComfySleeping.options.specialMaskComfyMod = sandboxOptions:getOptionByName("ComfySleeping.specialMaskComfyMod"):getValue()
	
	initComfortModMap()
	initComfyPillowTypes()
	initClothingList()
	
	print("Sandbox options & clothing list initialized!")
	
end

Events.OnGameStart.Add(initComfySleeping)