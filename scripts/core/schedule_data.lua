local scheduler = {}
local Mod = ReworkedPoopBosses
scheduler.ScheduleData = {}
---
---@param delay integer
---@param func function
---@param args any
---@function
---@scope Scheduler
function scheduler.Schedule(delay, func, args)
	table.insert(scheduler.ScheduleData, {
		Time = Game():GetFrameCount(),
		Delay = delay,
		Call = func,
		Args = args or {},
	})
end

Mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
	local time = Game():GetFrameCount()
	for i = #scheduler.ScheduleData, 1, -1 do
		local data = scheduler.ScheduleData[i]
		if data.Time + data.Delay <= time then
			table.remove(scheduler.ScheduleData, i)
			data.Call(table.unpack(data.Args))
		end
	end
end)

Mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, function()
	scheduler.ScheduleData = {}
end)

return scheduler
