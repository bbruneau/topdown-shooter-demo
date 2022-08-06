local Utils = require("utils")

local World = {
  hitboxes = {}
}

function World:init()
  math.randomseed(os.time())
  World.hitboxes = {}
end

local function createHitbox(id, sprite, position, onCollision)
  love.graphics.setColor(0, 0, 0, 0.2);
  local hb = {
    id = id,
    sprite = sprite,
    boundingBox = Utils:createRotatedRectangle(position, sprite:getWidth(), sprite:getHeight()),
    onCollision = onCollision
  }

  return hb
end

function World:registerHitbox(hitbox)
  table.insert(World.hitboxes, hitbox)
end

function World:unregisterHitbox(hitbox)
  for i, h in ipairs(World.hitboxes) do
    if h == hitbox then
      table.remove(World.hitboxes, i)
      return
    end
  end
end

function World:checkHitboxCollisions()
  for _, ha in ipairs(World.hitboxes) do
    for _, hb in ipairs(World.hitboxes) do
      if ha:collidesWith(hb) then
        ha:onCollision(hb)
      end
    end
  end
end

return World
