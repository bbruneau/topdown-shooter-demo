local Utils = {}

function Utils:degToR(deg)
  return deg * math.pi / 180
end

function Utils:turnLeft(obj, amount)
  obj.direction = obj.direction - amount
end

function Utils:turnRight(obj, amount)
  Utils:turnLeft(obj, -amount)
end

function Utils:moveForward(obj, amount)
  local dirRad = Utils:degToR(obj.direction)
  obj.position.x = obj.position.x + amount * math.cos(dirRad)
  obj.position.y = obj.position.y + amount * math.sin(dirRad)
end

function Utils:moveBackward(obj, amount)
  Utils:moveForward(obj, -amount)
end

return Utils
