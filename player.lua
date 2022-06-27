local Sprites = require("sprites")
local Utils   = require("utils")

local Player = {}

function Player:init()
  Sprites:loader("player", "sprites/player.png")
  Player.position = {
    x = love.graphics.getWidth() / 2,
    y = love.graphics.getHeight() / 2,
    ox = Sprites.player:getWidth() / 2,
    oy = Sprites.player:getHeight() / 2,
    dir = Utils:degToRad(-90)
  }
  Player.speed = 150
  Player.turnSpeed = Utils:degToRad(180)
end

function Player:getDirection()
  return Player.position.dir
end

function Player:getTurnSpeed(dt)
  return Player.turnSpeed * dt
end

function Player:handleMovement(dt)
  if love.keyboard.isDown("right") then
    Utils:turnRight(Player.position, Player:getTurnSpeed(dt))
  end
  if love.keyboard.isDown("left") then
    Utils:turnLeft(Player.position, Player:getTurnSpeed(dt))
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
    Player.position.ox, Player.position.oy)
end

return Player
