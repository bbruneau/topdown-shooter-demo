local Utils   = require("utils")
local Sprites = require("sprites")

local Zombie = {}

function Zombie:init()
  Sprites:loader("zombie", "sprites/zombie.png")
  Zombie.instances = {}
end

function Zombie:spawn()
  local zombie = {}
  zombie.position = Utils:randomLocation(Sprites.zombie)
  zombie.position.direction = Utils:degToR(math.random(0, 359))

  table.insert(Zombie.instances, zombie)
end

function Zombie:count()
  return #Zombie.instances
end

function Zombie:draw()
  for _i, z in ipairs(Zombie.instances) do
    love.graphics.draw(Sprites.zombie, z.position.x, z.position.y, z.position.direction, 1, 1, z.position.ox,
      z.position.oy)
  end
end

return Zombie
