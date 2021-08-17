--[[---------------------------------------------------------------------------
Vote regulations
- hobo's can't vote for anything (no voting rights for hobo's!)
- Government jobs can't vote for gangster related things
- Criminal jobs can't vote for government related things
- Civilians can vote for anything

Assumes the jobs are unedited in jobs.lua, add them in the tables below to add your own jobs
---------------------------------------------------------------------------]]

if true then return end -- REMOVE THIS LINE TO ENABLE THE MODULE
local GovernmentJobs, GangsterJobs

local function config()
	GovernmentJobs = {
		[TEAM_MAYOR] = true,
		[TEAM_POLICE] = true,
		[TEAM_CHIEF] = true
	}

	GangsterJobs = {
		[TEAM_GANG] = true,
		[TEAM_MOB] = true
	}
end

local function decide(ply, target)
	if not GovernmentJobs then config() end

	if ply:Team() == TEAM_HOBO then return false, DarkRP.getPhrase("hobos_no_rights") end

	if GangsterJobs[ply:Team()] and GovernmentJobs[target:Team()] then
		return false, DarkRP.getPhrase("gangsters_cant_vote_for_government")
	end

	if GovernmentJobs[ply:Team()] and GangsterJobs[target:Team()] then
		return false, DarkRP.getPhrase("government_cant_vote_for_gangsters")
	end
end
hook.Add("canDemote", "VoteRegulations", decide)

local function canVote(ply, vote)
	if vote.votetype ~= "job" and vote.votetype ~= "demote" then return end -- only apply to promotions and demotions
	if not IsValid(vote.target) then return end

	return decide(ply, vote.target)
end
hook.Add("canVote", "VoteRegulations", canVote)
