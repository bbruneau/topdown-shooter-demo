local Utils   = require "utils"
local Sprites = require "sprites"
local Player  = require "player"
local Bullet  = require "bullet"

local Zombie = {}

local NEXT_ZOMBIE_COOLDOWN
local ZOMBIE_COOLDOWN_TIMER
local ZOMBIES_KILLED
local NEXT_RESPAWN

function Zombie:init()
  Zombie.instances = {}

  ZOMBIE_COOLDOWN_TIMER = 0
  NEXT_ZOMBIE_COOLDOWN = 10
  ZOMBIE_COOLDOWN_TIMER = 0
  ZOMBIES_KILLED = 0
  NEXT_RESPAWN = nil
end

function Zombie:bodyCount()
  return ZOMBIES_KILLED
end

function Zombie:spawn()
  local zombie = {}
  zombie.position = Utils:randomPosition(Sprites.zombie, false)
  zombie.hitbox = S.trikers.Circle(zombie.position.x, zombie.position.y,
    Sprites.zombie:getWidth() / 2, zombie.position.dir);
  zombie.speed = 50

  table.insert(Zombie.instances, zombie)

end

function Zombie:destroy(pos)
  ZOMBIES_KILLED = ZOMBIES_KILLED + 1
  table.remove(Zombie.instances, pos)
  if Zombie:count() < 1 then
    NEXT_RESPAWN = TIME_ELAPSED + math.random(0, 2)
  else
    NEXT_RESPAWN = TIME_ELAPSED + math.random(2, 10)
  end
end

function Zombie:count()
  return #Zombie.instances
end

function Zombie:aimAtPlayer(zombie)
  zombie.position.dir = math.atan2(Player.position.y - zombie.position.y, Player.position.x - zombie.position.x)
end

function Zombie:update(dt)
  for iz, z in ipairs(Zombie.instances) do
    if S.triking(z.hitbox, Player.hitbox) then
      Player:kill(z)
    end

    for ib, b in ipairs(Bullet.instances) do
      if S.triking(b.hitbox, z.hitbox) then
        Bullet:destroy(ib)
        Zombie:destroy(iz)
      end
    end

    Zombie:aimAtPlayer(z)
    Utils:moveForward(z, dt)
  end

  ZOMBIE_COOLDOWN_TIMER = math.max(ZOMBIE_COOLDOWN_TIMER - dt, 0)

  if ZOMBIE_COOLDOWN_TIMER == 0 then
    Zombie:spawn()
    NEXT_ZOMBIE_COOLDOWN = math.max(NEXT_ZOMBIE_COOLDOWN - 1, 1)
    ZOMBIE_COOLDOWN_TIMER = NEXT_ZOMBIE_COOLDOWN
  end

  if NEXT_RESPAWN and NEXT_RESPAWN <= TIME_ELAPSED then
    Zombie:spawn()
    NEXT_RESPAWN = nil
  end
end

function Zombie:draw()
  for _i, z in ipairs(Zombie.instances) do
    love.graphics.draw(Sprites.zombie, z.position.x, z.position.y, z.position.dir, 1, 1, z.position.ox,
      z.position.oy)
    if DEBUG.hitbox.zombie == true then z.hitbox:draw() end
  end
end

return Zombie
