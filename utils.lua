local Utils = {

}

function Utils:degToR(deg)
  return deg * math.pi / 180
end

function Utils:turnLeft(obj, amount)
  obj.direction = obj.direction - amount
end

function Utils:turnRight(obj, amount)
  Utils:turnLeft(obj, -amount)
end

function Utils:moveForward(position, amount)
  local dirRad = Utils:degToR(position.direction)
  position.x = position.x + amount * math.cos(dirRad)
  position.y = position.y + amount * math.sin(dirRad)
end

function Utils:moveBackward(obj, amount)
  Utils:moveForward(obj, -amount)
end

function Utils:getClosestEdge(x, y)
  local maxX = love.graphics.getWidth();
  local maxY = love.graphics.getHeight();

  local sides = { top = 0 + y, bottom = maxY - y, left = 0 + x, right = maxX - x }

end

function Utils:randomLocation(sprite, onScreen)
  if onScreen == nil then
    onScreen = true
  end

  local maxX = love.graphics.getWidth();
  local maxY = love.graphics.getHeight();
  local dir = Utils:degToR(math.random(0, 359))
  local ox = 0
  local oy = 0

  if sprite ~= nil then
    ox = sprite:getWidth() / 2
    oy = sprite:getHeight() / 2
  end

  if onScreen then
    return {
      x = math.random(0 + ox, maxX - ox),
      y = math.random(0 + oy, maxY - oy),
      dir = dir,
      ox = ox,
      oy = oy
    }
  else
    -- local x = math.random(0, maxX)
    -- local y = math.random(0, maxY)
    return {
      x = math.random(0, maxX),
      y = math.random(0 + oy, maxY - oy),
      dir = dir,
      ox = ox,
      oy = oy
    }
  end
end

return Utils
