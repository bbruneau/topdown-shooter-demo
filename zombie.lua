local Utils   = require("utils")
local Sprites = require("sprites")
local Player  = require("player")

local Zombie = {}

function Zombie:init()
  Sprites:loader("zombie", "sprites/zombie.png")
  Zombie.instances = {}
end

function Zombie:spawn()
  local zombie = {}
  zombie.position = Utils:randomLocation(Sprites.zombie, false)
  zombie.position.tostring = function()
    return "(" .. zombie.position.x .. ", " .. zombie.position.y .. ")"
  end
  zombie.speed = 50

  table.insert(Zombie.instances, zombie)
end

function Zombie:count()
  return #Zombie.instances
end

function Zombie:aimAtPlayer(zombie)
  zombie.position.dir = math.atan2(Player.position.y - zombie.position.y, Player.position.x - zombie.position.x)
end

function Zombie:move(dt)
  for _i, z in ipairs(Zombie.instances) do
    Zombie:aimAtPlayer(z)
    Utils:moveForward(z, dt)
  end
end

function Zombie:draw()
  for _i, z in ipairs(Zombie.instances) do
    love.graphics.draw(Sprites.zombie, z.position.x, z.position.y, z.position.dir, 1, 1, z.position.ox,
      z.position.oy)
  end
end

return Zombie
