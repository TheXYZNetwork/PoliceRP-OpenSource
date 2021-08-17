include("shared.lua")

 --[[
 Name: Draw     Purpose: Draw the model in-game.     
 Remember, the things you render first will be underneath!  
 ]]--
ENT.upOffset = Vector(0, 0, 28)

 function ENT:Draw()      
 // self.BaseClass.Draw(self)  
 -- We want to override rendering, so don't call baseclass.                                   
 // Use this when you need to add to the rendering.        
 self.Entity:DrawModel()       // Draw the model.   
 end