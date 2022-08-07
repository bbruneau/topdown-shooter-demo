local Sprites = require "sprites"
local Utils = require "utils"

local Bullet = {}

function Bullet:init()
  Bullet.instances = {}
end

function Bullet:destroy(pos)
  table.remove(Bullet.instances, pos)
end

function Bullet:spawn(x, y, dir)
  local bullet = { id = #Bullet.instances + 1 }
  bullet.position = Utils:createPosition({
    x = x,
    y = y,
    dir = dir,
    ox = Sprites.bullet:getWidth() / 2,
    oy = Sprites.bullet:getHeight() / 2
  })
  bullet.hitbox = S.trikers.Circle(bullet.position.x, bullet.position.y,
    Sprites.bullet:getWidth() / 10, bullet.position.dir);
  bullet.speed = 200

  table.insert(Bullet.instances, bullet)
end

function Bullet:update(dt)
  for _i, b in ipairs(Bullet.instances) do
    Utils:moveForward(b, dt)
  end
end

function Bullet:draw()
  for _i, b in ipairs(Bullet.instances) do
    love.graphics.draw(Sprites.bullet, b.position.x, b.position.y, b.position.dir, 0.25, 0.25, b.position.ox,
      b.position.oy)
    if DEBUG.hitbox.bullet == true then b.hitbox:draw() end
  end
end

return Bullet
