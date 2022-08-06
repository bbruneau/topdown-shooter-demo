local Sprites = require("sprites")
local Utils   = require("utils")

local Player = {}

function Player:init()
  Player = {}
  Player.id = "Player"
  Player.position = Utils:createPosition({
    ox = Sprites.player:getWidth() / 2,
    oy = Sprites.player:getHeight() / 2,
  })
  Player.speed = 150
  Player.turnSpeed = Utils:degToRad(180)
  Player.hitbox = S.trikers.Rectangle(Player.position.x, Player.position.y, Sprites.player:getWidth(),
    Sprites.player:getHeight(), Player.position.dir);
  Player.hasDied = false
end

function Player:getDirection()
  return Player.position.dir
end

function Player:getTurnSpeed(dt)
  return Player.turnSpeed * dt
end

function Player:update(dt)
  if love.keyboard.isDown("right") then
    Utils:turnRight(Player, Player:getTurnSpeed(dt))
  end
  if love.keyboard.isDown("left") then
    Utils:turnLeft(Player, Player:getTurnSpeed(dt))
  end
  if love.keyboard.isDown("up") then
    Utils:moveForward(Player, dt)
  end
  if love.keyboard.isDown("down") then
    Utils:moveBackward(Player, dt)
  end
end

function Player:draw()
  love.graphics.draw(Sprites.player, Player.position.x, Player.position.y,
    Player:getDirection(), 1, 1,
    Player.position.ox, Player.position.oy
  )
  if DEBUG.hitbox.player == true then Player.hitbox:draw() end
end

return Player
