local Mod = ReworkedPoopBosses
Mod.CORN_MINE = {}
local CORN_MINE = Mod.CORN_MINE
local ENUMS = Mod.ENUMS
local FUNCTIONS = Mod.FUNCTIONS


function CORN_MINE:Death(npc)
    local data = npc:GetData()
    local sprite = npc:GetSprite()

    if npc:HasMortalDamage() or sprite:IsFinished("Pulse") or npc:IsDead() then
        npc:BloodExplode()
        npc.State = NpcState.STATE_DEATH
        print("shid")
        -- sprite:Play("Death")

        return true
    end
end
Mod:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, CORN_MINE.Death, EntityType.ENTITY_CORN_MINE)


function CORN_MINE:Collide(npc, collider)
    if collider:ToPlayer() or collider:ToNPC() then
        -- npc.State = NpcState.STATE_DEATH
        -- npc:GetSprite():Play("Death")
        npc:Kill()
        return false
    end
end
Mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, CORN_MINE.Collide, EntityType.ENTITY_CORN_MINE)


-- Mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, CORN_MINE.Death, EntityType.ENTITY_CORN_MINE)
