local Utils = {}

function Utils:createPosition(args)
  local x, y, ox, oy, dir;
  if args.x then x = args.x else x = love.graphics.getWidth() / 2 end
  if args.y then y = args.y else y = love.graphics.getHeight() / 2 end
  if args.ox then ox = args.ox else ox = 0 end
  if args.oy then oy = args.oy else oy = 0 end
  if args.dir then dir = args.dir else dir = 0 end

  return { x = x, y = y, ox = ox, oy = oy, dir = dir }
end

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

function Utils:moveForward(obj, dt)
  obj.position.x = obj.position.x + obj.speed * dt * math.cos(obj.position.dir)
  obj.position.y = obj.position.y + obj.speed * dt * math.sin(obj.position.dir)
end

function Utils:moveBackward(obj, dt)
  obj.position.x = obj.position.x - obj.speed * dt * math.cos(obj.position.dir)
  obj.position.y = obj.position.y - obj.speed * dt * math.sin(obj.position.dir)
end

function Utils:getClosestEdge(x, y)
  local maxX = love.graphics.getWidth();
  local maxY = love.graphics.getHeight();

  local sides = { top = 0 + y, bottom = maxY - y, left = 0 + x, right = maxX - x }

end

function Utils:createRotatedRectangle(position, w, h, mode)

  if mode == nil then mode = "fill" end

  love.graphics.push()
  love.graphics.translate(position.x + position.ox, position.y + position.oy)
  love.graphics.rotate(position.dir)
  love.graphics.rectangle(mode, -position.ox, -position.oy, w, h)
  love.graphics.pop()
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

return Utils
