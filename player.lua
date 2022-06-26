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
    direction = Utils:degToR(-90)
  }
  Player.speed = 150
end

function Player:getDirection()
  return Utils:degToR(Player.position.direction)
end

function Player:handleMovement(dt)
  if love.keyboard.isDown("right") then
    Utils:turnRight(Player.position, 180 * dt)
  end
  if love.keyboard.isDown("left") then
    Utils:turnLeft(Player.position, 180 * dt)
  end
  if love.keyboard.isDown("up") then
    Utils:moveForward(Player.position, Player.speed * dt)
  end
  if love.keyboard.isDown("down") then
    Utils:moveBackward(Player.position, Player.speed * dt)
  end
end

function Player:draw()
  love.graphics.draw(Sprites.player, Player.position.x, Player.position.y,
    Player:getDirection(), 1, 1,
    Player.position.ox, Player.position.oy)
end

return Player
