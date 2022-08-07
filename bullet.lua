local Sprites = require "sprites"
local Utils = require "utils"

local Bullet = {}

function Bullet:init()
  Bullet.instances = {}
end

function Bullet:spawn(x, y, dir)
  local bullet = {}
  bullet.position = Utils:createPosition({
    x = x,
    y = y,
    dir = dir,
    ox = Sprites.bullet:getWidth() / 2,
    oy = Sprites.bullet:getHeight() / 2
  })
  bullet.hitbox = S.trikers.Circle(bullet.position.x, bullet.position.y,
    Sprites.bullet:getWidth() / 2, bullet.position.dir);
  bullet.speed = 50

  table.insert(Bullet.instances, bullet)
end

function Bullet:update(dt)
  for _i, b in ipairs(Bullet.instances) do
    Utils:moveForward(b, dt)
  end
end

function Bullet:draw()
  for _i, b in ipairs(Bullet.instances) do
    love.graphics.draw(Sprites.bullet, b.position.x, b.position.y, b.position.dir, 1, 1, b.position.ox,
      b.position.oy)
    if DEBUG.hitbox.bullet == true then b.hitbox:draw() end

  end
end

return Bullet
