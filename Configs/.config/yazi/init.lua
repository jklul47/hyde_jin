function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	else
		-- Format: YYMMDD - HH:MM (e.g., 250411 - 07:18)
		time = os.date("%y%m%d - %H:%M", time)
	end

	local size = self._file:size()
	-- Format: size | date - time (e.g., 20B | 250411 - 07:18)
	return string.format("%s | %s", size and ya.readable_size(size) or "-", time)
end
