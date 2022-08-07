local Utils = {}

function Utils:degToRad(deg)
  return deg * math.pi / 180
end

function Utils:radToDeg(rad)
  return rad * 180 / math.pi
end

function Utils:turnLeft(obj, amountInRads)
  obj.position.dir = obj.position.dir - amountInRads
  obj.hitbox:rotateTo(obj.position.dir)
end

function Utils:turnRight(obj, amountInRads)
  Utils:turnLeft(obj, -amountInRads)
end

local getDelta = function(obj, dt)
  return obj.speed * dt * math.cos(obj.position.dir), obj.speed * dt * math.sin(obj.position.dir)
end

function Utils:getDelta(direction, distance, dt)
  return distance * dt * math.cos(direction), distance * dt * math.sin(direction)
end

local updateHitbox = function(obj)
  obj.hitbox:translateTo(obj.position.x, obj.position.y)
end

function Utils:moveForward(obj, dt)
  -- local xDelta, yDelta = getDelta(obj, dt)
  local xDelta, yDelta = Utils:getDelta(obj.position.dir, obj.speed, dt)
  local newX = obj.position.x + xDelta
  local newY = obj.position.y + yDelta

  if (obj.id == "Player") then
    -- keep player in play area
    obj.position.x = Utils:clamp(newX, 10, love.graphics.getWidth() - 10)
    obj.position.y = Utils:clamp(newY, 10, love.graphics.getHeight() - 10)
  else
    obj.position.x = newX
    obj.position.y = newY
  end
  updateHitbox(obj)
end

function Utils:moveBackward(obj, dt)
  local xDelta, yDelta = getDelta(obj, dt)
  obj.position.x = obj.position.x - xDelta
  obj.position.y = obj.position.y - yDelta
  updateHitbox(obj)
end

function Utils:createPosition(args)
  local x, y, ox, oy, dir;
  if args.x then x = args.x else x = love.graphics.getWidth() / 2 end
  if args.y then y = args.y else y = love.graphics.getHeight() / 2 end
  if args.ox then ox = args.ox else ox = 0 end
  if args.oy then oy = args.oy else oy = 0 end
  if args.dir then dir = args.dir else dir = 0 end

  return { x = x, y = y, ox = ox, oy = oy, dir = dir }
end

function Utils:randomPosition(sprite, onScreen)
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
    local edges = { "left", "right", "top", "bottom" }
    local edge = edges[math.random(1, 4)]
    local x = math.random(0, maxX)
    local y = math.random(0, maxY)

    if edge == "left" then
      x = 0 - ox
    elseif edge == "right" then
      x = maxX + ox
    elseif edge == "top" then
      y = 0 - oy
    elseif edge == "bottom" then
      y = maxY + oy
    end

    return {
      x = x,
      y = y,
      dir = dir,
      ox = ox,
      oy = oy
    }
  end
end

function Utils:orElse(val, fallback)
  if val == nil then
    return fallback
  else
    return val
  end
end

function Utils:clamp(val, min, max)
  if val < min then
    return min
  elseif val > max then
    return max
  else
    return val
  end
end

return Utils
