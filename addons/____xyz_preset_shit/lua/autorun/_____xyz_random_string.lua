// XYZ Random String Generator
XYZShit = XYZShit or {}

local chars = {"q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m","Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M","1","2","3","4","5","6","7","8","9","0"}
function XYZShit:RandomString(length)
    local string = ""
    for i=1, length do
        string = string..chars[math.random(#chars)] 
    end
    return string
end