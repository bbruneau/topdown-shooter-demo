local Utils = {}

function Utils:degToRad(deg)
  return deg * math.pi / 180
end

function Utils:radToDeg(rad)
  return rad * 180 / math.pi
end

function Utils:turnLeft(obj, amountInRads)
  obj.dir = obj.dir - amountInRads
end

function Utils:turnRight(obj, amountInRads)
  Utils:turnLeft(obj, -amountInRads)
end

function Utils:moveForward(x, y, dir, amount)
  local x1 = x + amount * math.cos(dir)
  local y1 = y + amount * math.sin(dir)
  return { x = x1, y = y1 }
end

function Utils:moveBackward(x, y, dir, amount)
  return Utils:moveForward(x, y, dir, -amount)
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
  local dir = Utils:degToRad(math.random(0, 359))
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
