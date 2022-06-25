local Sprites = require("sprites")
local Player = require("player")

function love.load()
  Sprites:init()
  Player:init()
  TIME_ELAPSED = 0
end

function love.update(dt)
  TIME_ELAPSED = TIME_ELAPSED + dt
  Player:handleMovement(dt)
end

function love.draw()
  love.graphics.draw(Sprites.background, 0, 0)
  love.graphics.draw(Sprites.player, Player.state.position.x, Player.state.position.y,
    Player:getDirection(), 1, 1,
    Player.state.position.ox, Player.state.position.oy)
end
