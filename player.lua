local Sprites = require("sprites")
local Utils = require("utils")

local Player = {}

function Player:init()
  Sprites:loader("player", "sprites/player.png")
  local ps = {}
  ps.position = {
    x = love.graphics.getWidth() / 2,
    y = love.graphics.getHeight() / 2,
    ox = Sprites.player:getWidth() / 2,
    oy = Sprites.player:getHeight() / 2
  }
  ps.direction = Utils:degToR(-90)
  ps.speed = 150

  Player.state = ps
end

function Player:getDirection()
  return Utils:degToR(Player.state.direction)
end

function Player:handleMovement(dt)
  local state = Player.state
  if love.keyboard.isDown("right") then
    Utils:turnRight(state, 180 * dt)
  end
  if love.keyboard.isDown("left") then
    Utils:turnLeft(state, 180 * dt)
  end
  if love.keyboard.isDown("up") then
    Utils:moveForward(state, state.speed * dt)
  end
  if love.keyboard.isDown("down") then
    Utils:moveBackward(state, state.speed * dt)
  end
end

return Player
