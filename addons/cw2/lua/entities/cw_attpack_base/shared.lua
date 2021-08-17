ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Attachment package base"
ENT.Author = "Spy"
ENT.Spawnable = false
ENT.AdminSpawnable = false 

function ENT:getAttachments()
	return self.attachments
end