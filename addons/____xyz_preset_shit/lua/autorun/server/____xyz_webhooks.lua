XYZShit.Webhook = {}
XYZShit.Webhook.Hooks = {}

function XYZShit.Webhook.Register(name, info)
	if XYZShit.Webhook.Hooks[name] then return end
	XYZShit.Webhook.Hooks[name] = info
end

-- The unique name to access it
-- The important part of the webhook
-- Wall of Shame
XYZShit.Webhook.Register("wallofshame", "12345678/AbCdEfG")
-- Bug reports
XYZShit.Webhook.Register("bug_reports", "12345678/AbCdEfG")
-- Anti-cheat
XYZShit.Webhook.Register("anticheat", "12345678/AbCdEfG")
-- Training exam
XYZShit.Webhook.Register("pd_exam", "12345678/AbCdEfG")
XYZShit.Webhook.Register("fr_exam", "12345678/AbCdEfG")
-- Undercover
XYZShit.Webhook.Register("fbi_undercover", "12345678/AbCdEfG")
-- Patrol logs
XYZShit.Webhook.Register("patrol_log_swat", "12345678/AbCdEfG")
XYZShit.Webhook.Register("patrol_log_usms", "12345678/AbCdEfG")
XYZShit.Webhook.Register("patrol_log_sd", "12345678/AbCdEfG")
XYZShit.Webhook.Register("patrol_log_pd", "12345678/AbCdEfG")
XYZShit.Webhook.Register("patrol_log_fbi", "12345678/AbCdEfG")
-- Police Union IA
XYZShit.Webhook.Register("union_ia_swat", "12345678/AbCdEfG")
XYZShit.Webhook.Register("union_ia_usms", "12345678/AbCdEfG")
XYZShit.Webhook.Register("union_ia_sd", "12345678/AbCdEfG")
XYZShit.Webhook.Register("union_ia_pd", "12345678/AbCdEfG")
XYZShit.Webhook.Register("union_ia_fbi", "12345678/AbCdEfG")
-- Police Union Compliment
XYZShit.Webhook.Register("union_comp_swat", "12345678/AbCdEfG")
XYZShit.Webhook.Register("union_comp_usms", "12345678/AbCdEfG")
XYZShit.Webhook.Register("union_comp_sd", "12345678/AbCdEfG")
XYZShit.Webhook.Register("union_comp_pd", "12345678/AbCdEfG")
XYZShit.Webhook.Register("union_comp_fbi", "12345678/AbCdEfG")
-- Event System
XYZShit.Webhook.Register("event_alert", "12345678/AbCdEfG")
XYZShit.Webhook.Register("event_log", "12345678/AbCdEfG")
-- Other
XYZShit.Webhook.Register("eco_breakdown", "12345678/AbCdEfG")
XYZShit.Webhook.Register("auction_house", "12345678/AbCdEfG")

--[[
Example of an embed table to pass in 2nd arg

{
	author = {
	    name =  user:Name() or "Unknown User",
	    url = "https://thexyznetwork.xyz/lookup/"..user:SteamID64(),
	    icon_url = "https://extra.thexyznetwork.xyz/steamProfileByID?id="..user:SteamID64()
	},
	title = type or "Detection Found",
	color = color or "368575",
	description = msg or "Unknown details"
}
]]--

function XYZShit.Webhook.PostEmbed(name, embed)
	local info = XYZShit.Webhook.Hooks[name]
	if not info then return end

	local tbl = {
		embeds = {
			embed
		}
	}
	http.Post("https://extra.thexyznetwork.xyz/webhook/", {payload_json = util.TableToJSON(tbl), hook_id = info})
end


function XYZShit.Webhook.Post(name, username, msg)
	local info = XYZShit.Webhook.Hooks[name]
	if not info then return end

	local tbl = {
		username = username or nil,
		content = string.gsub(msg, "%@", ""),
		hook_id = info
	}
	http.Post("https://extra.thexyznetwork.xyz/webhook/", tbl)
end
