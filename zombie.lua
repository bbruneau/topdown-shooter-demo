local Utils   = require "utils"
local Sprites = require "sprites"
local Player  = require "player"

local Zombie = {}

function Zombie:init()
  Zombie.instances = {}
end

function Zombie:spawn()
  local zombie = {}
  zombie.position = Utils:randomPosition(Sprites.zombie, false)
  zombie.hitbox = S.trikers.Circle(zombie.position.x, zombie.position.y,
    Sprites.zombie:getWidth() / 2, zombie.position.dir);
  zombie.speed = 50

  table.insert(Zombie.instances, zombie)
end

function Zombie:count()
  return #Zombie.instances
end

function Zombie:aimAtPlayer(zombie)
  zombie.position.dir = math.atan2(Player.position.y - zombie.position.y, Player.position.x - zombie.position.x)
end

function Zombie:update(dt)
  for _i, z in ipairs(Zombie.instances) do
    if S.triking(z.hitbox, Player.hitbox) then
      Player:kill(z)
    end
    Zombie:aimAtPlayer(z)
    Utils:moveForward(z, dt)
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
