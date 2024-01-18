local Mod = ReworkedPoopBosses
Mod.FUNCTIONS = {}
local FUNCTIONS = Mod.FUNCTIONS

-- function from epiphany https://steamcommunity.com/sharedfiles/filedetails/?id=3012430463
---@param player EntityPlayer
---@return string
---@function
function FUNCTIONS:GetPlayerString(player)
	return "PLAYER_" .. player:GetCollectibleRNG(1):GetSeed() .. "_" .. player:GetCollectibleRNG(2):GetSeed()
end

---@function
---@returns int!
function FUNCTIONS:GetPlayerNumber(player)
	local num_players = Game():GetNumPlayers()
	for i = 0, (num_players - 1) do
		if GetPtrHash(Game():GetPlayer(i)) == GetPtrHash(player) then
			return i
		end
	end
	return -1
end

--math.max but for vectors
---@param vec1 Vector
---@param vec2 Vector
---@return Vector
---@function
function FUNCTIONS:VectorMax(vec1, vec2)
    if vec1:Length() >= vec2:Length() then
        return vec1
    else
        return vec2
    end
end

--math.min but for vectors
---@param vec1 Vector
---@param vec2 Vector
---@return Vector
---@function
function FUNCTIONS:VectorMin(vec1, vec2)
    if vec1:Length() <= vec2:Length() then
        return vec1
    else
        return vec2
    end
end

---@param integer integer
---@function
function FUNCTIONS.Round(integer)
	return integer % 1 >= 0.5 and math.ceil(integer) or math.floor(integer)
end


--gather projectiles

Mod.GatheringProjectiles = false
Mod.GatheredProjectiles = {}

Mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_INIT, function(_, projectile)
    local data = projectile:GetData()
    if Mod.GatheringProjectiles then
        table.insert(Mod.GatheredProjectiles, projectile)
    end
end)

function Mod:SetGatheredProjectiles()
    Mod.GatheredProjectiles = {}
    Mod.GatheringProjectiles = true
end

function Mod:GetGatheredProjectiles()
    Mod.GatheringProjectiles = false
    return Mod.GatheredProjectiles
end

function Mod:ClearTables()
	Mod.GatheringProjectiles = false
	Mod.GatheredProjectiles = {}
end

Mod:AddCallback(ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, function(type, var, sub, index, seed)
    Mod:ClearTables()
end)

Mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function(_, isContinued)
    Mod:ClearTables()
end)
--taken from ff