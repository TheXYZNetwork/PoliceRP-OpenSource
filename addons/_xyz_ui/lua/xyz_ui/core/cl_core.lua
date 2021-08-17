function XYZUI.CharLimit(text, limit)
	limit = limit or 16
	if #text > limit then
		text = string.sub(text, 1, limit).."..."
	end
	return text
end