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
		["FullHat"] = ComfySleeping.options.hatComfyMod,
		["Hat"] = ComfySleeping.options.hatComfyMod,
		["MaskFull"] = ComfySleeping.options.maskComfyMod,
		["MaskEyes"] = ComfySleeping.options.maskComfyMod,
		["Mask"] = ComfySleeping.options.maskComfyMod,
		["FullSuitHead"] = ComfySleeping.options.fullSuitComfyMod,
		["FullSuit"] = ComfySleeping.options.fullSuitComfyMod,
		["Torso1Legs1"] = ComfySleeping.options.fullJohnsComfyMod,
		["Eyes"] = ComfySleeping.options.eyesComfyMod,
		["LeftEye"] = ComfySleeping.options.eyesComfyMod,
		["RightEye"] = ComfySleeping.options.eyesComfyMod,
		["Nose"] = ComfySleeping.options.noseComfyMod,
		["Ears"] = ComfySleeping.options.earsComfyMod,
		["EarTop"] = ComfySleeping.options.earsComfyMod,
		["Scarf"] = ComfySleeping.options.scarfComfyMod,
		["Neck"] = ComfySleeping.options.neckComfyMod,
		["Necklace"] = ComfySleeping.options.necklaceComfyMod,
		["Necklace_Long"] = ComfySleeping.options.necklaceLongComfyMod,
		["TankTop"] = ComfySleeping.options.shirtComfyMod,
		["Tshirt"] = ComfySleeping.options.shirtComfyMod,
		["ShortSleeveShirt"] = ComfySleeping.options.shirtComfyMod,
		["Shirt"] = ComfySleeping.options.shirtComfyMod,
		["Jacket"] = ComfySleeping.options.jacketComfyMod,
		["Jacket_Down"] = ComfySleeping.options.ponchoComfyMod,
		["JacketHat"] = ComfySleeping.options.ponchoComfyMod,
		["Jacket_Bulky"] = ComfySleeping.options.jacketBulkyComfyMod,
		["JacketHat_Bulky"] = ComfySleeping.options.jacketBulkyComfyMod,
		["BoilerSuit"] = ComfySleeping.options.boilerSuitComfyMod,
		["Dress"] = ComfySleeping.options.dressComfyMod,
		["FullTop"] = ComfySleeping.options.fullTopComfyMod,
		["TorsoExtra"] = ComfySleeping.options.torsoExtraComfyMod,
		["TorsoExtraVest"] = ComfySleeping.options.vestComfyMod,
		["Hands"] = ComfySleeping.options.handComfyMod,
		["RightWrist"] = ComfySleeping.options.wristComfyMod,
		["LeftWrist"] = ComfySleeping.options.wristComfyMod,
		["Right_MiddleFinger"] = ComfySleeping.options.handRingComfyMod,
		["Left_MiddleFinger"] = ComfySleeping.options.handRingComfyMod,
		["Right_RingFinger"] = ComfySleeping.options.handRingComfyMod,
		["Left_RingFinger"] = ComfySleeping.options.handRingComfyMod,
		["Belt"] = ComfySleeping.options.beltComfyMod,
		["BeltExtra"] = ComfySleeping.options.beltExtraComfyMod,
		["AmmoStrap"] = ComfySleeping.options.ammoStrapComfyMod,
		["BellyButton"] = ComfySleeping.options.bellyRingComfyMod,
		["Pants"] = ComfySleeping.options.pantsComfyMod,
		["UnderwearTop"] = ComfySleeping.options.underComfyMod,
		["UnderwearBottom"] = ComfySleeping.options.underComfyMod,
		["UnderwearExtra1"] = ComfySleeping.options.underComfyMod,
		["UnderwearExtra2"] = ComfySleeping.options.underComfyMod,
		["Legs1"] = ComfySleeping.options.halfJohnsComfyMod,
		["Shoes"] = ComfySleeping.options.shoesComfyMod,
		["Tail"] = ComfySleeping.options.tailComfyMod,
		
		-- Scrap Armor Body Locations
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
local function initClothingList()
	-- Thanks to Collide in the PZ mod-dev channel for the help getting all clothing items
	local allItemsList = getScriptManager():getAllItems()

	print("Got clothing list of size " .. tostring(allItemsList:size()) .. ".")
	for i = allItemsList:size() - 1, 0, -1 do
		local item = allItemsList:get(i)
		local itemType = item:getTypeString() -- getType() value changed to 'usertype'
		
		if (itemType == "Clothing") then
			local itemLocation = item:getBodyLocation()
			local itemName = item:getDisplayName() -- getDisplayName()
			local fabricType = item:getFabricType()
			
			-- Is items location in the comfort map?
			if (ComfySleeping.comfortModMap[itemLocation] ~= nil) then
				ComfySleeping.clothingList[itemName] = ComfySleeping.comfortModMap[itemLocation]
				
			end
			
			-- Fallback if location isn't recognized, fabric type is used and overrides body location (if present)
			if fabricType == "Cotton" then ComfySleeping.clothingList[itemName] = ComfySleeping.options.cottonComfyMod
			elseif fabricType == "Denim" then ComfySleeping.clothingList[itemName] = ComfySleeping.options.denimComfyMod
			elseif fabricType == "Leather" then ComfySleeping.clothingList[itemName] = ComfySleeping.options.leatherComfyMod end
		
		-- Same as above but for container items, meant for various backpacks, but apparently coolers also have a comfort modifier
		-- because of this :)
		elseif itemType == "Container" then
			local itemName = item:getDisplayName() -- getDisplayName()
			ComfySleeping.clothingList[itemName] = ComfySleeping.options.bagComfyMod
		
		end
	end
	
	for key,val in ipairs(ComfySleeping.clothingList) do
		print(key .. " : " .. val)
		
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