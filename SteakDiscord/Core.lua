local function ExtractDiscordLink(text)
	if not text then return nil end

	return text:match("(https://discord%.gg/%S+)") or text:match("(https://discord%.com/invite/%S+)") or text:match("(discord%.gg/%S+)") or text:match("(discord%.com/invite/%S+)")
end

local function SendDiscordToRaid()
	local motd = GetGuildRosterMOTD()
	local link = ExtractDiscordLink(motd)

	if not link then link = ExtractDiscordLink(GetGuildInfoText()) end

	if link then
		if GetNumRaidMembers() > 0 then
			SendChatMessage("We just met you, and this is crazy, but here's our discord ("..link.."), so logon maybe?", "RAID")
		elseif GetNumPartyMembers() > 0 then
			SendChatMessage("We just met you, and this is crazy, but here's our discord ("..link.."), so logon maybe?", "PARTY")
		else
			print("|cffff5555You are not in a group.")
		end
	else
		print("|cffff5555No Discord link found in GMOTD.|r")
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")

f:SetScript("OnEvent", function()
	local btn = CreateFrame("Button", "RaidDiscordButton", RaidFrame, "UIPanelButtonTemplate")

	btn:SetSize(70, 22)
	btn:SetText("Discord")

	--btn:SetPoint("TOPRIGHT", RaidFrame, "TOPRIGHT", -10, -10)
	btn:SetPoint("RIGHT", FriendsFrameCloseButton, "LEFT", 5, 0)

	btn:SetScript("OnClick", SendDiscordToRaid)
end)
