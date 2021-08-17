properties.Add("copymodel",
{
    MenuLabel		=	"Copy Model",
    Order			=	1599,
    MenuIcon		=	"icon16/page_copy.png",

    Filter    = function(self, ent, ply)  -- A function that determines whether an entity is valid for this property
                  if (!IsValid(ent)) then return false end
                  if (ent:IsPlayer()) then return false end
                  if (!gamemode.Call("CanProperty", ply, "remove", ent)) then return false end
                  return true
              end,

    Action    = function(self, ent) -- The action to perform upon using the property ( Clientside )
                    SetClipboardText(ent:GetModel())
                end
})