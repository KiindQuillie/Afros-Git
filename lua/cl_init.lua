-- File directory: /GarrysMod/garrysmod/gamemodes/*your_gamemode* or sandbox/gamemode/cl.init.lua
-- Disable using spawnmenu for players without admin permission

function GM:SpawnMenuOpen()

    return LocalPlayer():IsAdmin()

end

	
-- Set the maximum time in seconds before a player must respawn, for campaign configured permanently.
local maxdeathtime = 999999;
 
-- Create a hook for the GM:PlayerDeath() function that
-- sets our two variables when the player dies
function player_initdeath( ply, wep, killer )
 
     ply.nextspawn = CurTime() + maxdeathtime; -- set when we want to spawn
 
end
hook.Add( "PlayerDeath", "player_initalize_dvars", player_initdeath );
 
function playerforcerespawn( ply )
 
     if (CurTime()>=ply.nextspawn) then
          ply:Spawn()
          ply.nextspawn = math.huge
     end
 
end
 
hook.Add( "PlayerDeathThink", "player_step_forcespawn", playerforcerespawn );
