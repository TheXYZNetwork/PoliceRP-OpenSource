-- various metamethod utility mixins, mainly made to write less

-- VECTOR MIXINS

local vec = debug.getregistry("Vector")

-- if there is no vector division method, define one, as it's very useful

local VEC = "Vector" -- make the 'Vector' string once, since it's an object

if not vec.__div then
	vec.__div = function(a, b)
		-- make sure both A and B are vectors
		if a == VEC and b == VEC then
			a.x = a.x / b.x
			a.y = a.y / b.y
			a.z = a.z / b.z
			
			return a
		end
		
		-- if they aren't, just return the first vector
		return a
	end
end

-- if there is no subtraction method, define one

if not vec.__sub then
	vec.__sub = function(a, b)
		-- make sure both A and B are vectors
		
		if a == VEC and b == VEC then
			a.x = a.x - b.x
			a.y = a.y - b.y
			a.z = a.z - b.z
			
			return a
		end
		
		-- if they aren't, just return the first vector
		return a
	end
end

-- ANGLE MIXINS

local ang = debug.getregistry("Angle")

local ANG = "Angle"

if not ang.__sub then
	ang.__sub = function(a, b)
		if a == ANG and b == ANG then
			a.p = a.p - b.p
			a.y = a.y - b.y
			a.r = a.r - a.r
			
			return a
		end
		
		return a
	end
end

-- Length method for angles

--if not ang.Length then

	function ang:Length()
		local p, y, r = math.abs(p), math.abs(y), math.abs(r)
		
		return p + y + r
	end
--end

function LerpColor(dt, a, b)
	a.r = LerpCW20(dt, a.r, b.r)
	a.g = LerpCW20(dt, a.g, b.g)
	a.b = LerpCW20(dt, a.b, b.b)
	a.a = LerpCW20(dt, a.a, b.a)
	
	return a
end

function math.randomizeVector(vecObj, offset)
	vecObj.x = vecObj.x + math.Rand(-offset, offset)
	vecObj.y = vecObj.y + math.Rand(-offset, offset)
	vecObj.z = vecObj.z + math.Rand(-offset, offset)
	
	return vecObj
end