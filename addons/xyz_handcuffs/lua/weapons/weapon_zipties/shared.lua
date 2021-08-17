SWEP.PrintName = "Zip Ties"
SWEP.Author = "Smith Bob"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true
SWEP.ViewModel = "models/tobadforyou/c_flexcuffs.mdl"
SWEP.WorldModel = "models/tobadforyou/flexcuffs_deployed.mdl"
SWEP.ViewModelFOV = 85
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize 	 = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo = "none"

SWEP.HoldType = ""

function SWEP:Initialize()
	self:SetWeaponHoldType("melee")
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
end 

function SWEP:Deploy()
	local ply = self.Owner
	self:SetNextPrimaryFire(CurTime()+1.7)
	self:SetNextSecondaryFire(CurTime()+1.7)
	ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("draw"))
	timer.Simple(1.7, function()
		ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("idle"))
	end)
	return true
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	self:SetNextPrimaryFire(CurTime()+2)

	local ply = self.Owner
	local target = ply:GetEyeTrace().Entity
	if not target:IsPlayer() then return end

	if ply:GetPos():Distance(target:GetPos()) > 250 then return end

	if IsValid(target:GetActiveWeapon()) and (target:GetActiveWeapon() == "xyz_suicide_vest") then return end

	if target:XYZIsArrested() then return end
	if target:XYZIsZiptied() then
		if target.xyz_activeFreeze then return end
		target:XYZUnziptie(ply)
	else
		target:XYZZiptie(ply)
		XYZShit.Msg("Handcuffs", Color(200, 100, 40), "You have ziptied "..target:Name(), ply)
	end
	ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("deploy"))
	timer.Simple(2, function()
		ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("idle"))
	end)
end

function SWEP:SecondaryAttack()
	if CLIENT then return end
	self:SetNextSecondaryFire(CurTime()+2)

	local ply = self.Owner
	local target = ply:GetEyeTrace().Entity

	if target:IsVehicle() then
		if not (target:GetDriver() == NULL) then return end
	
		for k, v in pairs(target:VC_GetPlayers()) do
			if v:XYZIsZiptied() then
				if v.XYZdragger then
					v.XYZdragger.XYZdragging = nil
					v.XYZdragger = nil
				end
				v:ExitVehicle()
				local oldPos = v:GetPos()
				timer.Simple(0, function()
					v:SetPos(oldPos)
				end)
			end
		end
	elseif target:IsPlayer() and target:XYZIsZiptied() then
		if not target.ziptiedWeapons then return end
		local weps = {}
		for k, v in pairs(target.ziptiedWeapons) do
			if not table.HasValue(GAMEMODE.Config.DefaultWeapons, k) and not GAMEMODE.Config.noStripWeapons[k] and not table.HasValue(target:getJobTable().weapons, k) and v ~= "xStore" then
				table.insert(weps, k)
				target.ziptiedWeapons[k] = nil
			end
		end
		XYZShit.Msg("Handcuffs", Color(200, 100, 40), "Removing the following weapons:\n"..table.concat(weps, "\n"), ply)
		hook.Call("XYZHandcuffsStripped", nil, ply, target)
	end
end


function SWEP:Reload()
	if CLIENT then return end
	if self.NextReload and self.NextReload > CurTime() then return end
	self.NextReload = CurTime() + 2

	local ply = self.Owner
	local target = ply:GetEyeTrace().Entity

	if not target:IsPlayer() then return end

	if target:XYZIsZiptied() then
		target:XYZBlindfold(ply)
	end
end

if CLIENT then
    function SWEP:DrawWorldModel()
    	local ply = self.Owner
        if ply == LocalPlayer() then return end
        if LocalPlayer():GetPos():DistToSqr(ply:GetPos()) > 200000 then
            if self.GunModel then
                self.GunModel:Remove()
                self.GunModel = nil
            end
            return
        end
    	local ang = ply:EyeAngles()
    	ang:RotateAroundAxis(ang:Forward(), 60)
		local pos
    	if not (ply:LookupBone("ValveBiped.Bip01_R_Hand") == nil) then
    		pos = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_R_Hand"))
    	else 
    		pos = ply:GetPos()
    	end

    	if not self.GunModel then
    		self.GunModel = ClientsideModel(self.WorldModel)
    		timer.Simple(5, function() -- Used to prevent the floating model lol
    			if self.GunModel then
    				self.GunModel:Remove()
					self.GunModel = nil
    			end
    		end)
    	end
        pos = pos + (ang:Forward()) + (ang:Right()*-1) + (ang:Up()*3.5)
    	self.GunModel:SetPos(pos)
    	self.GunModel:SetAngles(ang)
    end

    function SWEP:Holster()
        if self.GunModel then
            self.GunModel:Remove()
            self.GunModel = nil
        end
    end
end
